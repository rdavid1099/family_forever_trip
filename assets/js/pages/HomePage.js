import React from 'react'
import PropTypes from 'prop-types'

import {Wrapper} from '../styledComponents'

export default function HomePage(props) {
  return (
    <Wrapper className="container">
      <div style={{textAlign: "center"}}>
        <h1>FamilyForeverTrip</h1>
        <p>A place for our family and friends to share their experiences on our first annual FamilyForeverTrip ❤️</p>
      </div>

      <img src="https://media.giphy.com/media/S5JSwmQYHOGMo/giphy.gif" alt="Under Construction" style={{margin: "125px 45% 0 45%"}} />
    </Wrapper>
  )
}
