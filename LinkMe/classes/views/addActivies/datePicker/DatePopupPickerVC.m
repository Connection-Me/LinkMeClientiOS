//
//  DatePopupPickerVC.m
//  LinkMe
//
//  Created by Summer Wu on 14-10-28.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "DatePopupPickerVC.h"
#import "summer_extend.h"

@interface DatePopupPickerVC ()
{
//    NSMutableArray      *yeadList;
//    NSMutableArray      *monthList;
//    NSMutableArray      *
}

@end

@implementation DatePopupPickerVC
SUMMER_DEF_XIB(DatePopupPickerVC, YES, NO);
DEF_SIGNAL(OPEN_DATE)
DEF_SIGNAL(DISMISS_OPEN_DATE)

DEF_SIGNAL(CLOSE_DATE)
DEF_SIGNAL(DISMISS_CLOSE_DATE)

ON_SIGNAL2( BeeUIBoard, signal )
{
    [super handleUISignal:signal];
    
    if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
    {
        [self setArrayData];
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
//        NSString *feildTextValue = _evalItem.fieldText;
//        if(feildTextValue!=nil&&![feildTextValue isEqualToString:@""])
//        {
//            NSInteger row1 = [self findRow:[feildTextValue substringWithRange:NSMakeRange(0, 2)] andComponent:0];
//            [_pickerView selectRow:row1 inComponent:0 animated:NO];
//            
//            NSInteger row2 = [self findRow:[feildTextValue substringWithRange:NSMakeRange(3, 2)] andComponent:1];
//            [_pickerView selectRow:row2 inComponent:1 animated:NO];
//            
//            NSInteger row3 = [self findRow:[feildTextValue substringWithRange:NSMakeRange(6, 2)] andComponent:2];
//            [_pickerView selectRow:row3 inComponent:2 animated:NO];
//        }
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

-(void)setArrayData
{
   
//    _hourArray = [NSArray arrayWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil];
//    //    _minuteArray = [NSArray arrayWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12","13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"12", nil];
//    _minuteArray = [NSMutableArray arrayWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09", nil];
//    for (int i = 10; i<60; i++) {
//        [_minuteArray addObject:[NSString stringWithFormat:@"%d",i]];
//    }
}

-(IBAction)okTouchUpInside:(id)sender
{
    NSDate *select  = [_datePickerView date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateAndTime = [dateFormatter stringFromDate:select];

    if([self.sendSignal isEqualToString:@"OPEN_DATE"])
        [self sendUISignal:self.OPEN_DATE withObject:dateAndTime];
    else if([self.sendSignal isEqualToString:@"CLOSE_DATE"])
    {
        [self sendUISignal:self.CLOSE_DATE withObject:dateAndTime];
    }
}
-(IBAction)cancelTouchUpInside:(id)sender
{
    [self sendUISignal:self.DISMISS_OPEN_DATE withObject:nil];
}

@end
