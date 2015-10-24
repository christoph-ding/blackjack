class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    # when my score changes, I will check my score for logic such as winning, losing, etc
    # @.listenTo @, 'change: scores', @checkScore
    # we can HEAR THINGS, and we can invoke the callback function
    # but we are NOT tracking the right 'change'
    # is not triggered by hit or stand. need to know how to access score

  hit: ->
    @add(@deck.pop())
    @last()
    if not @isDealer
      @checkScore()

  stand: ->

  dealerChoice: ->
    # logic for whether dealer decides to hit or stand
    if @dealerScore()[0] < 17 #dealerScore, not scores
      @hit()
      @dealerChoice()
    else
      @checkScore()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: ->
   @reduce (score, card) ->
     score + if card.get 'revealed' then card.get 'value' else 0
   , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  dealerMinScore: -> 
   @reduce (score, card) ->
      score + card.get 'value' 
   , 0

  dealerScore: -> 
    [@dealerMinScore(), @dealerMinScore() + 10 * @hasAce()]

  checkScore: ->
    # situation for human
    if not @isDealer
      if @scores()[0] > 21     
        @trigger "lose", @

    # situation for dealer
    if @isDealer      
      console.log @.models
      if @dealerScore()[0] > 21   
        @trigger "win", @
      else
        @trigger "compareScores"
