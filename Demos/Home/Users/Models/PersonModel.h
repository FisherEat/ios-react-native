//
//  PersonModel.h
//  Demos
//
//  Created by gaolong on 15/12/31.
//  Copyright © 2015年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PersonDetail;
@interface PersonModel : NSObject

@property (nonatomic, copy)  NSString *username;
@property (nonatomic, copy) NSString *password;

@end

@interface PersonData : NSObject

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, strong) NSArray *favorites; //array of PersonDetail

@end

@interface PersonDetail : NSObject

@property (nonatomic, copy) NSString *booksName;
@property (nonatomic, copy) NSString *words;
@property (nonatomic, copy) NSString *goals;

@end