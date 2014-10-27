//
//  AddActivityVC.h
//  LinkMe
//
//  Created by ChaoSo on 14-10-25.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bee.h"

@interface AddActivityVC : BeeUIBoard
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *openTimeView;
@property (weak, nonatomic) IBOutlet UIView *endingTimeView;
@property (weak, nonatomic) IBOutlet UIView *limitCount;
@property (weak, nonatomic) IBOutlet UIView *downCountView;
@property (weak, nonatomic) IBOutlet UIView *approveTime;
@property (weak, nonatomic) IBOutlet UIView *closeTime;
@property (weak, nonatomic) IBOutlet UIView *descView;

@end
