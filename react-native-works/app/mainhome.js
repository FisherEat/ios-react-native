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
  NetInfo,
} from 'react-native';

import Button from '../components/button.ios'
import Common from './common/Common'
import URLRequest from './common/URLRequest'
import HUD from './common/HUD'

var NativeBoard = NativeModules.GLSpringboard

export default class MainHome extends Component {
  constructor(props) {
    super(props);
    this.state = {
      id: 2,
      params:null,
      back: null,
      dataSource: {},
      connectionInfoHistory: []
    }
  }
  componentDidMount() {
     // this.requestData();
     this.requestWMData();
     this.requestByWebSocket();
     NetInfo.addEventListener(
         'change',
         this._handleConnectionInfoChange
     );
  }
  componentWillUnmount() {
      
  }
  _handleConnectionInfoChange(connectionInfo) {
      const connectionInfoHistory = this.state.connectionInfo.slice();


  }
  netInfoRequest() {

  }
  requestByWebSocket() {
      var ws = new WebSocket('http://baidu.com');
      ws.onopen = () => {
          ws.send('China');
      }
      ws.onmessage = (e) => {
          console.log(e.data);
      }
      ws.onerror = (e) => {
          console.log(e.message);
      }
      ws.onclose = (e) => {
          console.log(e.code, e.reason);
      }
  }
  //自由行首页数据接口通了，但是返回的数据是空。必须弄清楚原因在行动。
  requestData() {
      let path = 'superDiy/home/baseInfo';
      let params;
      URLRequest.get(URLRequest.TNHostSite, path, params).then((response)=> {
          console.log(response);
          this.setState({dataSource: response.data})
      }).catch((error) => {
          console.log(error);
          aler("Error happened!");
      })
  }
  requestWMData() {
      let parmas = {param1: 'wl', param2:'0', param3: '0', param4:'1'};
      URLRequest.specialGet(URLRequest.WMHostSite, parmas).then((response) => {
          console.log(response.data.list);
      }).catch((error) => {
         console.log();
      })
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
    var data = ['1',2, 4];
    return (
      <View style={styles.container}>
        <Text>这是第一版 1.0.0</Text>
        <Text>Welcome! value={data.map((element, index) => {
           return <Text>haode</Text>
        })}</Text>
        <Button></Button>
        <TouchableOpacity style={styles.button} onPress={this._pressToNative.bind(this)}>
          <Text style={styles.text}>点我跳转到Native页面</Text>
        </TouchableOpacity>
        <Text style={styles.text}>value:{this.state.back}</Text>
      </View>
    )
  }
 }

 // <View style={{width: 100, height: 100, backgroundColor: 'white'}}>
 //  <HUD position={"center"} style={{width: 100, height:100}} visible={true} />
 // error happened: No component found for view with name "ARTSurfaceView"
 // </View>
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
