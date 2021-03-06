//
//  MainVC.m
//  LinkMe
//
//  Created by Summer Wu on 14-9-12.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "MainVC.h"
#import "summer_extend.h"
#import "HeaderVC.h"
#import "FooterVC.h"
#import "HomeVC.h"
#import "LoginVC.h"
#import "HomeDetailViewController.h"
#import "AddActivityVC.h"
#import "PersonalSettingVC.h"

@interface MainVC ()
{
    BeeUIRouter                *_router;
    HeaderVC                   *_headerVC;
    FooterVC                   *_footerVC;
    
    NSString                   * _screenName;
    
    HomeVC                     *_homeVCtodo;
    HomeVC                     *_homeVCdoing;
    HomeVC                     *_homeVCdone;
    
    UIImageView                *_pickedColorImageView;
}

@end

@implementation MainVC
DEF_SINGLETON(MainVC)
SUMMER_DEF_XIB(MainVC, YES, NO);

ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {
        [self initializeRouterObserveEvents];
        [self setupRouter];
        [self setupHeader];
        [self setupFooter];
        [self initializeRouterMapClass];
        [self setupUI]; 
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

-(void)setupUI
{
    [self testOpenScreen:@"todo"];
}

#pragma mark header界面
-(void)setupHeader
{
    _headerVC = [HeaderVC sharedInstance];
    _headerVC.parentBoard = self;
    _headerVC.view.alpha = 1.0f;
    _headerVC.view.hidden = NO;
    
   // _headerVC.view.userInteractionEnabled = YES;
    CGRect rect = [[UIScreen mainScreen] bounds];
    _headerVC.view.frame = CGRectMake(0, 0, rect.size.width, 55);
    [self.view addSubview:_headerVC.view];
    
    UIGraphicsBeginImageContext(CGSizeMake(5, 5));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 20, 20);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    //画圆
    CGContextAddArc(ctx, 1/2, 1/2, 14.5, 0, 6.3, 0);
    CGContextFillPath(ctx);
    //取得图片
    _pickedColorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 10, 10)];
    _pickedColorImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _pickedColorImageView.layer.masksToBounds = YES;
    _pickedColorImageView.layer.cornerRadius = 5;
    [self.view addSubview:_pickedColorImageView];
    _pickedColorImageView.hidden = YES;
}
#pragma mark 中间界面
-(void)setupRouter
{
    _router = [[BeeUIRouter alloc] init];
    _router.parentBoard = self;
    _router.view.alpha = 1.0f;
    _router.view.hidden = NO;
   // _router.view.userInteractionEnabled = YES;
    CGRect rect = [[UIScreen mainScreen] bounds];
    self.view.frame = rect;
    _router.view.frame = CGRectMake(0, 55, rect.size.width, rect.size.height-55-42);
    [[_router.view layer] setCornerRadius:8.0f];
    [self.view addSubview:_router.view];
}
#pragma mark footer界面
-(void)setupFooter
{
    _footerVC = [FooterVC sharedInstance];
    _footerVC.parentBoard = self;
    _footerVC.view.alpha = 1.0f;
    _footerVC.view.hidden = NO;
    CGRect rect = [[UIScreen mainScreen] bounds];
    _footerVC.view.frame = CGRectMake(0, (_router.view.frame.origin.y+_router.view.frame.size.height), rect.size.width, 42);
    [self.view addSubview:_footerVC.view];
}

-(void)initializeRouterMapClass
{
    _homeVCtodo = [[HomeVC alloc]init];
    _homeVCtodo.whenActivities = @"todo";
    _homeVCtodo.parentBoard = self;
    [_router map:@"todo" toBoard:_homeVCtodo];
    
    _homeVCdoing = [[HomeVC alloc]init];
    _homeVCdoing.whenActivities = @"doing";
    _homeVCdoing.parentBoard = self;
    [_router map:@"doing" toBoard:_homeVCdoing];
    
    _homeVCdone = [[HomeVC alloc]init];
    _homeVCdone.whenActivities = @"done";
    _homeVCdone.parentBoard = self;
    [_router map:@"done" toBoard:_homeVCdone];
}

