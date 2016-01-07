//
//  ForthViewController.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "ForthViewController.h"
#import "TNTrainAd.h"

#define HEAD_AD_VIEW_HEIGHT  (SCREEN_WIDTH/4.0f)
@interface ForthViewController ()

@property (nonatomic, strong) UIView         *adContainer;
@property (nonatomic, strong) NSMutableArray *adViewsArray;
@property (nonatomic, strong) NSArray        *adList;
@property (nonatomic, strong) UIImageView    *adImageView;

@end

@implementation ForthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UIImageView *)supplyAdView:(UIImage *)imgage
{
    self.adContainer.frame = CGRectMake(0, 64.0f - HEAD_AD_VIEW_HEIGHT , self.view.width, HEAD_AD_VIEW_HEIGHT);
    self.adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, HEAD_AD_VIEW_HEIGHT)];
    self.adImageView.image = imgage;
    [self.adContainer addSubview:self.adImageView];
    return self.adImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
