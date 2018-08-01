import React, { PureComponent } from 'react'
import { connect } from 'react-redux'

import * as actions from '../actions'

class %CLASS% extends PureComponent {

  constructor (props) {
    super(props)
    this.state = {
    }
  }

  render () {
    return (
      <div>
      </div>
    )
  }
}

const mapState = ({ self, tree, location }) => ({ self, tree, location })

const mapActions = {
  navigate: actions.navigate,
}

export default connect(mapState, mapActions)(%CLASS%)

