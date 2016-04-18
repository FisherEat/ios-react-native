/**
 * created by schiller
 */
 import React, {
   AppRegistry,
   Component,
   StyleSheet,
   Navigator,
   Text,
   Image,
   View,
 } from 'react-native';

 class ForthReactView extends Component {
   render() {
     return (
         <View style={styles.container}>
             <Text style={styles.text}>这是第四页！！！</Text>
         </View>
     );
   }
 }

 const styles = StyleSheet.create({
     container: {
         flex: 1,
         flexDirection: 'row',
         justifyContent: 'center',
         alignItems: 'center',
         backgroundColor: 'white',
     },
     text: {
         fontSize: 18,
         color: '#666666',
     }
 })

export default ForthReactView
