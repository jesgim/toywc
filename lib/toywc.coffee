Wc = require './wc'
ToywcView = require './toywc-view'
{CompositeDisposable} = require 'atom'

module.exports = Toywc =
  toywcView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @toywcView = new ToywcView(state.toywcViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @toywcView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'toywc:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @toywcView.destroy()

  serialize: ->
    toywcViewState: @toywcView.serialize()

  toggle: ->
    console.log 'Toywc was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      words = 0
      if editor = atom.workspace.getActiveTextEditor()
        words = Wc.wordcount(editor.getText())
      @toywcView.setCount(words)
      @modalPanel.show()
