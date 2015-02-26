# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    #alert( @get('playerHand').at(0).get 'value')
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'endOfTurn', @dealerTurn, this
    @get('playerHand').on 'endOfGame', @decideWinner, this
    # if @get('playerHand').optimalScore() == 21
      # @trigger 'winnerDecided', 'BlackJack!'
    # set winner in anonymous function before call to decideWinner
    # console.log @get('playerHand').optimalScore()
    return
    
  dealerTurn: ->
    @get('dealerHand').at(0).flip()
    while @get('dealerHand').optimalScore() < 17
      @get('dealerHand').hit() 
    @decideWinner()
    return

  decideWinner: ->
    @trigger('disable')
    if @get('playerHand').optimalScore()>21
      @trigger 'winnerDecided','Player is bust!'
    else if @get('playerHand').optimalScore()==21
      @trigger 'winnerDecided','BlackJack!'
    else if @get('dealerHand').optimalScore()>@get('playerHand').optimalScore()&&@get('dealerHand').optimalScore()<=21
      @trigger 'winnerDecided','Dealer wins!'
    else if @get('dealerHand').optimalScore()==@get('playerHand').optimalScore()
      @trigger 'winnerDecided','Tie game!'
    else
      @trigger 'winnerDecided','Player wins!'

  newGame: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'endOfTurn', @dealerTurn, this
    @get('playerHand').on 'endOfGame', @decideWinner, this
    return



  