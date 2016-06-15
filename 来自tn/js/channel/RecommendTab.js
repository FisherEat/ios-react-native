import React, {
    AppRegistry,
    Component,
    StyleSheet,
    Text,
    View,
    Image,
    TextInput,
    TouchableHighlight,
    TouchableOpacity,
    Alert,
    Linking,
    Dimensions,
    ScrollView,
    ListView
} from 'react-native';
import appHre from '../appUtils/appHref';

var screenWidth = Dimensions.get("window").width;
const BOTTOMDISPATCH = 100;

class RecommendTab extends Component {
    constructor(props) {
        super(props);
        let _ = this;
        let tabs = this.props.tabs;

        if (tabs) {
            //[1, 1, 1, 1] 每个tab下选中的moduleID
            this.tabModuleMap = tabs.map( (d)=>{
                return d.gItems[0].mId;
            } );

            this.state = {
                tabIndex: 0,
                page: 1,
                loaddingNext: false,
                productTab: tabs[0].gItems,
                listData: tabs[0].gItems[0].mItems,
                moduleId: tabs[0].gItems[0].mId,
            };

            this.props.setRecommendList( tabs[0].gItems[0].mItems)
        }

        if( this.props.scrollListen ){
            this.props.scrollListen.push(function ( bottomDistance ) {
                if( bottomDistance < BOTTOMDISPATCH ){
                    _.state.page++;
                    _.fetchNext();
                }
            })
        }
    }

    renderOneTab() {
        return (<View key="productBox"></View>);
    }

    fetchNext() {
        var _ = this;
        if (_.isLoading || _.state.loaddingNext) {
            return;
        }
        var moduleId = this.state.moduleId;
        var page = this.state.page;

        fetch("http://m.tuniu.com/event/admin/GetCmsProductAjax?moduleId=" + moduleId + "&currentPage=" + page + "&pageSize=10").then((response)=>response.json()).then(function (json) {
            console.log("fetchEnd");
            if (page > 1) {
                var listData = [...(_.state.listData || []), ...json.data.mItems];
            } else {
                listData = json.data.mItems;
            }

            _.setState({
                listData: listData,
            });

            _.props.setRecommendList( listData );

            _.state.loaddingNext = false;
            _.refs.recommendRoot.measure(function (ox, oy) {
                _.props.scrollTopRecommend( oy );
            })
        })
    }

    renderTwoTab(tabs) {
        var _ = this;
        var scrollTab;
        function switchTab(tabIndex) {
            _.state.tabIndex = tabIndex;
            _.state.productTab = _.props.tabs[tabIndex].gItems;
            _.state.moduleId = _.tabModuleMap[tabIndex];
            _.state.page = 1;
            _.fetchNext();

            var length = tabs.length;
            var scrollLeft;
            //默认显示四行,每行占据25%
            if( tabIndex < 2 ){
                scrollLeft = 0;
            } else if( tabIndex > length - 2 - 1 ){
                scrollLeft = (length - 4 ) * screenWidth / 4;
            } else {
                scrollLeft = (1+ (tabIndex - 2) * 2 ) * screenWidth / 8;
            }
            scrollTab.scrollTo( {x: scrollLeft} )
        }

        function loadProductList(id) {
            if( id == _.state.moduleId ){
                return;
            }
            _.state.moduleId = id;
            _.tabModuleMap[_.state.tabIndex] = id;
            _.state.page = 1;
            _.fetchNext();
        }

        function renderHead(sectionData, sectionID) {
           return (<View>
               <ScrollView horizontal={true}
                           style={styles.tabTopOut}
                           showsHorizontalScrollIndicator={false}
                           directionalLockEnabled={true}
                           ref={(view)=>scrollTab=view}
                           key="tabBox1">
                   {
                       tabs.map(function (tab, index) {
                           return (
                               <View style={[styles.tabTop,
                                    _.state.tabIndex == index ? styles.tabTopSelect : '',
                                    tabs.length < 4 ? {width: screenWidth/tabs.length} : '']}
                                     key={"tabText1"+index} >
                                   <Text onPress={()=>switchTab( index )}
                                         style={[styles.tabTopText, _.state.tabIndex == index ? styles.tabTopTextSelect : '']}>
                                       {tab.gTitle}
                                   </Text>
                               </View>
                           )
                       })
                   }
               </ScrollView>
               <View style={styles.tabBottom} key="tabBox2">
                {
                    _.state.productTab.map(function (tab, index) {
                    return (<TouchableOpacity
                                style={styles.tabBottomLink} key={"tabText2"+index}
                                onPress={()=>loadProductList(tab.mId)} >
                        <View style={[styles.tabBottomCtn, tab.mId == _.state.moduleId ? styles.tabBottomCtnSelect : '']}>
                            <Text   style={[styles.tabBottomText, tab.mId == _.state.moduleId ? styles.tabBottomTextSelect : '']}>{tab.mTitle}</Text>
                        </View>
                    </TouchableOpacity>)
                })
                 }</View>
            </View>)
        }

        return (
            <View ref="recommendRoot">
                {renderHead()}
            </View>
            );
    }

