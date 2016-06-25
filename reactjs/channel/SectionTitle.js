/**
*created by schiller
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
    Dimensions,
    ScrollView,
    ListView
} from 'react-native';
var screenWidth = Dimensions.get("window").width;

export default class SectionTitle extends Component {
  constructor( props ) {
    super(props);
  }

  makeLeftColorStyle( index ){
    index = index % COLORSTYLE.length;
    return StyleSheet.create({
      color: {
        borderLeftColor: COLORSTYLE[index]
      }
    }).color;
  }

  render(){
    var self = this;
    var items = this.props.mItems;
    var titleIndex = this.props.index;
    return (<View key={"title_"+titleIndex}>
        {
            items.map( (item, index) =>
               (<View style={[styles.groupTitle, this.makeLeftColorStyle(titleIndex)] } key={'sectionTitle'+index}>
                    <Text style={styles.titleText} key={"text_"+item.adMainTitle}>{item.adMainTitle}</Text>
                </View>)
            )
        }
    </View>)
  }
}

const COLORSTYLE = ["#ffd000","#9ed969","#80daea","#ff7c70","#7aa2f7","#ff965f","#af8fed"];

const styles = StyleSheet.create({
  groupTitle: {
      flex: 1,
      height: 36,
      marginTop: 10,
      backgroundColor: "#fff",
      borderBottomColor: "#eee",
      borderBottomWidth: 1,
      borderLeftWidth: 5,
      borderLeftColor: "#ffd000"
  },
  titleText: {
      textAlign: 'left',
      color: '#333333',
      fontSize: 14,
      marginLeft: 7,
      marginTop: 11
  }
})
