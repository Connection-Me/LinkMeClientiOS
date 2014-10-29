//
//  UIColor+UIColorExt.m
//  Draw
//
//  Created by Kira on 13-3-28.
//
//

#import "UIColor+UIColorExt.h"

@implementation UIColor (UIColorExt)

+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha
{
    return [UIColor colorWithRed:red/255.0
                           green:green/255.0
                            blue:blue/255.0
                           alpha:alpha/255.0];
}

@end
