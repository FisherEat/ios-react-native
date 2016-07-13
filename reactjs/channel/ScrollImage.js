/**
*created by schiller,A scrollviewimage widget
*/

'use strict';
import React, {
    Component,
    StyleSheet,
    Text,
    View,
    Image,
    ScrollView,
    TouchableHighlight
} from 'react-native';

import AppConfig from '../common/AppConfig';

let imgUrlArr = ['http://upload-images.jianshu.io/upload_images/2404791-5967492b1bf772ac.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
'http://upload-images.jianshu.io/upload_images/1170656-381eb0a86f93edd4.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
'http://upload-images.jianshu.io/upload_images/2015405-232f623d7e4daf5c.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1080/q/100'];

var imgItems = imgUrlArr.map(function (url, index) {
    return {adImgUrl: url}
});
export default class ScrollImage extends Component {
    constructor(props) {
        super(props);
        this.state = {
            dotIndex: 0,
        }
    }

    render() {
        let _ = this;
        //var items = this.props.mItes;
        var items = imgItems;
        let scrollTimer = null;
        var scroll = function(event) {
            clearTimeout(scrollTimer);
            let x = event.nativeEvent.contentOffset.x;
            let index = x / AppConfig.screenWidth;
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
                                        <TouchableHighlight onPress={() =>{}}>
                                            <Image  source={require('../resources/user/starter-head.png')}
                                                    style={styles.slideImg}
                                                    resizeMode="cover">
                                            </Image>
                                        </TouchableHighlight>
                                    )
                                })
                            }
                </ScrollView>
            </View>
        )
    }
}

const styles = StyleSheet.create({
    slide: {
        backgroundColor: '#ccc',
        alignItems: 'flex-start',
        alignSelf: 'flex-start',
        flexDirection: 'row'
    },
    slideImg: {
        width: AppConfig.screenWidth,
        height: 80
    }
})

//export default ScrollImage;
