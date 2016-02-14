//
//  GLRootHomeDatas.m
//  Demos
//
//  Created by gaolong on 16/2/10.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLRootHomeDatas.h"

@implementation GLRootHomeDatas

@end

@implementation GLRootHomeData
+ (NSMutableDictionary *)getCellDataSource
{
    NSMutableArray *demoArray = [GLRootHomeData getDemoArray];
    NSMutableArray *urlsArray = [GLRootHomeData getToUrlString];
    NSMutableArray *dataSourceArray = [NSMutableArray array];
    NSMutableDictionary *dataSourceDic = [NSMutableDictionary dictionary];
    
    GLRootHomeCellModel *cellModel0 = [[GLRootHomeCellModel alloc] init];
    cellModel0.cellType = GLRootHomeCellTypeHeader;
    cellModel0.cellHeight = 143.0f;
    cellModel0.model = nil;
    [dataSourceArray addObject:cellModel0];
    
    for (NSInteger i = 1; i < demoArray.count; i++) {
        GLRootHomeCellModel *cellModel = [[GLRootHomeCellModel alloc] init];
        cellModel.cellType = GLRootHomeCellTypeSingle;
        cellModel.cellHeight = 50.0f;
        GLRootSingelCellModel *model = [[GLRootSingelCellModel alloc] init];
        model.titleName = demoArray[i-1];
        model.cellId = [GLRootHomeData cellId:i - 1];
        model.toUrlString = urlsArray[i - 1];
        cellModel.model = model;
        [dataSourceArray addObject:cellModel];
    }
    dataSourceDic[@(0)] = dataSourceArray;

    return dataSourceDic;
}

+ (NSArray *)getToUrlString
{
    NSString *defaultURL = @"defualtURL";
    NSMutableArray *urls = [NSMutableArray arrayWithArray:@[defaultURL,GLURLDemoButtonCell,GLURLDemoScrollCell,GLURLDemoPickerViewCell,
        GLURLDemoTabBarCell,
        GLURLDemoAnimationCell,
        GLURLDemoTestCell,
        defaultURL,
        GLURLDemoNetWorkCell,
        GLURLDemoPassValueCell,
        GLURLDemoTextViewCell,
        GLURLDemoAdScrollTimerCell,
        GLURLDemoLoginCell,
        GLURLDemoWebViewCell,
        GLURLDemoTopBarCell,
        GLURLDemoTableViewCell]];
    return urls;
}

+ (NSMutableArray *)getDemoArray
{
     NSMutableArray *demoArray = [NSMutableArray arrayWithArray:@[@"customDemo", @"ButtonDemo", @"ScrollDemo", @"PickerViewDemo", @"TarBarDemo", @"AnimationDemo", @"TestDemo", @"LGALerViewDemo", @"NetWorkDemo", @"PassValueBlock", @"TextViewDemo", @"AdScrollTimerDemo", @"LoginDemo", @"WebViewDemo", @"TopBarViewDemo", @"TableViewTypesDemo"]];
    return demoArray;
}

+ (GLTestDemoTypeCell)cellId:(NSInteger)ID
{
    return ID;
}

@end

@implementation GLRootHomeCellModel

@end

@implementation GLRootSingelCellModel

@end