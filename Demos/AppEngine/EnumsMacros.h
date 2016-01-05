//
//  EnumsMacros.h
//  TuNiuApp
//
//  Created by chen on 11/5/13.
//  Copyright (c) 2013 Yu Liang. All rights reserved.
//

#ifndef TuNiuApp_EnumsMacros_h
#define TuNiuApp_EnumsMacros_h

//////////////////////////////////////////////////////////////////////////////////////////////////
//产品类型
typedef NS_ENUM(NSInteger, TNProductType) {
    TNProductTypeNone = -1,         //默认值
    TNProductTypeAll = 0,           //全部产品
    TNProductTypePackage = 1,           //跟团游产品
    TNProductTypeDIY = 2,                   //自助游产品
    TNProductTypeCruiseShip = 3,            //邮轮产品
    TNProductTypeSceneTicket = 4,                //景点门票
    TNProductTypeAirTicket = 5,         //机票
    TNProductTypeHotel = 6,         //酒店
    TNProductTypeLastMinute = 7,         //尾货
    TNProductTypeSelfDrive = 8,    //自驾
    TNProductTypeVisa = 9,      //签证
    TNProductTypeWireless = 10,      //牛无线
    TNProductTypeGiftCard = 30,     //礼品卡
    TNProductTypeCEORecommend = 15,  //老于推荐的produtctType
    TNProductTypeOne = 101,   //one
    TNProductTypeTrain = 18,    //火车票
    TNProductTypeDuoBao = 21,    //一元夺宝
    TNProductTypeCurrentFun = 96,   //当地玩乐
    TNProductTypeFinance = 97,   //途牛金融
    TNProductTypeBoss30 = 102,  //BOSS 3.0跟团
    TNProductTypeNGSelfDrive = 103,  //NG自驾
};

//分享数据来源类型
typedef NS_ENUM(NSInteger, TNShareDataSourceType) {
    TNShareDataFromProductView = 1,  //分享数据来源于详细产品页
    TNShareDataFromWebview = 2,        //分享数据来源于webView
    TNShareDataFromURLIntercept = 3,  //来自H5页面URL
    TNShareDataFromDonate = 4 ,      //来自慈善活动
    TNShareDataFromInviteCode = 5 ,  //来自牛拉客,老带新二维码
    TNShareDataFromAbout= 6,   //来自APP推荐
    TNShareDataFromScreenCut = 7, //来自截屏
    TNShareDataFromHotelDetail = 8,//来自酒店详情页
    TNShareDataFromHotelBookSuccess = 9,//来自酒店预订成功页
    TNShareDataFromTrainTiicketDetail = 10,//来自火车票列表页车次详情
};

//目的地下的分类，如周边跟团、国内跟团或国内自助、出境自助
typedef NS_ENUM(NSInteger, TNTopType) {
    TNTopTypeNone = -1,         //默认值
    TNTopTypeAll = 0,           //全部
    TNTopTypeNearBy = 26,       //周边
    TNTopTypeDomestic = 27,     //国内
    TNTopTypeOverseas = 28,     //出境
    
};

//产品详情用
typedef NS_ENUM(NSInteger, TNProductCouponUseStyle) {
    TNProductCouponUseStyleNone = 0, //0 : 表示没有抵用券，界面不显示
    TNProductCouponUseStyleAll,      //1：有抵用券，可以用，显示抵用券
    TNProductCouponUseStylePart,     //2：有抵用券未必能用，采取“或”的方式提示用户
};

typedef NS_ENUM(NSInteger, TNRecommendedProductPicSize) {
    TNRecommendedProductPicSize480 = 1,
    TNRecommendedProductPicSize640,
    TNRecommendedProductPicSize1080
};


