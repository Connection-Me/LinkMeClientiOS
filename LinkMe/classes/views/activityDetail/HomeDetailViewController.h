//
//  HomeDetailViewController.h
//  LinkMe
//
//  Created by ChaoSo on 14-9-16.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bee_UIBoard.h"
#import "Bee.h"
#import "ActivityModel.h"
@interface HomeDetailViewController : BeeUIBoard
AS_SINGLETON(HomeDetailViewController)

AS_SIGNAL(CLOSE_CELL_DETAIL)

@property (weak, nonatomic) IBOutlet UIView *insertUserView;
@property (weak, nonatomic) IBOutlet UIView *activityView;
@property (weak, nonatomic) IBOutlet UIView *informationView;

@property (nonatomic,strong)  ActivityModel    *sampleActivityModel;

@property (nonatomic,strong)  ActivityModel    *detailActivityModel;
@end
