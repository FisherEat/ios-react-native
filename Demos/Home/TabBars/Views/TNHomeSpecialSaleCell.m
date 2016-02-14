//
//  TNHomeSpecialSaleCell.m
//  gl
//
//  Created by schiller on 15/7/15.
//  Copyright (c) 2015年 schiller. All rights reserved.
//



#import "TNHomeSpecialSaleCell.h"

@implementation TNHomeSpecialSaleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit
{
    _imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _imageView.contentMode   = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _imageView.layer.cornerRadius  = 2.0f;
    _imageView.layer.masksToBounds = YES;
    [self addSubview:_imageView];
    
    UIImageView *maskImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    maskImageView.contentMode  = UIViewContentModeScaleAspectFill;
    maskImageView.image        = [UIImage imageNamed:@"loading_image_100x100"];
    [_imageView addSubview:maskImageView];
    
    //从底部往上
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, self.frame.size.height - 12.0f - 6.0f, self.frame.size.width, 16.0f)];
    _priceLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    _priceLabel.textColor = [UIColor colorWithRed:250 green:180 blue:0 alpha:1];
    _priceLabel.backgroundColor = [UIColor clearColor];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [_imageView addSubview:_priceLabel];
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, _priceLabel.y - 14.0f - 5.0f, self.frame.size.width, 14.0f)];
    _descLabel.backgroundColor = [UIColor clearColor];
    //_descLabel.font = [UIFont fontWithName:@"" size:<#(CGFloat)#>];
    _descLabel.textColor = [UIColor whiteColor];
    _descLabel.textAlignment = NSTextAlignmentCenter;
    [_imageView addSubview:_descLabel];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, _descLabel.y - 1.0f - 5.0f, 73.0f, 1.0f)];
    _lineView.backgroundColor = [UIColor whiteColor];
    _lineView.centerX = _imageView.centerX;
    [_imageView addSubview:_lineView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, _lineView.y - 16.0f - 5.0f , self.frame.size.width, 16.0f)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_imageView addSubview:_titleLabel];

}
@end

@interface TNHomeSpecialSaleCell ()

@property (nonatomic, strong) TNHomeSpecialSaleView *leftView;
@property (nonatomic, strong) TNHomeSpecialSaleView *middleView;
@property (nonatomic, strong) TNHomeSpecialSaleView *rightView;

@end

#define IsPortrait ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)

//获取屏幕 宽度、高度

#define SCREEN_HEIGHT (IsPortrait ? MAX(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)) : MIN(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)))
#define SCREEN_4_INCH ((SCREEN_HEIGHT - 568) < FLT_EPSILON)
#define FULL_VIEW_HEIGHT (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)?(SCREEN_HEIGHT):(SCREEN_HEIGHT- 20))

#define APP_FONT(size) [UIFont systemFontOfSize:size]
#define APP_BOLD_FONT(size) [UIFont boldSystemFontOfSize:size]
#define APP_FONT_SMALL APP_FONT(12.0f)
#define APP_FONT_NORMAL APP_FONT(14.0f)
#define APP_FONT_LARGE APP_FONT(16.0f)

static const float contentPaddingLeft = 10;
@implementation TNHomeSpecialSaleCell
static const float contentPaddingMiddle = 6;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
     [self commonInit];
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat imageWidth = (SCREEN_WIDTH - contentPaddingLeft * 2 - contentPaddingMiddle * 2) / 3.0f;
    CGFloat imageHeight = 133;
    
    _leftView = [[TNHomeSpecialSaleView alloc] initWithFrame:CGRectMake(contentPaddingLeft, 5, imageWidth, imageHeight)];
    [self.contentView addSubview:_leftView];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectMake(_leftView.x, 5, imageWidth, imageHeight);
    _leftButton.backgroundColor = [UIColor colorWithRed:0.9 green:0.4 blue:0.8 alpha:0.8];
    [self.contentView addSubview:_leftButton];
    
    _middleView = [[TNHomeSpecialSaleView alloc] initWithFrame:CGRectMake(contentPaddingLeft + imageWidth +  contentPaddingMiddle, 5, imageWidth, imageHeight)];
    [self.contentView addSubview:_middleView];
    
    _middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _middleButton.frame = CGRectMake(_middleView.x, 5, imageWidth, imageHeight);
    _middleButton.backgroundColor = [UIColor colorWithRed:0.7 green:0.8 blue:0.2 alpha:0.8];
    [self.contentView addSubview:_middleButton];
    
    _rightView = [[TNHomeSpecialSaleView alloc] initWithFrame:CGRectMake(contentPaddingLeft + imageWidth * 2 + contentPaddingMiddle * 2, 5, imageWidth, imageHeight)];
    [self.contentView addSubview:_rightView];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(_rightView.x, 5, imageWidth, imageHeight);
    _rightButton.backgroundColor = [UIColor colorWithRed:0.620 green:0.702 blue:0.847 alpha:0.800];
    [self.contentView addSubview:_rightButton];
    
    self.clipsToBounds = YES;
}

- (void)bindSpecialInfos:(NSArray *)specialInfoArray withIndex:(NSInteger)leftIndex
{
    
}


@end
