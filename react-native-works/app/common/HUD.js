/**
 * created by schiller
 */
 import React from 'react-native'
 import AppConfig from './AppConfig'
 import Modalbox from 'react-native-modalbox'
 import Progress from 'react-native-progress'

//modalbox第三方库官网
//https://github.com/maxs15/react-native-modalbox/blob/master/Example/index.ios.js

 const {
   View,
   Component,
   Text,
   StyleSheet,
 } = React

 class HUD extends Component {
   constructor(props) {
     super(props)
   }
   render () {
     return (
       <Modalbox
          style={[styles.modalbox]}
          position={"center"}
          backdropOpacity={0.3}
          swipeToClose={false}
          backdropPressToClose={false}
          isOpen={this.props.visible}
          >
          <Progress.CircleSnail
            color={['red', 'green', 'orange']}
            thickness={2}
          />
          <Text style={styles.text}>加载中...</Text>
       </Modalbox>
     )
   }
 }

 const styles = StyleSheet.create({
   modalbox: {
     justifyContent: 'center',
     alignItems: 'center',
     backgroundColor: 'black',
     height: 100,
     width: 100,
     marginTop: -20,
     borderRadius: 10,
   },
   text: {
     color: "black",
     fontSize: 14,
     marginTop: 5,
   },
 })

export default HUD
