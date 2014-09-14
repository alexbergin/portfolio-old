"use strict";
require.config({
  baseUrl: "../scripts",
  paths: {
    "jquery": "vendor/jquery/dist/jquery",
    "moment": "vendor/moment/moment",
    "classlist": "vendor/classlist/classList",
    "requestAnimationFrame": "vendor/requestAnimationFrame/app/requestAnimationFrame",
    "touch-swipe": "vendor/jquery-touchswipe/jquery.touchSwipe"
  },
  shim: {
    "touch-swipe": {
      deps: ["jquery"]
    }
  },
  deps: ["jquery", "classlist", "requestAnimationFrame", "touch-swipe"]
});

require(["portfolio/App"], function(App) {
  return new App();
});

//# sourceMappingURL=main.js.map
