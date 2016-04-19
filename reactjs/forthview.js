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

import AppConfig from './common/AppConfig'

 class ForthReactView extends Component {
   constructor(props) {
       super(props)
       this.state = {
           activityList: [],
           dataSource: new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2}),
       }
   }
   componentDidMount() {
       let data = [{}, {} ,{} ,{}];
       this.setState({
           dataSource: this.state.dataSource.cloneWithRows(data)
       })
   }
   render() {
     return (
         <View style={styles.container}>
             <Text style={styles.text}>这是第四页！！！</Text>
             <ListView
                dataSource={this.state.dataSource}
                renderRow={this.renderRow.bind(this)}
                style={styles.listview}
             ></ListView>
         </View>
     );
   }
   renderRow(rowData, sectionID, rowID) {
       return (
           <TouchableHighlight
              underlayColor="transparent"  style={styles.rowContainer}
              onPress={() => {
                this.props.navigator.push({
                    component:'',
                    title: '',
                    prams: {id: '', data: rowData}
                })
              }}>
              <View>
              </View>
           </TouchableHighlight>
       )
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
     rowContainer: {

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
     }
 })

export default ForthReactView
