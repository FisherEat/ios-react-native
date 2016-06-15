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
    ScrollView,
    TouchableHighlight,
    ListView,
    NativeModules
} from 'react-native';
import appHre from '../appUtils/appHref';

export default class SectionService extends Component {
    constructor(props) {
        super(props);
    }

    render() {
        var self = this;
        var items = this.props.mItems;

        return (<ScrollView horizontal={true}
                            style={styles.container}
                            showsHorizontalScrollIndicator={false}
                            directionalLockEnabled={true}
                            contentContainerStyle={styles.pictureNavigator} key="picNav">{
            items.map(function (item, index) {
                return (<TouchableHighlight key={"picNav"+index}
                                            underlayColor='#ddd'
                                            style={styles.pictureNavigatorItem}
                                            onPress={appHre.bind(null, item.adAppLinkUrl, item.adMLinkUrl)}>
                    <View>
                    <Image source={{uri:item.adImgUrl}} style={styles.pictureNavigatorItemPic}/>
                    <Text style={styles.pictureNavigatorItemText}>{item.adMainTitle}</Text>
                    </View>
                </TouchableHighlight>)
            })

        }</ScrollView>)
    }
}

const styles = StyleSheet.create({
    container: {
        backgroundColor: '#fff',
        marginBottom: 10,
    },
    pictureNavigator: {
        flexDirection: "row",
        justifyContent: "space-around",
        backgroundColor: "#fff",
        marginLeft: 10,
        paddingTop: 15,
        paddingBottom: 20
    },
    pictureNavigatorItem: {
        flex: 1,
        width: 66,
        marginRight: 10,
        backgroundColor: "#fafafa",
        borderRadius: 4,
        paddingTop: 5,
        paddingBottom: 5
    },
    pictureNavigatorItemPic: {
        width: 24,
        height: 24,
        alignSelf: "center"
    },
    pictureNavigatorItemText: {
        fontSize: 12,
        padding: 3,
        textAlign: "center"
    },
})
