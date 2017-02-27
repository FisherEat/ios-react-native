/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

//'use strict';

import React, {
  AppRegistry,
  Component,
  StyleSheet,
  Text,
  View,
  ListView,
  Navigator,
} from 'react-native';

import MainHomeComponent from './app/mainhome'
import SearchHomeComponent from './app/searchhome'
import CodePush from 'react-native-code-push'

class rnToday_2 extends Component {
    constructor(props) {
      super(props)
      this.state = {

      }
    }

    componentDidMount() {
      CodePush.sync();
    }
    render() {
      const classname = this.props.classname;
      let component , title
      if (classname == 'Home') {
        component = MainHomeComponent;
        title = '首页';
      }else if (classname == 'Search') {
        component = SearchHomeComponent;
      }
      return (

          <Navigator
            initialRoute={{
              name:'mainhome',
              component:component,
              images:this.props.images
            }}
            configureScene={
              (route) =>
              {
                return Navigator.SceneConfigs.HorizontalSwipeJump;
              }
            }
            renderScene={(route, navigator) => {
                return <route.component {...route.params} title={'nice'} navigator={navigator}/>
              }}
          />
        );
    }
}

const styles = StyleSheet.create({

});

AppRegistry.registerComponent('rnToday_2', () => rnToday_2);
