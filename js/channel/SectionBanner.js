/**
 * Created by sheldon on 5/25/16.
 */
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
    NativeModules
} from 'react-native';
import appHre from '../appUtils/appHref'

var screenWidth = Dimensions.get("window").width;

export default class SectionBanner extends Component {
    constructor(props) {
        super(props);
        this.state = {
            dotIndex: 0
        }
    }

    render() {
        var self = this;
        var items = this.props.mItems;

        var scrollTimer = null;
        var _ = this;
        var scrollEnd = function (x) {
            var index = x / screenWidth;
            if (index - Math.floor(x) > 0.5) {
                index = Math.ceil(index);
            }
            else {
                index = Math.floor(index);
            }
            _.setState({
                dotIndex: index
            });

        }
        var scroll = function (event) {
            clearTimeout(scrollTimer);
            var x = event.nativeEvent.contentOffset.x;
            var index = x / screenWidth;
            if (index - Math.floor(index) > 0.5) {
                index = Math.ceil(index);
            }
            else {
                index = Math.floor(index);
            }
            _.setState({
                dotIndex: index
            });

        }
        return (
            <View>
                <ScrollView onScroll={scroll} scrollEventThrottle={16} contentOffset={{x:0,y:0}} pagingEnabled={true}
                            horizontal={true} contentContainerStyle={styles.slide} showsHorizontalScrollIndicator={false}
                            automaticallyAdjustContentInsets={false}
                            directionalLockEnabled={false} key="slideBox">
                    {
                        items.map(function (item, index) {
                            return (<TouchableHighlight onPress={appHre.bind(null, item.adAppLinkUrl, item.adMLinkUrl)}
                                          key={"slide_pic"+index}>
                                <Image source={{uri:item.adImgUrl}}
                                       style={styles.slideImage}
                                       resizeMode="cover"/>
                            </TouchableHighlight>)
                        })
                    }
                </ScrollView>
                <View style={styles.dotContainer} key="slideDotBox">
                    {
                        items.map(function (item, index) {
                            return (
                                <View style={index==_.state.dotIndex?styles.slideDotActive:styles.slideDot}
                                      key={"slideDot"+index}></View>);
                        })
                    }
                </View>
            </View>
        )
    }
}

const styles = StyleSheet.create({
    slide: {
        backgroundColor: "#ccc",
        alignItems: "flex-start",
        alignSelf: "flex-start",
        flexDirection: "row"
    },
    slideDot: {
        width: 4,
        height: 4,
        borderRadius: 4,
        backgroundColor: "#fff",
        margin: 4
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
        width: screenWidth,
        top: -10,
        left: 0,
        flex: 1,
        alignItems: "center",
        justifyContent: "center",
        flexDirection: "row"
    },
    slideImage: {
        width: screenWidth,
        height: screenWidth / 750 * 230,
    },
})
