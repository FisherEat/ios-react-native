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
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end

@implementation GLNetWorkDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.netWorkTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, self.view.height - 20) style:UITableViewStylePlain];
    self.netWorkTableView.delegate   = self;
    self.netWorkTableView.dataSource = self;
   // [self.view addSubview:self.netWorkTableView];

  //[self.netWorkTableView registerNib:[UINib nibWithNibName:@"NetWorkCell" bundle:nil] forCellReuseIdentifier:@"ShitCell"];

      
}

#pragma mark - 
#pragma mark tableview delegate 、 tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NetWorkCell *cell = (NetWorkCell *)[tableView dequeueReusableCellWithIdentifier:@"shit"];
    
    if (cell==nil)
    {
        cell=[[NetWorkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shit"];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  75.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