enum TypeEncodings {
#if __LP64__
    Char                = 'c',
    Bool                = 'B',
    Short               = 's',
    Int                 = 'i',
    Long                = 'l',
    LongLong            = 'q',
    UnsignedChar        = 'C',
    UnsignedShort       = 'S',
    UnsignedInt         = 'I',
    UnsignedLong        = 'L',
    UnsignedLongLong    = 'Q',
    Float               = 'f',
    Double              = 'd',
    Object              = '@'
#else
    Bool                = 'c',
    Short               = 's',
    Int                 = 'i',
    Long                = 'l',
    LongLong            = 'q',
    UnsignedChar        = 'C',
    UnsignedShort       = 'S',
    UnsignedInt         = 'I',
    UnsignedLong        = 'L',
    UnsignedLongLong    = 'Q',
    Float               = 'f',
    Double              = 'd',
    Object              = '@'
#endif
    
};

typedef NS_ENUM(NSInteger, TNOrderPayType) {
    TNOrderPayTypeALiPaySDK = 1,           //支付宝SDK
    TNOrderPayTypeUnionPaySDK,             //银联SDK
    TNOrderPayTypeWXSDK,                   //微信
    TNOrderPayTypeTNBao = 6,               //途牛宝支付
    TNOrderPayTypeNiuxianhua = 7           //牛先花支付

};

typedef NS_ENUM(NSInteger, TNSubscribeType) {
    TNSubscribeTypeUnknown = 0,
    TNSubscribeTypeSubcribe,           //订阅
    TNSubscribeTypeCancel,                 //取消
    
};

typedef NS_ENUM(NSInteger, TNProductSubscriptionShowType) {
    TNProductSubscriptionShowTypeExpanding = 0,  //展开状态
    TNProductSubscriptionShowTypePackUp         //收起状态
};



//产品类型 1:目的地；2：跟团；3：自助
typedef NS_ENUM(NSInteger, TNProductTypeForSubscribe) {
    TNProductTypeForSubscribeDestination = 1,           //目的地
    TNProductTypeForSubscribePackage = 2,                   //跟团游产品
    TNProductTypeForSubscribeDIY = 3,                       //自助游产品
    TNProductTypeForSubscribeVisa = 4,                       //签证
    TNProductTypeForSubscribeSelfDrive = 8                   //自驾
};

//图片尺寸 1：480；2：640；3：720；4：1080
typedef NS_ENUM(NSInteger, TNProductImageSize) {
    TNProductImageSize480 = 1,
    TNProductImageSize640,
    TNProductImageSize720,
    TNProductImageSize1080,
};

typedef NS_ENUM(NSInteger, TNBindType) {
    TNBindTypeTencentQQ = 0,           //QQ
    TNBindTypeSinaWeiBo,               //新浪微博
    TNBindTypeWeiChat,             //微信
};

typedef NS_ENUM(NSInteger, TNShareItemType) {
    TNShareItemTypeUnknow = -1,
    TNShareItemTypeTencentQQ = 0,           //QQ
    TNShareItemTypeSinaWeiBo,               //新浪微博
    TNShareItemTypeWeiXinSession,           //微信好友
    TNShareItemTypeWeiXinTimeline,          //微信朋友圈
};

//出团通知书确认操作
typedef NS_ENUM(NSInteger, TNTravelNotificationActionType) {
    TNTravelNotificationActionTypeBeenConfirmed = 0,           //出团通知书不需要确认
    TNTravelNotificationActionTypeNeedConfirm,               //出团通知书需要确认
};


//产品类型
typedef NS_ENUM(NSInteger, TNTicketType) {
    TNTicketTypeEntrance = 1,              //门票
    TNTicketTypeCoupon   = 2,              //联票
    TNTicketTypePackage  = 3,              //套票
    TNTicketTypeSpecial  = 4,              //专项
};


typedef NS_ENUM(NSInteger, TNTrafficType) {
    TNTrafficTypeCar = 1, //自驾
    TNTrafficTypeBus = 2, //公交
};

//门票预订输入数据验证
typedef NS_ENUM(NSInteger, TNTicketBookValidationType) {
    TNVisaBookValidationTypePass = 0, //验证通过
    TNVisaBookValidationTypeNullError, //字符串为空
    TNVisaBookValidationTypeLengthError, //长度错误
    TNVisaBookValidationTypeFormatError, //格式错误
};

//签证预订输入数据验证
typedef NS_ENUM(NSInteger, TNVisaBookValidationType) {
    TNTicketBookValidationTypePass = 0, //验证通过
    TNTicketBookValidationTypeNullError, //字符串为空
    TNTicketBookValidationTypeLengthError, //长度错误
    TNTicketBookValidationTypeFormatError, //格式错误
};

