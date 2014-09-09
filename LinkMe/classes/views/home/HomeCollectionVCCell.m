
//
//  HomeCollectionVCCell.m
//  LinkMe
//
//  Created by ChaoSo on 14-8-31.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "HomeCollectionVCCell.h"
#import "summer_extend.h"
#import "ImageDownloader.h"

@interface HomeCollectionVCCell()
{
    ActivityModel    *_activityModel;
}

@end

@implementation HomeCollectionVCCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)updateCell:(NSInteger)index{
    if(index%1==0){
        [self.imageView setImage:[UIImage imageNamed:@"pic1.jpg"]];
    }
    if(index%2==0){
        [self.imageView setImage:[UIImage imageNamed:@"pic2.jpg"]];
    }
    if(index%3==0){
        [self.imageView setImage:[UIImage imageNamed:@"pic3.jpg"]];
    }
    if(index%4==0){
        [self.imageView setImage:[UIImage imageNamed:@"pic4.jpg"]];
    }
    
}

-(void)updatecellByActivityModel:(ActivityModel *)activityModel
{
    ImageDownloader * imageDownloader = [[ImageDownloader alloc]init];
    [imageDownloader startDownloadImage:activityModel.imageURL andLoadImage:^(id data) {
        self.imageView.image = data;
    }];
}

@end
