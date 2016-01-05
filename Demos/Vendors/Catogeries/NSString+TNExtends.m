//
//  NSString+TNExtends.m
//  TuNiuApp
//
//  Created by XiongCaixing on 13-10-23.
//  Copyright (c) 2013年 XiongCaixing. All rights reserved.
//

#import "NSString+TNExtends.h"
#import <CommonCrypto/CommonDigest.h>

NSString *MPHexStringFromBytes(void *bytes, NSUInteger len)
{
	NSMutableString *output = [NSMutableString string];
	
	unsigned char *input = (unsigned char *)bytes;
	
	NSUInteger i;
	for (i = 0; i < len; i++)
		[output appendFormat:@"%02x", input[i]];
	return output;
}

@implementation NSString(TNExtends)

+ (BOOL)isNilOrEmpty:(NSString *)str{
    if (!str || ![str isKindOfClass:[NSString class]]|| [str isEmpty]) {
        return YES;
    }
    return NO;
}

- (BOOL)isEmpty
{
	return [self isEmptyIgnoringWhitespace:YES];
}

- (BOOL)isEmptyIgnoringWhitespace:(BOOL)ignoreWhitespace
{
	NSString *toCheck = (ignoreWhitespace) ? [self stringByTrimmingWhitespace] : self;
	return [toCheck isEqualToString:@""];
}

- (NSString *)stringByTrimmingWhitespace
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)stringByTrimmingEscapeCharacter
{
    if ([self rangeOfString:@"\\n"].length > 0) {
        return [[self componentsSeparatedByString:@"\\n"] componentsJoinedByString:@"\n"];
    }
    else {
        return self;
    }
}

- (NSString *)MD5Hash
{
	const char *input = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(input, [@(strlen(input)) intValue], result);
	return MPHexStringFromBytes(result, CC_MD5_DIGEST_LENGTH);
}

- (NSString *)MD5Hash32bit
{
    const char *input = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(input, [@(strlen(input)) intValue], result);
	return MPHexStringFromBytes(result, CC_MD5_DIGEST_LENGTH);
}

- (NSString *)SHA1Hash
{
	const char *input = [self UTF8String];
	unsigned char result[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(input, [@(strlen(input)) intValue], result);
	return MPHexStringFromBytes(result, CC_SHA1_DIGEST_LENGTH);
}

#pragma mark countWord
- (NSInteger)countWord
{
    
    NSInteger i, n = [self length], l = 0, a = 0, b = 0;
    
    unichar c;
    
    for(i=0;i<n;i++){
        
        c=[self characterAtIndex:i];
        
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    
    if(a==0 && l==0) return 0;
    
    return l+(NSInteger)ceilf((float)(a+b)/2.0);
    
}

#pragma mark -
//计算NSString字节长度,汉字占2个，英文占1个
-  (NSInteger)convertToInt:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
    
}

@end

@implementation NSMutableString(TNExtends)

- (void)trimCharactersInSet:(NSCharacterSet *)aCharacterSet
{
	// trim front
	NSRange frontRange = NSMakeRange(0, 1);
	while ([aCharacterSet characterIsMember:[self characterAtIndex:0]])
		[self deleteCharactersInRange:frontRange];
	
	// trim back
	while ([aCharacterSet characterIsMember:[self characterAtIndex:([self length] - 1)]])
		[self deleteCharactersInRange:NSMakeRange(([self length] - 1), 1)];
}

- (void)trimWhitespace
{
	[self trimCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)trimAllWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end

