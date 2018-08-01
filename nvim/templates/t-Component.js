import React, { PureComponent } from 'react'
import { connect } from 'react-redux'

class CCC extends PureComponent {
  render () {
    return (
      <div>
      </div>
    )
  }
}

const mapState = ({ self, tree, location }) => ({ self, tree, location })

export default connect(mapState)(CCC)

