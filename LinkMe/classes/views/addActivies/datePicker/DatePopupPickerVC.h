//
//  DatePopupPickerVC.h
//  LinkMe
//
//  Created by Summer Wu on 14-10-28.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "Bee_UIBoard.h"
#import "Bee.h"

@interface DatePopupPickerVC : BeeUIBoard

AS_SIGNAL(OPEN_DATE)
AS_SIGNAL(DISMISS_OPEN_DATE)

AS_SIGNAL(CLOSE_DATE)
AS_SIGNAL(DISMISS_CLOSE_DATE)
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;
@property (weak, nonatomic) IBOutlet UIView *popupView;

@property(strong,nonatomic) NSString     *sendSignal;

@end
