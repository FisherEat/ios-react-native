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

import AppConfig from '../common/AppConfig'
export default class HotDest extends Component {
    constructor(props) {
        super(props);
        this.state = {
            expand: false,
            rotate: '0deg'
        }
    }

    render() {
        var self = this;
        var items = this.props.mItems;

        return (<View style={styles.HotDest}>
              {
                  items.map(function(item, index) {
                      
                  })
              }
            </View>)
    }
}

const styles = StyleSheet.create({
    HotDest: {
        flex: 4,
        flexDirection: 'row',
        flexWrap: "wrap",
        backgroundColor: '#fff'
    },
    td: {

    },
    tdText: {

    },
    tdImg: {

    }
})
