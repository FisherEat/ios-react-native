//
//  GLThirdDataSource.h
//  Demos
//
//  Created by gaolong on 16/6/22.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GLThirdCellType)
{
    GLThirdCellTypeDefault, //默认cell
};

@interface GLThirdModel : NSObject

@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *imgName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *urlViewController;

@end

@interface GLThirdDataModel : NSObject

@property (nonatomic, assign) GLThirdCellType cellType;
@property (nonatomic, strong) id model;
@property (nonatomic, assign) CGFloat cellHeight;

- (instancetype)initWithType:(GLThirdCellType)type  model:(id)model;

@end

//数据源
@interface GLThirdDataSource : NSObject

@property (nonatomic, strong) NSMutableArray *collectionDataSourceArray;

- (void)setUpCollectionDataSource:(id)baseData;

- (void)clearDataSource;

@end
