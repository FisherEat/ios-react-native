//
//  main.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "FMDB.h"
#import <sqlite3.h>

void FMDBReportABugFunction();
#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

int main(int argc, char * argv[]) {
    @autoreleasepool {
         //FMDBReportABugFunction();
//        
//        NSString *dbPath = @"/tmp/tmp.db";
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        [fileManager removeItemAtPath:dbPath error:nil];
//        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
//         NSLog(@"Is SQLite compiled with it's thread safe options turned on? %@!", [FMDatabase isSQLiteThreadSafe] ? @"Yes" : @"No");
//        {
//            FMDBQuickCheck([db executeQuery:@"select * from table"] == nil);
//            NSLog(@"%d: %@", [db lastErrorCode], [db lastErrorMessage]);
//        }
//        
//        if (![db open]) {
//            NSLog(@"Could not open db.");
//        }
//        
//        [db setShouldCacheStatements:YES];
//        
//        [db executeUpdate:@"blah blah blah"];
//        FMDBQuickCheck([db hadError]);
//        
//        if ([db hadError]) {
//            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
//        }
//        
//        NSError *err = 0x00;
//        FMDBQuickCheck(![db executeUpdate:@"blah blah blah" withErrorAndBindings:&err]);
//        FMDBQuickCheck(err != nil);
//        FMDBQuickCheck([err code] == SQLITE_ERROR);
//        NSLog(@"err: '%@'", err);
//        
//        // empty strings should still return a value.
//        FMDBQuickCheck(([db boolForQuery:@"SELECT ? not null", @""]));
//        
//        // same with empty bits o' mutable data
//        FMDBQuickCheck(([db boolForQuery:@"SELECT ? not null", [NSMutableData data]]));
//        
//        // same with empty bits o' data
//        FMDBQuickCheck(([db boolForQuery:@"SELECT ? not null", [NSData data]]));
//        
//        
//        
//        // how do we do pragmas?  Like so:
//        FMResultSet *ps = [db executeQuery:@"pragma journal_mode=delete"];
//        FMDBQuickCheck(![db hadError]);
//        FMDBQuickCheck(ps);
//        FMDBQuickCheck([ps next]);
//        [ps close];
//        
//        // oh, but some pragmas require updates?
//        [db executeUpdate:@"pragma page_size=2048"];
//        FMDBQuickCheck(![db hadError]);
//        
//        // what about a vacuum?
//        [db executeUpdate:@"vacuum"];
//        FMDBQuickCheck(![db hadError]);
//        
//        // but of course, I don't bother checking the error codes below.
//        // Bad programmer, no cookie.
//        
//        [db executeUpdate:@"create table test (a text, b text, c integer, d double, e double)"];
//        
//        
//        [db beginTransaction];
//        int i = 0;
//        while (i++ < 20) {
//            [db executeUpdate:@"insert into test (a, b, c, d, e) values (?, ?, ?, ?, ?)" ,
//             @"hi'", // look!  I put in a ', and I'm not escaping it!
//             [NSString stringWithFormat:@"number %d", i],
//             [NSNumber numberWithInt:i],
//             [NSDate date],
//             [NSNumber numberWithFloat:2.2f]];
//        }
//        [db commit];
//
//        // do it again, just because
//        [db beginTransaction];
//        i = 0;
//        while (i++ < 20) {
//            [db executeUpdate:@"insert into test (a, b, c, d, e) values (?, ?, ?, ?, ?)" ,
//             @"hi again'", // look!  I put in a ', and I'm not escaping it!
//             [NSString stringWithFormat:@"number %d", i],
//             [NSNumber numberWithInt:i],
//             [NSDate date],
//             [NSNumber numberWithFloat:2.2f]];
//        }
//        [db commit];
//        
//        FMResultSet *rs = [db executeQuery:@"select rowid,* from test where a = ?", @"hi'"];
//        while ([rs next]) {
//            // just print out what we've got in a number of formats.
//            NSLog(@"%d %@ %@ %@ %@ %f %f",
//                  [rs intForColumn:@"c"],
//                  [rs stringForColumn:@"b"],
//                  [rs stringForColumn:@"a"],
//                  [rs stringForColumn:@"rowid"],
//                  [rs dateForColumn:@"d"],
//                  [rs doubleForColumn:@"d"],
//                  [rs doubleForColumn:@"e"]);
//            
//            
//            if (!([[rs columnNameForIndex:0] isEqualToString:@"rowid"] &&
//                  [[rs columnNameForIndex:1] isEqualToString:@"a"])
//                ) {
//                NSLog(@"WHOA THERE BUDDY, columnNameForIndex ISN'T WORKING!");
//                return 7;
//            }
//        }
//        
//        [rs close];
//        
//        FMDBQuickCheck(![db hasOpenResultSets]);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

void FMDBReportABugFunction() {
    NSString *dbPath = @"/tmp/bug.db";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:dbPath error:nil];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    [queue inDatabase:^(FMDatabase *db) {
        BOOL worked = [db executeUpdate:@"create table test (a text, b text, c integer, d double, e double)"];
        FMDBQuickCheck(worked);
        worked = [db executeUpdate:@"insert into test values ('a', 'b', 1, 2.2, 2.3)"];
        FMDBQuickCheck(worked);
        
        FMResultSet *rs = [db executeQuery:@"select * from test"];
        
        FMDBQuickCheck([rs next]);
        NSLog(@"path=%@", NSHomeDirectory());
        [rs close];
    }];
    [queue close];
}