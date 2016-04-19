/**
 *created by schiller
 */

 import React, {
   ScrollView,
   Component,
   StyleSheet,
   Text,
   View,
   Image,
   Dimensions,
   ListView,
   TouchableHighlight,
 } from 'react-native'

 import AppConfig from '../common/AppConfig'
 import NavBar from '../common/NavBar'
 const {
   NavigationBar,
   NavBarImageButton,
   NavBarTextButton,
 } = NavBar

 class Settings extends Component {
   constructor(props) {
     super(props)
     this.state={
       dataSource: new ListView.DataSource({rowHasChanged: (r1, r2) => r1 != r2}),
     }
   }
   componentDidMount() {
     let data = [{
         cellType: 0,
         imageUrl: '',
         title: '',
       }, {
         cellType: 1,
         imageUrl: require('../resources/setting/setting-schoolmateInfo.png'),
         title: '校友资料',
       } , {
         cellType: 0,
         imageUrl: '',
         title: '',
       }, {
         cellType: 1,
         imageUrl: require('../resources/setting/setting-acceptMessage.png'),
         title: '接收推送消息',
       }, {
         cellType: 1,
         imageUrl: require('../resources/setting/setting-advice.png'),
         title: '意见反馈',
       }, {
         cellType: 0,
         imageUrl: '',
         title: '',
       }, {
         cellType: 1,
         imageUrl: require('../resources/setting/setting-clearImg.png'),
         title: '清除图片缓存',
       }, {
         cellType: 1,
         imageUrl: require('../resources/setting/setting-update.png'),
         title: '更新到最新版本',
       }]
     this.setState({dataSource: this.state.dataSource.cloneWithRows(data)})
   }
   render() {
     return (
       <View style={styles.container}>
       <NavigationBar
         navigator={this.props.navigator}
         tintColor={"#f8f8f8"}
         title='详情页'
         rightButton={(<NavBarImageButton
            image={require('../resources/navbar/share.png')}
            onPress={() => {
              alert('我要分享')
            }}
           />)}
       >
       </NavigationBar>
       <ListView
         style={styles.listview}
         dataSource={this.state.dataSource}
         renderRow={this.renderRow.bind(this)}
       >
       </ListView>
       </View>
     )
   }

   renderRow(rowData, sectionID, rowID) {
     let uri = rowData.imageUrl;
     if (rowData.cellType == 0) {
       return <View style={styles.blanklist}></View>
     }else {
       return (
         <TouchableHighlight
            style={{flex: 1}}
            onPress={() => {
              alert('shit')
            }}
            >
           <View style={styles.rowContainer}>
             <Image source={rowData.imageUrl} style={{left: 15,right: 5,top: 2, width:15, height:15, justifyContent:'flex-start'}}/>
             <Text style={{fontSize: 16, color: '#333333', left: 25}}>{rowData.title}</Text>
           </View>
         </TouchableHighlight>
       )
     }
   }
 }

 const styles = StyleSheet.create({
   container: {
     flex: 1,
     backgroundColor: AppConfig.PageBgColor,
   },
   listview: {
     flex: 1,
   },
   rowContainer: {
     flex: 1,
     flexDirection: 'row',
     color: 'white',
     height: 40,
     alignItems:'center'
   },
   blanklist: {
     width: AppConfig.ScreenWidth.ScaleFactor,
     height: 15,
     backgroundColor: '#999999',
   },
 })

 export default Settings
