define(["portfolio/controllers/BuildController", "portfolio/controllers/RouterController", "portfolio/controllers/BackgroundController", "portfolio/controllers/MenuController", "portfolio/controllers/LoadController"], function(BuildController, RouterController, BackgroundController, MenuController, LoadController) {
  var App;
  return App = function() {
    window.portfolio = {
      build: new BuildController,
      background: new BackgroundController,
      router: new RouterController,
      menu: new MenuController,
      load: new LoadController,
      start: function() {
        var i, run, _results;
        i = 0;
        run = ["build", "background"];
        _results = [];
        while (i < run.length) {
          portfolio[run[i]].init();
          _results.push(i++);
        }
        return _results;
      }
    };
    return portfolio.start();
  };
});

//# sourceMappingURL=App.js.map
