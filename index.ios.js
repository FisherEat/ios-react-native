import React, {
  AppRegistry,
  Component,
  StyleSheet,
  View,
  Text,
} from 'react-native';

class Demos extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.text}>Welcome to React!</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  text: {
      fontSize: 16,
      color: '#333333',
  },
});

AppRegistry.registerComponent('Demos', () => Demos);
