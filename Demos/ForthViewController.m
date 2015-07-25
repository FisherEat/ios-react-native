//
//  ForthViewController.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "ForthViewController.h"
#import "TNTrainTicketManger.h"
#import "TNTrainAd.h"

#define HEAD_AD_VIEW_HEIGHT  (SCREEN_WIDTH/4.0f)
@interface ForthViewController ()

@property (nonatomic, strong) UIView         *adContainer;
@property (nonatomic, strong) NSMutableArray *adViewsArray;
@property (nonatomic, strong)   NSArray      *adList;
@property (nonatomic, strong) UIImageView    *adImageView;

@end

@implementation ForthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self customAdViews];
}

/**
 * @author Edited by schiller, 15-07-25 16:07:29
 *
 * @brief  从远端获取广告图片，然后展示在火车票首页顶部
 */
- (void)customAdViews
{
    self.adViewsArray = [NSMutableArray array];
    
    __block typeof (&*self) __weak weakSelf = self;
    
   [[TNTrainTicketManger sharedInstance] fetchAdDataWithCompletion:^(NSArray *adList, NSError *error) {
       if (!error && adList.count > 0) {
           self.adList = adList;
           
           TNTrainAd *trainAd = self.adList[0];
           [NSURL URLWithString:trainAd.image];
           
           NSURL *url  = [NSURL URLWithString:@""];
           NSURLRequest *request = [NSURLRequest requestWithURL:url];
           NSData *imageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
           if (imageData) {
               UIImage *image = [UIImage imageWithData:imageData];
               [self.view addSubview:[self supplyAdView:image]];

           }
       }
   }];
    
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
