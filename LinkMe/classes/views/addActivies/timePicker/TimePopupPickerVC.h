//
//  TimePopupPickerVC.h
//  LinkMe
//
//  Created by Summer Wu on 14-10-28.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "Bee_UIBoard.h"
#import "Bee.h"

@interface TimePopupPickerVC : BeeUIBoard

AS_SIGNAL(OPEN_TIME)
AS_SIGNAL(DISMISS_OPEN_TIME)

AS_SIGNAL(CLOSE_TIME)
AS_SIGNAL(DISMISS_CLOSE_TIME)
@property (weak, nonatomic) IBOutlet UIView *popupView;

@property(strong,nonatomic) NSString     *sendSignal;
@property (weak, nonatomic) IBOutlet UIDatePicker  *timePickerView;

@end
