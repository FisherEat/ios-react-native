//
//  DBCommonDefine.h
//  Demos
//
//  Created by gaolong on 16/2/12.
//  Copyright © 2016年 schiller. All rights reserved.
//

typedef NS_ENUM(NSInteger, DBTableName)
{
    DB_TABLE_USERPROFILE, //用户表
};

typedef NS_ENUM(NSInteger, DBOrderType)
{
    DBOrderTypeDefault = 0, //默认
    DBOrderTypeAscend,      //增序
    DBOrderTypeDescend,     //降序
    
};

//call back blocks
typedef void (^VoidBlock)(void);
typedef void (^StringBlock)(NSString *info, NSError *error);
typedef void (^BoolBlock)(BOOL flag, NSError *error);
typedef void (^ArrayBlock)(NSMutableArray *models, NSError *error);
typedef void (^DictionaryBlock)(NSMutableDictionary *infoDict, NSError *error);
typedef void (^PageArrayBlock)(NSInteger totalPage, NSMutableArray *models, NSError *error);