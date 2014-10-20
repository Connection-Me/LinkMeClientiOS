//
//  LoginVC.m
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "LoginVC.h"
#import "summer_extend.h"
#import "CoreService.h"

@interface LoginVC ()

@end

@implementation LoginVC
DEF_SINGLETON(LoginVC)
DEF_SIGNAL(CLOSE_VC)
SUMMER_DEF_XIB(LoginVC, YES, NO)

ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {
        self.title = @"登陆";
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

-(IBAction)loginTouchUpInside:(id)sender
{
    [[CoreService sharedInstance].userRemoteService queryLoginByUsername:@"123" andPassWord:@"123" andController:@"user" andMethodName:@"login"];
}

-(IBAction)backTouchUpInside:(id)sender
{
    [self sendUISignal:self.CLOSE_VC withObject:nil];
}

@end
