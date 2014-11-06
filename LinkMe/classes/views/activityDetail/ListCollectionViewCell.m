//
//  ListCollectionViewCell.m
//  LinkMe
//
//  Created by ChaoSo on 14-11-6.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "ListCollectionViewCell.h"
#import "summer_extend.h"
#import "UIImageView+UIImageViewExt.h"

@implementation ListCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)updateCell{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [imageView setImage:[UIImage imageNamed:@"user2.jpg"]];
    [imageView setCircle];
    [self addSubview:imageView];
}

@end
