//
//  GLThirdDataSource.m
//  Demos
//
//  Created by gaolong on 16/6/22.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLThirdDataSource.h"

@implementation GLThirdDataModel

- (instancetype)initWithType:(GLThirdCellType)type model:(id)model
{
    if (self = [super init]) {
        _cellType = type;
        _model = model;
        _cellHeight = 0;
    }
    return self;
}

@end

@implementation GLThirdModel

@end

@implementation GLThirdDataSource

- (instancetype)init
{
    if (self = [super init]) {
        self.collectionDataSourceArray = [NSMutableArray array];
    }
    return self;
}

- (void)clearDataSource
{
    [self.collectionDataSourceArray removeAllObjects];
}

- (void)setUpCollectionDataSource:(id)baseData
{
    if (![baseData isKindOfClass:[NSArray class]]) {
        return;
    }
    [self.collectionDataSourceArray removeAllObjects];
    
    NSArray<GLThirdModel *> *baseArray = (NSArray<GLThirdModel *> *)baseData;
    [baseArray enumerateObjectsUsingBlock:^(GLThirdModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GLThirdDataModel *dataModel = [[GLThirdDataModel alloc] initWithType:GLThirdCellTypeDefault model:obj];
        [self.collectionDataSourceArray addObject:dataModel];
    }];
}

@end
