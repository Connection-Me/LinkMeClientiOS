//
//  HeaderVC.m
//  LinkMe
//
//  Created by Summer Wu on 14-9-12.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "HeaderVC.h"

#import "summer_extend.h"
#import "CommendEvent.h"
#import "CoreService.h"
#import "PersonalSettingVC.h"
@interface HeaderVC ()
{
    NSTimer          *_checkInviteTimer;
    NSInteger        _beInviteSum;
    RNFrostedSidebar *_callout;
}
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation HeaderVC
DEF_SINGLETON(HeaderVC)
DEF_SIGNAL(ADD_VC)
DEF_SIGNAL(ADD_INVITE_STATUS)
DEF_SIGNAL(REMOVE_INVITE_STATUS)
DEF_SIGNAL(PERSONAL_SETTING)
SUMMER_DEF_XIB(HeaderVC, YES, NO);
ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {
        _beInviteSum = 0;
        [self observeNotifications];
        [self setHeaderView];
       // [self startCheckBeInviteNum];
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

-(void)observeNotifications
{
    [self observeNotification:CommendEvent.CHECK_BE_INVITE_NUM_START];
    [self observeNotification:CommendEvent.CHECK_BE_INVITE_NUM_SUCCESS];
    [self observeNotification:CommendEvent.CHECK_BE_INVITE_NUM_FAILED];
}

-(void)startCheckBeInviteNum
{
    [[CoreService sharedInstance].commendRemoteService checkInviteNum];
}

-(void)setHeaderView{
    self.headerView = [CommonHeaderView createHeader:self.view WithTitle:@"首页" LeftButtonType:CommonHeaderMenu RightButtonType:CommonHeaderAdd];
    
    
    [self.headerView.leftButton addTarget:self action:@selector(onBurger:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headerView.rightButton addTarget:self action:@selector(clickAdd:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - click button
- (IBAction)onBurger:(id)sender {
    NSLog(@"click Menu button");
    if(_beInviteSum>0){
        
    }
    NSArray *images = @[
                        [UIImage imageNamed:@"globe"],
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"star"],
                        
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        ];
    
    _callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    _callout.delegate = self;
    //    callout.showFromRight = YES;
    [_callout show];
}
- (IBAction)clickAdd:(id)sender {
    NSLog(@"click ADD button");
    [self sendUISignal:self.ADD_VC withObject:nil];

}
#pragma mark - DELEGATE
-(void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index{
    if(index == 0){
        
    }
    else if(index == 1){
        [_callout dismiss];
        [self sendUISignal:self.PERSONAL_SETTING withObject:nil];
        
    }
    
}


ON_NOTIFICATION3(CommendEvent, CHECK_BE_INVITE_NUM_START, notification)
{
    
}

ON_NOTIFICATION3(CommendEvent, CHECK_BE_INVITE_NUM_SUCCESS, notification)
{
    NSNumber *inviteSum = notification.object;
    _beInviteSum = [inviteSum integerValue];
    if (_beInviteSum>0) {
        [self sendUISignal:self.ADD_INVITE_STATUS withObject:@(_beInviteSum)];
    }
    else if (_beInviteSum == 0){
        [self sendUISignal:self.REMOVE_INVITE_STATUS withObject:@(_beInviteSum)];
    }
    
    _checkInviteTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(startCheckBeInviteNum) userInfo:nil repeats:NO];
}

ON_NOTIFICATION3(CommendEvent, CHECK_BE_INVITE_NUM_FAILED, notification)
{
    _checkInviteTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(startCheckBeInviteNum) userInfo:nil repeats:NO];
}


@end
