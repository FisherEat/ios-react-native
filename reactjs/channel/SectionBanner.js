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
    var _ = this;
    return (
      <View>
        <ScrollView
           contentOffset={{x: 0, y: 0}}
           pagingEnabled={true}
           horizontal={true}
           contentContainerStyle={styles.slide}
           showsHorizontalScrollIndicator={false}
           directionalLockEnabled={false}
           key="slideBox">
           {
             items.map(function(item, index) {
               return (
                 <TouchableHighlight>
                   <Image source={{uri: item.adImgUrl}}
                          style={styles.slideImage}
                          />
                 </TouchableHighlight>)
             })
           }
        </ScrollView>
        <View style={styles.dotContainer}
              key="slideDotBox">
              {
                items.map(function(item, index){
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

module.exports = SectionBanner;
