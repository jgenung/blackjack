# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    currentPlayerHand = @get 'playerHand'
    currentPlayerHand.on 'endOfTurn', @dealerTurn, this
    return
    
    
  dealerTurn: ->
    currentDealerHand = @get 'dealerHand'
    currentDealerHand.at(0).flip()
    console.log currentDealerHand.optimalScore()
    while currentDealerHand.optimalScore() < 17
      currentDealerHand.hit() 
    return  

  