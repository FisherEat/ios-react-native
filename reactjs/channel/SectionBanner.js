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
  TouchableHighlight
} from 'react-native';
var ScreenWidth = Dimensions.get("window").width;

class SectionBanner extends Component {
  constructor(props) {
    super(props);
    this.state = {
      dotIndex: 0
    }
  }

  render() {
    var self = this;
    var items = this.props.mItems;//从外部传来的参数
    var scrollTimer = null;
    var _ = this;
    var scrollEnd = function (x) {
      var index = x / ScreenWidth;
      if (index - Math.floor(x) > 0.5) {
        index = Math.ceil(index);
      }else {
        index = Math.floor(index);
      }
      _.setState({
        dotIndex: index
      });
    }
    var scroll = function (event) {
      clearTimeout(scrollTimer);
      var x = event.nativeEvent.contentOffset.x;
      var index = x / ScreenWidth;
      if (index - Math.floor(index) > 0.5) {
        index = Math.ceil(index);
      }else {
        index = Math.floor(index);
      }
      _.setState({
        dotIndex: index
      });
    }

    return (
      <View>
        <ScrollView
           onScroll={scroll}
           scrollEventThrottle={16}
           contentOffset={{x: 0, y: 0}}
           pagingEnable={true}
           horizontal={true}
           contentContainerStyle={styles.slide}
           showsHorizontalScrollIndicator={false}
           directionalLockEnabled={false}
           key="slideBox">
           {
             items.map((item, index) => {
               return (
                 <TouchableHighlight
                   onPress={()=>{}}
                   key={"slide_pic" + index}>
                   <Image source={{uri: item.adImgUrl}}
                          style={styles.slideImage}
                          resizeMode="cover"/>
                 </TouchableHighlight>
               )
             })
           }
        </ScrollView>
        <View style={styles.dotContainer}
              key="slideDotBox">
              {
                items.map((item, index) => {
                  return (
                    <View style={index==_.state.dotIndex ? sytles.slideDotActive : styles.slideDot}
                          key={"slideDot"+index}>
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
    width: 4,
    height: 4,
    borderRadius: 4,
    backgroundColor: '#fff',
    margin: 4,
  },
  slideDotActive: {
    width: 4,
    height: 4,
    borderRadius: 4,
    backgroundColor: "#ff8a00",
    margin: 4
  },
  dotContainer: {
       height: 4,
       width: ScreenWidth,
       top: -10,
       left: 0,
       flex: 1,
       alignItems: "center",
       justifyContent: "center",
       flexDirection: "row"
   },
   slideImage: {
       width: ScreenWidth,
       height: ScreenWidth / 750 * 230,
   }
});

export default SectionBanner;
