//
//  FooterVC.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-12.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bee.h"
#import "Bee_UIBoard.h"

@interface FooterVC : BeeUIBoard
AS_SINGLETON(FooterVC)
AS_SIGNAL(OPEN_VC)

@property(weak,nonatomic) IBOutlet UIButton    *allTypeBtn;
@property(weak,nonatomic) IBOutlet UIButton    *nowTypeBtn;
@property(weak,nonatomic) IBOutlet UIButton    *timeTypeBtn;


@end
