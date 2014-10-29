//
//  FooterVC.m
//  LinkMe
//
//  Created by Summer Wu on 14-9-12.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "FooterVC.h"
#import "summer_extend.h"

@interface FooterVC ()
{
    NSMutableArray   *typeArray;
}

@end

@implementation FooterVC
DEF_SINGLETON(FooterVC)
DEF_SIGNAL(OPEN_VC)
SUMMER_DEF_XIB(FooterVC, NO, YES);
ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {
        [self setupButton];
        [self setupData];
        [self setLine];
    }
    else if([signal isKindOf:BeeUIBoard.LAYOUT_VIEWS])
    {
    }
    else if([signal isKindOf:BeeUIBoard.DELETE_VIEWS])
    {
        [self unobserveAllNotifications];
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
-(void)setLine{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.size.width,0.3)];
    [view setBackgroundColor:COLOR_LIGHT_GRAY];
    [self.view addSubview:view];
    
}


-(void)setupButton
{
    [_allTypeBtn setBackgroundColor:COLOR_HEADER];
    [_nowTypeBtn setBackgroundColor:COLOR_HEADER];
    [_timeTypeBtn setBackgroundColor:COLOR_HEADER];
}
-(void)setupData
{
    typeArray = [[NSMutableArray alloc]initWithArray:@[@"all",@"now",@"time"]];
}

-(IBAction)activityBtnTouchUpInside:(id)sender
{
    UIButton  *btn = (UIButton*)sender;
    [self sendUISignal:self.OPEN_VC withObject:[typeArray objectAtIndex:btn.tag-101]];
}
@end
