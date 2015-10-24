class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    # when my score changes, I will check my score for logic such as winning, losing, etc
    # @.listenTo @, 'change: scores', @checkScore
    @.listenTo @, 'change', console.log @scores()
    # we can HEAR THINGS, and we can invoke the callback function
    # but we are NOT tracking the right 'change'
    # is not triggered by hit or stand. need to know how to access score

  hit: ->
    @add(@deck.pop())
    @last()

  stand: ->

  dealerChoice: ->
    # logic for whether dealer decides to hit or stand
    console.log 'dealer is making a choice'

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  checkScore: ->
    console.log 'i am checking score'

      # if @.scores === 21
      #   trigger "win"
      #   console.log "you win!"
      # if @.scores > 21 
      #   trigger "lose"
      #   console.log "you lose, new game"
    # then trigger win/lose, etc that other things are listening to
