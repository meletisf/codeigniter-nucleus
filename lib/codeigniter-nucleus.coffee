CodeigniterNucleusView = require './codeigniter-nucleus-view'
{CompositeDisposable} = require 'atom'

module.exports = CodeigniterNucleus =
  codeigniterNucleusView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @codeigniterNucleusView = new CodeigniterNucleusView(state.codeigniterNucleusViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @codeigniterNucleusView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'codeigniter-nucleus:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @codeigniterNucleusView.destroy()

  serialize: ->
    codeigniterNucleusViewState: @codeigniterNucleusView.serialize()

  toggle: ->
    console.log 'CodeigniterNucleus was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
