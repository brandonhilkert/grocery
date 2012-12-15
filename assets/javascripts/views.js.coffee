class Grocery.Views.Chrome extends Backbone.View
  initialize: ->
    @headerView = new Grocery.Views.Header()

  render: ->
    @$el.append @headerView.render().el
    @$el.append "<div id='main'></div>"
    @

class Grocery.Views.Header extends Backbone.View
  template: template("header")

  render: ->
    @$el.html @template(@)
    @

class Grocery.Views.Index extends Backbone.View
  template: template("index")

  events:
    "click button": "createList"

  render: ->
    @$el.html @template(@)
    @

  createList: ->
    list = new Grocery.Models.List()
    list.save {},
      success: ->
        Grocery.app.navigate "/list/#{list.get("id")}/items", trigger: true

class Grocery.Views.NewItem extends Backbone.View
  template: template("new-item")
  className: "new-item"

  events:
    "click button": "addItem"
    "keyup input": "addOnEnter"

  render: ->
    @$el.html @template(@)
    @

  addItem: ->
    item = $("#item").val()
    Grocery.items.create
      name:   item

    $("#item").val("")

  addOnEnter: (event) ->
    @addItem() if event.keyCode == 13

class Grocery.Views.Items extends Backbone.View
  tagName: "ul"
  className: "items"

  initialize: ->
    @collection.on "reset", @addAll, @
    @collection.on "add", @addOne, @

  render: ->
    @addAll()
    @

  addAll: ->
    @collection.forEach @addOne, @

  addOne: (item) ->
    itemView = new Grocery.Views.Item model: item
    @$el.append itemView.render().el


class Grocery.Views.Item extends Backbone.View
  className: "item"
  tagName: "li"
  template: template("item")

  events:
    "click li":       "toggleActions"
    "click .cancel":  "toggleActions"
    "click .delete":  "deleteItem"

  initialize: ->
    @model.on "destroy", @remove, @

  render: ->
    @$el.html @template(@model.toJSON())
    @

  toggleActions: (event) ->
    $(event.currentTarget).find(".actions").toggle()

  deleteItem: (event) ->
    item = $(event.currentTarget).data("name")
    model = Grocery.items.where name: item
    model[0].destroy()