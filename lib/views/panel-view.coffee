React = require 'react-for-atom'

HeaderView =
  React.createClass
    displayName: "HeaderView"
    render: ->
      props =
        className: "idris-panel-header"
      React.DOM.div props, "Idris: ", this.props.header

PanelView =
  React.createClass
    displayName: "HelloMessage"
    render: ->
      header = React.createElement HeaderView,
        header: "Loaded"

      childView = React.createElement this.props.childView
      childViewContainer =
        React.DOM.div { className: 'idris-panel-content' }, childView

      props =
        className: 'idris-panel-view'
      React.DOM.div props, header, childViewContainer

openPanel = (node, content) ->
  debugger
  panelView = React.createElement PanelView,
    childView: content

  React.render panelView, node


module.exports =
  PanelView: PanelView
  openPanel: openPanel
