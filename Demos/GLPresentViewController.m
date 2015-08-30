//
//  GLPresentViewController.m
//  Demos
//
//  Created by gaolong on 15/8/27.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "GLPresentViewController.h"
#import "TNTableViewCell.h"
#import "MainCell.h"
#import "AttachCell.h"
#import "AddTBCellViewController.h"

@interface GLPresentInfoCell()

@end

@implementation GLPresentInfoCell

- (void)bindModel:(NSDictionary *)cellData
{
    self.nameLabel.text = cellData[@"personName"];
    self.ageLabel.text  = cellData[@"personAge"];
}

@end

@interface GLPresentViewController ()<GLTopBarViewDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation GLPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];

    [self showTopBarView];
    [self showTableView];

    NSDictionary *dict = @{@"Cell": @"MainCell", @"isAttached":@(NO)};
    NSArray *array = @[dict ,dict, dict ,dict ,dict];
    self.dataArray = [NSMutableArray arrayWithArray:array];
    
    self.imageArray = @[@"a", @"b", @"c", @"d", @"d"];
}

#pragma mark - UI Events
- (void)showTopBarView
{
    self.topBarView.topBarStytle = GLTopBarStyleTitleLeftButtonRightButton;
    self.topBarView.titleText = @"哈哈";
    self.topBarView.leftButtonTitle = @"返回";
    self.topBarView.rightButtonTitle = @"更多";
    self.topBarView.delegate = self;
    
    [self.view addSubview:self.topBarView];
}

- (void)showTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.y = self.topBarView.bottom;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"]) {
        static NSString *CellIdentifier = @"MainCell";
        MainCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        NSString *imageName = [NSString stringWithFormat:@"%@.png", self.imageArray[indexPath.row]];
        cell.Headerphoto.image = [UIImage imageNamed:imageName];
        
        return cell;
    }else if ([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"AttachedCell"]) {
        static NSString *CellIdentifier = @"AttachedCell";
        AttachCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[AttachCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    
    return nil ;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"])
    {
        return 80;
    }else{
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSIndexPath *path = nil;
    if ([[self.dataArray[path.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"]) {
        path = [NSIndexPath indexPathForItem:(indexPath.row + 1) inSection:indexPath.section];
    }else {
        path = indexPath;
    }
    
    if ([[self.dataArray[indexPath.row] objectForKey:@"isAttached"] boolValue]) {
        //关闭附加Cell
        NSDictionary *dict = @{@"Cell": @"MainCell", @"isAttached": @(NO)};
        self.dataArray[(path.row - 1)] = dict;

        [self.dataArray removeObjectAtIndex:path.row];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
        [self.tableView endUpdates];
    }else {
        //打开附加cell
       NSDictionary *dict = @{@"Cell": @"MainCell", @"isAttached":@(YES)};
        self.dataArray[(path.row - 1)] = dict;
        NSDictionary *addDict = @{@"Cell": @"AttachedCell",@"isAttached":@(YES)};
        [self.dataArray insertObject:addDict atIndex:path.row];
        [self.dataArray insertObject:addDict atIndex:(path.row + 1)];
        //[self.dataArray insertObject:addDict atIndex:path.row];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
         path = [NSIndexPath indexPathForItem:(path.row + 1) inSection:indexPath.section];
         [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
        [self.tableView endUpdates];
    }

}

#pragma mark 隐藏导航栏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark GLTopBarViewDelegate
- (void)topBarLeftButtonPressed:(UIButton *)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)topBarRightButtonPressed:(UIButton *)button
{
    AddTBCellViewController *addCellVC = [[AddTBCellViewController alloc] init];
    [self.navigationController pushViewController:addCellVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
