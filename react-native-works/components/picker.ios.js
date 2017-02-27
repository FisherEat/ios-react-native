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
  PickerIOS,
  Dimensions,
} from 'react-native';

var array = [
  {label: "苹果", value: "apple"},
  {label: "梨", value: "pear"},
  {label: "香蕉", value: "banana"},
  {label: "菠萝", value: "pineapple"},
  {label: "葡萄", value: "grape"},
  {label: "桃", value: "peach"},
];

class rnToday_2 extends Component {
 constructor(props) {
   super(props);
   this.state = {selected: "pear"}
 }

  render() {
    return (
      <View style={styles.parent}>
        <Text style={styles.title}>选择你喜欢的水果</Text>
        <PickerIOS
          style={{width: Dimensions.get('window').width}}
          selectedValue={this.state.selected}
          onValueChange={(value) => this.setState({selected: value})} >
          {array.map((obj) => (
            <PickerIOS.Item
              key={obj.value+obj.label}
              value={obj.value}
              label={obj.label}
            />
          ))}
        </PickerIOS>
        <Text style={styles.text}>你已经选择：{this.state.selected}</Text>
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
    backgroundColor: '#e9ea00',
  },
  title: {
    marginTop: 10,
    height: 40,
  },
  text: {
    fontSize: 18,
    color: '#660099',
  },
});

AppRegistry.registerComponent('rnToday_2', () => rnToday_2);
