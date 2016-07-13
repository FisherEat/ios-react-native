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
  Dimensions,
  ScrollView,
  TouchableHighlight
} from 'react-native';
import SectionBanner from '../channel/SectionBanner'
import SectionTitle from '../channel/SectionTitle'
import SectionSpecial from '../channel/SectionSpecial'
import AppConfig from '../common/AppConfig'

//滑动图片组件测试
import ScrollImage from '../channel/ScrollImage'

class Domestic extends Component {
  constructor(props) {
    super(props);
    this.scrollListen = [];
    this.state = {
      pageStatus: null,
      bannerData: null,
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

  componentDidMount() {
      let cityInfo = {code: 2500, name: '上海'};
      this.getData(cityInfo);
  }

  banner(data) {
    var bannberItems = [];
    for (let d of data.values()) {
      for (let dd of d.gItems.values()) {
        if (dd.mTplId == 1152) {
          bannberItems = dd.mItems;
        }
      }
    }
    return bannerItems;
  }

  getItemDatas() {
      var mydata = this.state.pageStatus;
      var banner = [];
      for (let d of mydata.values()) {
        for (let dd of d.gItems.values()) {
          if (dd.mTplId == 1152) {
            banner = dd.mItems;
          }
        }
      }
      return banner;
  }

  renderPage() {
    var data = this.state.pageStatus;
    var _ = this;
    var tabs = [];
    var sectionCount = 0;

    var tcg = function* titleCountGenerator() {
            let i = 0;
            while (true) {
                yield i++;
            }
        }();

    var sections = data.map(function (d, index) {
        sectionCount ++;
        if (d.gGroupId != 0) {
            tabs.push(d);
        }
        return (
            <View>
               {
                   d.gItems.map(function(dd, index) {
                       if (dd.mTplId == 1537) {
                        return <SectionTitle mItems={dd.mItems} index={tcg.next().value}></SectionTitle>
                       }
                       if (dd.mTplId == 1539) {
                           return <SectionSpecial  mItems={dd.mItems} ></SectionSpecial>
                       }
                       if (dd.mTplId == 1152) {
                           return <SectionBanner mItems={dd.mItems}></SectionBanner>
                       }
                   })
               }
            </View>
        )
    });

    return (
        <View style={styles.container}>
            {
                <ScrollView style={styles.container}>
                    {
                        [...sections]
                    }
                </ScrollView>
            }
        </View>
    )



    // var items = this.getItemDatas();
    //   return (<View style={styles.container}>
    //         <SectionBanner
    //            mItems={items}
    //            key="SectionBanner"
    //            style={{width: AppConfig.ScreenWidth, height: 200, backgroundColor: 'red'}}>
    //         </SectionBanner>
    //     </View>
    //   )
  }

  render() {
    if (!this.state.pageStatus) {
      return (
        <View style={styles.container}>
          <Text style={styles.welcomeTip}>fuck...</Text>
        </View>
      )
    }
   return this.renderPage();
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    height: AppConfig.ScreenHeight,
    backgroundColor: '#f0f0f0',
    marginTop: 64.5,
  },
  welcomeTip: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10
  }
});

module.exports = Domestic;
