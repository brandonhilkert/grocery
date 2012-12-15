class Grocery.Routers.App extends Backbone.Router
  initialize: ->
    @appView = new Grocery.Views.AppView()
    chrome = new Grocery.Views.Chrome el: $("#app")
    chrome.render()

  routes:
    "": "index"
    "list/:id/items": "items"

  index: ->
    view = new Grocery.Views.Index()
    @appView.showView view

  items: ->
    view = new Grocery.Views.Index()
    @appView.showView view