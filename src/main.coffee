new AppView(model: new App()).$el.appendTo 'body'

# new game

# bust when player goes over 21
  # trigger a bust in App model when score goes over 21
  # listen for bust in the view, render a bust message to the dom from the view
  # end of turn event

# player can choose to stand
  
  # end of turn event

# on end of player turn, flip dealer card
  # in App.coffee on end of turn 

# dealer has to hit until they reach 17 or go bust, then they have to stand
  # on end of turn event, hit dealer hand until dealer score >= 17
  # trigger end of turn

# on dealer end of turn, announce who wins
  # determine who wins in app.coffee
    # win, loss, tie
      ## player loses if they bust
      ## dealer loses if they bust
      ## if neither has busted, higher score wins
      ## if tie, go to next game
  # trigger player win or dealer win or tie
  # appView.coffee listens for winner and renders it to the dom

