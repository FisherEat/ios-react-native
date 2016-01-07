//
//  PersonModel.m
//  Demos
//
//  Created by gaolong on 15/12/31.
//  Copyright © 2015年 schiller. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel

@end

@implementation PersonData

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"favorites" :[PersonDetail class]};
}

@end

@implementation PersonDetail

@end
