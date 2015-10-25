assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49

  describe "dealing", ->
    it "should make a two card player hand upon starting", ->
      collection = new Deck()
      playerHand = collection.dealPlayer()
      assert.strictEqual playerHand.length, 2