//
//  UIColor+TKCategory.m
//  Created by Devin Ross on 5/14/11.
//
/*
 
 tapku || http://github.com/devinross/tapkulibrary
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "UIColor+TKCategory.h"

#define GREY(color) [UIColor colorWithRed:color/255.0 green:color/255.0 blue:color/255.0 alpha:1]

@implementation UIColor (TKCategory)


+ (id) colorWithHex:(unsigned int)hex{
	return [UIColor colorWithHex:hex alpha:1];
}

+ (id) colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha{
	
	return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hex & 0xFF)) / 255.0
                           alpha:alpha];
	
}

+ (UIColor*) randomColor{
	
	NSInteger r = arc4random() % 255;
	NSInteger g = arc4random() % 255;
	NSInteger b = arc4random() % 255;
	return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
	
}

+ (UIColor*)appBackgroundColor {
    
    return [UIColor colorwithHexString:@"#fefefc"];
}

+ (UIColor*)appBlackColor {
    
    return GREY(38);
}

+ (UIColor*)appOffWhiteColor {
    
    return GREY(234);
}

+ (UIColor *)colorwithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    unsigned int hex = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&hex];
    return [UIColor colorWithHex:hex alpha:alpha];
}

+ (UIColor *)colorwithHexString:(NSString *)hexString
{
    unsigned int hex = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&hex];
    return [UIColor colorWithHex:hex];
}


@end