/**
 * created by schiller
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
    TouchableHighlight,
    ListView,
    NativeModules
} from 'react-native';

import AppConfig from '../common/AppConfig';

export default class SectionSpecial extends Component {
    constructor(props) {
        super(props);
    }

    render() {
        var _ = this;
        var items = this.props.mItems;

        return (<View style={styles.specialBox}>
            {
                items.map(function(item, index) {
                   return (<TouchableHighlight>
                       <View style={styles.specialItem}>
                          <Text>此地不留爷，自有留爷处</Text>
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
        width: AppConfig.ScreenWidth / 2 - 15,
        margin: 5
    },
    specialImage: {
        width: AppConfig.ScreenWidth / 2 - 15,
        height: (AppConfig.ScreenWidth / 2 - 15) * 0.6059
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
