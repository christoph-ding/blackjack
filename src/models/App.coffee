# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    # listenTo win/lose ... restart if lose
    @listenTo @.get('playerHand'), "lose", => @.get('dealerHand').models[0].flip(); setTimeout((=>@confirmPlayAgain("You bust!")), 100)
    @listenTo @.get('dealerHand'), "compareScores", => @compareScores()
    @listenTo @.get('dealerHand'), "win", => @.get('dealerHand').models[0].flip(); setTimeout((=>@confirmPlayAgain("Dealer busted. You win!")), 100)

  dealAgain: ->    
    @initialize()
    @trigger 'dealAgain', @

  compareScores: ->
    @.get('dealerHand').models[0].flip()
    playerScore = @.get('playerHand').scores()[0]
    dealerScore = @.get('dealerHand').dealerScore()[0]
    if playerScore > dealerScore 
      setTimeout((=>@confirmPlayAgain("You win!")), 100)     
    else if playerScore == dealerScore 
      setTimeout((=>@confirmPlayAgain("Push.")), 100)              
    else if playerScore < dealerScore 
      setTimeout((=>@confirmPlayAgain("You lose!")), 100)                   

  confirmPlayAgain: (message)-> 
    # if confirm message
    if confirm (message + "\n Play Again?")
      @dealAgain()
    else
      alert "See you later!"
    

    #  if (confirm(message + "\n Play Again?") == true) {
    #   this.dealAgain();
    # } else {
    #   alert("See you later!");
    # }

    # setTimeout((=>confirm ("You bust.")), 100); setTimeout((=>@dealAgain()), 1000);