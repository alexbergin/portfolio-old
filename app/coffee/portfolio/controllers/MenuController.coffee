define ->

	class MenuController

		colors: [
			"red"
			"green"
			"blue"
			"yellow"
		]

		init: ->
			@.getElements()
			@.addListeners()
			@.builder()

		getElements: ->
			@.toggle = document.getElementsByTagName("nav")[0].getElementsByClassName("menu")[0]
			@.menu = document.getElementsByTagName("menu")[0]

		addListeners: ->
			@.toggle.addEventListener "click" , => 
				@.toggleMenu()

			window.addEventListener "keypress" , (e) =>
				if e.keyCode is 109 then @.toggleMenu()

		toggleMenu: ->
			document.body.classList.toggle("menu-open")
			if document.body.classList.contains("menu-open")
				color = @.colors[ Math.floor( Math.random() * @.colors.length )]
				portfolio.background.vel.scrollX += 10
				@.menu.setAttribute("class" , color )
			else
				portfolio.background.vel.scrollX -= 10

		builder: =>
			m = "<div class=\"content\">"
			content = portfolio.content

			i = 0
			while i < content.length
				if content[i].noTab isnt true
					m += "<a href=\"#{content[i].slug}/\"><h1>#{content[i].title}</h1></a>"
					if i + 1 isnt content.length
						m += "<hr />"

				i++

			m += "</div>"

			@.menu.innerHTML = m
