//
//  HomeDetailViewController.h
//  LinkMe
//
//  Created by ChaoSo on 14-9-16.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bee_UIBoard.h"
#import "LinkMeViewController.h"
#import "Bee.h"
#import "ActivityModel.h"
@interface HomeDetailViewController : LinkMeViewController<UICollectionViewDataSource,UICollectionViewDelegate>
AS_SINGLETON(HomeDetailViewController)

AS_SIGNAL(CLOSE_CELL_DETAIL)

@property (weak, nonatomic) IBOutlet UIView *insertUserView;
@property (weak, nonatomic) IBOutlet UIView *activityView;
@property (weak, nonatomic) IBOutlet UIView *informationView;
@property (weak, nonatomic) IBOutlet UITableView *approveUserList;
@property (weak, nonatomic) IBOutlet UIImageView *founderImageView;
@property (weak, nonatomic) IBOutlet UILabel *founderNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *founderTime;
@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;
@property (weak, nonatomic) IBOutlet UILabel *activityStartDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityEndingDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLessPeopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityMaxCountLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *signInStartTime;
@property (weak, nonatomic) IBOutlet UILabel *signInEndingTime;
@property (weak, nonatomic) IBOutlet UILabel *activityType;
@property (weak, nonatomic) IBOutlet UILabel *approveCount;
@property (weak, nonatomic) IBOutlet UILabel *rejectCount;
@property (weak, nonatomic) IBOutlet UILabel *activityName;
@property (weak, nonatomic) IBOutlet UITextView *activityDesc;

@property (nonatomic,strong)  ActivityModel    *sampleActivityModel;

@property (nonatomic,strong)  ActivityModel    *detailActivityModel;
@end
