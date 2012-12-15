//= require "app"
//= require "models"
//= require "views"
//= require "routers"

$(function() {
  Grocery.app = new Grocery.Routers.App();
  Backbone.history.start();
});
