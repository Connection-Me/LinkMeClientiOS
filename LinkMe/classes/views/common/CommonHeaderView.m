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
@synthesize label = _label;
@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _label = [[UILabel alloc] init];
        _leftButton = [[UIButton alloc] init];
        _rightButton = [[UIButton alloc] init];
    }
    return self;
}
-(id)initWithSytle:(NSInteger)style AndTitle:(NSString *)title AndFrame:(CGRect)frame{
    self = [super init];
    //位置
    if(ISIOS7){
        
        self.frame = CGRectMake(0, 0, frame.size.width,55);
    }else{
        self.frame = CGRectMake(0, 0, frame.size.width,35);
    }
    [self setBackgroundColor:[UIColor colorWithRed:92/255.0f green:92/255.0f blue:92/255.0f alpha:1.0f]];
//    [self setBackgroundColor:[UIColor redColor]];

    [self initData:style AndTitle:title AndFrame:frame];
    return self;
}

+(CommonHeaderView*)createHeaderView:(UIView*)superView AndStyle:(NSInteger)style AndTitle:(NSString *)title{
    
    CommonHeaderView* titleView = [self titleView:superView];
    if (titleView != nil){
        
        return titleView;
    }
    
    titleView = [[CommonHeaderView alloc] initWithSytle:style AndTitle:title AndFrame:superView.frame];
    [superView addSubview:titleView];
    return titleView;
    
    
}
+ (CommonHeaderView*)titleView:(UIView*)superView
{
    UIView* view = [superView viewWithTag:COMMON_TITLE_VIEW_TAG];
    if ([view isKindOfClass:[CommonHeaderView class]]){
        return (CommonHeaderView*)view;
    }
    else{
        if (view != nil){
            NSLog(@"the view is not nil");
        }
        return nil;
    }
}
#define HEAD_VIEW_HEIGHT (ISIOS7 ? 55 : 35)
-(void)initData:(NSInteger)style AndTitle:(NSString *)title AndFrame:(CGRect)frame{
    
    if(style==1){
        //标题
        [_label setFrame:CGRectMake((self.frame.size.width-100)/2, 20, 100, 35)];
        [_label setText:title];
        [_label setFont:AD_BOLD_FONT(20, 20)];
        [_label setTextColor:[UIColor whiteColor]];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setBackgroundColor:[UIColor clearColor]];
        [self insertSubview:_label atIndex:0];
        CGFloat leftButton_Y = (HEAD_VIEW_HEIGHT-STATUSBAR_DELTA-30)/2.0f + STATUSBAR_DELTA;
        //左边按钮
        UIImage *leftImage = [UIImage imageNamed:@"menu"];
        [self.leftButton setFrame:CGRectMake(0, leftButton_Y, 100, 30)];
        [self.leftButton setImage:leftImage forState:UIControlStateNormal];
        [self.leftButton setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 65)];
        [self.leftButton setBackgroundColor:[UIColor clearColor]];
//        [_leftButton setFont:THE_FONT(20)];
        [self insertSubview:_leftButton atIndex:0];
        
        //右边按钮
        UIImage *rightImage = [UIImage imageNamed:@"add"];
        [self.rightButton setFrame:CGRectMake(self.frame.size.width-10-90, 20, 100, 35)];
        [self.rightButton setImage:rightImage forState:UIControlStateNormal];
        [self.rightButton setImageEdgeInsets:UIEdgeInsetsMake(9, 70, 5, 10)];
//        [_rightButton setFont:THE_FONT(20)];
        [self.rightButton setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.rightButton];
    }
    else if(style == 2){
        //标题
        [_label setFrame:CGRectMake((self.frame.size.width-100)/2, 20, 100, 35)];
        [_label setText:title];
        [_label setFont:AD_BOLD_FONT(20, 20)];
        [_label setTextColor:[UIColor whiteColor]];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setBackgroundColor:[UIColor clearColor]];
        [self insertSubview:_label atIndex:0];
        CGFloat leftButton_Y = (HEAD_VIEW_HEIGHT-STATUSBAR_DELTA-30)/2.0f + STATUSBAR_DELTA;
        
        //左边按钮
        UIImage *leftImage = [UIImage imageNamed:@"back"];
        [self.leftButton setFrame:CGRectMake(0, leftButton_Y, 100, 30)];
        [self.leftButton setImage:leftImage forState:UIControlStateNormal];
        [self.leftButton setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 65)];
        [self.leftButton setBackgroundColor:[UIColor clearColor]];
        //        [_leftButton setFont:THE_FONT(20)];
        [self insertSubview:_leftButton atIndex:0];
        
    }
}
+(void)setBackButton{
    
    
}


#pragma mark - Listen
-(void)setListenInView:(UIView*)view selector:(SEL)selector{
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    [view addGestureRecognizer:singleTap];
}

-(void)backTouchUpInside
{
    [self sendUISignal:self.CLOSE_VC withObject:nil];
}

@end
