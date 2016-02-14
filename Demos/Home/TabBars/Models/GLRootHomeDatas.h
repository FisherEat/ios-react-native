//
//  GLRootHomeDatas.h
//  Demos
//
//  Created by gaolong on 16/2/10.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GLRootHomeCellType)
{
    GLRootHomeCellTypeHeader,
    GLRootHomeCellTypeButton,
    GLRootHomeCellTypeSingle,
};

typedef NS_ENUM(NSInteger, GLTestDemoTypeCell)
{
    CustomDemoCell = 0,
    ButtonDemoCell ,
    ScrollDemoCell ,
    PickerViewDemoCell ,
    TarBarDemoCell ,
    AnimationDemoCell,
    TestDemoCell ,
    LGALerViewDemoCell ,
    NetWorkDemoCell ,
    PassValueDemoCell ,
    TextViewDemoCell ,
    AdScrollTimerCell ,
    LoginDemoCell ,
    WebViewDemoCell ,
    TopBarViewDemoCell ,
    TableViewDemoCell 
};

@interface GLRootHomeDatas : NSObject

@end

@interface GLRootHomeData : NSObject

+ (NSMutableDictionary *)getCellDataSource;

+ (NSMutableArray *)getDemoArray;

@end

@interface GLRootSingelCellModel : NSObject

@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, assign) GLTestDemoTypeCell cellId;
@property (nonatomic, copy) NSString *toUrlString;

@end

@interface GLRootHomeCellModel : NSObject

@property (nonatomic, assign) GLRootHomeCellType cellType;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) GLRootSingelCellModel *model;

@end