-(void)testOpenScreen:(NSString*)name
{
    _screenName = name;
    if(_screenName)
    {
        [_router open:_screenName animated:YES];
    }
}

#pragma mark - 监听事件
-(void)initializeRouterObserveEvents
{
}

ON_SIGNAL3(FooterVC, OPEN_VC, signal)
{
    NSString * openName = (NSString*)signal.object;
    [self testOpenScreen:openName];
}

ON_SIGNAL3(HomeVC, OPEN_CELL_DETAIL, signal)
{
    HomeDetailViewController *detail = [HomeDetailViewController sharedInstance];
    detail.sampleActivityModel = (ActivityModel*)signal.object;
    detail.parentBoard = self;
    [self.navigationController pushViewController:detail animated:YES];
    
//    LoginVC *loginVC = [LoginVC sharedInstance];
//    loginVC.parentBoard = self;
//    [self.navigationController pushViewController:loginVC animated:YES];
   // loginVC.hidesBottomBarWhenPushed = YES;
   // UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init];
//    UIButton *button = [[UIButton alloc] init];
//    button.frame = CGRectMake(0, 0, 30, 30);
//    button.titleLabel.text = @"返回";
//    button.titleLabel.textColor = [UIColor blackColor];
//////    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
////    self.stack.navigationBar.titleTextAttributes = dic;
////    [button setImage:[UIImage imageNamed:@"icon-back_light.png"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(_back:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

//    self.stack.navigationBarHidden = NO;
//    self.stack.navigationBar.barTintColor = [UIColor redColor];
   // [self.stack pushBoard:loginVC animated:YES];
    
//    self.navigationItem.leftBarButtonItem = button;
   // [self.stack pushBoard:loginVC animated:YES];
//    [self.navigationController presentViewController:loginVC animated:YES completion:^{
//        loginVC.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
//    }];
}

ON_SIGNAL3(HomeDetailViewController, CLOSE_CELL_DETAIL, signal)
{
    [self.navigationController popViewControllerAnimated:YES];
    _footerVC.view.userInteractionEnabled = YES;
    _headerVC.view.userInteractionEnabled = YES;
    _router.view.userInteractionEnabled = YES;
}

ON_SIGNAL3(LoginVC, CLOSE_VC, signal)
{
    [self.navigationController popViewControllerAnimated:YES];
    _footerVC.view.userInteractionEnabled = YES;
    _headerVC.view.userInteractionEnabled = YES;
    _router.view.userInteractionEnabled = YES;
}

ON_SIGNAL3(HeaderVC, ADD_VC, signal)
{
    AddActivityVC *addPage = [[AddActivityVC alloc] init];
    addPage.parentBoard = self;
    [self.navigationController pushViewController:addPage animated:YES];
}

ON_SIGNAL3(AddActivityVC, CLOSE_ADDVC, signal)
{
    [self.navigationController popViewControllerAnimated:YES];
    _footerVC.view.userInteractionEnabled = YES;
    _headerVC.view.userInteractionEnabled = YES;
    _router.view.userInteractionEnabled = YES;
}

ON_SIGNAL3(HeaderVC, PERSONAL_SETTING, signal)
{
    
    PersonalSettingVC *personalSettingVC = [[PersonalSettingVC alloc] init];
    
    personalSettingVC.parentBoard = self;
    
    [self.navigationController pushViewController:personalSettingVC animated:YES];
    
}
ON_SIGNAL3(PersonalSettingVC, CLOSE_PERSONAL_VC, signal)
{
    [self.navigationController popViewControllerAnimated:YES];
    _footerVC.view.userInteractionEnabled = YES;
    _headerVC.view.userInteractionEnabled = YES;
    _router.view.userInteractionEnabled = YES;
}

ON_SIGNAL3(HeaderVC, ADD_INVITE_STATUS, signal)
{
    _pickedColorImageView.hidden = NO;
}

ON_SIGNAL3(HeaderVC, REMOVE_INVITE_STATUS, signal)
{
    _pickedColorImageView.hidden = YES;
}
@end
