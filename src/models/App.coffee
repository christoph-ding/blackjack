# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    # listenTo win/lose ... restart if lose
    @listenTo @.get('playerHand'), "lose", => alert "You bust."
    @listenTo @.get('dealerHand'), "compareScores", => @compareScores()
    @listenTo @.get('dealerHand'), "win", => alert "you win!"

  compareScores: ->
    @.get('dealerHand').models[0].flip()
    playerScore = @.get('playerHand').scores()[0]
    dealerScore = @.get('dealerHand').dealerScore()[0]
    if playerScore > dealerScore 
      alert "you win!"        
    else if playerScore == dealerScore 
      alert "Push. Play again!"               
    else if playerScore < dealerScore 
      alert "you lose...Play again!"                        
