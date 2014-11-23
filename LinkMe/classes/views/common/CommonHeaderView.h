//
//  CommonHeaderView.h
//  LinkMe
//
//  Created by ChaoSo on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LEFT_BUTTON_BLOCK)();
typedef void(^RIGHT_BUTTON_BLOCK)();

@interface CommonHeaderView : UIView
typedef NS_ENUM(NSInteger, CommonHeaderButtonSytle) {
    CommonHeaderBack,
    CommonHeaderMenu,
    CommonHeaderAdd,
    CommonHeaderInvite,
    CommonHeaderNone,
};

@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIButton *leftButton;
@property (nonatomic,strong)UIButton *rightButton;
@property (nonatomic,strong) LEFT_BUTTON_BLOCK leftButtonBlock;
@property (nonatomic,strong) RIGHT_BUTTON_BLOCK rightButtonBlock;

+(CommonHeaderView *)createHeader:(UIView *)superView WithTitle:(NSString *)titleText;
+(CommonHeaderView *)createHeader:(UIView *)superView WithTitle:(NSString *)titleText LeftButtonType:(CommonHeaderButtonSytle)leftBtnStyle RightButtonType:(CommonHeaderButtonSytle)rightBtnStyle;

-(void)setLeftButtonBlock:(LEFT_BUTTON_BLOCK)BtnBlock;

-(void)setRightButtonBlock:(RIGHT_BUTTON_BLOCK)BtnBlock;

@end
