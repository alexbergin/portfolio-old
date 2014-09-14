define(function() {
  var LoadController;
  return LoadController = (function() {
    function LoadController() {}

    LoadController.prototype.init = function() {
      this.getElements();
      return this.addListeners();
    };

    LoadController.prototype.getElements = function() {
      this.lightbox = document.getElementsByTagName("aside")[0];
      return this.els = document.getElementsByClassName("image-asset");
    };

    LoadController.prototype.imgs = function(section) {
      var els, i, _results;
      els = section.getElementsByClassName("image-asset");
      i = 0;
      _results = [];
      while (i < els.length) {
        els[i].loaded = function() {
          return this.classList.add("loaded");
        };
        els[i].addEventListener("load", function() {
          return this.loaded();
        });
        els[i].setAttribute("src", els[i].getAttribute("data-src"));
        _results.push(i++);
      }
      return _results;
    };

    LoadController.prototype.addListeners = function() {
      var i, self;
      i = 0;
      self = this;
      while (i < this.els.length) {
        this.els[i].addEventListener("click", function() {
          self.lightbox.style.backgroundImage = "url(" + (this.getAttribute("data-src")) + ")";
          return self.lightbox.classList.add("open");
        });
        i++;
      }
      return this.lightbox.getElementsByTagName("a")[0].addEventListener("click", (function(_this) {
        return function() {
          return _this.lightbox.classList.remove("open");
        };
      })(this));
    };

    return LoadController;

  })();
});

//# sourceMappingURL=LoadController.js.map
