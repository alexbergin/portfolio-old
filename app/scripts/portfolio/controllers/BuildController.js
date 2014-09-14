var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

define(function() {
  var BuildController;
  return BuildController = (function() {
    function BuildController() {
      this.make = __bind(this.make, this);
    }

    BuildController.prototype.init = function() {
      return this.loadContent();
    };

    BuildController.prototype.loadContent = function() {
      return $.getJSON("/content.json", function(response) {
        portfolio.content = response.website;
        portfolio.build.make();
        portfolio.menu.init();
        return portfolio.load.init();
      });
    };

    BuildController.prototype.make = function() {
      var c, className, i, m, o;
      m = "";
      c = portfolio.content;
      i = 0;
      while (i < c.length) {
        o = 0;
        className = "page-" + c[i].slug.substring(2);
        m += "<article class=\"" + className + "\">";
        while (o < c[i].pages.length) {
          m += "<section class=\"" + c[i].pages[o].type + "\">";
          switch (c[i].pages[o].type) {
            case "text-card":
              m += this.assemble.text(c[i].pages[o]);
              break;
            case "project-detail":
              m += this.assemble.detail(c[i].pages[o]);
              break;
            case "image-card":
              m += this.assemble.image(c[i].pages[o]);
          }
          m += "</section>";
          o++;
        }
        m += "</article>";
        i++;
      }
      document.getElementsByTagName("main")[0].innerHTML = m;
      return portfolio.router.init();
    };

    BuildController.prototype.assemble = {
      text: function(data) {
        var m, _ref, _ref1;
        m = "<div class=\"center\">";
        if (((_ref = data.headline) != null ? _ref.length : void 0) > 0) {
          m += "<h1>" + data.headline + "</h1>";
        }
        if (((_ref1 = data.copy) != null ? _ref1.length : void 0) > 0) {
          m += "<p>" + data.copy + "</p>";
        }
        m += "</div>";
        return m;
      },
      image: function(data) {
        var m;
        m = "<div class=\"center\">";
        m += "<div class=\"background\">";
        m += "<img class=\"image-asset\" data-src=\"" + data.src + "\" />";
        m += "<div class=\"loader\"></div>";
        m += "</div>";
        return m += "</div>";
      },
      detail: function(data) {
        var combine, m, n, solo, _ref, _ref1, _ref10, _ref11, _ref12, _ref13, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9;
        m = "<div class=\"center\">";
        m += "<ul>";
        if (((_ref = data.url) != null ? _ref.length : void 0) > 0) {
          m += "<li class=\"link\">";
          m += "<a href=\"" + data.url + "\" target=\"_blank\">" + data.url + "</a>";
          m += "</li>";
        }
        combine = false;
        solo = "";
        if (((_ref1 = data.employer) != null ? _ref1.name : void 0) === ((_ref2 = data.client) != null ? _ref2.name : void 0) && ((_ref3 = data.client) != null ? _ref3.name : void 0) !== "") {
          combine = true;
        }
        if (data.employer === void 0 || data.client === void 0) {
          solo = "full";
        }
        if (combine === false) {
          m += "<div class=\"double\">";
          if (((_ref4 = data.client) != null ? (_ref5 = _ref4.name) != null ? _ref5.length : void 0 : void 0) > 0 && combine === false) {
            m += "<li class=\"client " + solo + "\">";
            m += "<label>Client</label>";
            m += "<a href=\"" + data.client.url + "\" target=\"_blank\"><h2>" + data.client.name + "</h2></a>";
            m += "</li>";
          }
          if (((_ref6 = data.employer) != null ? (_ref7 = _ref6.name) != null ? _ref7.length : void 0 : void 0) > 0 && combine === false) {
            m += "<li class=\"employer " + solo + "\">";
            m += "<label>Employer</label>";
            m += "<a href=\"" + data.employer.url + "\" target=\"_blank\"><h2>" + data.employer.name + "</h2></a>";
            m += "</li>";
          }
          m += "</div>";
        }
        if (combine === true && ((_ref8 = data.employer) != null ? _ref8.name.length : void 0) > 0 && ((_ref9 = data.employer) != null ? _ref9.url.length : void 0)) {
          m += "<li class=\"employer-client\">";
          m += "<label>Employer & Client</label>";
          m += "<a href=\"" + data.employer.url + "\" target=\"_blank\"><h2>" + data.employer.name + "</h2></a>";
          m += "</li>";
        }
        if (((_ref10 = data.team) != null ? _ref10.length : void 0) > 0) {
          m += "<li class=\"team\">";
          m += "<label>Team</label>";
          n = 0;
          while (n < data.team.length) {
            m += "<a href=\"" + data.team[n].url + "\" target=\"_blank\"><h2>" + data.team[n].name + "</h2></a>";
            n++;
          }
          m += "</li>";
        }
        if (((_ref11 = data.date) != null ? _ref11.start.length : void 0) > 0 && ((_ref12 = data.date) != null ? _ref12.finish.length : void 0) > 0) {
          m += "<li class=\"date\">";
          m += "<label>Project Duration</label>";
          m += "<p>from</p>";
          m += "<h2 class=\"start\">" + data.date.start + "</h2><br />";
          m += "<p>to</p>";
          m += "<h2 class=\"finish\">" + data.date.finish + "</h2>";
          m += "</li>";
        }
        if (((_ref13 = data.mediums) != null ? _ref13.length : void 0) > 0) {
          m += "<li class=\"medium\">";
          m += "<label>Medium</label>";
          n = 0;
          while (n < data.mediums.length) {
            m += "<h2>" + data.mediums[n] + "</h2>";
            n++;
          }
          m += "</li>";
        }
        m += "</ul>";
        m += "</div>";
        return m;
      }
    };

    return BuildController;

  })();
});

//# sourceMappingURL=BuildController.js.map
