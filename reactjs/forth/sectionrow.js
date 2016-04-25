/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

//'use strict';

import React, {
  AppRegistry,
  Component,
  StyleSheet,
  Text,
  View,
  ScrollView,
  Image,
  ProgressViewIOS,
  ListView,
} from 'react-native';

//要求原数组是一个对象数组，对象下面还有一个子数组，方便转换
var mockData = [
  {
    id:"aaa",
    sub: Array(11).fill(1).map((el, index) => {
      return "first " + index
    })
  },
  {
    id:"bbb",
    sub: Array(11).fill(1).map((el, index) => {
      return "second " + index
    })
  },
  {
    id:"ccc",
    sub: Array(11).fill(1).map((el, index) => {
      return "third " + index
    })
  },
  {
    id:"ddd",
    sub: Array(11).fill(1).map((el, index) => {
      return "fourth " + index
    })
  }
]

class SectionRowList extends Component {

    constructor(props) {
      super(props)
      //转换为一个一维对象数组
        var convertToObject = (array) => {
          var dataBlob = {},
          sectionIDs = [],
          rowIDs = []
          sectionIDs = array.map((el, index) => {
              var sid = el.id
              dataBlob[sid] = el
              rowIDs[index] = el.sub.map((elem) => {
                  var key = el.id +":"+elem
                  dataBlob[key] = elem
                  return key
              })
              return sid
          })
          return {
            dataBlob: dataBlob,//一个对象
            sectionIDs: sectionIDs,// 一个一维数组 [string|number, string|number, string|number ...]
            rowIDs: rowIDs // 一个二维数组，［［string|number］，［string|number］，［string|number］...］
          }
      }

      var {
        dataBlob,
        sectionIDs,
        rowIDs,
      } = convertToObject(mockData)

      var getSectionData = (dataBlob, sectionID) => {
          return dataBlob[sectionID];
      }

      var getRowData = (dataBlob, sectionID, rowID) => {
          //console.log(dataBlob, sectionID, rowID)
          return dataBlob[rowID];
      }


      var source = new ListView.DataSource({//这是定义结构
          getSectionData          : getSectionData,
          getRowData              : getRowData,
          rowHasChanged           : (row1, row2) => row1 !== row2,
          sectionHeaderHasChanged : (s1, s2) => s1 !== s2
      }).cloneWithRowsAndSections(dataBlob, sectionIDs, rowIDs)//这是添加数据

      this.state = {dataSource: source}
    }

    renderRow(rowData, sectionID, rowID) {

        return (
                <View style={styles.row}>
                    <Text style={styles.rowText}>{rowData}</Text>
                </View>
        );
    }


    renderSectionHeader(sectionData, sectionID) {
        return (
            <View style={styles.section}>
                <Text style={styles.sectionText}>{sectionData.id}</Text>
            </View>
        );
    }

    render() {
        return (
          <View style={styles.container}>
              <View style={styles.header}>
                  <Text style={styles.headerText}>ListView的section sticky效果</Text>
              </View>
              <ListView
                  dataSource = {this.state.dataSource}
                  style={styles.list}
                  renderRow  = {this.renderRow}
                  renderSectionHeader = {this.renderSectionHeader}
              />
          </View>
        )
    }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  list: {
    backgroundColor: '#dff0d8',
  },
  header: {
    height: 60,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#3f51b8',
    flexDirection: 'column',
    paddingTop: 25,
  },
  headerText: {
    fontWeight: 'bold',
    fontSize: 20,
    color: 'white',
  },
  section: {
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems:'flex-start',
    padding: 6,
    backgroundColor: '#2196f3',
  },
  sectionText: {
    color: 'white',
    paddingHorizontal: 8,
    fontSize: 16,
  },
  row: {
    paddingVertical: 20,
    paddingLeft: 16,
    borderColor: 'white',
    borderBottomColor: '#e0e0e0',
    borderWidth: 1,
  },
  rowText: {
    color: '#468847',
    fontSize: 16,
  }
  });

export default SectionRowList
