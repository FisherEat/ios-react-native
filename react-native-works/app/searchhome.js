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
  TouchableHighlight,
} from 'react-native';

import Button from '../components/button.ios'
import ModalBox from 'react-native-modalbox'
import SearchBar from './common/SearchBar'
import SuperHomeComponent from './super/superhome'

var NativeBoard = NativeModules.GLSpringboard

export default class SearchHome extends Component {
  constructor(props) {
    super(props);
    this.state = {
      id: 2,
      back: null,
      isOpen: true,
      isDisabled: false,
      swipeToClose: true,
    }
  }
  onClose() {
    console.log("Modal just closetd");
  }
  onOpen() {
    console.log('Modle opened!')
  }
  _pressButton() {
    const navigator = this.props.navigator;
    if (navigator) {
      navigator.push({

      })
    }
  }
  _pressToNative() {
    var params = {name: 'gaolong', 'password': 123}
    var callback = () => {};
    NativeBoard.showNativeView(params, function(callback){
      console.log(callback);
    });
  }
  render() {
    let defaultName = 'SuperHomeComponent'
    let defaultComponent = SuperHomeComponent
    return (
      <View style={styles.container}>
        <ModalBox
            style={[styles.modal, styles.modal1]}
            ref={"modal1"}
            swipeToClose={this.state.swipeToClose}
            onOpened={this.onOpen}
            isOpen={this.state.isOpen}
        >
        </ModalBox>
        <Text>Welcome!</Text>
        <Button></Button>
        <Text style={styles.text}>value:{this.state.back}</Text>
        <SearchBar cancelButtonClicked={()=>{
          alert('shite')
        }}>
        </SearchBar>
        <TouchableHighlight
          style={{width: 200, height: 40, backgroundColor: '#9845a3'}}
          onPress={()=>{
            const navigator = this.props.navigator;
            if (navigator) {
              navigator.push({
                name: 'SuperHome',
                component: SuperHomeComponent,
                params: {
                  person: 'gaolong',
                   age: 21,
                   getMsg:function(msg) {
                     console.log(msg);
                }},
                title: {shit: 'shit'},
              })
            }
          }}>
          <Text style={{fontSize: 16}}>这个是测试导航以及参数传递的按钮</Text>
        </TouchableHighlight>
      </View>
    )
  }
 }

 // <Navigator
 //   initialRoute={{name:defaultName, component: defaultComponent}}
 //   configureScene={(route) => {
 //     return Navigator.SceneConfigs.VerticalDownSwipJump
 //   }}
 //   renderScene={(route, navigator) => {
 //     let Component = route.component;
 //     return <Component {...route.params} navigator={navigator} />
 //   }}
 // />

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
   modal: {
     justifyContent: 'center',
     alignItems: 'center',
   },
   modal1: {
   height: 230,
   backgroundColor: "#3B5998"
  },
 })
