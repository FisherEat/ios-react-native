//
//  PassMesg.m
//  Demos
//
//  Created by schiller on 15/7/21.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "PassMesg.h"

@implementation PassMesg

- (void) changeName:(PassMesg *)person withName:(NSString *)newName
{
    NSString *orinName = [person valueForKey:@"name"];
    [person setValue:newName forKeyPath:@"name"];
    NSLog(@"Change %@'s name is to :%@", orinName, newName);
    
}

- (id)init
{
    self = [super init];
    if (self) {
        self.observerArray = [NSMutableArray new];
    }
    return self;
}

@end
