//
//  GLCDataBaseOperationManager.m
//  Demos
//
//  Created by gaolong on 16/2/12.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLCDataBaseOperationManager.h"

@interface GLCDataBaseOperationManager ()

@property (nonatomic, strong) NSMutableArray *tablePropertyNamesArray;
@property (nonatomic, assign) BOOL isLoadedDB;

@end

@implementation GLCDataBaseOperationManager

static GLCDataBaseOperationManager *g_staticDBOperation;

+ (GLCDataBaseOperationManager *)sharedDBObject
{
    @synchronized(self) {
        if (!g_staticDBOperation) {
            g_staticDBOperation = [[GLCDataBaseOperationManager alloc] init];
        }
    }
    return g_staticDBOperation;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.dbObject = [[FMDatabase alloc] init];
        self.tablePropertyNamesArray = [NSMutableArray array];
        NSArray *userProfilePropertyNameArray = @[@"nickName", @"sex", @"birthday", @"userId", @"age"];
        [self.tablePropertyNamesArray addObject:userProfilePropertyNameArray];
    }
    return self;
}

+ (void)closeDBObject
{
   // [g_staticDBOperation release];
    g_staticDBOperation = nil;
    
}

- (void)closeDB
{
    self.isLoadedDB = NO;
    [self.queue close];
}

@end
