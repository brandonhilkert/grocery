class Grocery.Routers.App extends Backbone.Router
  initialize: ->
    chrome = new Grocery.Views.Chrome el: $("#app")
    chrome.render()
    @$mainEl = $("#main")

  routes:
    "": "index"
    "list/:id/items": "items"

  index: ->
    view = new Grocery.Views.Index()
    @$mainEl.html view.render().el

  items: (id) ->
    Grocery.items = new Grocery.Collections.Items [], listId: id
    Grocery.items.fetch()

    newItemView = new Grocery.Views.NewItem()
    @$mainEl.html newItemView.render().el

    itemsView = new Grocery.Views.Items collection: Grocery.items
    @$mainEl.append itemsView.render().el
