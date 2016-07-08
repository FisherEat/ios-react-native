/**
 * Created by yulibin on 16/6/2.
 */
/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';
import React, {
    Component,
    StyleSheet,
    Text,
    View,
    Image,
    Linking,
    Dimensions,
    ScrollView,
    ListView,
    NativeModules
} from 'react-native';

import TestJson from '../channel/testChannel.json';
import SectionBanner from '../channel/SectionBanner.js';
import SectionTitle from '../channel/SectionTitle.js';
import HotDest from '../channel/HotDest.js';
import SectionService from '../channel/SectionService.js';
import SectionSpecial from '../channel/SectionSpecial.js';
import Header from '../components/header.ios';
import {RecommendTab, RecommendList} from '../channel/RecommendTab.js';
//import TNApiUrls from '../Common/TNApiUrls';
import TNURLRequest from '../Common/TNURLRequest'

// import RecommendList from './js/channel/RecommendList.js';

const PAGE_NAME="国内游频道页";
var screenWidth = Dimensions.get("window").width;
var screenHeight = Dimensions.get("window").height;
class Domestic extends Component {
    constructor(props) {
        super(props);
        this.scrollListen = [];
        this.state = {
            pageStatus: null
        }
    }

    getData(cityInfo) {
        var _ = this;
        var params = {pageId: 1209, cityCode:cityInfo.code};
        var path = "event/admin/getCmsChannelAjax";

        TNURLRequest.get(path, params).then((response) => {
            _.setState({
                pageStatus: response.data
            });
        }).catch((error) => {
            console.log('Error happened ....:' + error);
        });
    }

    componentDidMount() {
        let cityData = {code: 2500};
        this.getData(cityData);
        // NativeModules.TNReactNativeUtil.rn_loadCitycallBack((cityData) => {
        //     this.getData(cityData);
        // });
        // NativeModules.TNReactNativeUtil.rn_logPage(PAGE_NAME,"");
    }

    onScroll(e) {
        var _ = this;
        this.scrollListen.forEach((fn)=> {
            var offsetY = e.nativeEvent.contentOffset.y;
            _.refs.rootView.refs.InnerScrollView.measure((ox, oy, w, h) => {
                fn && fn(h - screenHeight - offsetY);
            })

        })
    }

    renderPage() {
        var data = this.state.pageStatus;
        var _ = this;
        var tabs = [];
        var sectionCount = 0;  //计算产品推荐tab在第几个位置
        var tcg = function* titleCountGenerator() {
            let i = 0;
            while (true) {
                yield i++;
            }
        }();

        var scrollToRm = function (top) {
            _.refs.rootView.scrollTo({y: top});
        }

        var setRecommendList = function (list) {
            //先这样处理了,
            setTimeout(function () {
                if (_.refs.recommendList) {
                    _.refs.recommendList.setListData(list)
                }
            }, 100)
        }


        var sections = data.map(function (d, index) {
            sectionCount++;
            if (d.gGroupId != 0) {
                tabs.push(d);
            }
            return (
                <View key={"react_group"+index}>
                    {
                        d.gItems.map(function (dd, index) {
                            if (dd.mTplId == 1537) {
                                return <SectionTitle key={"sectionTit" + index} mItems={dd.mItems}
                                                     index={ tcg.next().value}></SectionTitle>
                            }
                            if (dd.mTplId == 1152) {
                                return <SectionBanner key={"sectionBanner" + index}
                                                      mItems={ dd.mItems }></SectionBanner>;
                            }
                            if (dd.mTplId == 1539) {
                                return <SectionSpecial key={"sectionSpecial" + index}
                                                       mItems={ dd.mItems }></SectionSpecial>;
                            }
                            if (dd.mTplId == 1531) {
                                return <HotDest key={"HotDest"+index} mItems={ dd.mItems }></HotDest>
                            }
                            if (dd.mTplId == 1532) {
                                return <SectionService key={"sectionService" + index}
                                                       mItems={ dd.mItems }></SectionService>
                            }

                        })
                    }
                </View>
            )
        });

        return (
            <View style={styles.container} key="react_loaded">
                {
                    [<Header ref="Header" title="国内游">

                    </Header>,
                        <ScrollView ref='rootView'
                                    stickyHeaderIndices={[sectionCount]}
                                    scrollEventThrottle={100} onScroll={_.onScroll.bind(_)} style={styles.container}
                                    key="react_abroad">
                            {
                                [...sections
                                    ,
                                    <RecommendTab ref="recommendTab" key='recomend-tab'
                                                  scrollTopRecommend={ scrollToRm.bind(_) }
                                                  setRecommendList={setRecommendList.bind(_)}
                                                  tabs={tabs} scrollListen={_.scrollListen}></RecommendTab>
                                    , <RecommendList ref="recommendList" key="recomend-list"></RecommendList>
                                ]}
                        </ScrollView>]
                }
            </View>
        );
    }

    render() {
        if (!this.state.pageStatus) {
            return (
                <View style={styles.container} key="react_loading">
                    {
                        [<Header ref="Header">

                        </Header>,
                            <Text style={styles.welcome}>

                            </Text>
                        ]
                    }
                </View>
            );
        }
        return this.renderPage();

    }
}
const styles = StyleSheet.create({
    container: {
        flex: 1,
        height: screenHeight,
        backgroundColor: '#f0f0f0'
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10
    },
    instructions: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
    },
    title: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#ffff00',

    },
    avatar: {
        width: 100,
        height: 100
    },


});
module.exports = Domestic;
