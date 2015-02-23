class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="new-game-button">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <DIV id="PopUp" style="display: none; position: absolute; left: 100px; top: 50px; border: solid black 1px; padding: 10px; background-color: rgb(200,100,100); text-align: justify; font-size: 12px; width: 135px;"" onmouseover="document.getElementById("PopUp").style.display = "none" ">
    <SPAN id="PopUpText">TEXT</SPAN>
    </DIV>'
    #<DIV id="PopUp" style="display: none; position: "absolute"; left: 100px; top: 50px; border: "solid black 1px"; padding: "10px"; background-color: "rgb(200,100,100)"; text-align: "justify"; font-size: "12px"; width: 135px"; onmouseover="document.getElementById("PopUp").style.display = "none"" >
    #<SPAN id="PopUpText">TEXT</SPAN>
    #</DIV>'

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .new-game-button': -> 
      @model.newGame()
      $('.hit-button').prop('disabled', false)
      $('.stand-button').prop('disabled', false)
      @render()

  initialize: ->
    @render()
    @model.on 'disable', @disable, this
    @model.on('winnerDecided', ((string) ->
      $('#PopUp').css('display', 'block')
      $('#PopUpText').text(string)
      ), this)
    #@model.on('change: all', @render(), this)
    return

  disable: -> 
    $('.stand-button').prop('disabled', true)
    $('.hit-button').prop('disabled', true)
    return

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

