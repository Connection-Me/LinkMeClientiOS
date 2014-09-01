//
//  CommonHeaderView.m
//  LinkMe
//
//  Created by ChaoSo on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "CommonHeaderView.h"

@implementation CommonHeaderView
#define COMMON_TITLE_VIEW_TAG   20140901
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
-(id)initWithSytle:(NSInteger)style AndTitle:(NSString *)title{
    self = [super init];
    [self initData:style AndTitle:title];
    return self;
}

+(CommonHeaderView*)createHeaderView:(UIView*)superView AndStyle:(NSInteger)style AndTitle:(NSString *)title{
    
    CommonHeaderView* titleView = [self titleView:superView];
    if (titleView != nil){
        
        return titleView;
    }
    
    titleView = [[CommonHeaderView alloc] initWithSytle:style AndTitle:title];
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
            
        }
        return nil;
    }
}

-(void)initData:(NSInteger)style AndTitle:(NSString *)title{

    if(style==1){
        
        //位置
        if(ISIOS7){
            self.frame = CGRectMake(0, 0, self.window.frame.size.width,55);
        }else{
            self.frame = CGRectMake(0, 0, self.window.frame.size.width,35);
        }
        [self setBackgroundColor:[UIColor colorWithRed:92/255.0f green:92/255.0f blue:92/255.0f alpha:1.0f]];
        
        
        //标题
        [self.label setText:title];
        [self.label setFrame:CGRectMake(self.center.x-(100/2), 20, 100, 35)];
        [self addSubview:self.label];
        
        //左边按钮
        [self.leftButton setTitle:@"菜单" forState:UIControlStateNormal];
        [self.leftButton setFrame:CGRectMake(10, 20, 35, 35)];
        [self.leftButton setBackgroundColor:[UIColor redColor]];
        [self addSubview:self.leftButton];
        
        //右边按钮
        [self.leftButton setTitle:@"新建" forState:UIControlStateNormal];
        [self.leftButton setFrame:CGRectMake(self.frame.size.width-10, 20, 35, 35)];
        [self.leftButton setBackgroundColor:[UIColor redColor]];
        [self addSubview:self.rightButton];
        
        
    }
}

@end