    render() {
        var tabs = this.props.tabs;
        if (tabs.length <= 1) {
            return this.renderOneTab(tabs);
        }

        return this.renderTwoTab(tabs);
    }
}

class RecommendList extends Component{
   constructor( props ){
       super( props )
       this.state = {
           productListData: new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2})
       }
   }

   setListData( data ){
        this.setState({
            productListData: this.state.productListData.cloneWithRows( data )
        })
   }

   render(){
       var _ = this;

       function renderRow(item) {
           function replaceltrt( str ){
               return str && str.replace(/&lt;/g, '<').replace(/&rt;/g, '>');
           }

           return <TouchableHighlight onPress={appHre.bind(null, item.prdLinkAppUrl, item.prdLinkMUrl)}>
               <View>
                   <Image source={{uri:item.prdImgUrl}} style={styles.productListImage}
                          resizeMode={Image.resizeMode.stretch}/>
                   <View style={styles.productListText}>
                       <Text style={styles.productListTitle}>{replaceltrt( item.prdName )}</Text>
                       <Text style={styles.productListIntro}>{item.prdRecommend}</Text>
                   </View>
               </View>
           </TouchableHighlight>;
       }

       if( !this.state.productListData  ){
           return <View></View>;
       }
       return <ListView key='recommend-list'
                        dataSource={this.state.productListData}
                        renderRow={renderRow}>
       </ListView>
   }
}

export { RecommendTab, RecommendList}

const styles = StyleSheet.create({
    tabTopOut: {
        backgroundColor: "#fff"
    },
    tabTop: {
        width: screenWidth/4,
        height: 45,
        alignItems: 'center',
        justifyContent: 'center',
    },
    tabTopSelect: {
        alignItems: 'center',
        justifyContent: 'center',
        borderBottomWidth: 2,
        borderBottomColor: '#23cc77'
    },
    tabTopText: {
        fontSize: 16,
        color: "#333"
    },
    tabTopTextSelect: {
        color: '#23cc77'
    },
    tabBottom: {
        backgroundColor: "#f8f8f8",
        flexDirection: "row",
        flexWrap: "wrap",
    },
    tabBottomLink: {
        width: screenWidth/4,
        overflow: 'visible',
        paddingLeft: 10,
        paddingRight: 10,
        borderBottomWidth: 1,
        borderRightWidth: 1,
        borderBottomColor: "#f0f0f0",
        borderRightColor: "#f0f0f0",
    },
    tabBottomCtn: {
        alignItems: 'center',
        justifyContent: 'center',
        height: 26,
        marginTop: 8,
        marginBottom: 8,
        borderRadius: 13,
        // backgroundColor: '#23cc77',
    },
    tabBottomCtnSelect:{
        backgroundColor: '#23cc77',
    },
    tabBottomText: {
        fontSize: 12,
        color: "#666"
    },
    tabBottomTextSelect: {
        color: '#fff'
    },
    productListImage: {
        width: screenWidth,
        height: screenWidth / 320 * 150,
        resizeMode: "cover"
    },
    productListText: {
        backgroundColor: "#fff",
        padding: 15
    },
    productListTitle: {
        color: "#333",
        fontSize: 14,
        height: 16
    },
    productListIntro: {
        color: "#999",
        fontSize: 12,
        height: 14,
        marginTop: 10
    }
})
