//
//  TableViewDemoViewController.m
//  Demos
//
//  Created by schiller on 15/8/31.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "TableViewDemoViewController.h"
#import "PersonModel.h"
#import "GLLoginManager.h"
#import "NSObject+MJKeyValue.h"
#import "GLLoginView.h"
#import "GLUserRegisterView.h"

static const CGFloat TopBarHeight = 64.5;

@interface TableViewDemoViewController ()<GLLoginButtonClickedDelegate>

@property (nonatomic, strong) GLLoginView *loginView;
@property (nonatomic, strong) GLUserRegisterView *registerView;
@property (nonatomic, strong) PersonModel *person;

@end

@implementation TableViewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLoginView];
    [self initInputData];
    [self fetchData];
}

#pragma mark - load data

- (void)initInputData
{
    self.person = [PersonModel new];
    self.person.name = @"xiaohua";
    self.person.age = @"18";
}

- (void)refreshData
{
    [self fetchData];
}

- (void)fetchData
{
    [GLLoginManager loginWithInput:self.person completion:^(NSDictionary *callBackDic, NSError *erro) {
        if (erro) {
            NSLog(@"callbacks data = %@", erro);
        }else if (callBackDic) {
            NSLog(@"callbacks data = %@", callBackDic);
        }else {
            NSLog(@"callbacks data is nil");
        }
    }];
}

#pragma mark - login view 
- (void)setUpLoginView
{
    self.loginView = [[GLLoginView alloc] initWithFrame:CGRectMake(0, TopBarHeight, self.view.width, self.view.height - TopBarHeight)];
    self.loginView.delegate = self;
    [self.view addSubview:self.loginView];
}

- (void)setUpRegisterView
{
    self.registerView = [GLUserRegisterView new];
    [self.registerView autoConstrainAttribute:ALAttributeLeft toAttribute:ALAttributeLeft ofView:self.view];
   // [self.registerView autoConstrainAttribute:al toAttribute:<#(ALAttribute)#> ofView:<#(nonnull UIView *)#>]
    
}

- (void)loginWithName:(NSString *)name password:(NSString *)password
{
    self.person.name = name;
    self.person.age = password;
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
