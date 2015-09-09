Wc = require '../lib/wc'

describe "toywc:wordcount", ->
  it "should print the right number of words of a given text"

  runs ->
    words = Wc.wordcount("hello world")
    expect(words).toEqual(2)
