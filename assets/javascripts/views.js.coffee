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
    "click button": "viewItems"

  render: ->
    @$el.html @template(@)
    @

  viewItems: ->
    Grocery.app.navigate "items", trigger: true

class Grocery.Views.AppView
  showView: (view) ->
    @currentView.remove() if @currentView

    @currentView = view
    $("#main").html @currentView.render().el