typedef NS_ENUM(NSInteger, TNSortFilterType) {
    TNSortFilterTypeDefault = 1,    //1:默认
    TNSortFilterType30DaySaleCount = 2,    //2：销量||推荐
    TNSortFilterTypeSatisfaction = 3,    //3：满意||评分
    TNSortFilterTypePriceDescend = 4,    //4：价格降序
    TNSortFilterTypePriceAscend = 5,    //5：价格升序
//    TNSortFilterTypeRemarkCount = 6, //6：点评数量
//    TNSortFilterTypeDiscount = 7,       //9: 距离
    TNSortFilterTypeSynthesis = 6,     //综合排序
    TNSortFilterTypeDistanceDescend = 7,    //距离降序
    TNSortFilterTypeDistanceAscend = 8,    //距离升序
    TNSortFilterTypeNone = 0,  //不排序
};

typedef NS_ENUM(NSInteger, TNSelfDriveOptionFilterType) {
    TNSelfDriveOptionFilterTypeScenic = 1,    //1：景点
    TNSelfDriveOptionFilterTypeHotel = 2,       //2：酒店
    TNSelfDriveOptionFilterTypeDayCount = 3,    //3：天数
    TNSelfDriveOptionFilterTypeDistance = 4,    //4：距离
    TNSelfDriveOptionFilterTypeTheme = 5,   //5：主题
    TNSelfDriveOptionFilterTypeDestination = 6, //6：目的地
    TNSelfDriveOptionFilterTypePriceRange = 7,  //7：价格范围
};


typedef NS_ENUM(NSInteger, TNHotelSortFilterType) {
    TNHotelSortFilterTypeDefault = 1,    //1:默认
    TNHotelSortFilterType30DaySaleCount = 2,    //2：销量||推荐
    TNHotelSortFilterTypeSatisfaction = 3,    //3：满意||评分
    TNHotelSortFilterTypePriceDescend = 4,    //4：价格降序
    TNHotelSortFilterTypePriceAscend = 5,    //5：价格升序
    TNHotelSortFilterTypeDistance = 6, //6：距离越近越好
};

typedef NS_ENUM(NSInteger, TNVisaType) {
    TNVisaTypeAll = 0,    //0：全部签证
    TNVisaTypeTravel = 1,    //1：旅游签证
    TNVisaTypeBusiness = 2,    //2：商务签证
    TNVisaTypeTourist = 3,    //3：探亲签证
    TNVisaTypeMaxCount,
};

typedef NS_ENUM(NSInteger, TNBookOrderType) {
    TNBookOrderTypeNetWork = 0,    //0：网络订单
    TNBookOrderTypeOnline = 1,    //1：在线预订订单
};

typedef NS_ENUM(NSInteger, TNOnlineBookTouristCellType) {
    TNOnlineBookTouristCellTypeHeader = 0,    //头信息
    TNOnlineBookTouristCellTypeName,   //姓名
    TNOnlineBookTouristCellTypeTouristType,   //出游人类型
    TNOnlineBookTouristCellTypeIdType,   //证件类型
    TNOnlineBookTouristCellTypeIdValue,   //证件号
    TNOnlineBookTouristCellTypeTel,   //手机号
    TNOnlineBookTouristCellTypeGender,   //性别
    TNOnlineBookTouristCellTypeBirthday,   //出生日期
};

typedef NS_ENUM(NSInteger, TNHotelPayType) {
    TNHotelPayTypeCashPayWithOutGuarantee = 0,      //现付非担保
    TNHotelPayTypeCashPayWithGuarantee,         //现付担保
        TNHotelPayTypePrepay, //预付
};

typedef NS_ENUM(NSInteger, TNHotelSearchType) {
    TNHotelSearchTypeDefault = 1,           //默认
    TNHotelSearchTypePOI,                   //通过POI进来
    TNHotelSearchTypeNearBy,                //附近
};

