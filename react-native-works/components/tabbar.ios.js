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
  TabBarIOS,
} from 'react-native';

class rnToday_2 extends Component {
 constructor(props) {
   super(props);
   this.state = {selectedTab: 'blueTab'}
 }
 _renderPanel (color:string, pageText: string, index: number) {
   return (
     <View style={[styles.panel, {backgroundColor: color}]}>
      <Text style={styles.panelText}>{pageText}</Text>
      <Text style={styles.panelText}>{index}</Text>
     </View>
   );
 }
  render() {
    return (
      <TabBarIOS
        tintColor="white"
        barTintColor="#51c9d2">
        <TabBarIOS.Item
          title="蓝色按钮"
          selected={this.state.selectedTab === 'blueTab'}
          onPress={() => this.setState({selectedTab: 'blueTab'})}>
          {this._renderPanel('#337ab7', 'Blue面板', 0)}
        </TabBarIOS.Item>
        <TabBarIOS.Item
          title="红色按钮"
          selected={this.state.selectedTab === 'redTab'}
          onPress={() => this.setState({selectedTab: 'redTab'})}>
          {this._renderPanel('#d9534f', 'Red面板', 1)}
        </TabBarIOS.Item>
        <TabBarIOS.Item
          title="绿色按钮"
          selected={this.state.selectedTab === 'greenTab'}
          onPress={() => this.setState({selectedTab: 'greenTab'})}>
          {this._renderPanel('#09ea00', 'Green面板', 0)}
        </TabBarIOS.Item>
        <TabBarIOS.Item
          title="黄色按钮"
          selected={this.state.selectedTab === 'yellowTab'}
          onPress={() => this.setState({selectedTab: 'yellowTab'})}>
          {this._renderPanel('#f0ad4e', 'Yellow面板', 0)}
        </TabBarIOS.Item>
      </TabBarIOS>
    );
  }
}

const styles = StyleSheet.create({
  panel: {
    flex: 1,
    paddingTop: 30,
    justifyContent: 'center',
    alignItems: 'center',
  },
  panelText: {
    color: 'white',
    textAlign: 'center',
    fontSize: 16,
    lineHeight: 30,
  },
});

AppRegistry.registerComponent('rnToday_2', () => rnToday_2);
