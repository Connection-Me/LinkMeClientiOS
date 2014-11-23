//
//  AppCommendCollectionViewCell.m
//  LinkMe
//
//  Created by Summer Wu on 14-11-22.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "AppCommendCollectionViewCell.h"
#import "ImageDownloader.h"

@implementation AppCommendCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)updateCellByUser:(UserModel *)userModel
{
    ImageDownloader * imageDownloader = [[ImageDownloader alloc]init];
    //todo:还没有图像url,注册的时候，每个用户应该有默认图片;
    return;
    [imageDownloader startDownloadImage:userModel.profile andLoadImage:^(id data) {
        self.userImage.image = data;
    }];
}


@end
