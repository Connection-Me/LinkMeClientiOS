//
//  TimePopupPickerVC.m
//  LinkMe
//
//  Created by Summer Wu on 14-10-28.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "TimePopupPickerVC.h"
#import "summer_extend.h"

@interface TimePopupPickerVC ()

@end

@implementation TimePopupPickerVC
SUMMER_DEF_XIB(TimePopupPickerVC, YES, NO);

DEF_SIGNAL(OPEN_TIME)
DEF_SIGNAL(DISMISS_OPEN_TIME)
DEF_SIGNAL(CLOSE_TIME)
DEF_SIGNAL(DISMISS_CLOSE_TIME)

ON_SIGNAL2( BeeUIBoard, signal )
{
    [super handleUISignal:signal];
    
    if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
    {
        self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        [[self.popupView layer] setCornerRadius:8.0f];
    }
    else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
    {
    }
    else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
    {
    }
    else if ( [signal is:BeeUIBoard.LOAD_DATAS] )
    {
    }
    else if ( [signal is:BeeUIBoard.FREE_DATAS] )
    {
    }
    else if ( [signal is:BeeUIBoard.WILL_APPEAR] )
    {
       
    }
    else if ( [signal is:BeeUIBoard.DID_APPEAR] )
    {
        
    }
    else if ( [signal is:BeeUIBoard.WILL_DISAPPEAR] )
    {
        
    }
    else if ( [signal is:BeeUIBoard.DID_DISAPPEAR] )
    {
    }
}


-(IBAction)okTouchUpInside:(id)sender
{
    NSDate *select  = [_timePickerView date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateAndTime = [dateFormatter stringFromDate:select];
    if ([self.sendSignal isEqualToString:@"OPEN_TIME"])
        [self sendUISignal:self.OPEN_TIME withObject:dateAndTime];
    else if([self.sendSignal isEqualToString:@"CLOSE_TIME"])
        [self sendUISignal:self.CLOSE_TIME withObject:dateAndTime];
    
}
-(IBAction)cancelTouchUpInside:(id)sender
{
    [self sendUISignal:self.DISMISS_OPEN_TIME withObject:nil];
}

@end
