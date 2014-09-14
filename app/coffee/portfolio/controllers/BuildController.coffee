define ->

	class BuildController

		init: ->
			@.loadContent()

		loadContent: ->
			$.getJSON( "/content.json" , ( response ) -> 
				portfolio.content = response.website
				portfolio.build.make()
				portfolio.menu.init()
				portfolio.load.init()
			)

		make: =>
			m = ""
			c = portfolio.content
			i = 0
			while i < c.length
				o = 0
				className = "page-" + c[i].slug.substring( 2 )
				m += "<article class=\"#{className}\">"

				while o < c[i].pages.length
					m += "<section class=\"#{c[i].pages[o].type}\">"

					switch c[i].pages[o].type
						when "text-card"
							m += @.assemble.text( c[i].pages[o] )

						when "project-detail"
							m += @.assemble.detail( c[i].pages[o] )

						when "image-card"
							m += @.assemble.image( c[i].pages[o] )

					m += "</section>"
					o++

				m += "</article>"
				i++

			document.getElementsByTagName("main")[0].innerHTML = m
			portfolio.router.init()

		assemble:

			text: ( data ) ->
				m =  "<div class=\"center\">"
				if data.headline?.length > 0
					m += "<h1>#{data.headline}</h1>"
				if data.copy?.length > 0
					m += "<p>#{data.copy}</p>"
				m += "</div>"
				return m

			image: ( data ) ->
				m =  "<div class=\"center\">"
				m += 	"<div class=\"background\">"
				m += 		"<img class=\"image-asset\" data-src=\"#{data.src}\" />"
				m += 		"<div class=\"loader\"></div>"
				m += 	"</div>"
				m += "</div>"

			detail: ( data ) ->
				m =  "<div class=\"center\">"
				m += "<ul>"

				if data.url?.length > 0
					m += "<li class=\"link\">"
					m += 	"<a href=\"#{data.url}\" target=\"_blank\">#{data.url}</a>"
					m += "</li>"

				combine = false
				solo = ""
				if data.employer?.name is data.client?.name and data.client?.name isnt "" then combine = true
				if data.employer is undefined or data.client is undefined then solo = "full"

				if combine is false
					m += "<div class=\"double\">"

					if data.client?.name?.length > 0 and combine is false
						m += "<li class=\"client #{solo}\">"
						m += 	"<label>Client</label>"
						m += 	"<a href=\"#{data.client.url}\" target=\"_blank\"><h2>#{data.client.name}</h2></a>"
						m += "</li>"

					if data.employer?.name?.length > 0 and combine is false
						m += "<li class=\"employer #{solo}\">"
						m += 	"<label>Employer</label>"
						m += 	"<a href=\"#{data.employer.url}\" target=\"_blank\"><h2>#{data.employer.name}</h2></a>"
						m += "</li>"

					m += "</div>"

				if combine is true and data.employer?.name.length > 0 and data.employer?.url.length
					m += "<li class=\"employer-client\">"
					m += 	"<label>Employer & Client</label>"
					m += 	"<a href=\"#{data.employer.url}\" target=\"_blank\"><h2>#{data.employer.name}</h2></a>"
					m += "</li>"

				if data.team?.length > 0
					m += "<li class=\"team\">"
					m += 	"<label>Team</label>"

					n = 0
					while n < data.team.length
						m += "<a href=\"#{data.team[n].url}\" target=\"_blank\"><h2>#{data.team[n].name}</h2></a>"
						n++

					m += "</li>"

				if data.date?.start.length > 0 and data.date?.finish.length > 0 
					m += "<li class=\"date\">"
					m += 	"<label>Project Duration</label>"
					m += 	"<p>from</p>"
					m += 	"<h2 class=\"start\">#{data.date.start}</h2><br />"
					m += 	"<p>to</p>"
					m += 	"<h2 class=\"finish\">#{data.date.finish}</h2>"
					m += "</li>"

				if data.mediums?.length > 0
					m += "<li class=\"medium\">"
					m += 	"<label>Medium</label>"

					n = 0
					while n < data.mediums.length
						m += 	"<h2>#{data.mediums[n]}</h2>"
						n++

					m += "</li>"

				m += "</ul>"
				m += "</div>"
				return m







