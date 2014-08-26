//
//  TCMessageBox.h
//  Churches OER
//
//  Created by phoenix on 4/15/13.
//  Copyright (c) 2013 Phoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCMessageBox : NSObject

+(void)showMessage:(NSString *)message hideByTouch:(BOOL)hideByTouch withActivityIndicator:(BOOL)withIndicator offset:(CGSize)offset;

+(void)showMessage:(NSString *)message hideByTouch:(BOOL)hideByTouch withActivityIndicator:(BOOL)withIndicator;

+(void)showMessage:(NSString *)message hideByTouch:(BOOL)hideByTouch;

+(BOOL)presenting;
+(void)hide;
+(void)hideIn:(NSTimeInterval)delay;
@end
