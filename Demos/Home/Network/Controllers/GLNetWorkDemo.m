//
//  GLNetWorkDemo.m
//  Demos
//
//  Created by schiller on 15/8/3.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "GLNetWorkDemo.h"
#import "NetWorkCell.h"
#import "CustomCell.h"

@interface GLNetWorkDemo ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *netWorkTableView;

@end

@implementation GLNetWorkDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.netWorkTableView.delegate   = self;
    self.netWorkTableView.dataSource = self;
}

#pragma mark tableview delegate 、 tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NetWorkCell *cell = (NetWorkCell *)[tableView dequeueReusableCellWithIdentifier:@"NetWorkCell"];
    
    if (cell==nil)
    {
        cell=[[NetWorkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NetWorkCell"];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  100.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
