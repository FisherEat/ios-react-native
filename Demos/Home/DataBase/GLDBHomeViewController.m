//
//  GLDBHomeViewController.m
//  Demos
//
//  Created by yxt on 16/9/16.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLDBHomeViewController.h"

#import "FMDB.h"

@interface GLDBHomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *insertBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *revertBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation GLDBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"path : %@", NSHomeDirectory());
    [self createDB];
}
- (IBAction)insert:(id)sender
{
    BOOL insert = [_db executeUpdate:@"insert into t_health (name,phone) values(?,?)",@"jacob",@"138000000000"];
    if (insert) {
        NSLog(@"插入数据成功");
    }else {
        NSLog(@"插入数据失败");
    }
}

- (IBAction)delete:(id)sender
{
    BOOL delete = [_db executeUpdate:@"delete from t_health where name like ?",@"jacob"];
    if (delete) {
        NSLog(@"删除数据成功");
    }else{
        NSLog(@"删除数据失败");
    }
}

- (IBAction)revert:(id)sender
{
    BOOL update = [_db executeUpdate:@"update t_health set name = ?  where phone = '%@'",@"jacob111"];
    if (update) {
        NSLog(@"更新数据成功");
    }else{
        NSLog(@"更新数据失败");
    }
}

- (IBAction)check:(id)sender
{
    FMResultSet *set = [_db executeQuery:@"select * from t_health "];
    while ([set next]) {
        NSString *name =  [set stringForColumn:@"name"];
        NSString *phone = [set stringForColumn:@"phone"];
        NSLog(@"name : %@ phone: %@",name,phone);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

#pragma mark - FMDB
- (void)createDB
{
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [cacheDir stringByAppendingPathComponent:@"contact.sqlite"];
    _db = [FMDatabase databaseWithPath:filePath];
    BOOL flag = [_db open];
    if (flag) {
        NSLog(@"database open successfully");
    }else {
        NSLog(@"database open failed");
    }
    
    BOOL createTB = [_db executeUpdate:@"create table if not exists t_health(id integer primary key  autoincrement, name text,phone text)"];
    if (createTB) {
        NSLog(@"table create successfully");
    }else {
        NSLog(@"table create failed");
    }
    
}

@end
