//
//  HeaderVC.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-12.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "Bee_UIBoard.h"
#import "LinkMeViewController.h"
#import "Bee.h"
#import "RNFrostedSidebar.h"
#import "CommonHeaderView.h"

@interface HeaderVC : LinkMeViewController<RNFrostedSidebarDelegate>
AS_SINGLETON(HeaderVC)
AS_SIGNAL(ADD_VC)
AS_SIGNAL(PERSONAL_SETTING)
@property (strong,nonatomic) IBOutlet CommonHeaderView *headerView;
@end
