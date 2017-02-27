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
  TouchableHighlight,
} from 'react-native';

export default class SuperHome extends Component {
  constructor(props) {
    super(props);
    this.state = {
    }
  }
  componentDidMount() {

  }
  _pressButton() {
    const navigator = this.props.navigator;
    if (this.props.person == 'gaolong') {
      let backMsg = "I know what you want";
      this.props.getMsg(backMsg);
    }
    if (navigator) {
      this.props.navigator.pop();
    }
  }
  requestData() {

  }
  render() {
    return (
      <View style={{flex: 1, flexDirection: 'column', justifyContent: 'center', alignItems: 'center'}}>
        <Text style={{fontSize: 16, color: 'black'}}>
        这是个react 页面
        </Text>
        <Text style={{fontSize: 16, color: 'black'}}>
        {this.props.person}
        </Text>
        <TouchableHighlight onPress={this._pressButton.bind(this)}>
          <Text style={{fontSize: 16, color: 'black'}}>Jump Back!</Text>
        </TouchableHighlight>
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
