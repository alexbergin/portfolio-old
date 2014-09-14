var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

define(function() {
  var MenuController;
  return MenuController = (function() {
    function MenuController() {
      this.builder = __bind(this.builder, this);
    }

    MenuController.prototype.colors = ["red", "green", "blue", "yellow"];

    MenuController.prototype.init = function() {
      this.getElements();
      this.addListeners();
      return this.builder();
    };

    MenuController.prototype.getElements = function() {
      this.toggle = document.getElementsByTagName("nav")[0].getElementsByClassName("menu")[0];
      return this.menu = document.getElementsByTagName("menu")[0];
    };

    MenuController.prototype.addListeners = function() {
      this.toggle.addEventListener("click", (function(_this) {
        return function() {
          return _this.toggleMenu();
        };
      })(this));
      return window.addEventListener("keypress", (function(_this) {
        return function(e) {
          if (e.keyCode === 109) {
            return _this.toggleMenu();
          }
        };
      })(this));
    };

    MenuController.prototype.toggleMenu = function() {
      var color;
      document.body.classList.toggle("menu-open");
      if (document.body.classList.contains("menu-open")) {
        color = this.colors[Math.floor(Math.random() * this.colors.length)];
        portfolio.background.vel.scrollX += 10;
        return this.menu.setAttribute("class", color);
      } else {
        return portfolio.background.vel.scrollX -= 10;
      }
    };

    MenuController.prototype.builder = function() {
      var content, i, m;
      m = "<div class=\"content\">";
      content = portfolio.content;
      i = 0;
      while (i < content.length) {
        if (content[i].noTab !== true) {
          m += "<a href=\"" + content[i].slug + "/\"><h1>" + content[i].title + "</h1></a>";
          if (i + 1 !== content.length) {
            m += "<hr />";
          }
        }
        i++;
      }
      m += "</div>";
      return this.menu.innerHTML = m;
    };

    return MenuController;

  })();
});

//# sourceMappingURL=MenuController.js.map
