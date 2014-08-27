//
//  RootVC.m
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "RootVC.h"
#import "summer_extend.h"
#import "LoginVC.h"
#import "LoginEvent.h"
#import "TCMessageBox.h"
#import "LoginPageViewController.h"

@interface RootVC ()

@end

@implementation RootVC
{
    BeeUIRouter * _router;
    NSString    * _screenName;
}

SUMMER_DEF_XIB(RootVC, YES, NO)

DEF_SINGLETON(RootVC)


ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {
        [self initializeRouterObserveEvents];

        [self initializeRouter];
        [self initializeRouterMapClass];
        
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
        [self autoLogin];
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

-(void)initializeRouter
{
    _router = [BeeUIRouter sharedInstance];
    _router.parentBoard = self;
    _router.view.alpha = 1.0f;
    _router.view.hidden = NO;
    _router.view.left = 0.0f;
    _router.view.frame = self.view.frame;
    [self.view addSubview:_router.view];
}

#pragma mark - 监听事件
-(void)initializeRouterObserveEvents
{
    [self observeNotification:LoginEvent.LOGIN];
    [self observeNotification:LoginEvent.LOGIN_SUCCESS];
    [self observeNotification:LoginEvent.LOGIN_FAILED];
    
    [self observeNotification:LoginEvent.REGISTER];
    [self observeNotification:LoginEvent.REGISTER_SUCCESS];
    [self observeNotification:LoginEvent.REGISTER_FAILED];
}

-(void)initializeRouterMapClass
{
   // [_router map:@"login" toClass:[LoginVC class]];
    [_router map:@"login" toClass:[LoginPageViewController class]];
}

-(void)testOpenScreen:(NSString*)name
{
    _screenName = name;
    if(_screenName)
    {
        [_router open:_screenName animated:NO];
    }
}

-(void)autoLogin
{
    //先直接打开login界面
    [self testOpenScreen:@"login"];
}

#pragma mark - Notification
ON_NOTIFICATION3(LoginEvent, LOGIN, notification)
{
    [TCMessageBox showMessage:@"Logining..." hideByTouch:NO withActivityIndicator:YES];
}
ON_NOTIFICATION3(LoginEvent, LOGIN_SUCCESS, notification)
{
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}
ON_NOTIFICATION3(LoginEvent, LOGIN_FAILED, notification)
{
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

ON_NOTIFICATION3(LoginEvent, REGISTER_SUCCESS, notification)
{
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
    //请求服务器返回的json
     NSString * data = (NSString*)notification.object;
    //TODO 处理返回json
}

ON_NOTIFICATION3(LoginEvent, REGISTER_FAILED, notification)
{
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

@end
