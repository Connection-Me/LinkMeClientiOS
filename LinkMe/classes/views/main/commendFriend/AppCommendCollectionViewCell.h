//
//  AppCommendCollectionViewCell.h
//  LinkMe
//
//  Created by Summer Wu on 14-11-22.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "Bee.h"
@interface AppCommendCollectionViewCell : UICollectionViewCell

AS_SIGNAL(TOUCH_Y_BUTTON)

@property(weak,nonatomic) IBOutlet UIImageView   *userImage;

@property(weak,nonatomic) IBOutlet UIButton      *selectBtn;

-(void)updateCellByUser:(UserModel*)userModel;

@end
