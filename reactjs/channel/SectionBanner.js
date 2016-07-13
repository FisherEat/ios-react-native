/**
*created by schiller
*/

'use strict';
import React, {
  AppRegistry,
  Component,
  StyleSheet,
  Text,
  View,
  Image,
  TextInput,
  Alert,
  Linking,
  Dimensions,
  ScrollView,
  ListView,
  TouchableHighlight,
  NativeModules,
} from 'react-native';
import AppConfig from '../common/AppConfig'

class SectionBanner extends Component {
  constructor(props) {
    super(props);
    this.state = {
      dotIndex: 0
    }
  }

  render() {
  	alert('shit');
    var _ = this;
    var items = this.props.mItems;//从外部传来的参数
    var lastItem = items[items.length - 1];
    lastItem.adImgUrl = "http://m.tuniucdn.com/fb2/t1/G1/M00/B6/BD/Cii9EFcxgKeIWTHcAAEXPp9X3UIAAFXJQMgNaEAARdW25.jpeg";

//Math.round()是四舍五入的。。。Math.ceil()是向上取整。。Math.floor()是向下取整
    var scrollTimer = null;
    var scroll = function (event) {
        clearTimeout(scrollTimer);
        var x = event.nativeEvent.contentOffset.x;
        var index = x / AppConfig.ScreenWidth;
        index = Math.round(index);
        _.setState({
            dotIndex: index
        });
    }

    return (
      <View>
        <ScrollView onScroll={scroll}
                    scrollEventThrottle={20}
                    horizontal={true}
                    contentOffset={{x:0, y:0}}
                    contentContainerStyle={styles.slide}
                    automaticallyAdjustContentInsets={false}
                    pagingEnabled={true}
                    showsHorizontalScrollIndicator={false}>
           {
             items.map(function(item, index) {
               return (
                 <TouchableHighlight onPress={() => {}}>
                   <Image source={{uri: item.adImgUrl}}
                          style={styles.slideImage}
                          resizeMode="cover"/>
                 </TouchableHighlight>)
             })
           }
        </ScrollView>
        <View style={styles.dotContainer} key="slideDotBox">
           {
               items.map(function(item, index) {
                   return (
                       <View style={index == _.state.dotIndex ? styles.slideDotActive : styles.slideDot }>
                       </View>
                   )
               })
           }
        </View>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  slide: {
    backgroundColor: '#ccc',
    alignItems:"flex-start",
    alignSelf: 'flex-start',
    flexDirection: 'row'
  },
  slideDot: {
    width: 8,
    height: 8,
    borderRadius: 8,
    backgroundColor: '#fff',
    margin: 4,
  },
  slideDotActive: {
    width: 8,
    height: 8,
    borderRadius: 8,
    backgroundColor: "#ff8a00",
    margin: 4
  },
  dotContainer: {
       height: 4,
       width: AppConfig.ScreenWidth,
       top: -10,
       left: 0,
       flex: 1,
       alignItems: "center",
       justifyContent: "center",
       flexDirection: "row"
   },
   slideImage: {
       width: AppConfig.ScreenWidth,
       height: AppConfig.ScreenWidth / 750 * 230,
   }
});

module.exports = SectionBanner;
