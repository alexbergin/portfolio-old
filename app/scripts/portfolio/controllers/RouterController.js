var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

define(function() {
  var RouterController;
  return RouterController = (function() {
    function RouterController() {
      this.render = __bind(this.render, this);
      this.update = __bind(this.update, this);
    }

    RouterController.prototype.x = 0;

    RouterController.prototype.y = 0;

    RouterController.prototype.needsUpdate = true;

    RouterController.prototype.active = "page-home";

    RouterController.prototype.lastActive = "page-home";

    RouterController.prototype.init = function() {
      this.getElements();
      this.addListeners();
      this.update();
      return this.render();
    };

    RouterController.prototype.getElements = function() {
      this.site = document.getElementsByTagName("main")[0];
      this.upButton = document.getElementsByTagName("nav")[0].getElementsByClassName("up")[0];
      this.downButton = document.getElementsByTagName("nav")[0].getElementsByClassName("down")[0];
      this.leftButton = document.getElementsByTagName("nav")[0].getElementsByClassName("left")[0];
      return this.rightButton = document.getElementsByTagName("nav")[0].getElementsByClassName("right")[0];
    };

    RouterController.prototype.addListeners = function() {
      window.addEventListener("hashchange", function() {
        document.body.classList.remove("menu-open");
        return portfolio.router.update();
      });
      window.addEventListener("keyup", (function(_this) {
        return function(e) {
          switch (e.keyCode) {
            case 38:
              if (_this.up !== null) {
                return window.location.hash = _this.up;
              }
              break;
            case 40:
              if (_this.down !== null) {
                return window.location.hash = _this.down;
              }
              break;
            case 37:
              if (_this.left !== null) {
                return window.location.hash = _this.left;
              }
              break;
            case 39:
              if (_this.right !== null) {
                return window.location.hash = _this.right;
              }
          }
        };
      })(this));
      return window.addEventListener("resize", portfolio.router.update);
    };

    RouterController.prototype.update = function() {
      var article, hash, i, o, page, pastX, pastY, section, xvel, yvel;
      page = window.location.hash;
      if (page === "" || page === "#" || page === "#/") {
        window.location.hash = "/home/";
        return;
      }
      article = -1;
      section = -1;
      i = 0;
      while (i < portfolio.content.length) {
        o = 0;
        while (o < portfolio.content[i].pages.length) {
          hash = portfolio.content[i].slug;
          if (o > 0) {
            hash += "/" + o;
          }
          if (hash === page || hash + "/" === page) {
            this.lastActive = this.active;
            this.lastSection = this.activeSection;
            this.active = "page-" + (portfolio.content[i].slug.substring(2));
            this.activeSection = o;
            document.getElementsByClassName(this.active)[0].classList.add("active");
            document.getElementsByClassName(this.active)[0].getElementsByTagName("section")[o].classList.add("active");
            portfolio.load.imgs(document.getElementsByClassName(this.active)[0].getElementsByTagName("section")[o]);
            article = i;
            section = o;
          }
          o++;
        }
        i++;
      }
      if (article === -1 || section === -1) {
        window.location.hash = "/404";
        return;
      }
      pastX = this.x;
      pastY = this.y;
      this.x = section;
      this.y = article;
      if (portfolio.content[this.y].pages[this.x + 1] !== void 0) {
        this.right = "" + portfolio.content[this.y].slug + "/" + (this.x + 1) + "/";
      } else {
        this.right = null;
      }
      if (portfolio.content[this.y].pages[this.x - 1] !== void 0) {
        if (this.x - 1 > 0) {
          this.left = "" + portfolio.content[this.y].slug + "/" + (this.x - 1) + "/";
        } else {
          this.left = "" + portfolio.content[this.y].slug + "/";
        }
      } else {
        this.left = null;
      }
      if (portfolio.content[this.y - 1] !== void 0 && portfolio.content[this.y - 1].noTab !== true) {
        this.up = "" + portfolio.content[this.y - 1].slug + "/";
      } else {
        this.up = null;
      }
      if (portfolio.content[this.y + 1] !== void 0 && portfolio.content[this.y + 1].noTab !== true) {
        this.down = "" + portfolio.content[this.y + 1].slug + "/";
      } else {
        this.down = null;
      }
      this.upButton.setAttribute("href", this.up);
      this.downButton.setAttribute("href", this.down);
      this.leftButton.setAttribute("href", this.left);
      this.rightButton.setAttribute("href", this.right);
      xvel = 10 * (pastX - this.x);
      yvel = 10 * (pastY - this.y);
      setTimeout((function(_this) {
        return function() {
          portfolio.background.vel.scrollX += xvel;
          return portfolio.background.vel.scrollY += yvel;
        };
      })(this), 100);
      return this.needsUpdate = true;
    };

    RouterController.prototype.render = function() {
      return setInterval((function(_this) {
        return function() {
          var articles, i, n, sections, style, x, y, _results;
          if (_this.needsUpdate === true) {
            _this.needsUpdate = false;
            x = -_this.x * window.innerWidth + "px";
            y = -_this.y * window.innerHeight + "px";
            style = "-webkit-transform: translate( " + x + " , " + y + "); ";
            style += "-ms-transform: translate( " + x + " , " + y + "); ";
            style += "transform: translate( " + x + " , " + y + "); ";
            _this.site.setAttribute("style", style);
            articles = document.getElementsByTagName("article");
            i = 0;
            _results = [];
            while (i < articles.length) {
              sections = articles[i].getElementsByTagName("section");
              n = 0;
              while (n < sections.length) {
                if (sections[n] !== articles[i].getElementsByTagName("section")[_this.activeSection] && sections[n] !== articles[i].getElementsByTagName("section")[_this.lastSection]) {
                  sections[n].classList.remove("active");
                }
                n++;
              }
              if (articles[i].classList.contains(_this.active) === false && articles[i].classList.contains(_this.lastActive) === false) {
                articles[i].classList.remove("active");
              }
              _results.push(i++);
            }
            return _results;
          }
        };
      })(this), 150);
    };

    return RouterController;

  })();
});

//# sourceMappingURL=RouterController.js.map
