//
//  GLCDataBaseOperationManager.h
//  Demos
//
//  Created by gaolong on 16/2/12.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "DBCommonDefine.h"

#define DBOperation [GLCDataBaseOperationManager sharedDBObject]

@class FMDatabaseQueue;
@interface GLCDataBaseOperationManager : NSObject

@property (nonatomic, strong) FMDatabase *dbObject;
@property (nonatomic, strong) FMDatabaseQueue *queue;

@property (nonatomic, strong) dispatch_queue_t dbQueue;

+ (GLCDataBaseOperationManager *)sharedDBObject;

- (void)openDB:(NSString *)account;

- (void)closeDB;

- (void)insertWithTableName:(DBTableName)tableName insertData:(id)classInstance result:(VoidBlock)block;

- (void)insertWithTableName:(DBTableName)tableName insertData:(id)classInstance;

- (void)insertWithBatchWithTableName:(DBTableName)tableName dataArray:(NSArray *)dataArray;

- (void)insertWithBatchWithTableName:(DBTableName)tableName dataArray:(NSArray *)dataArray result:(VoidBlock)block;

- (void)deleteFromTableName:(DBTableName)tableName propertyName:(NSString *)propertyName propertyValue:(NSString *)propertyValue;

- (void)deleteFromTableName:(DBTableName)tableName propertyName:(NSString *)propertyName propertyValue:(NSString *)propertyValue result:(VoidBlock)block;

- (void)deleteFromTableName:(DBTableName)tableName whereSQLString:(NSString *)whereSQLString;

- (void)deleteFromTableName:(DBTableName)tableName whereSQLString:(NSString *)whereSQLString result:(VoidBlock)block;

- (void)updateBatchWithTableName:(DBTableName)tableName updateData:(id)classInstance;

- (void)updateBatchWithTableName:(DBTableName)tableName dataArray:(NSArray *)dataArray;

- (NSMutableArray *)selectFromTableName:(DBTableName) orderByName:(NSString *)orderByName orderType:()

@end
