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
  NativeModules,
  TouchableHighlight
} from 'react-native';
import SectionBanner from '../channel/SectionBanner'

let ScreenWidth = Dimensions.get("window").width;
let ScreenHeight = Dimensions.get("window").height;

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
    var items = this.getItemDatas();
    alert(items);
      return (<View style={styles.container}>
            <Text>fuckkkkkkkkkkkk</Text>
            <SectionBanner
               mItems={items}
               key="SectionBanner"
               style={{width: ScreenWidth, height: 200, backgroundColor: 'red'}}>
            </SectionBanner>
        </View>
      )
  }

  // <ScrollView style={{width:ScreenWidth, height: 100, flexDirection: 'row'}}>
  //   {
  //       items.map(function(item, index) {
  //           return (<TouchableHighlight>
  //               <Image
  //                  source={{uri: item.adImgUrl}}
  //                  style={{width: ScreenWidth, height: ScreenWidth / 750 * 230}}/>
  //           </TouchableHighlight>)
  //       })
  //   }
  // </ScrollView>

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
