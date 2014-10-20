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
#import "UserEvent.h"
#import "TCMessageBox.h"
#import "LoginPageViewController.h"
#import "HomeVC.h"
#import "MainVC.h"
#import "HomeDetailViewController.h"
#import "NetWorkEvent.h"

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
    [self observeNotification:UserEvent.LOGIN];
    [self observeNotification:UserEvent.LOGIN_SUCCESS];
    [self observeNotification:UserEvent.LOGIN_FAILED];
    
    [self observeNotification:UserEvent.REGISTER];
    [self observeNotification:UserEvent.REGISTER_SUCCESS];
    [self observeNotification:UserEvent.REGISTER_FAILED];
    [self observeNotification:UserEvent.REGISTER_FAILED_EXISTED];
    [self observeNotification:UserEvent.REGISTER_FAILED_INFO_ERROR];
    
    [self observeNotification:NetWorkEvent.NEWWORK_UNREACHABLE];
}

-(void)initializeRouterMapClass
{
    [_router map:@"login" toClass:[LoginPageViewController class]];
    //[_router map:@"home" toClass:[HomeVC class]];
    [_router map:@"main" toClass:[MainVC class]];
    [_router map:@"detail" toClass:[HomeDetailViewController class]];
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
ON_NOTIFICATION3(UserEvent, LOGIN, notification)
{
    [TCMessageBox showMessage:@"Logining..." hideByTouch:NO withActivityIndicator:YES];
}
ON_NOTIFICATION3(UserEvent, LOGIN_SUCCESS, notification)
{
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [self testOpenScreen:@"main"];
    
}
ON_NOTIFICATION3(UserEvent, LOGIN_FAILED, notification)
{
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    //test
#ifdef DEBUG
     [self testOpenScreen:@"main"];
#endif
}

ON_NOTIFICATION3(UserEvent, REGISTER, notification)
{
    [TCMessageBox showMessage:@"registering..." hideByTouch:NO withActivityIndicator:YES];
}

ON_NOTIFICATION3(UserEvent, REGISTER_SUCCESS, notification)
{
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
    //请求服务器返回的json
     NSString * data = (NSString*)notification.object;
    //TODO 处理返回json
}

ON_NOTIFICATION3(UserEvent, REGISTER_FAILED, notification)
{
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器异常，请稍后再试。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

ON_NOTIFICATION3(UserEvent, REGISTER_FAILED_EXISTED, notification)
{
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名已被注册！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

ON_NOTIFICATION3(UserEvent, REGISTER_FAILED_INFO_ERROR, notification)
{
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册信息有误！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

ON_NOTIFICATION3(NetWorkEvent, NEWWORK_UNREACHABLE, notification)
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查网络" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [self testOpenScreen:@"main"];
}

@end
