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
    Dimensions,
    Alert,
    Linking,
    ScrollView,
    TouchableHighlight,
    ListView,
    NativeModules
} from 'react-native';
import appHre from '../appUtils/appHref';
var screenWidth = Dimensions.get("window").width;

export default class SectionService extends Component {
    constructor(props) {
        super(props);
        if( this.props.mItems ){
            this.state = {
                leftTimeArr: this.props.mItems.map((item) => item.prdBKLeftTime || 0)
            };

            //倒计时,自动减1
            setInterval(()=>{
                this.setState({
                    leftTimeArr: this.state.leftTimeArr.map( (num)=> num<=0 ? 0 : --num )
                })
            }, 1000)
        }
    }



    render() {
        var _ = this;
        var items = this.props.mItems;
        if( !items || !items.length ){
            return '';
        }

        function makeTimeArr( second ){
            var day=Math.floor(second/3600/24);
            var hour=Math.floor(second/3600)-day*24;
            var minute=Math.floor((second%3600)/60);
            var s=second%60;
            day=("0"+day).slice(-2);
            hour=("0"+hour).slice(-2);
            minute=("0"+minute).slice(-2);
            s=("0"+s).slice(-2);
            return [day, hour, minute, s];
        }

        function timeView( second, isSoldOut ) {
            if( !second || second<=0 || isSoldOut ){
                return <View></View>;
            }

            var arr = makeTimeArr( second );
            return <View style={styles.specialClock}>
                <View style={styles.clockText}>
                    <Text style={styles.clockName}>正在抢购</Text>
                    <Text style={styles.clockTime}>{arr[0]}</Text>
                    <Text style={styles.clockDot}>:</Text>
                    <Text style={styles.clockTime}>{arr[1]}</Text>
                    <Text style={styles.clockDot}>:</Text>
                    <Text style={styles.clockTime}>{arr[2]}</Text>
                    <Text style={styles.clockDot}>:</Text>
                    <Text style={styles.clockTime}>{arr[3]}</Text>
                </View>
            </View>
        }

        return (<View style={styles.specialBox} key="specialBox">
            {
                items.map(function (item, index) {
                    var isSoldOut = !!item.prdBKIsSoldOut||item.prdBKLeftTime<=0&&item.prdBKHumanDiscountRate;

                    return (<TouchableHighlight key={"special"+index} onPress={appHre.bind(null, item.prdLinkAppUrl, item.prdLinkMUrl)}>
                    <View style={styles.specialItem} >
                        <Image  resizeMode="cover" style={styles.specialImage} source={{uri:item.prdImgUrl}}/>
                        { timeView(_.state.leftTimeArr[index], isSoldOut) }
                        <Text style={styles.specialProductName}>{item.prdName}</Text>
                        <Text style={styles.specialProductIntro} numberOfLines={1}>{item.prdRecommend}</Text>
                        <View key={"specialText"+index}><Text
                            style={styles.specialProductIntro}>{item.prdClassBrandName}</Text><View
                            style={styles.specialTextRight}><Text style={styles.specialProductIntro}><Text
                            style={{fontSize:16,paddingRight:2,color:"#f60"}}>￥{item.prdSalePrice}</Text>起</Text></View></View>
                    </View>
                    </TouchableHighlight>)
                })
            }
        </View>)
    }
}

const styles = StyleSheet.create({
    specialBox: {
        backgroundColor: "#fff",
        flexDirection: "row",
        flex: 2,
        padding: 5,
        paddingBottom: 0
    },
    specialItem: {
        width: screenWidth / 2 - 15,
        margin: 5
    },
    specialImage: {
        width: screenWidth / 2 - 15,
        height: (screenWidth / 2 - 15) * 0.6059
    },
    specialClock: {
        height: 12,
        top: -25,
    },
    clockText: {
        flex: 1,
        flexDirection: 'row',
        paddingLeft: 8
    },
    clockName: {
        color: '#fff',
        fontSize: 10,
    },
    clockTime: {
        marginLeft: 5,
        color: '#666',
        fontSize: 10,
        backgroundColor:'rgba(255, 255, 255, 0.8)'
    },
    clockDot: {
        marginLeft: 5,
        color: '#fff',
        fontSize: 10,
    },
    specialProductName: {
        marginTop: 10,
        fontSize: 12,
        height: 14,
        color: "#333"
    },
    specialProductIntro: {
        fontSize: 12,
        lineHeight: 22,
        color: "#999"
    },
    specialTextRight: {
        flex: 1,
        right: 0,
        top: -22,
        alignSelf: "flex-end"
    },
})
