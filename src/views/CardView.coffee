class window.CardView extends Backbone.View

  className: 'card'

  # template: _.template '<%= rankName %> of <%= suitName %>'
  template: _.template '<img src=<%= imagePath %> />'

  initialize: -> 
    @model.on 'flip', => @render()
    @render()

  render: ->
    @$el.children().detach()
    # @$el.append('img').attributes('src', @model.imagePath)
    @$el.addClass 'covered' unless @model.get 'revealed'
    if @model.get('revealed')
      @$el.html @template @model.imagePath()


