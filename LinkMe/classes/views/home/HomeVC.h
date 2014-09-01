//
//  HomeVC.h
//  LinkMe
//
//  Created by ChaoSo on 14-8-31.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEE.h"
@interface HomeVC : BeeUIBoard<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UICollectionView *mainView;

@end
