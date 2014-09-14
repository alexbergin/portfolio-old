define ->

	class RouterController

		x: 0
		y: 0

		needsUpdate: true
		active: "page-home"
		lastActive: "page-home"

		init: ->
			@.getElements()
			@.addListeners()
			@.update()
			@.render()

		getElements: ->
			@.site = document.getElementsByTagName("main")[0]
			@.upButton = document.getElementsByTagName("nav")[0].getElementsByClassName("up")[0]
			@.downButton = document.getElementsByTagName("nav")[0].getElementsByClassName("down")[0]
			@.leftButton = document.getElementsByTagName("nav")[0].getElementsByClassName("left")[0]
			@.rightButton = document.getElementsByTagName("nav")[0].getElementsByClassName("right")[0]

		addListeners: ->
			window.addEventListener "hashchange" , ->
				document.body.classList.remove("menu-open")
				portfolio.router.update()

			window.addEventListener "keyup" , ( e ) =>
				switch e.keyCode
					when 38
						if @.up isnt null then window.location.hash = @.up

					when 40 
						if @.down isnt null then window.location.hash = @.down

					when 37 
						if @.left isnt null then window.location.hash = @.left

					when 39 
						if @.right isnt null then window.location.hash = @.right

			window.addEventListener "resize" , portfolio.router.update

			# $( document.body ).swipe({
			# 	swipeDown: -> 
			# 		if portfolio.router.up isnt null then window.location.hash = portfolio.router.up

			# 	swipeUp: -> 
			# 		if portfolio.router.down isnt null then window.location.hash = portfolio.router.down

			# 	swipeRight: -> 
			# 		if portfolio.router.left isnt null then window.location.hash = portfolio.router.left

			# 	swipeLeft: -> 
			# 		if portfolio.router.right isnt null then window.location.hash = portfolio.router.right
			# })

		update: =>
			page = window.location.hash
			if page is "" or page is "#" or page is "#/"
				window.location.hash = "/home/"
				return

			article = -1
			section = -1

			i = 0
			while i < portfolio.content.length

				o = 0
				while o < portfolio.content[i].pages.length
					hash = portfolio.content[i].slug
					if o > 0 then hash += "/#{o}"

					if hash is page or hash + "/" is page
						@.lastActive = @.active
						@.lastSection = @.activeSection
						@.active = "page-#{portfolio.content[i].slug.substring( 2 )}"
						@.activeSection = o
						document.getElementsByClassName(@.active)[0].classList.add("active")
						document.getElementsByClassName(@.active)[0].getElementsByTagName("section")[o].classList.add("active")
						portfolio.load.imgs( document.getElementsByClassName(@.active)[0].getElementsByTagName("section")[o] )
						article = i
						section = o
					o++
				i++

			if article is -1 or section is -1
				window.location.hash = "/404"
				return

			pastX = @.x
			pastY = @.y

			@.x = section
			@.y = article

			if portfolio.content[@.y].pages[ @.x + 1 ] isnt undefined
				@.right = "#{portfolio.content[@.y].slug}/#{@.x + 1}/"

			else
				@.right = null

			if portfolio.content[@.y].pages[ @.x - 1 ] isnt undefined
				if @.x - 1 > 0
					@.left = "#{portfolio.content[@.y].slug}/#{@.x - 1}/"

				else
					@.left = "#{portfolio.content[@.y].slug}/"

			else
				@.left = null

			if portfolio.content[@.y - 1] isnt undefined and portfolio.content[@.y - 1].noTab isnt true
				@.up = "#{portfolio.content[@.y - 1].slug}/"

			else
				@.up = null

			if portfolio.content[@.y + 1] isnt undefined and portfolio.content[@.y + 1].noTab isnt true
				@.down = "#{portfolio.content[@.y + 1].slug}/"

			else
				@.down = null

			@.upButton.setAttribute("href" , @.up )
			@.downButton.setAttribute("href" , @.down )
			@.leftButton.setAttribute("href" , @.left )
			@.rightButton.setAttribute("href" , @.right )

			xvel = 10 * ( pastX - @.x )
			yvel = 10 * ( pastY - @.y )

			setTimeout =>
				portfolio.background.vel.scrollX += xvel
				portfolio.background.vel.scrollY += yvel
			, 100

			@.needsUpdate = true

		render: =>
			setInterval =>
				if @.needsUpdate is true
					@.needsUpdate = false
					x = -@.x * window.innerWidth + "px"
					y = -@.y * window.innerHeight + "px"

					style  = "-webkit-transform: translate( #{x} , #{y}); "
					style += "-ms-transform: translate( #{x} , #{y}); "
					style += "transform: translate( #{x} , #{y}); "

					@.site.setAttribute( "style" , style )

					articles = document.getElementsByTagName("article")
					i = 0
					while i < articles.length
						sections = articles[i].getElementsByTagName("section")
						n = 0
						while n < sections.length
							if sections[n] isnt articles[i].getElementsByTagName("section")[@.activeSection] and sections[n] isnt articles[i].getElementsByTagName("section")[@.lastSection]
								sections[n].classList.remove("active")
							n++

						if articles[i].classList.contains( @.active ) is false and articles[i].classList.contains( @.lastActive ) is false
							articles[i].classList.remove("active")
						i++

			, 150