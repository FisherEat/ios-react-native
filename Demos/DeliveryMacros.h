//
//  DeliveryMacros.h
//  TuNiuApp
//
//  Created by chen on 11/5/13.
//  Copyright (c) 2013 Yu Liang. All rights reserved.
//

#ifndef TuNiuApp_DeliveryMacros_h
#define TuNiuApp_DeliveryMacros_h

//////////////////////////////////////////////////////////////////////////////////////////////////

//注意下面这3个是不用的，真正用的是TN_iOS_PARTNER_NUM
#define TN_iOS_APPSTORE_PARTNER_NUM         14588            //途牛旅游iOS版App Store p值
#define TN_iOS_91_PARTNER_NUM               14890            //途牛旅游iOS版91助手 p值
#define TN_iOS_PP_PARTNER_NUM               14925            //途牛旅游iOS版PP助手 p值
#define TN_iOS_KUAIYONG_PARTNER_NUM         15145            //途牛旅游iOS版快用助手 p值
#define TN_iOS_TONGBUTUI_PARTNER_NUM        14927            //途牛旅游iOS版同步推   p值
#define TN_iOS_ITOOLS_BJ_PARTNER_NUM        15281            //途牛旅游iOS版itools越狱版   p值
#define TN_iOS_WUYOU_PARTNER_NUM            15354            //途牛旅游iOS版无忧助手   p值
#define TN_iOS_I4_PARTNER_NUM               15337            //途牛旅游iOS版爱思助手   p值
#define TN_iOS_AIDESIQI_PARTNER_NUM         15409            //途牛旅游iOS版艾德思奇助手   p值
#define TN_iOS_XY_PARTNER_NUM               15458            //途牛旅游iOS版XY助手   p值
#define TN_iOS_WO_PARTNER_NUM               15493            //途牛旅游iOS版联通沃门户   p值
#define TN_iOS_APPLEASSIST_PARTNER_NUM      15637            //途牛旅游iOS版苹果助手   p值
#define TN_iOS_HAIMA_PARTNER_NUM            15639            //途牛旅游iOS版海马助手   p值
#define TN_iOS_UMZONE_PARTNER_NUM           15641            //途牛旅游iOS版UM空间   p值
#define TN_iOS_HULU_PARTNER_NUM             15654            //途牛旅游iOS版葫芦商城   p值
#define TN_iOS_TONGBUTUIOPTIMIZATION_PARTNER_NUM        15712            //途牛旅游iOS版同步推优化   p值
#define TN_iOS_FOX_PARTNER_NUM              15865            //途牛旅游iOS版狐狸苹果助手   p值
#define TN_iOS_BAILINGOUTUO_PARTNER_NUM     16027            //途牛旅游iOS版百灵欧拓   p值

#define FLURRY_API_KEY                      @"4NYQBQ6WF7ZGR2RDM3S8"             //flurry api key


#define TN_iOS_PARTNER_NUM                  ([GVUserDefaults standardUserDefaults].serverPartnerId)            //途牛旅游iOS版p值
#define TN_TRAVEL_APP_ID                    @"447313708"    //途牛旅游在appstore的id
#define TN_iOS_API_TYPE                     0               //下单途径 api_type
#if TN_PRO
#define TN_iOS_CLIENT_TYPE                  14              //下单子途径/渠道[BI关注数据] client_type
#else
#define TN_iOS_CLIENT_TYPE                  10              //下单子途径/渠道[BI关注数据] client_type
#endif
#define TN_iOS_DEVICE_TYPE                  0               //下单设备类型 device_type
#define TN_SESSION_EXPIRE_DURATION_HOUR     2*7*24          //单位为hour. 默认为2周。

#define TN_PRODUCT_AMOUNT_PER_PAGE          10              //每一页显示的产品数量

//////////////////////////////////////////////////////////////////////////////////////////////////


#endif
