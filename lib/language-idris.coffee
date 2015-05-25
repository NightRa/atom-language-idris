StatusBarView = require './statusbar-view'
IdrisController = require './idris-controller'
IdrisModel = require './idris-model'
{CompositeDisposable} = require 'atom'
utils = require './utils'
autocompleteProvider = require './autocomplete-provider'

module.exports =
  config:
    pathToIdris:
      type: 'string'
      default: 'idris'

  activate: ->
    warningNoIdris = 'Please put idris into your path or set the right path in the settings of this package.'

    pathToIdris = atom.config.get "language-idris.pathToIdris"

    # check for the verion of idris. this has two purposes:
    # 1. see if there is an idris set in your path or the package config
    # 2. see if the version of idris is new enough for the ide mode
    #    and switch to ideslave for older ones
    idrisVersionPromise = utils.execPromise "#{pathToIdris} --version --nobanner"

    idrisVersionPromise.then ((version) ->
      Promise.resolve utils.parseVersion(version)
    ), (error) ->
      atom.notifications.addWarning warningNoIdris
    .then @startIdrisProcesses

  startIdrisProcesses: (version) ->
    @statusbar = new StatusBarView()
    @model = new IdrisModel(version)
    @controller =
      new IdrisController @statusbar, @model

    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', @controller.getCommands()

  consumeStatusBar: ->
    console.log 'STATUSBAR'

  deactivate: ->
    @subscriptions.dispose()
    this.controller.destroy()

  provideAutocompletion: ->
    debugger
    autocompleteProvider
