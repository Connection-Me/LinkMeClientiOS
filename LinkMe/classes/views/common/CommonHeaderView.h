//
//  CommonHeaderView.h
//  LinkMe
//
//  Created by ChaoSo on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonHeaderView : UIView

@property (nonatomic,weak)UILabel *label;
@property (nonatomic,strong)UIButton *leftButton;
@property (nonatomic,strong)UIButton *rightButton;

-(id)initWithSytle:(NSInteger)style AndTitle:(NSString *)title;
+(CommonHeaderView*)createHeaderView:(UIView*)superView AndStyle:(NSInteger)style AndTitle:(NSString *)title;
@end
