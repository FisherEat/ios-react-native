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
      response.json();
     }).then((json) => {
      _.setState({
        pageStatus: json.data
      });
    })
  }

  componentDidMount() {

  }

  renderPage() {
    var data = this.state.pageStatus;
    var _ = this;
    var tabs = [];
    var sectionCount = 0;
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
