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

-(void)setupButton
{
    [_allTypeBtn setBackgroundColor:[UIColor colorWithRed:92/255.0f green:92/255.0f blue:92/255.0f alpha:1.0f]];
    [_nowTypeBtn setBackgroundColor:[UIColor colorWithRed:92/255.0f green:92/255.0f blue:92/255.0f alpha:1.0f]];
    [_timeTypeBtn setBackgroundColor:[UIColor colorWithRed:92/255.0f green:92/255.0f blue:92/255.0f alpha:1.0f]];
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
