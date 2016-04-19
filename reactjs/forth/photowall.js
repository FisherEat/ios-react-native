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
 } from 'react-native';

import AppConfig from '../common/AppConfig'
import NavBar from '../common/NavBar'
const {
  NavigationBar,
  NavBarImageButton,
  NavBarTextButton,
} = NavBar

 class PhotoWall extends Component {
   constructor(props) {
       super(props)
       this.state = {
         photoWall: [],
         dataSource: new ListView.DataSource({rowHasChanged: (r1, r2) => r1 != r2})
       }
   }
   componentDidMount() {
     let data =[{} ,{}, {}, {}, {}, {}];
     this.setState({
       dataSource: this.state.dataSource.cloneWithRows(data)
     })
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
              dataSource={this.state.dataSource}
              renderRow={this.renderRow.bind(this)}
              style={styles.listview}
              contentContainerStyle={styles.listViewStyle}
           >
           </ListView>
         </View>
     );
   }

   renderRow(rowData, sectionID, rowID) {
     return (
       <TouchableHighlight
          style={styles.rowContainer}
          onPress={() => {
            this.props.navigator.push({
              component: '',
              title: '岁月如歌',
              params: {id: 'PhotoList'}
            })
          }}
       >
        <View>
          <Image style={styles.cover} source={require('../resources/photoWall/cover.png')}/>
            <Text style={styles.textStyle}>相册</Text>
        </View>
       </TouchableHighlight>
     )
   }
}

 const styles = StyleSheet.create({
     container: {
         flex: 1,
         backgroundColor: AppConfig.PageBgColor,
      },
      listview: {
        width:AppConfig.ScreenWidth,
        marginBottom: 30*AppConfig.ScaleFactor,
        marginTop: 15*AppConfig.ScaleFactor,
      },
      listViewStyle: {
        justifyContent: 'space-around',
        flexDirection: 'row',
        flexWrap: 'wrap',
      },
      cover: {
      width: (AppConfig.ScreenWidth - 30 * AppConfig.ScaleFactor * 4)/2,
      height: 350 * AppConfig.ScaleFactor,
      },
      textStyle:{
       width:(AppConfig.ScreenWidth-30 * AppConfig.ScaleFactor*4)/2,
       height:105 * AppConfig.ScaleFactor,
       backgroundColor:'rgba(70,70,70,0.7)',
       textAlign:'center',
       color:'white',
       fontSize:16.0,
       marginTop:245 * AppConfig.ScaleFactor,
       padding:24 * AppConfig.ScaleFactor,
   },
 })

export default PhotoWall
