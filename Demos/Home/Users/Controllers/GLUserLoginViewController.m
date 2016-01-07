//
//  GLUserLoginViewController.m
//  Demos
//
//  Created by schiller on 15/8/31.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "GLUserLoginViewController.h"
#import "PersonModel.h"
#import "GLLoginManager.h"
#import "NSObject+MJKeyValue.h"
#import "GLLoginView.h"
#import "GLUserRegisterView.h"

static const CGFloat TopBarHeight = 64.5;

@interface GLUserLoginViewController ()<GLLoginButtonClickedDelegate>

@property (nonatomic, strong) GLLoginView *loginView;
@property (nonatomic, strong) GLUserRegisterView *registerView;
@property (nonatomic, strong) PersonModel *person;
@property (nonatomic, strong) PersonData *resultData;

@end

@implementation GLUserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLoginView];
    [self initInputData];
}

#pragma mark - load data

- (void)initInputData
{
    self.person = [[PersonModel alloc] init];
}

- (void)refreshData
{
    [self fetchData];
}

- (void)fetchData
{
    [GLLoginManager loginWithInput:self.person completion:^(PersonData *results, NSError *erro) {
        if (erro) {
            NSLog(@"callbacks data = %@", erro);
        }else if (results) {
            self.resultData = results;
            [self.loginView bindData:self.resultData];
            NSLog(@"callbacks data = %@", results);
        }else {
            NSLog(@"callbacks data is nil");
        }
    }];
}

#pragma mark - login view 
- (void)setUpLoginView
{
    self.loginView = [GLLoginView new];
    self.loginView.delegate = self;
    [self.view addSubview:self.loginView];
    [self setUpConstraints];
}

- (void)setUpConstraints
{
    [self.loginView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [self.loginView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:TopBarHeight];
}

#pragma mark - GLLoginButtonClickedDelegate
- (void)loginWithName:(NSString *)name password:(NSString *)password
{
    self.person.username = name;
    self.person.password = password;
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
