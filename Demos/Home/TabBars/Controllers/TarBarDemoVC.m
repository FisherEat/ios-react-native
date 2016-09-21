//
//  TarBarDemoVC.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "TarBarDemoVC.h"
#import "Masonry.h"
#import "GLNoticeCell.h"

@interface TarBarDemoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TarBarDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self loadData];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TOP_BAR_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UINib *nib = [UINib nibWithNibName:@"GLNoticeCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"GLNoticeCell"];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GLNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLNoticeCell" forIndexPath:indexPath];
    cell.textLabel.text = @"人生若只如初见";
    return cell;
}

- (void)addLabel
{
    __weak typeof (self) weakSelf = self;
    self.myLabel = [[UILabel alloc] init];
    [self.myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100,30));
        make.center.equalTo(weakSelf.view);
    }];
    [self.view addSubview:self.myLabel];
}

- (void)loadData
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
