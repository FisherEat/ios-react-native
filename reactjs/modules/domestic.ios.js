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
import SectionBanner from '../channel/SectionBanner'

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

    fetch(url+cityInfo.code).then((response) => response.json()).then((json) => {
      _.setState({
        pageStatus: json.data
      });
    })
  }

  onScroll(e) {
         var _ = this;
         this.scrollListen.forEach((fn)=> {
             var offsetY = e.nativeEvent.contentOffset.y;
             _.refs.rootView.refs.InnerScrollView.measure((ox, oy, w, h) => {
                 fn && fn(h - screenHeight - offsetY);
             })

         })
  }

  componentDidMount() {
      let cityInfo = {code: 2500, name: '上海'};
      this.getData(cityInfo);
      console.log('fuck'+this.state.pageStatus);
  }

  renderPage() {
    var data = this.state.pageStatus;
    var _ = this;
    var tabs = [];
    var sectionCount = 0;
//data数据结构
    var sections = data.map(function (d, index) {
        sectionCount ++;
        if (d.gGroupId != 0) {
            tabs.push(d);
        }
        return (
            <View key={"react_group" + index}>
              {
                  d.gItems.map(function (dd, index) {
                      // if (dd.mTplId == 1537) {//展示标题栏
                      //     return <View key={"Title"+index}></View>
                      // }
                      console.log(dd.mItems);
                      if (dd.mTplId == 1152) {//展示分页滚动条
                          return <SectionBanner key={"SectionBanner"+index}
                          mItems={dd.mItems}></SectionBanner>
                      }
                      // if (dd.mTplId == 1539) {//展示特卖产品
                      //     return <View key={"SpecialProduct"+index}>
                      //              <Text>展示特卖产品</Text>
                      //            </View>
                      // }
                      // if (dd.mTplId == 1531) {//展示热门目的地
                      //     return <View key={"HotDest" + index}>
                      //              <Text>展示热门目的地</Text>
                      //            </View>
                      // }
                      // if (dd.mTplId == 1532) {//展示目的地
                      //     return <View key={"SectionServer"+index}>
                      //               <Text>展示目的地</Text>
                      //            </View>
                      // }
                  })
              }
            </View>
        )
    });
  return (<View style={styles.container} key="react_loaded">
        <ScrollView
         ref="rootView"
         scrollEventThrottle={100}
         onScroll={_.onScroll.bind(_)}
         style={styles.container}
         key="react_abroad">
            <Text>mabi</Text>
        </ScrollView>
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
