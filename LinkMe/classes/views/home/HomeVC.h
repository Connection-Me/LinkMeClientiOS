//
//  HomeVC.h
//  LinkMe
//
//  Created by ChaoSo on 14-8-31.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bee.h"
#import "RNFrostedSidebar.h"
#import "CommonHeaderView.h"
@interface HomeVC : BeeUIBoard<UICollectionViewDataSource,UICollectionViewDelegate,RNFrostedSidebarDelegate>
//@property (strong, nonatomic) IBOutlet CommonHeaderView *headerView;
AS_SIGNAL(TEST)
AS_SINGLETON(HomeVC)
AS_SIGNAL(OPEN_CELL_DETAIL)
@property (strong, nonatomic) IBOutlet UICollectionView *mainView;
//@property (weak, nonatomic) IBOutlet UIView *footerView;


@end
