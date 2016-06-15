import React, {
    AppRegistry,
    Component,
    StyleSheet,
    Text,
    View,
    Image,
    Animated,
    TextInput,
    Alert,
    Linking,
    Dimensions,
    TouchableOpacity,
    ScrollView,
    ListView,
    NativeModules
} from 'react-native';
import appHre from '../appUtils/appHref'

var screenWidth = Dimensions.get("window").width;

export default class HotDest extends Component {
    constructor(props) {
        super(props);


        this.state = {
            expand: false,
            rotate: '0deg'
        }
    }

    click() {
        // this.setState('expand', !this.state.expand)
        this.setState({
            expand: !this.state.expand,
            rotate: this.state.expand ? '180deg' : '0deg'
        })
    }

    render() {
        var self = this;
        var items = this.props.mItems;
        var hasShowBt = items.length > 8;
        // ()=> this.state = !this.state
        if (hasShowBt) {
            var addEmptyBt = 3 - items.length % 4;
            for (let i = 0; i < addEmptyBt; i++) {
                items.push({
                    phCatName: ''
                })
            }
        }
        var ImageArr = [require('../images/rn_channel_home_destin1.png'), require('../images/rn_channel_home_destin2.png'), require('../images/rn_channel_home_destin3.png')];

        return (<View style={styles.HotDest} key="HotDest">{
            [
                items.map(function (item, index) {
                    if (hasShowBt && !self.state.expand && index >= 7) {
                        return;
                    }

                    return (<TouchableOpacity
                        onPress={appHre.bind(null, item.phCatAppUrl, item.phCatMUrl)}
                        activeOpacity={0.8} style={styles.td} key={"HotDest"+index} >
                        <Text style={styles.tdText} lineNumbers={1}>
                            {index < 3 ? <Image resizeMode="cover" style={styles.tdImg} source={ImageArr[index]}/> : ''}
                            <Text>{' '+ item.phCatName}</Text>
                        </Text>
                    </TouchableOpacity>)
                })
                , (hasShowBt ?
                <View style={[styles.td ]} key="show_hide">
                    <TouchableOpacity activeOpacity={0.8}  onPress={ this.click.bind(this) } lineNumbers={1}>
                        <Text style= {styles.tdText}>{self.state.expand ? '收起' : '更多'} </Text>
                        <View style={ {position: 'absolute', right: 0, bottom: 2,transform:[{rotate: self.state.expand ? '180deg': '0deg'}]} }>
                            <Image style= {{}}
                                source={require('../images/rn_channel_hotDest_More.png')} />
                        </View>
                    </TouchableOpacity>
                </View> : '')
            ]
        }</View>)
    }
}

const styles = StyleSheet.create({
    HotDest: {
        flex: 4,
        flexDirection: "row",
        flexWrap: "wrap",
        backgroundColor: "#fff",
        // alignItems: 'center',
    },
    td: {
        height: 36,
        alignItems: 'center',
        justifyContent: 'center',
        width: screenWidth / 4,
        borderBottomWidth: 1,
        borderRightWidth: 1,
        borderBottomColor: "#f0f0f0",
        borderRightColor: "#f0f0f0",
    },
    tdText: {
        fontSize: 12,
        paddingLeft: 12,
        paddingRight: 12
    },
    tdImg: {
    }
})
