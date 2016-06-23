/**
*created by schiller
*/

'use strict';
import React, { AppRegistry, StyleSheet, Text, View ,Component} from 'react-native';
import AppConfig from '../common/AppConfig';

class SectionTitle extends Component {
    constructor(prop) {
        super(props);
    }

    render() {
        var self = this;
        var items = this.props.mItems;
        var titleIndex = this.props.index;
        return (
           <View key={"title" + titleIndex}>
             {
                 items.map((item, index) => {
                     (<View style={styles.groupTitle}>
                        <Text style={styles.titleText}></Text>
                     </View>)
                 })
             }
           </View>
       )
    }
}

const styles = StyleSheet.create({
    groupTitle: {
        flex: 1,
        height: 36,
        marginTop: 10,
        backgroundColor: "#fff",
        borderBottomColor: '#eee',
        borderBottomWidth: 1,
        borderLeftWidth: 5,
        borderLeftColor: "#ffd000"
    },
    titleText: {
        textAlign: 'left',
        color: '#333333',
        fontSize: 14,
        marginLeft: 7,
        marginTop: 11,
    }
})
