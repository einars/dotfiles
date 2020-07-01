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

const mapState = ({ location }) => ({ location })

export default connect(mapState)(CCC)

