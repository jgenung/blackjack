class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
     #alert array[0]
     @trigger('endOfGame', this) if @optimalScore() == 21 || @minScore() >= 21

  hit: ->
    @add(@deck.pop())
    @trigger('endOfGame', this) if @optimalScore() == 21 || @minScore() >= 21
    # display either "You win!" or "Bust, you lose!", deactivate hit/stand until new game button is clicked 

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
     #@trigger('endOfGame', this) if @minScore()+ 10 * @hasAce() == 21 || @minScore() >= 21
     [@minScore(), @minScore() + 10 * @hasAce()]

  optimalScore: ->
    if !@hasAce()
      @scores()[0]
    else if @scores()[1] <= 21
      @scores()[1]
    else
      @scores()[0]

  stand: ->
    @trigger('endOfTurn', this)


