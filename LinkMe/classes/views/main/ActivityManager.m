//
//  ActivityManager.m
//  LinkMe
//
//  Created by ChaoSo on 14-10-29.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "ActivityManager.h"

@implementation ActivityManager
DEF_SINGLETON(ActivityManager)


-(void)setAddPageTextFieldImage:(AddActivityVC *)addPage{
    
    NSDictionary *picDic = @{
                             @"name" : [UIImage imageNamed:@"p_name@2x"],
                             @"upperLimit" : [UIImage imageNamed:@"p_upLimit@2x"],
                             @"lowerLimit" : [UIImage imageNamed:@"p_downCount@2x"],
                             @"description" : [UIImage imageNamed:@"p_description@2x"]
                             };
    
    [self setImageIntoTextField:[picDic objectForKey:@"name"] textField:addPage.nameTf];
    [self setImageIntoTextField:[picDic objectForKey:@"upperLimit"] textField:addPage.ceilingCountTf];
    [self setImageIntoTextField:[picDic objectForKey:@"lowerLimit"] textField:addPage.lowerLimitCountTf];
//    [self setImageIntoTextField:[picDic objectForKey:@"description"] textField:addPage.descriptionTf];
    
    
}

-(void)setImageIntoTextField:(UIImage *)image textField:(UITextField *)tf{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    imageView.image = image;
    tf.leftView = imageView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    
}
@end