typedef NS_ENUM(NSInteger, TNCouponType) {//产品优惠类型
    TNProductCouponStyleNone = 0,     //0: 没有优惠
    TNProductCouponStyleStandBy,      //1：立减优惠
    TNProductCouponStyleMuchEarlier,  //2：早多优惠
    TNProductCouponStyleMobile,       //3：手机特惠
    TNProductCouponStyleVouchers,     //4：抵用券
    TNProductCouponStyleDoubleVouchers,//5：双倍抵用券，仅限周边跟团产品
};

typedef NS_ENUM (NSInteger, TNCategoryType) {//只用在了首页里
    TNCategoryTypeGroup = 1,            // 跟团旅游
    TNCategoryTypeSelfTourism,          // 自助旅游
    TNCategoryTypeCruiseShip,           // 邮轮
    TNCategoryTypeScenicTicket,         // 门票
    TNCategoryTypeDrivingTourism,       // 自驾旅游
    TNCategoryTypeVisa,                 // 签证
    TNCategoryTypeHotel,                // 酒店
    TNCategoryTypeWifi,                 // 牛无线
    TNCategoryTypeGroupNearBy = 126,    // 周边-跟团旅游
    TNCategoryTypeGroupDomestic = 127,  // 国内-跟团旅游
    TNCategoryTypeGroupOverseas = 128,  // 出境-跟团旅游
};

//通知中心的通知类型
typedef NS_ENUM (NSInteger, TNNotificationType) {
    TNNotificationTypeOrder = 1,
    TNNotificationTypeLastMinute,
    TNNotificationTypeH5Activity,
    TNNotificationTypeOne,
    TNNotificationTypeCategory,//品类
};

//第三方下载安装激活统计，统计类型
typedef NS_ENUM (NSInteger, TNActivationType) {
    TNActivationTypeThreeMinutesUsed = 0,//使用3分钟
    TNActivationTypeLaunch,              //启动
    TNActivationTypeLogin,               //登录途牛
    TNActivationTypeOneMinutesUsed,      //使用1分钟
    TNActivationTypeTwoMinutesUsed,      //使用2分钟
    TNActivationTypeRegistration,        //注册途牛用户
    TNActivationTypeDailyActive,         //没日打开
};

//1门票自取（网上支付），2门票自取（景区现付），3快递上门 [app暂不用解析]
typedef NS_ENUM (NSInteger, TNDrawType) {
    TNDrawTypeOnlinePay = 1,
    TNDrawTypeScenicPay = 2,
    TNDrawTypeExpressDelivery = 3,
};

//定位状态
typedef NS_ENUM(NSInteger, TNCurrentCityGetType) {
    TNCurrentCityGetTypeDefault = 0,
    TNCurrentCityGetTypeFaild,
    TNCurrentCityGetTypeLoading,
    TNCurrentCityGetTypeSuccess,
    TNCurrentCityGetTypeNotSupport,
};

//Date Format Type
typedef NS_ENUM(NSInteger, TNDateFormatType) {
    TNDateFormatTypeDefault = 0, //2014-02-03
    TNDateFormatTypeNum,         //20140203
    TNDateFormatTATimeStamp,     //yyyy-MM-dd HH:mm:ss
    TNDateFormatWeek,            //Tuesday, Tue
    TNDateFormatBenchmark //yyyyMMddHHmmssSSS
};

typedef NS_ENUM(NSInteger, TNUserCenterChargeCellType) {
    TNUserCenterChargeCellTypeBlank,           //空行
    TNUserCenterChargeCellTypeCoupon,          //抵用券余额
    TNUserCenterChargeCellTypeTravelCoupon,    //旅游券余额
    TNUserCenterChargeCellTypeCash,            //现金账户余额
};

//银行卡类型
typedef NS_ENUM(NSInteger, TNBankCardType) {

    TNBankCardTypeSaving = 1, //储蓄卡
    TNBankCardTypeCredit = 2, //信用卡

};

//机票排序
typedef NS_ENUM (NSInteger, TNFlightSortType){
    TNFlightSortTypeOrder = 1,       //排序规则
    TNFlightSortTypePriceDesc = 2,  //价格降序
    TNFlightSortTypePriceAsc,       //价格升序
    TNFlightSortTypeTimeDesc,       //起飞时间降序
    TNFlightSortTypeTimeAsc         //起飞时间升序
};

