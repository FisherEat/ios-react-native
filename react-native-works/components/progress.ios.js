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
  ProgressViewIOS,
} from 'react-native';

import TimerMixin from 'react-timer-mixin'

class rnToday_2 extends Component {
 mixins: [TimerMixin]

 constructor(props) {
   super(props);
   this.state={progress: 0}
 }
 componentDidMount() {
   this.updateProgress();
 }
 updateProgress() {
   var progress = this.state.progress + 0.01;
   this.setState({progress});
   //此处直接使用该动画函数，前面不用加 this,加this报错
   requestAnimationFrame(() => this.updateProgress());
 }
 getProgress(offset) {
   var  progress = this.state.progress + offset;
   return Math.sin(progress % Math.PI) % 1;
 }
  render() {
    return (
      <View style={styles.container}>
        <ProgressViewIOS style={styles.progressView} progress={this.getProgress(0)} />
        <ProgressViewIOS style={styles.progressView} progressTintColor="purple" progress={this.getProgress(0.2)} />
        <ProgressViewIOS style={styles.progressView} progressTintColor="red" progress={this.getProgress(0.4)} />
        <ProgressViewIOS style={styles.progressView} progressTintColor="orange" progress={this.getProgress(0.6)} />
        <ProgressViewIOS style={styles.progressView} progressTintColor="yellow" progress={this.getProgress(0.8)} />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    marginTop: -20,
    backgroundColor: 'transparent',
  },
  progressView: {
    marginTop: 20,
  },
});

AppRegistry.registerComponent('rnToday_2', () => rnToday_2);
