AtomLanguagePawnView = require './language-pawn-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomLanguagePawn =
  atomLanguagePawnView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomLanguagePawnView = new AtomLanguagePawnView(state.atomLanguagePawnViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomLanguagePawnView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'language-pawn:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomLanguagePawnView.destroy()

  serialize: ->
    atomLanguagePawnViewState: @atomLanguagePawnView.serialize()

  toggle: ->
    console.log 'AtomLanguagePawn was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
