/**
 * created by schiller
 */

 import React, {
     Component,
     MapView,
     Text,
     Image,
     StyleSheet,
     View,
 } from 'react-native'

 class MapViewList extends Component {
     constructor(props) {
         super(props)
         this.props.region = React.PropTypes.shape({
             latitude: React.PropTypes.number,
             longitude: React.PropTypes.number,
             latitudeDelta: React.PropTypes.number,
             longitudeDelta: React.PropTypes.number,
         }),
         this.props.onChange = React.PropTypes.func.isRequired,
         this.state = {
             latitude: 0,
             longitude: 0,
             latitudeDelta: 0,
             longitudeDelta: 0,
         }
     }
     componentWillReceiveProps(nextProps) {
         this.setState(nextProps.region);
     }
     render() {
         var region = this.state;
         return(
             <View style={styles.row}>
                <Text style={{fontSize: 18, backgroundColor: '#333333', alignItems: 'center'}}>{'Latitude'}</Text>
             </View>
         )
     }
 }

var styles = StyleSheet.create({
    map: {
        height: 150,
        margin: 10,
        borderWidth: 1,
        borderColor: '#000000',
    },
    row: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
    },
})

export default MapViewList
