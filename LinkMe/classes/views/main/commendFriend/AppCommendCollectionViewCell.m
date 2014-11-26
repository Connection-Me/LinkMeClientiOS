//
//  AppCommendCollectionViewCell.m
//  LinkMe
//
//  Created by Summer Wu on 14-11-22.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "AppCommendCollectionViewCell.h"
#import "ImageDownloader.h"
#import "CommendCheckItems.h"

@interface AppCommendCollectionViewCell()
{
    UserModel           *_userModel;
}

@end

@implementation AppCommendCollectionViewCell

DEF_SIGNAL(TOUCH_Y_BUTTON)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    
    [self setDefaultButtomImage:self.selectBtn];
}

-(void)updateCellByUser:(UserModel *)userModel
{
    _userModel = userModel;
    if ([[CommendCheckItems sharedInstance] isCheckItems:userModel]) {
        [self setBtn:self.selectBtn withImage:[UIImage imageNamed:@"join.png"] AndTitle:@""];
    }
    else{
        [self setBtn:self.selectBtn withImage:nil AndTitle:@"Y"];
    }
    ImageDownloader * imageDownloader = [[ImageDownloader alloc]init];
    //todo:还没有图像url,注册的时候，每个用户应该有默认图片;
    return;
    [imageDownloader startDownloadImage:userModel.profile andLoadImage:^(id data) {
        self.userImage.image = data;
    }];
}

-(void)setBtn:(UIButton*)btn withImage:(UIImage*)image AndTitle:(NSString*)title{
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateDisabled];
    [btn setTitle:title forState:UIControlStateDisabled];
}

-(void)setDefaultButtomImage:(UIButton *)btn
{
    CGColorRef colorref = [UIColor blackColor].CGColor;
    [btn.layer setCornerRadius:7.0f];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setBorderWidth:1.0];
    [btn.layer setBorderColor:colorref];
    btn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    btn.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:22];
}

-(IBAction)yesButtonTouchUpInside:(id)sender
{
    [self sendUISignal:self.TOUCH_Y_BUTTON withObject:_userModel];
}

@end
