//
//  AppCommendCollectionViewCell.h
//  LinkMe
//
//  Created by Summer Wu on 14-11-22.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface AppCommendCollectionViewCell : UICollectionViewCell

@property(weak,nonatomic) IBOutlet UIImageView   *userImage;

@property(weak,nonatomic) IBOutlet UIButton      *selectBtn;

-(void)updateCellByUser:(UserModel*)userModel;

@end
