@Grocery =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

# Allow events to be pushed to top level Application
_.extend Grocery, Backbone.Events

@template = (name) ->
  Handlebars.compile $("#" + name + "-template").html()