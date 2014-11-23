//
//  ActivityTypeVC.h
//  LinkMe
//
//  Created by Summer Wu on 14-11-21.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bee.h"

@interface ActivityTypeVC : BeeUIBoard

@property(weak,nonatomic) IBOutlet UIView    *mainView;

AS_SIGNAL(CLOSE_ACTIVITY_TYPE_VC)

@end
