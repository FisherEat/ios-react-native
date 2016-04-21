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
   ListView,
   TouchableHighlight,
   NativeModules,
 } from 'react-native';

var NativeBoard = NativeModules.GLSpringBoard
import AppConfig from '../common/AppConfig'
import NavBar from '../common/NavBar'
import PhotoWall from './photowall'
import Settings from './settings'
import URLRequest from '../common/URLRequest'

const {
  NavigationBar,
  NavBarImageButton,
  NavBarTextButton,
} = NavBar

 class ForthReactView extends Component {
   constructor(props) {
       super(props)
       this.state = {
           activityList: [],
           dataSource: new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2}),
       }
   }
   componentDidMount() {
       let data = [{}, {} ,{} ,{},{},{},{},{}];
       this.setState({
           dataSource: this.state.dataSource.cloneWithRows(data)
       })
       this.requestData();
   }
   requestData() {
     let params = {c:{"cc":"3415","ct":10,"p":14588,"dt":0,"v":"8.0.5"} , d:{}}
     URLRequest.normalGet(params,URLRequest.SUPER_HOME_BASE).then((response) => {
       console.log(response)
     }).catch((error) => {
       console.log(error)
     })
   }
   pushToNative() {
       var params = {code: 10000, msg: 'success'}
       callback = () => {}
       NativeBoard.showNativeView(params, function(callback){
           console.log(callback)
       })
   }
   render() {
     return (
         <View style={styles.container}>
            <NavigationBar
              tintColor='#f8f8f8'
              title={(<TouchableHighlight style={{flex: 1}} underlayColor='transparent' onPress={() => {
                this.props.navigator.push({
                  component: '',
                  title:'搜索',
                  params:{id: 'search'}
                })
              }}>
                <Image
                  style={{width:896*AppConfig.ScaleFactor,flex:1,height:35,resizeMode:'contain',marginBottom:-7}}
                  source={require('../resources/navbar/navbar-searchbar-normal.png')}
                />
                </TouchableHighlight>
              )}

               rightButton={(<NavBarImageButton
                 image={require('./../resources/navbar/navbar-screening-normal.png')}
                 onPress={() => {
                   this.props.navigator.push({
                     component: Settings,
                     title: '筛选',
                     params: {id: ''}
                   })
                 }}
                />)}

                leftButton={(<NavBarTextButton
                  title='南京'
                  textStyle={{color:'black'}}
                  image={require('../resources/navbar/navbar-qr-scan-normal.png')}
                  onPress={() => {
                     this.props.navigator.push(
                      this.pushToNative()
                    )
                  }}
                  />)}
            >
            </NavigationBar>
            <ListView
              dataSource={this.state.dataSource}
              renderRow={this.renderRow.bind(this)}
              style={styles.listview}>
            </ListView>
         </View>
     );
   }
   renderRow(rowData, sectionID, rowID) {
       return (
           <TouchableHighlight
              underlayColor="transparent"  style={styles.rowContainer}
              onPress={() => {
                this.props.navigator.push({
                    component:PhotoWall,
                    title: '详情页',
                    prams: {id: '', data: rowData}
                })
              }}>
              <View>
                <Image style={styles.cover} source={require('../resources/activity/cover.png')} />
                <View style={{flexDirection: 'row', marginTop: 10, marginLeft: 5}}>
                  <Text style={styles.city}>南京</Text>
                  <Text style={styles.title}>一览众山小</Text>
                  <Text style={styles.tag}>五言绝句</Text>
                </View>
                <Text style={styles.takeparts}>下一站到天后</Text>
                <View style={{flexDirection:'row', alignItems:'center',marginLeft: 10,}}>
                  <Image style={styles.icon} source={require('../resources/activity/location.png')} />
                  <Text style={styles.rowText}>南京航空航天大学</Text>
                </View>
                <View style={{flexDirection:'row', alignItems:'center', marginLeft:10}}>
                  <Image style={styles.icon} source={require('../resources/activity/search-history.png')} />
                  <Text style={styles.time}>2016年4月20日 11:11</Text>
                </View>
                <Text style={styles.takepartButton}>高小龙</Text>
              </View>
           </TouchableHighlight>
       )
   }
 }

 const styles = StyleSheet.create({
     container: {
         flex: 1,
         width:AppConfig.ScreenWidth,
         justifyContent: 'center',
         alignItems: 'center',
         marginTop: 5,
         backgroundColor: AppConfig.PageBgColor,
     },
     rowContainer: {
       marginHorizontal: 30*AppConfig.ScaleFactor,
       marginTop: 30*AppConfig.ScaleFactor,
       marginBottom: 0,
       paddingBottom:5,
       backgroundColor: 'white',
       overflow: 'hidden',
       borderRadius: 4,
       borderColor: 'rgba(220,220,220,0.7)',
       borderWidth:0.8,
     },
     cover: {
      width: AppConfig.ScreenWidth-30 * AppConfig.ScaleFactor*2,
      height: 615 * AppConfig.ScaleFactor,
      overflow: 'hidden'
     },
     listview: {
         width: AppConfig.SreenWidth,
     },
     text: {
         fontSize: 18,
         color: '#666666',
     },
     city: {
       fontSize: 15,
       fontWeight: 'bold',
       padding: 5,
     },
     title: {
       fontSize: 15,
       fontWeight: 'bold',
       padding: 5,
     },
     tag: {
       backgroundColor: '#ebf9fa',
       borderRadius: 4,
       color: '#66ccda',
       padding: 5,
     },
     takeparts: {
      color:'red',
      position:'absolute',
      right: 5,
      bottom: 60,
      fontSize: 16,
      },
     icon: {
       width: 15,
       height: 15,
     },
     rowText: {
       color: '#646464',
       padding: 5,
     },
     time: {
       color: '#646464',
       padding: 5,
     },
     takepartButton: {
       color: 'white',
       fontSize: 16,
       position:'absolute',
       right: 5,
       bottom: 15,
       padding: 5,
       borderRadius: 4,
       overflow: 'hidden',
       backgroundColor: '#66ccda',
     },
 })

export default ForthReactView
