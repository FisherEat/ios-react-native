//
//  TNNavigationURLHelper.m
//  TuNiuApp
//
//  Created by Ben on 15/7/14.
//  Copyright (c) 2015年 Tuniu. All rights reserved.
//

#import "TNNavigationURLHelper.h"
#import "TNNavigator.h"

NSString *const TNNURLScheme = @"tuniuapp";
NSString *const TNNURLHotelHome = @"tuniuapp://travel/hotel/home";
NSString *const TNNURLHotelList = @"tuniuapp://travel/hotellist";
NSString *const TNNURLHotelDetail = @"tuniuapp://travel/hoteldetail";
NSString *const TNNURLCategoryHome = @"tuniuapp://travel/category";
NSString *const TNNURLActiveCategoryHome = @"tuniuapp://travel/category/activity";
NSString *const TNNURLTrainTicketHome = @"tuniuapp://travel/trainticket/home";
NSString *const TNNURLTrainTicketList = @"tuniuapp://travel/trainticket/list";
NSString *const TNNURLTrainTicketDetail = @"tuniuapp://travel/trainticket/traindetail";
NSString *const TNNURLAirlineTicketHome = @"tuniuapp://travel/airlineticket/home";
NSString *const TNNURLAirlineTicketListSingle = @"tuniuapp://travel/airlineticket/list/single";
NSString *const TNNURLAirlineTicketListRound = @"tuniuapp://travel/airlineticket/list/round";
NSString *const TNNURLSearchList = @"tuniuapp://travel/search";
NSString *const TNNURLFreePackageHome = @"tuniuapp://travel/selfhelp_pack";
NSString *const TNNURLProductDetail = @"tuniuapp://travel/product_detail";
NSString *const TNNURLPackageList = @"tuniuapp://travel/grouplist";
NSString *const TNNURLPackageSelectPlanDate = @"tuniuapp://travel/package/plandate";
NSString *const TNNURLPackageBookStepOne = @"tuniuapp://travel/package/book/stepone";
NSString *const TNNURLPackageBookStepTwo = @"tuniuapp://travel/package/book/steptwo";
NSString *const TNNURLDiyList = @"tuniuapp://travel/diylist";
NSString *const TNNURLCruiseShipList = @"tuniuapp://travel/cruiseshiplist";
NSString *const TNNURLSelfDriveList = @"tuniuapp://travel/selfdrivelist";
NSString *const TNNURLVisaList = @"tuniuapp://travel/visalist";
NSString *const TNNURLWirelessList = @"tuniuapp://travel/wifilist";
NSString *const TNNURLLastMinuteList = @"tuniuapp://travel/lastminutelist";
NSString *const TNNURLScenicHomeList = @"tuniuapp://travel/category/ticket_home";
NSString *const TNNURLScenicThemeList = @"tuniuapp://travel/scenic_channel/scenicthemelist";
NSString *const TNNURLScenicRecommendList = @"tuniuapp://travel/scenic_channel/scenicrecommendlist";
NSString *const TNNURLTripChannel = @"tuniuapp://travel/tripchannel";
NSString *const TNNURLManOnTravel = @"tuniuapp://travel/ontravellist";
NSString *const TNNURLManOnTravelDetail = @"tuniuapp://travel/ontraveldetail";  /**< bad path  */
NSString *const TNNURLAskDetail = @"tuniuapp://travel/askdetail";
NSString *const TNNURLCEORecommend = @"tuniuapp://travel/ceorecommend";
NSString *const TNNURLTravelencyclopedia = @"tuniuapp://travel/travelencyclopedia";  /**< bad path  */
NSString *const TNNURLAlbum = @"tuniuapp://travel/album";  /**< bad path  */
NSString *const TNNURLFindNewList = @"tuniuapp://travel/findnewlist";
NSString *const TNNURLFindNewDetail = @"tuniuapp://travel/findnewdetail"; /**< bad path  */
NSString *const TNNURLCompanionDetail = @"tuniuapp://travel/companiondetail"; /**< bad path  */
NSString *const TNNURLPictureListDetail = @"tuniuapp://travel/pictures";

@implementation TNNavigationURLHelper

+ (void)registerAllURLs
{
    static dispatch_once_t onceToken;
    static NSDictionary *URLClassMap = nil;
    dispatch_once(&onceToken, ^{
        URLClassMap = @{TNNURLHotelHome:@"TNHotelViewController",
                        TNNURLHotelList:@"TNHotelListViewController",
                        TNNURLHotelDetail:@"TNModernHotelDetailViewController",
                        TNNURLCategoryHome:@"TNCategoryHomeViewController",
                        TNNURLActiveCategoryHome:@"TNChannelViewController",
                        TNNURLTrainTicketHome:@"TNTrainTicketHomeViewController",
                        TNNURLTrainTicketList:@"TNTrainTicketsViewController",
                        TNNURLTrainTicketDetail:@"TNTrainDetailViewController",
                        TNNURLAirlineTicketHome:@"TNAirplaneTicketHomeViewController",
                        TNNURLAirlineTicketListSingle:@"TNFlightsViewController",
                        TNNURLAirlineTicketListRound:@"TNAssembleFlightsViewController",
                        TNNURLSearchList:@"TNSearchResultViewController",
                        TNNURLFreePackageHome:@"TNDIYFillFilterInfoViewController",
                        TNNURLProductDetail:@"TNProductDetailContainerViewController",
                        TNNURLPackageList:@"TNPackageListViewController",
                        TNNURLPackageSelectPlanDate:@"TNPackageSelectPlanDateViewControllerV609",
                        TNNURLPackageBookStepOne:@"TNPackageBookStepOneViewController",
                        TNNURLPackageBookStepTwo:@"TNPackageBookStepTwoViewController",
                        TNNURLDiyList:@"TNDIYListViewController",
                        TNNURLCruiseShipList:@"TNCruiseShipViewController",
                        TNNURLSelfDriveList:@"TNSelfDriveListViewController",
                        TNNURLVisaList:@"TNVisaViewController",
                        TNNURLWirelessList:@"TNWirelessListViewController",
                        TNNURLLastMinuteList:@"TNLeftoverProductsViewController",
                        TNNURLScenicHomeList:@"TNScenicListViewController",
                        TNNURLScenicThemeList:@"TNScenicThemeViewController",
                        TNNURLScenicRecommendList:@"TNScenicRecommendListViewController",
                        TNNURLTripChannel:@"TNTripChannelViewController",
                        TNNURLManOnTravel:@"TNManOnTheRoadListViewController",
                        TNNURLAskDetail:@"TNAskDetailViewController",
                        TNNURLCEORecommend:@"TNTravelAssetsController",
                        TNNURLTravelencyclopedia:@"TNWeChatInterfaceController",
                        TNNURLAlbum:@"TNThemeAssetsController",
                        TNNURLManOnTravelDetail:@"TNManOnTheRoadDetailViewController",
                        TNNURLFindNewList:@"TNFindMarvelViewController",
                        TNNURLFindNewDetail:@"TNFindMarvelDetailViewController",
                        TNNURLCompanionDetail:@"TNTravelTogetherDetailViewController",
                        TNNURLPictureListDetail:@"TNMapAndPictureWallViewController",
                        };
    });
    
    [URLClassMap enumerateKeysAndObjectsUsingBlock:^(NSString *URL, NSString *className, BOOL *stop) {
        [[TNNavigator navigator].map from:URL toViewController:className];
    }];
}

@end
