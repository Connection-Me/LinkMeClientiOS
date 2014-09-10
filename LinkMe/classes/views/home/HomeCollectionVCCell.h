//
//  HomeCollectionVCCell.h
//  LinkMe
//
//  Created by ChaoSo on 14-8-31.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bee.h"
#import "ActivityModel.h"
@interface HomeCollectionVCCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *approveCount;
@property (weak, nonatomic) IBOutlet UILabel *rejectCount;



-(void)updateCell:(NSInteger)index;
-(void)updatecellByActivityModel:(ActivityModel*)activityModel;

@end
