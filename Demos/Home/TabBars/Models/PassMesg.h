//
//  PassMesg.h
//  Demos
//
//  Created by schiller on 15/7/21.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PassMesg : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *adress;
@property (nonatomic, strong) NSMutableArray *observerArray;

- (void)changeName:(PassMesg *)person withName:(NSString *)newName;

- (id)init;
@end
