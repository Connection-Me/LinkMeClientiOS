//
//  UIColor+UIColorExt.h
//  Draw
//
//  Created by Kira on 13-3-28.
//
//

#import <UIKit/UIKit.h>

#define OPAQUE_COLOR(A, B, C) ([UIColor colorWithIntegerRed:A green:B blue:C alpha:255])

#define COLOR255(R, G, B, A) ([UIColor colorWithIntegerRed:R green:G blue:B alpha:A])
#define COLOR1(R, G, B, A) ([UIColor colorWithRed:R green:G blue:B alpha:A])

@interface UIColor (UIColorExt)

+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha;

@end
