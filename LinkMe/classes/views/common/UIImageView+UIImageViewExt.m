//
//  UIImageView+UIImageViewExt.m
//  LinkMe
//
//  Created by ChaoSo on 14-10-30.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "UIImageView+UIImageViewExt.h"

@implementation UIImageView(UIImageViewExt)

-(void)setCircle{
    [self.layer setCornerRadius:CGRectGetHeight([self bounds]) / 2];
    self.layer.masksToBounds = YES;
}
@end
