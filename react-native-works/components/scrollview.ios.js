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

 }

  render() {
    var repeatArr = Array(100).join("1").split("")
    return (
      <View style={styles.parent}>
        <View style={styles.header}>
          <Text style={styles.text}>登陆</Text>
        </View>
         <ScrollView style={styles.s1} pagingEnabled={true} >
         {
           repeatArr.map(function(el, index){
             return <Text key={index} style={[styles.text,{color:'#000'}]}>
             <Text style={styles.b}>{index}</Text>
             这是主面板{'\n'}
             </Text>
           })
         }
        </ScrollView>
        <ScrollView  style={styles.s2}  >
         {
           repeatArr.map(function(el, index){
             return <Text key={index} style={[styles.text,{color:'#000'}]}>
             <Text style={styles.b}>{index}</Text>
             这是主面板{'\n'}
             </Text>
           })
         }
        </ScrollView>
        <ScrollView style={styles.s3} stickyHeaderIndices={[0]} >
         {
           repeatArr.map(function(el, index){
             return <Text key={index} style={[styles.text,{color:'#000'}]}>
             <Text style={styles.b}>{index}</Text>
              {index == 0 ?'这是第一行\n': '这是主面板\n' }
             </Text>
           })
         }
        </ScrollView>
        <View style={styles.footer}>
          <Text style={styles.text}>
            注册地址
          </Text>
        </View>
      </View>
    );
  }
}

// <ScrollView style={styles.s1} pagingEnable={true}>
//   {
//     repeatArray.map(
//       (el, index) =>
//       {
//         return
//          <Text key={index} style={[styles.text], {color: '#000'}}>
//           <Text style={styles.b}>{index}</Text>
//           这是主面板{'\n'}
//          </Text>
//       })
//   }
// </ScrollView>
// <ScrollView style={styles.s2}>
//   {
//     repeatArray.map(function(el, index)
//       {
//          <Text key={index} style={[styles.text,{color: '#000'}]}>
//           <Text style={styles.b}>{index}</Text>
//           这是主面板{'\n'}
//          </Text>
//       })
//   }
// </ScrollView>

const styles = StyleSheet.create({
  parent: {
    flex: 1,
    flexDirection: 'column',
    backgroundColor: '#ddc',
  },
  s0: {
    flex: 1,
    backgroundColor: 'white',
  },
  s1: {
    flex: 1,
    backgroundColor: '#efda5b',
  },
  s2: {
    flex: 1,
    backgroundColor: '#a4fab0',
  },
  s3: {
    flex: 1,
    backgroundColor: '#fb3568',
  },
  header: {
    height: 40,
    backgroundColor: '#31b0d0',
  },
  footer: {
    height: 40,
    backgroundColor: '#5cb55c',
  },
  b: {
    fontWeight: 'bold',
  },
  text: {
    padding: 10,
    fontSize: 12,
    color: '#fff',
    lineHeight: 18,
  },
});

AppRegistry.registerComponent('rnToday_2', () => rnToday_2);
