//
//  CommonHeaderView.m
//  LinkMe
//
//  Created by ChaoSo on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "CommonHeaderView.h"
#import "summer_extend.h"
@implementation CommonHeaderView

#define COMMON_TITLE_VIEW_TAG   20140901
@synthesize title = _title;
@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _title = [[UILabel alloc] init];
        _leftButton = [[UIButton alloc] init];
        _rightButton = [[UIButton alloc] init];
    }
    return self;
}

#define DEFAULT_STYLE CommonHeaderNone
+(CommonHeaderView *)createHeader:(UIView *)superView WithTitle:(NSString *)titleText{
    return [CommonHeaderView createHeader:superView WithTitle:titleText LeftButtonType:DEFAULT_STYLE RightButtonType:DEFAULT_STYLE];
}


+(CommonHeaderView *)createHeader:(UIView *)superView WithTitle:(NSString *)titleText LeftButtonType:(CommonHeaderButtonSytle)leftBtnStyle RightButtonType:(CommonHeaderButtonSytle)rightBtnStyle{
    CommonHeaderView *header = [[CommonHeaderView alloc] init];
    [CommonHeaderView initHeader:header];
    
    header.title.text = titleText;
    [header setButtonType:leftBtnStyle button:header.leftButton];
    [header setButtonType:rightBtnStyle button:header.rightButton];
    [superView addSubview:header];
    
    return header;
}



#define HEAD_VIEW_HEIGHT (ISIOS7 ? 55 : 35)

+(void)initHeader:(CommonHeaderView *)header{
    //位置
    if(ISIOS7){
        
        header.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,55);
    }else{
        header.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,35);
    }
    [header setBackgroundColor:COLOR_HEADER];
//    [header setBackgroundColor:[UIColor blueColor]];
    
    
    [header.title setFrame:CGRectMake((header.frame.size.width-100)/2, 20, 100, 35)];
    [header.title setFont:AD_BOLD_FONT(20, 15)];
    [header.title setTextColor:[UIColor whiteColor]];
    [header.title setTextAlignment:NSTextAlignmentCenter];
    [header.title setBackgroundColor:[UIColor clearColor]];
    [header addSubview:header.title];
    
    CGFloat leftButton_Y = (HEAD_VIEW_HEIGHT-STATUSBAR_DELTA-30)/2.0f + STATUSBAR_DELTA;
    
    [header.leftButton setFrame:CGRectMake(0, leftButton_Y, 100, 30)];
    [header.leftButton setBackgroundColor:[UIColor clearColor]];
    [header.leftButton addTarget:header action:@selector(clickLeft) forControlEvents:UIControlEventTouchUpInside];
    //        [_leftButton setFont:THE_FONT(20)];
    [header addSubview:header.leftButton];
    
    [header.rightButton setFrame:CGRectMake(header.frame.size.width-10-35, 20, 100, 35)];
    //        [_rightButton setFont:THE_FONT(20)];
    [header.rightButton addTarget:header action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    [header.rightButton setBackgroundColor:[UIColor clearColor]];
    [header addSubview:header.rightButton];
    
    UIView *footLine = [[UIView alloc] initWithFrame:CGRectMake(0, header.frame.size.height-0.5, header.frame.size.width, 0.5)];
    [footLine setBackgroundColor:[UIColor darkGrayColor]];
    [header addSubview:footLine];
    
    
}


-(void)setButtonType:(CommonHeaderButtonSytle)style button:(UIButton *)button{
    switch (style) {
        case CommonHeaderBack:{
        
            UIImage *leftImage = [UIImage imageNamed:@"back"];
            [button setImage:leftImage forState:UIControlStateNormal];
            [button setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 65)];
        }
            break;
            
        case CommonHeaderMenu:
        {
            UIImage *leftImage = [UIImage imageNamed:@"menu"];
            [button setImage:leftImage forState:UIControlStateNormal];
            [button setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 65)];
        }
            break;
            
        case CommonHeaderAdd:
        {
            UIImage *leftImage = [UIImage imageNamed:@"add"];
            [button setImage:leftImage forState:UIControlStateNormal];
            [button setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 65)];
        }
            break;
            
        default:
            break;
    }

    
    
}


-(void)setLeftButtonBlock:(LEFT_BUTTON_BLOCK)BtnBlock
{
    _leftButtonBlock = BtnBlock;
}
-(void)clickLeft{
    if(_leftButtonBlock == nil){
        NSLog(@"left block is nil");
        return ;
    }
    _leftButtonBlock();
}
-(void)setRightButtonBlock:(RIGHT_BUTTON_BLOCK)BtnBlock
{
    _rightButtonBlock = BtnBlock;
}
-(void)clickRight{
    if(_rightButtonBlock == nil){
        NSLog(@"right block is nil");
        return ;
    }
    _rightButtonBlock();
}



#pragma mark - Listen
-(void)setListenInView:(UIView*)view selector:(SEL)selector{
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    [view addGestureRecognizer:singleTap];
}



@end
