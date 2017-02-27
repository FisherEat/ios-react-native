/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

import React, {
  AppRegistry,
  Component,
  StyleSheet,
  Text,
  View,
  ScrollView,
  Image,
} from 'react-native';

class rnToday_2 extends Component {

  render() {
    var contentNav = ['头条','热点','娱乐','体育','财经'],
    NEW_DATA = [
     {
       img: "http://7xl041.com1.z0.glb.clouddn.com/new1.png",
       title: "李克强宴请上合各参会领导人",
       content: "称会议阐释了上合组织\“大家庭\”的深厚友谊和良好氛围",
       typeImg: "http://7xl041.com1.z0.glb.clouddn.com/new-type1.png"
     },
     {
       img: "http://7xl041.com1.z0.glb.clouddn.com/new1.png",
       title: "李克强宴请上合各参会领导人",
       content: "称会议阐释了上合组织\“大家庭\”的深厚友谊和良好氛围",
       typeImg: "http://7xl041.com1.z0.glb.clouddn.com/new-type1.png"
     },
     {
       img: "http://7xl041.com1.z0.glb.clouddn.com/new1.png",
       title: "李克强宴请上合各参会领导人",
       content: "称会议阐释了上合组织\“大家庭\”的深厚友谊和良好氛围",
       typeImg: "http://7xl041.com1.z0.glb.clouddn.com/new-type1.png"
     },
     {
       img: "http://7xl041.com1.z0.glb.clouddn.com/new1.png",
       title: "李克强宴请上合各参会领导人",
       content: "称会议阐释了上合组织\“大家庭\”的深厚友谊和良好氛围",
       typeImg: "http://7xl041.com1.z0.glb.clouddn.com/new-type1.png"
     },
     {
       img: "http://7xl041.com1.z0.glb.clouddn.com/new1.png",
       title: "李克强宴请上合各参会领导人",
       content: "称会议阐释了上合组织\“大家庭\”的深厚友谊和良好氛围",
       typeImg: "http://7xl041.com1.z0.glb.clouddn.com/new-type1.png"
     },
   ];

    return (
      <View style={styles.awrap}>
      <View style={styles.top}>
        <Text style={styles.topTitle}>网易</Text>
      </View>
      <View style={styles.contentWrap}>
        <View style={styles.contentNav}>
          {
            contentNav.map((el, index) =>
            {
              <Text style={styles.contentNavText}>
                <Text style={index == 0 ? styles.textR : ""}>{contentNav[index]}</Text>
              </Text>
            })
           }
        </View>

        <ScrollView style={styles.centent}>
        {
          NEW_DATA.map(function(el, index){
            return (
              <View>
                <View style={styles.cententLi}>
                  <Image source={{uri: NEW_DATA[index].img}} style={styles.cententImg} />
                  <View style={styles.rightCentent}>
                    <Text style={styles.cententTitle}>{NEW_DATA[index].title}</Text>
                    <Text style={styles.cententCentent}>{NEW_DATA[index].content}</Text>
                  </View>
                  <Image source={{uri: NEW_DATA[index].typeImg}} style={styles.cententType} />
                </View>
                <View style={styles.line}></View>
              </View>
            )
          })
        }
      </ScrollView>

      </View>
      <View style={styles.bottom}>
        <Text style={styles.alignCenter}>底部导航</Text>
      </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  alignCenter: {
    borderWidth: 3,
    alignItems: 'center',
    height: 20,
    borderColor: 'blue',
  },
  alignLeft: {

  },
  awrap: {
   flex: 1,
   flexDirection: 'column',
   backgroundColor: 'yellow',
  },
  contentWrap: {
    flex: 1,
    flexDirection: 'column',
  },
  top: {
    height: 64.5,
    backgroundColor: '#ec403c',
  },
  bottom: {
    justifyContent: 'center',
    height: 64.5,
    backgroundColor: '#887867',
  },
  textR: {
  fontWeight: 'bold',
  color: '#EC403C',
  },
  text: {
    padding: 10,
    fontSize: 16,
    lineHeight: 20,
    textAlign: 'center',
  },
  topTitle: {
    marginTop: 15,
    marginLeft: 20,
    textAlign: 'left',
    fontSize: 14,
    color: '#ffffff',
  },
  contentNavText: {
    width: 60,
    fontSize: 14,
    color: '#9c9c9c',
    marginLeft: 10,
  },
  cententImg: {
  width: 60,
  height: 60,
},
cententLi: {
  flexDirection: 'row',
  marginLeft: 10,
  marginRight: 10,
},
cententCentent: {
  fontSize: 12,
},
rightCentent: {
  flex: 1,
  paddingLeft: 5,
  paddingTop: 5,
  paddingRight: 5,
  paddingBottom: 5,
},
cententType: {
  width: 40,
  height: 22,
  position: 'absolute',
  bottom: 0,
  right: 0,
},
});

AppRegistry.registerComponent('rnToday_2', () => rnToday_2);