typedef NS_ENUM (NSInteger, TNDIYHotelSortType){
    TNDIYHotelSortTypeStockDesc = 1,  //库存降序
    TNDIYHotelSortTypePriceDesc,  //价格降序
    TNDIYHotelSortTypePriceAsc,       //价格升序
};

//机票日历
typedef NS_ENUM (NSInteger, TNFlightTicketCalendarType)
{
    TNFlightTicketCalendarTypeGroup = 1,      //套票
    TNFlightTicketCalendarTypeInternalIndividual = 2, //国内散客票
    TNFlightTicketCalendarTypeInternationalIndividual = 3  //国际散客票
};

//机票类型
typedef NS_ENUM (NSInteger, TNFlightTicketType){
    TNFlightTicketTypeGroup = 1,      //套票
    TNFlightTicketTypeIndividual = 2, //散客票
};

//散客票类型
typedef NS_ENUM (NSInteger, TNFlightIndividualTicketType){
    TNFlightIndividualTicketTypeSimple = 1,   //单程
    TNFlightIndividualTicketTypeRoundTrip = 2 //往返
};

//机票、酒店的view 以及业务处理都需要用到   因此放到这边来了
typedef NS_ENUM(NSInteger, TNPackageDataSourceType) {
    TNPackageDataSourceTypeEmpty = 0,               //空cell
    /*
     * @description -------------套餐列表使用
     */
    TNPackageDataSourceTypeIndividualTravelerTrip,  //散客入口
    TNPackageDataSourceTypePackageTrip,             //套餐
    TNPackageDataSourceTypeFlightGoTrip,            //去往航班
    TNPackageDataSourceTypeFlightBackTrip,          //返回航班
    TNPackageDataSourceTypeHotelTrip,               //酒店
    TNPackageDataSourceTypeHotelTripIncludePrice,   //包含酒店价格
    
    /*
     * @description -------------机票列表使用
     */
    TNPackageDataSourceTypeFlightWarning,           //机票提示cell
    TNPackageDataSourceTypeFlightGroupTicket,       //往返航班（套票）
    TNPackageDataSourceTypeFlightSimpleTicket,      //单程航班
};

//分享数据来源类型
typedef NS_ENUM(NSInteger, TNAPIUrlType) {
    TNAPIUrlTypeDefault = 0, //默认没有设置环境
    TNAPIUrlTypeMp = 1,  //MP环境
    TNAPIUrlTypeM145 = 2,  //m145
    TNAPIUrlTypeRelease = 3,  //release
    TNAPIUrlTypeFree = 5        //自定义
};

//证件类型
typedef NS_ENUM(NSInteger, TNCardType)

{
    TNCardTypeNone  = 0,     //暂无证件类型
    TNCardTypeID = 1,        //身份证
    TNCardTypePassport = 2,  //护照
    TNCardTypeOfficer= 3,    //军官证
    TNCardTypeHkmac= 4,      //港澳
    TNCardTypeOther = 6,     //其他
    TNCardTypeTaiwan = 7,    //台胞
    TNCardTypeHuiXiang = 8,  //回乡证
    TNCardTypeResidenceBokk = 9,     //户口本
    TNCardTypeBirthCertificate = 10, //出生证明
    TNCardTypeTaiwanMac = 11 //台湾通行证
};

//页面来源--常用旅客使用
typedef NS_ENUM(NSInteger, TNCommonTouristPageSource)
{
    TNCommonTouristPageSourceSelf = 0,
    TNCommonTouristPageSourceBook
};

typedef NS_ENUM(NSInteger, TNRestPasswordType){
    TNRestPasswordTypePhone = 0, //手机号
    TNRestPasswordTypeMail = 1   //邮箱找回
};

//游记评论类型
typedef NS_ENUM(NSInteger, TNUserCommentType) {
    TNUserCommentTypeNew,  // 新建评论
    TNUserCommentTypeReply, // 回复评论
};

