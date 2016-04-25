/**
 * created by schiller
 */
import React, {
  Component,
  StyleSheet,
  View,
  Text,
  Image,
  ListView,
  Navigator,
} from 'react-native'

var mockData = [
  {
    id: 'aaa',
    sub: Array(5).fill("See you again").map((ele, index) => {
      return ele + index;
    })
  },
  {
    id: 'bbb',
    sub: Array(6).fill("God is a girl").map((ele, index) => {
      return ele + index;
    })
  },
  {
    id: 'ccc',
    sub: Array(10).fill("神话").map((ele, index) => {
      return ele + index;
    })
  },
  {
    id: 'ddd',
    sub: Array(3).fill("The day you went away").map((ele, index) => {
      return ele + index;
    })
  }
]
class SectionList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      dataSource: new ListView.DataSource({
        getSectionData:null,
        getRowData:null,
        rowHasChanged: (row1, row2) => row1 !== row2,
        sectionHeaderHasChanged: (s1, s2) => s1 !== s2,
      })
    }
  }
  convertToObject(array) {
    var dataBlob = {},
    sectionIDs = [],
    rowIDs = [],
    sectionIDs = array.map((ele, index) => {
      var sid = ele.id
      dataBlob[sid] = ele;
      rowIDs[index] = ele.sub.map((element) => {
        var key = ele.id + ":" + element;
        dataBlob[key] = element;
        return key;
      })
      return sid;
    })
    return {
      dataBlob: dataBlob,
      sectionIDs: sectionIDs,
      rowIDs: rowIDs
    }
  }
  componentDidMount() {
    let data = [];
    var {dataBlob, sectionIDs, rowIDs} = this.convertToObject(mockData);
    var getSectionData = (dataBlob, sectionID) => {
      return dataBlob[secitonID];
    }
    var getRowData = (dataBlob, sectionID, rowID) => {
      return dataBlob[rowID];
    }
    this.setState({dataSource: this.state.dataSource.cloneWithRowsAndSections(dataBlob, sectionIDs, rowIDs)})
  }

  renderRow(rowData, secitonID, rowID) {
    return (
      <View style={styles.row}>
        <Text style={styles.rowText}>{rowData}</Text>
      </View>
    )
  }
  renderSectionHeader(sectionData, sectionID) {
    return (
      <View style={styles.section}>
        <Text style={styles.sectionText}>{sectionData.id}</Text>
      </View>
    )
  }
  render() {
    return(
      <View style={styles.container}>
        <View style={styles.header}>
          <Text style={styles.headerText}>ListView的section sticky效果</Text>
        </View>
        <ListView
          dataSource={this.state.dataSource}
          style={styles.list}
          renderRow={this.renderRow}
          renderSectionHeader={this.renderSectionHeader}
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
    backgroundColor: '#3f51b5',
    flexDirection: 'column',
    paddingTop: 25,
  },
  headerText: {
    fontWeight:'bold',
    fontSize: 20,
    color:'white',
  },
  section: {
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'flex-start',
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
    paddingLeft:16,
    borderColor: 'white',
    borderBottomColor: '#e0e0e0',
    borderWidth: 1,
  },
  rowText: {
    color: '#468847',
    fontSize: 16,
  },
})

export default SectionList;
