//
//  GLButtonCardDatas.h
//  Demos
//
//  Created by gaolong on 16/2/8.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLButtonCardDatas : NSObject

@end

@interface GLButtonCardModel : NSObject

@property (nonatomic, assign) NSInteger cardId;
@property (nonatomic, copy) NSString *cardName;
@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *imagaUrl;

@end

@interface GLButtonCardData : NSObject

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) NSString *titleName;

@end