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
  TextInput,
} from 'react-native';

class rnToday_2 extends Component {
 constructor(props) {
   super(props);
   this.state={value: 0, text: '', type: false}
 }

  render() {
    return (
      <View style={styles.parent}>
        <TextInput
          style={styles.textinput}
          clearButtonMode={'always'}
          placeholder={'placeholder'}
          placeholderTextColor={'#bfc5ee'}
          onChangeText={(val) => this.setState({text:val})}
          onBlur={() => this.setState({type: 'blur'})}
          onChange={() => this.setState({type: 'change'})}
          onFocus={() => this.setState({type: 'focus'})}
          value={this.state.text}
        />
        <TextInput
           style={styles.textinput}
           value={'用于失去焦点'}
        />
        <Text style={styles.text}>text: {this.state.text}{'\n'}</Text>
        <Text style={styles.text}>EventType:{String(this.state.type)}</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  parent: {
    flex: 1,
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center',
  },
  textinput: {
    borderWidth: 1,
    marginTop: 10,
    borderColor: 'gray',
    height: 40,
  },
  text: {
    fontSize: 16,
    color: '#660099',
  },
});

AppRegistry.registerComponent('rnToday_2', () => rnToday_2);
