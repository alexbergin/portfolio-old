define ->

	class LoadController

		init: ->
			@.getElements()
			@.addListeners()

		getElements: ->
			@.lightbox = document.getElementsByTagName("aside")[0]
			@.els = document.getElementsByClassName("image-asset")

		imgs: ( section ) ->

			els = section.getElementsByClassName("image-asset")

			i = 0
			while i < els.length
				els[i].loaded = ->
					@.classList.add "loaded" 

				els[i].addEventListener "load" , ->
					@.loaded()

				els[i].setAttribute( "src" , els[i].getAttribute( "data-src" ))

				i++

		addListeners: ->
			i = 0
			self = @
			while i < @.els.length
				@.els[i].addEventListener "click" , ->
					self.lightbox.style.backgroundImage = "url(#{@.getAttribute("data-src")})"
					self.lightbox.classList.add("open")
				i++

			@.lightbox.getElementsByTagName("a")[0].addEventListener "click" , =>
				@.lightbox.classList.remove("open")