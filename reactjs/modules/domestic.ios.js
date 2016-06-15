/**
*created by schiller
*/

'use strict';
import React, {
  Component,
  StyleSheet,
  Text,
  View,
  Image,
  Linking,
  Dimensions,
  ScrollView,
  ListView,
  NativeModules
} from 'react-native';

let ScreenWidth = Dimensions.get("window").width;
let ScreenHeight = Dimensions.get("window").height;

class Domestic extends Component {
  constructor(props) {
    super(props);
    this.scrollListen = [];
    this.state = {
      pageStatus: null
    }
  }

  getData(cityInfo) {
    var _ = this;
    let url = "http://m.tuniu.com/event/admin/getCmsChannelAjax?pageId=1209&cityCode=";

    fetch(url+cityInfo.code).then((response) => {
        return response.json();
     }).then((json) => {
      _.setState({
        pageStatus: json.data
      });
    })
  }

  componentDidMount() {
      let cityInfo = {code: 2500, name: '上海'};
      this.getData(cityInfo);
  }

  renderPage() {
    var data = this.state.pageStatus;
    var _ = this;
    var tabs = [];
    var sectionCount = 0;
//data数据结构
    var sections = data.map((d, index) => {
        sectionCount ++;
        if (d.gGroupId != 0) {
            tabs.push(d);
        }
        return (
            <View key={"react_group" + index}>
              {
                  d.gItems.map((dd, index) => {
                      if (dd.mTplId == 1537) {//展示标题栏
                          return <View></View>
                      }
                      if (dd.mTplId == 1152) {//展示分页滚动条
                          return <View></View>
                      }
                      if (dd.mTplId == 1539) {//展示特卖产品
                          return <View></View>
                      }
                      if (dd.mTplId == 1531) {//展示热门目的地
                          return <View></View>
                      }
                      if (dd.mTplId == 1532) {//展示目的地
                          return <View></View>
                      }
                  })
              }
            </View>
        )
    });
  return (
    <View style={styles.container}>
      <Text style={styles.welcomeTip}>拿到线上数据了...</Text>
    </View>
    )
  }

  render() {
    if (!this.state.pageStatus) {
      return (
        <View style={styles.container}>
          <Text style={styles.welcomeTip}>Loading...</Text>
        </View>
      )
    }
    return this.renderPage();
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    height: ScreenHeight,
    backgroundColor: '#f0f0f0',
  },
  welcomeTip: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10
  }
});

module.exports = Domestic;
