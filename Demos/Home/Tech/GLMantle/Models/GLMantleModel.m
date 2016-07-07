//
//  GLMantleModel.m
//  Demos
//
//  Created by schiller on 16/7/7.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLMantleModel.h"

@implementation GLMantleModel

@end

@implementation GLCommunityTripActivity

//直接通过dictionary给一个model赋值

- (id)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionaryValue];
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *mutDic = [NSDictionary mtl_identityPropertyMapWithModel:[[self class] mutableCopy]];
    return mutDic;
}

+ (NSValueTransformer *)activityListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[GLCommunityTripActivityItem class]];
}

+ (void)communityTripChannelActivity:(void (^)(GLCommunityTripActivity *, NSError *))block
{
    //http://api.tuniu.com/community/travelNote/activityList?c={"cc":1602,"ct":10,"p":14588,"ov":1,"dt":0,"v":"8.1.1"}&d={"citycode":"1602","width":600,"height":0}
    NSString *path = @"http://api.tuniu.com/community/travelNote/activityList";
    NSDictionary *params = @{@"d": @{@"citycode":@"1602",@"width":@(600),@"height":@(0)}};
    GLRequest *request = [GLRequest requestWithPath:path params:params];
    [[GLNetwork sharedInstance] sendHTTPRequest:request callback:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            block(nil, error);
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        GLCommunityTripActivity *model = [MTLJSONAdapter modelOfClass:[GLCommunityTripActivity class] fromJSONDictionary:dict[@"data"] error:nil];
        NSLog(@"dict = %@，，，，model = %@", dict, model);
        block(model, nil);
    }];
    
}

@end

@implementation GLCommunityTripActivityItem
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:[[self class] mutableCopy]];
}

@end