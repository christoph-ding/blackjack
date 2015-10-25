class window.Card extends Backbone.Model
  initialize: (params) ->
    @set
      revealed: true
      value: if !params.rank or 10 < params.rank then 10 else params.rank
      suitName: ['spades', 'diamonds', 'clubs', 'hearts'][params.suit]
      rankName: switch params.rank
        when 0 then 'king'
        when 1 then 'ace'
        when 11 then 'jack'
        when 12 then 'queen'
        else params.rank
        # Note: Face cards should be worth 10, Ace should be 1 or 11. change if incorrect
  
  imagePath: ->
    if @get 'revealed'
      imagePath: 'img/cards/' + @get('rankName') + '-' + @get('suitName') + ".png"
    else
      imagePath: 'img/card-back.png'      

  flip: ->
    @set 'revealed', !@get 'revealed'