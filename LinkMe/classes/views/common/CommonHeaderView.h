//
//  CommonHeaderView.h
//  LinkMe
//
//  Created by ChaoSo on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BACK_BUTTON_BLOCK)();

@interface CommonHeaderView : UIView

@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UIButton *leftButton;
@property (nonatomic,strong)UIButton *rightButton;
@property (nonatomic,strong) BACK_BUTTON_BLOCK backButtonBlock;

-(id)initWithSytle:(NSInteger)style AndTitle:(NSString *)title;
+(CommonHeaderView*)createHeaderView:(UIView*)superView AndStyle:(NSInteger)style AndTitle:(NSString *)title;
-(void)setBackButtonBlock:(BACK_BUTTON_BLOCK)backButtonBlock;
@end
