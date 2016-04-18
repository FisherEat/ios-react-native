/**
 * created by schiller
 */
import React, {
  AppRegistry,
  Component,
  StyleSheet,
  View,
  Text,
  Navigator,
} from 'react-native';

import ForthReactView from './reactjs/forthview'
import SuperHome from './reactjs/superhome'

class Demos extends Component {
  render() {
    const className = this.props.className;
    let component, title;
    if (className == 'ForthReactView') {
        component = ForthReactView;
        title = '第四页'
    }else if (className == 'SuperHome') {
        component = SuperHome;
        title = '自由行首页'
    }
    return (
        <Navigator
             initialRoute={{
               name:'Demos',
               component:component,
               images:this.props.className
             }}
             configureScene={
               (route) =>
               {
                 return Navigator.SceneConfigs.HorizontalSwipeJump;
               }
             }
             renderScene={(route, navigator) => {
                 return <route.component {...route.params} title={this.props.className} navigator={navigator}/>
               }}
        />
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  text: {
      fontSize: 16,
      color: '#333333',
  },
});

AppRegistry.registerComponent('Demos', () => Demos);
