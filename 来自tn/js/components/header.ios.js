/**
 * Created by yulibin on 16/6/2.
 */
'use strict';
import React, {
    Component,
    StyleSheet,
    Text,
    View,
    Image,
    TouchableOpacity,
    NativeModules
} from 'react-native';

export default class Header extends Component{
    constructor(props){
        super(props);
    }
    componentDidMount(){
        console.log(this);
    }
    render(){
        return (
            <View key="navigator" style={styles.navigator}>
                <Text style={styles.title}>{this.props.title}</Text>
                <TouchableOpacity onPress={()=>{NativeModules.TNReactNativeUtil.rn_leftTopBarClick();}} style={styles.backIcon} activeOpacity={1}><Image  source={require("../images/rn_topbar_nav_back.png")} style={styles.backImage}/></TouchableOpacity>
                <TouchableOpacity onPress={()=>{NativeModules.TNReactNativeUtil.rn_showSearch();}} style={styles.searchIcon} activeOpacity={1}><Image  source={require("../images/rn_topbar_search.png")} style={styles.searchImage}/></TouchableOpacity>
                <TouchableOpacity onPress={()=>{NativeModules.TNReactNativeUtil.rn_showChat();}} style={styles.chatIcon} activeOpacity={1}><Image  source={require("../images/rn_topbar_groupChat_green.png")} style={styles.chatImage}/></TouchableOpacity>
            </View>);
    }
}
const styles = StyleSheet.create({
    navigator:{
        height:64.5
    },
    title:{
        fontSize:18,
        lineHeight:18,
        paddingTop:30,
        paddingBottom:16,
        textAlign:"center"
    },
    backIcon:{
        left:12,
        top:16,
        width:12,
        height:50,
        position:"absolute"
    },
    backImage:{
        width:12,
        height:21,
        marginTop:14
    },
    searchIcon:{
        right:10,
        top:20,
        width:20,
        height:50,
        position:"absolute"
    },
    searchImage:{
        width:20,
        height:20,
        marginTop:14
    },
    chatIcon:{
        right:42,
        top:20,
        width:23,
        height:50,
        position:"absolute"
    },
    chatImage:{
        width:23,
        height:20,
        marginTop:14
    },


});
