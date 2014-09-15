//
//  HeaderVC.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-12.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "Bee_UIBoard.h"
#import "Bee.h"
#import "RNFrostedSidebar.h"
#import "CommonHeaderView.h"

@interface HeaderVC : BeeUIBoard<RNFrostedSidebarDelegate>
AS_SINGLETON(HeaderVC)

@property (strong,nonatomic) IBOutlet CommonHeaderView *headerView;
@end
