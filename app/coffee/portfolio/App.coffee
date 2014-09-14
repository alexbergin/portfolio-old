define [
	
	"portfolio/controllers/BuildController"
	"portfolio/controllers/RouterController"
	"portfolio/controllers/BackgroundController"
	"portfolio/controllers/MenuController"
	"portfolio/controllers/LoadController"

] , (

	BuildController
	RouterController
	BackgroundController
	MenuController
	LoadController

) ->

	App = ->

		window.portfolio =

			build: new BuildController
			background: new BackgroundController
			router: new RouterController
			menu: new MenuController
			load: new LoadController

			start: ->
				i = 0
				run = [
					"build"
					"background"
				]

				while i < run.length
					portfolio[run[i]].init()
					i++

		portfolio.start()