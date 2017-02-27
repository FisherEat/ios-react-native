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
  ScrollView,
  Image,
  TouchableWithoutFeedback,
} from 'react-native';

 export default class rnToday_2 extends Component {
 constructor(props) {
   super(props);
   this.state={active: false}
 }
 onkeyDown() {
   this.setState({active: true});
 }
 onKeyUp() {
   this.setState({active: false});
 }
  render() {
    return (
      <View style={{marginTop: 20}}>
        <TouchableWithoutFeedback
          onPressIn={this.onkeyDown.bind(this)}
          onPressOut={this.onKeyUp.bind(this)}
        >
          <View style={[styles.button, this.state.active ? styles.activeButton : {}]}>
            <Text style={[styles.buttonText, this.state.active ? styles.activeText : {}]}>
              Button
            </Text>
          </View>
        </TouchableWithoutFeedback>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  button: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    width: 200,
    height: 50,
    borderColor: '#00afc7',
    borderWidth: 1,
    borderRadius: 5,
    backgroundColor: 'white',
    shadowColor: '#57c6fa',
    shadowOffset: {width: 2, height: 2},
    shadowOpacity: 0.5,
    shadowRadius: 5,
  },
  buttonText: {
    padding: 5,
    color: "#00afc7",
  },
  activeButton: {
    backgroundColor: "#00afc7",
  },
  activeText: {
    color: '#ffffff',
    fontWeight: 'bold',
  },
});
