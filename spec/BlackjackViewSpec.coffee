# test the scoring of hands and your model of a deck of cards
assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe "hands", ->
    it "should render when we hit", ->

      # need to download sinon spy for this to work
      # sinon.spy(HandView.prototype, "render")
      # hand.hit()
      # expect(handView.render).to.have.been.called