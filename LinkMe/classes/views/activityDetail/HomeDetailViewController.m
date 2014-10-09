//
//  HomeDetailViewController.m
//  LinkMe
//
//  Created by ChaoSo on 14-9-16.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "summer_extend.h"
#import "HeaderVC.h"
#import "CommonHeaderView.h"
#import "FooterVC.h"
@interface HomeDetailViewController ()
{
    HeaderVC                   *_headerVC;
    FooterVC                   *_footerVC;
}
@end

@implementation HomeDetailViewController


DEF_SINGLETON(HomeDetailViewController)

SUMMER_DEF_XIB(HomeDetailViewController,YES, NO)

ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {
        //设置 头导航栏
        [self setupHeader];
        [self setupAcitityView];
        
        
    }
    else if([signal isKindOf:BeeUIBoard.LAYOUT_VIEWS])
    {
        
    }
    else if([signal isKindOf:BeeUIBoard.DELETE_VIEWS])
    {
    }
    else if ( [signal is:BeeUIBoard.WILL_APPEAR] )
	{
        
        
        
	}
	else if ( [signal is:BeeUIBoard.DID_APPEAR] )
	{
        
	}
	else if ( [signal is:BeeUIBoard.WILL_DISAPPEAR] )
	{
        
	}
	else if ( [signal is:BeeUIBoard.DID_DISAPPEAR] )
	{
	}
    

    
}
#pragma mark header界面
-(void)setupHeader
{
//    _headerVC = [HeaderVC sharedInstance];
   
    [CommonHeaderView createHeaderView:self.view AndStyle:2 AndTitle:@"活动详细"];
    _headerVC.parentBoard = self;
    _headerVC.view.alpha = 1.0f;
    _headerVC.view.hidden = NO;
    // _headerVC.view.userInteractionEnabled = YES;
    CGRect rect = [[UIScreen mainScreen] bounds];
    _headerVC.view.frame = CGRectMake(0, 0, rect.size.width, 55);
    [self.view addSubview:_headerVC.view];
}
-(void)setupAcitityView{
    [_activityView removeAllSubviews];
    
    [_activityView setBackgroundColor:[UIColor colorWithRed:253/255.f green:253/255.f blue:253/255.f alpha:0.9]];
    
    //加圆角
    _activityView.layer.cornerRadius = 10;
    //加阴影
    _activityView.layer.shadowColor = [UIColor blackColor].CGColor;
    _activityView.layer.shadowOffset = CGSizeMake(0, 0);
    _activityView.layer.shadowOpacity = 0.5;
    _activityView.layer.shadowRadius = 10.0;
    _activityView.layer.masksToBounds = NO;
    
    UIView *activityHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _activityView.frame.size.width, 42)];
    
    
    [activityHeader setBackgroundColor:[UIColor colorWithRed:24/255.f green:140/255.f blue:209/255.f alpha:0.9]];

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:activityHeader.bounds byRoundingCorners:  UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = activityHeader.bounds;
    maskLayer.path = maskPath.CGPath;
    activityHeader.layer.mask = maskLayer;
    
    //TODO roundAvatar
    
    
    UILabel *timeDis = [[UILabel alloc] initWithFrame:CGRectMake(activityHeader.frame.size.width/3*2, 0, activityHeader.frame.size.width/3, activityHeader.frame.size.height)];
    timeDis.text = @"2010.06.15";
    timeDis.font = AD_FONT(20, 10);
    timeDis.textColor = [UIColor whiteColor];
    [activityHeader addSubview:timeDis];
    
    [_activityView addSubview:activityHeader];
}



@end
