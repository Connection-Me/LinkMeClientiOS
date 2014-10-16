//
//  HTableViewCell.h
//  LinkMe
//
//  Created by ChaoSo on 14-10-13.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
@interface HTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *approveUserImage;
@property (weak, nonatomic) IBOutlet UILabel *approveNameLabel;

-(void)updateCell:(ActivityModel *) sampleActivityModel;
@end
