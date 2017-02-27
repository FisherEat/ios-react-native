/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

import React, {
  AppRegistry,
  Component,
  StyleSheet,
  Text,
  View,
  Image,
  Navigator,
  TouchableOpacity,
  NativeModules,
} from 'react-native';

import Button from '../components/button.ios'
import Common from './common/Common'
import URLRequest from './common/URLRequest'
import HUD from './common/HUD'

export default class SuperHome extends Component {
  constructor(props) {
    super(props);
    this.state = {
    }
  }
  componentDidMount() {

  }
  requestData() {

  }
  render() {
    return (
      <View style={styles.container}>
      </View>
    )
  }
 }

 const styles = StyleSheet.create({
   container: {
     flex: 1,
     flexDirection: 'column',
     alignItems: 'center',
     justifyContent: 'center',
     backgroundColor: '#946999',
   },
   text: {
     fontSize: 18,
   },
   button: {
     marginTop: 20,
     height: 50,
     width: 200,
     alignItems: 'center',
     justifyContent: 'center',
     backgroundColor: 'white',
     borderColor: '#889d5f',
     borderWidth: 3,
     borderRadius: 5,
   },
 })
