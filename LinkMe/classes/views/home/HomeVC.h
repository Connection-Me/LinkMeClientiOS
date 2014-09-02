//
//  HomeVC.h
//  LinkMe
//
//  Created by ChaoSo on 14-8-31.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEE.h"
#import "RNFrostedSidebar.h"
#import "CommonHeaderView.h"
@interface HomeVC : BeeUIBoard<UICollectionViewDataSource,UICollectionViewDelegate,RNFrostedSidebarDelegate>
@property (strong, nonatomic) IBOutlet CommonHeaderView *headerView;
@property (strong, nonatomic) IBOutlet UICollectionView *mainView;

@end