typedef NS_ENUM (NSInteger , TNCaptchaType){
    TNCaptchaTypeWhileLogin = 0, //登录
    TNCaptchaTypeWhileDynamicPassword,//动态密码
    TNCaptchaTypeWhileSendCode  //发送手机验证码
};

typedef NS_ENUM (NSInteger, TNPushNotificationCatType) {
    TNPushNotificationCatTypeSelectedActity = 1,  //精选活动
    TNPushNotificationCatTypeSaleRecommend,     //特卖推荐
    TNPushNotificationCatTypeOrderAssistant,    //订单管家
    TNPushNotificationCatTypeNotification       //消息通知
};


/**
 *   推送分享成功消息接口中分享的类型sharedType
 *   0、其他；1、游记；2、足迹；3、线路（或活动）；4、红包；5、照片；6、APP推荐；7、老带新二维码；8、截屏；1，2，5由pad添加，4单独在红包中使用redbagsheet
 *
 */
typedef NS_ENUM (NSInteger, TNUserShareSuccessType) {
    TNUserShareSuccessTypeOther = 0,  //其他
    TNUserShareSuccessTypeRouteOrActivity = 3,     //线路（或活动）
    TNUserShareSuccessTypeRedBag = 4,     //红包
    TNUserShareSuccessTypeAboutApp = 6, //app推荐
    TNUserShareSuccessTypeInvitationCode = 7, //老带新二维码
    TNUserShareSuccessTypeScreenCut = 8, //截屏
};

/**
 *   推送分享成功消息接口中分享的类型sharedId 
 *   一般是产品编号
 *   如果没有特殊的Id广告页（活动）传1，老带新传2 APP推荐传3 截屏传4 红包 5
 */
typedef NS_ENUM (NSInteger, TNSharedIdType) {
    TNSharedIdTypeActivity = 1,     //广告或活动传1，因为没有productid
    TNSharedIdTypeOldNew = 2, //老带新传2
    TNSharedIdTypeAbout = 3, //APP推荐传3
    TNSharedIdTypeScreenCut = 4, //截屏传4
    TNSharedIdTypeRedBag = 5, //红包 5
};

typedef NS_ENUM(NSInteger, TNZipType) {
    TNCommonZipType = 1,//公用包
    TNWifiZipType = 2  //牛无线
};

typedef NS_ENUM(NSInteger, TNDataSteWardCameraType){//资料管家、拍照类型
    TNDataSteWardCameraTypeSingle = 0, //单张
    TNDataSteWardCameraTypeID = 1,     //身份证
    TNDataSteWardCameraTypeN = 2,      //多张
};

typedef NS_ENUM(NSInteger, TNCacheType) {
    TNCacheTypeMemory = 0,           //默认,内存
    TNCacheTypeDisk,                   //磁盘
};

typedef NS_ENUM(NSInteger,TNScenicPromotionType) {
    TNScenicPromotionTypeCoupon = 15,//抵用券
    TNScenicPromotionTypeSubtracterNow1 = 14,//立减
    TNScenicPromotionTypeSubtracterNow2 = 20,//立减
    TNScenicPromotionTypeEarlyDiscount1 = 16,//早多
    TNScenicPromotionTypeEarlyDiscount2 = 17,//早多
    TNScenicPromotionTypeDiscountCode = 21,//优惠码
};

/*!
 *  @author linfeng, 15-06-02 13:06:02
 *
 *  @brief  MJPhotoBrowser样式类型
 */
typedef NS_ENUM(NSInteger, MJPhotoBrowserShowType){
    /*!
     *  @author linfeng, 15-06-02 13:06:02
     *
     *  @brief  现有普通样式 （适用于游记详情中的照片、游轮中的照片等）
     */
    MJPhotoBrowserShowTypeNormal = 0,
    /*!
     *  @author linfeng, 15-06-02 13:06:02
     *
     *  @brief  从个人信息界面中打开的某人全部照片样式
     */
    MJPhotoBrowserShowTypePersonalProfile = 1,
    /*!
     *  @author linfeng, 15-06-02 15:06:23
     *
     *  @brief  从个人信息界面中打开的某人头像照片样式
     */
    MJPhotoBrowserShowTypePersonalProfileBlank = 2,
};

#endif
