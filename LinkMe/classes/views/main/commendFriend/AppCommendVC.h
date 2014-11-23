//
//  AppCommendVC.h
//  LinkMe
//
//  Created by Summer Wu on 14-11-21.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bee.h"
#import "HobbyModel.h"
#import "ActivityModel.h"

@interface AppCommendVC : BeeUIBoard<UICollectionViewDataSource,UICollectionViewDelegate>
AS_SIGNAL(CLOSE_APPCOMMENDVC)

@property(strong,nonatomic) HobbyModel    *hobbyModel;
@property(strong,nonatomic) ActivityModel *activityModel;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end
