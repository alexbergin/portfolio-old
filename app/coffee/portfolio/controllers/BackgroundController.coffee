define ->

	class BackgroundController
		
		shapes: []
		frame: new Date().getTime()
		vel:
			scrollX: 0
			scrollY: 0
		
		data:
			amount: 20
			scale: 1.25
			minVel: 0.05
			maxVel: 0.6
			allowShuffle: true
			
			colors: [
				"#FA4248"
				"#5DDBBA"
				"#64C3F2"
				"#EDE670"
			]

			shapes:
				rectangle: [
					x: 0.33
					y: -0.33
				,
					x: 0.66
					y: -0.33
				,
					x: 0.66
					y: 1.33
				,
					x: 0.33
					y: 1.33
				,
					x: 0.33
					y: -0.33
				]
			
				triangle: [
					x: 0.5
					y: 0.07
				,
					x: 1.0
					y: 0.93
				,
					x: 0.0
					y: 0.93
				,
					x: 0.5
					y: 0.07
				]

				circle: [ 1 ]
		
				cross: [
					x: 0.33
					y: 0.00
				,
					x: 0.66
					y: 0.00
				,
					x: 0.66
					y: 0.33
				,
					x: 1.00
					y: 0.33
				,
					x: 1.00
					y: 0.66
				,
					x: 0.66
					y: 0.66
				,
					x: 0.66
					y: 1.00
				,
					x: 0.33
					y: 1.00
				,
					x: 0.33
					y: 0.66
				,
					x: 0.00
					y: 0.66
				,
					x: 0.00
					y: 0.33
				,
					x: 0.33
					y: 0.33
				,
					x: 0.33
					y: 0.00
				]

		init: ->
			@.getElements()
			@.initShapes()
			@.render()
			
		getElements: ->
			@.el = document.getElementsByTagName( "canvas" )[0]
			@.stage = @.el.getContext( "2d" )
			
		initShapes: ->
			i = 0
			while i < @.data.amount
				@.addShape()
				i++
				
			console.log @.shapes
				
		addShape: ( type , color , x , y , r , xvel , yvel , rvel ) ->
			buffer = @.data.scale * 250
			types = Object.getOwnPropertyNames( @.data.shapes )
			if type is undefined or types.indexOf( type )is -1
				type = types[ Math.floor( Math.random() * types.length )]
				
			colors = @.data.colors
			if color is undefined or colors.indexOf( color )is -1
				color = colors[ Math.floor( Math.random() * colors.length )]
				
			if x is undefined then x = -buffer + Math.random() * ( window.innerWidth + ( 2 * buffer ))
			if y is undefined then y = -buffer + Math.random() * ( window.innerHeight + ( 2 * buffer ))
			if r is undefined then r = Math.random() * 360

			if xvel is undefined
				dir = 0
				vel = @.data.minVel + ( Math.random() * ( @.data.maxVel - @.data.minVel ))
				if Math.random() > 0.5 then dir = -1 else dir = 1
				xvel = dir * vel
				
			if yvel is undefined
				dir = 0
				vel = @.data.minVel + ( Math.random() * ( @.data.maxVel - @.data.minVel ))
				if Math.random() > 0.5 then dir = -1 else dir = 1
				yvel = dir * vel
				
			if rvel is undefined
				dir = 0
				vel = @.data.minVel + ( Math.random() * ( @.data.maxVel - @.data.minVel ))
				if Math.random() > 0.5 then dir = -1 else dir = 1
				rvel = dir * vel
				
			@.shapes.push({
				type: type
				color: color
				mult: 0.5 + Math.random() * 2
				pos:
					x: x
					y: y
					r: r
				vel:
					x: xvel
					y: yvel
					r: rvel
			})
			
		repo: ( shape , rate ) ->
			buffer = @.data.scale * 250
			shape.pos.x += ( shape.vel.x + ( @.vel.scrollX * shape.mult )) * ( rate / ( 1000 / 60 ))
			shape.pos.y += ( shape.vel.y + ( @.vel.scrollY * shape.mult )) * ( rate / ( 1000 / 60 ))
			shape.pos.r += ( shape.vel.r / 2 ) * ( rate / ( 1000 / 60 ))
			shuffle = false
			
			if shape.pos.x > window.innerWidth + buffer
				shape.pos.x = -buffer
				shuffle = true
				
			if shape.pos.x < -buffer
				shape.pos.x = window.innerWidth + buffer
				shuffle = true
				
			if shape.pos.y > window.innerHeight + buffer
				shape.pos.y = -buffer
				shuffle = true
				
			if shape.pos.y < -buffer
				shape.pos.y = window.innerHeight + buffer
				shuffle = true
				
			if shape.pos.r > 360
				shape.pos.r -= 360
				
			if shape.pos.r < 0
				shape.pos.r += 360
				
			if shuffle is true and @.data.allowShuffle is true
				types = Object.getOwnPropertyNames( @.data.shapes )
				colors = @.data.colors
				
				type = types[ Math.floor( Math.random() * types.length )]
				color = colors[ Math.floor( Math.random() * colors.length )]
				
				shape.type = type
				shape.color = color
			
		draw: ( shape ) =>
			c = @.stage
			s = shape
			p = @.data.shapes[ s.type ]
			m = @.data.scale * 200
			i = 0
			
			c.save()
			c.fillStyle = s.color
			c.translate( s.pos.x , s.pos.y )
			c.rotate( s.pos.r * ( Math.PI / 180 ))
			c.beginPath()
			
			if p.length > 1
				while i < p.length
					x = ( p[i].x - 0.5 ) * m
					y = ( p[i].y - 0.5 ) * m

					if i is 0
						c.moveTo( x , y )
					else
						c.lineTo( x , y )
					i++
			else
				c.arc( 0 , 0 , p[0] * m * 0.5 , 0 , 2 * Math.PI )
				
			c.fill()
			c.restore()
				
		scale: ->
			if @.width isnt window.innerWidth or @.height isnt window.innerHeight
				@.width = window.innerWidth
				@.height = window.innerHeight
				@.el.width = document.body.clientWidth
				@.el.height = document.body.clientHeight

		friction: ( rate ) ->
			if Math.abs( @.vel.scrollX ) > 0.01
				@.vel.scrollX = Math.round( @.vel.scrollX * 0.95 * 1000 ) / 1000
			else
				@.vel.scrollX = 0

			if Math.abs( @.vel.scrollY ) > 0.01
				@.vel.scrollY = Math.round( @.vel.scrollY * 0.95 * 1000 ) / 1000
			else
				@.vel.scrollY = 0
			
		render: =>
			i = 0
			@.scale()
			elapsed = new Date().getTime()
			@.stage.clearRect( 0 , 0 , @.width , @.height )
			@.friction( elapsed - @.frame )
			while i < @.shapes.length
				@.repo( @.shapes[i] , elapsed - @.frame )
				@.draw( @.shapes[i] )
				i++
			@.frame = elapsed
			requestAnimationFrame @.render