//
//  NSString+TNExtends.h
//  TuNiuApp
//
//  Created by XiongCaixing on 13-10-23.
//  Copyright (c) 2013年 XiongCaixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *MPHexStringFromBytes(void *bytes, NSUInteger len);

@interface NSString(TNExtends)

+ (BOOL)isNilOrEmpty:(NSString *)str;
- (BOOL)isEmpty;
- (BOOL)isEmptyIgnoringWhitespace:(BOOL)ignoreWhitespace;
- (NSString *)stringByTrimmingWhitespace;
- (NSString *)stringByTrimmingEscapeCharacter;

- (NSString *)MD5Hash;
- (NSString *)SHA1Hash;
- (NSString *)MD5Hash32bit;

#pragma mark countWord
- (NSInteger)countWord;
- (NSInteger)convertToInt:(NSString*)strtemp;

@end

@interface NSMutableString(TNExtends)

- (void)trimCharactersInSet:(NSCharacterSet *)aCharacterSet;
- (void)trimWhitespace;
- (NSString *)trimAllWhitespace;

@end
