//
//  AddActivityVC.m
//  LinkMe
//
//  Created by ChaoSo on 14-10-25.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "AddActivityVC.h"
#import "summer_extend.h"
#import "HeaderVC.h"
#import "DatePopupPickerVC.h"
#import "TimePopupPickerVC.h"

@interface AddActivityVC ()
{
    NSArray *titleName;
    HeaderVC                   *_headerVC;
    DatePopupPickerVC          *_datePopupPickerVC;
    TimePopupPickerVC          *_timePopupPickerVC;
    
}

@end

@implementation AddActivityVC
SUMMER_DEF_XIB(AddActivityVC, YES, NO)
DEF_SIGNAL(CLOSE_ADDVC)

ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {
        [self setupHeader];
        titleName  = @[@"",@"活动名字",@"活动开始日期",@"活动结束日期",@"上限人数",@"下限人数",@"开始报名时间",@"截止报名时间",@"活动简介"];
        
//        [self setAllViewBorader];
        [self setAllViewTitle];
        [self setTextFieldUI];
        
        
    }
    else if([signal isKindOf:BeeUIBoard.LAYOUT_VIEWS])
    {
        
    }
    else if([signal isKindOf:BeeUIBoard.DELETE_VIEWS])
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

#pragma mark header界面
-(void)setupHeader
{
    //    _headerVC = [HeaderVC sharedInstance];
    __block AddActivityVC *homeDetailVC = self;
    
    CommonHeaderView *commonHeaderView= [CommonHeaderView createHeader:self.view WithTitle:@"添加活动" LeftButtonType:CommonHeaderBack RightButtonType:CommonHeaderNone  ];
    [commonHeaderView setLeftButtonBlock:^(){
        [homeDetailVC sendUISignal:homeDetailVC.CLOSE_ADDVC withObject:nil];
    }];
    
    [commonHeaderView setRightButtonBlock:^(){
        
    }];
    _headerVC.parentBoard = self;
    _headerVC.view.alpha = 1.0f;
    _headerVC.view.hidden = NO;
    // _headerVC.view.userInteractionEnabled = YES;
    CGRect rect = [[UIScreen mainScreen] bounds];
    _headerVC.view.frame = CGRectMake(0, 0, rect.size.width, 55);
    [self.view addSubview:_headerVC.view];
}

-(void)setTextFieldUI
{
    _openDateTextField.placeholder = @"月/日/年";
    _openTimeTextField.placeholder = @"时/分";
    _closeDateTextField.placeholder = @"月/日/年";
    _closeTimeTextField.placeholder = @"时/分";
}


-(void)configViewStyle{
    
    
    
}


-(void)setAllViewBorader{
    int viewTag ;
    UIView *view;
    for(viewTag = 1; viewTag<9; viewTag ++){
        view = (UIView *)[self.view viewWithTag:viewTag];
        [self addViewBorder:view];
    }
}
-(void)setAllViewTitle{
    int viewTag ;
    UIView *view;
    NSString *title;
    for(viewTag = 1; viewTag<9; viewTag ++){
        view = (UIView *)[self.view viewWithTag:viewTag];
        title = [titleName objectAtIndex:viewTag];
        [self addViewTitleAndTextField:view title:title];
    }
}



-(void)addViewBorder:(UIView *)view{
    
    if(view == nil){
        return ;
    }
    view.layer.borderWidth = 0.5f;
    view.layer.borderColor = [[UIColor grayColor] CGColor];
}



-(void)addViewTitleAndTextField:(UIView *)view title:(NSString *)titleText{
    if(view == nil){
        return ;
    }
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, (40-15)/2, 100, 20)];
    [title setText:titleText];
    [title setTextColor:[UIColor whiteColor]];
    [title setFont:[UIFont fontWithName:@"Avenir-Heavy" size:15]];
    [view addSubview:title];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(title.frame.origin.x+title.frame.size.width+10, title.frame.origin.y+2.5, view.frame.size.width-title.frame.size.width, 20)];
    [textField setTextColor:[UIColor whiteColor]];
//    textField.borderStyle=UITextBorderStyleRoundedRect;
    textField.clearButtonMode=UITextFieldViewModeNever;
//    [textField setPlaceholder:titleText];
//    [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [view addSubview:textField];
}

-(IBAction)openDateTouchUpInside:(id)sender
{
    _datePopupPickerVC = [[DatePopupPickerVC alloc]init];
    _datePopupPickerVC.sendSignal = @"OPEN_DATE";
    _datePopupPickerVC.parentBoard = self;
    _datePopupPickerVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:_datePopupPickerVC animated:YES completion:NO];
    
}
-(IBAction)openTimeTouchUpInside:(id)sender
{
    _timePopupPickerVC = [[TimePopupPickerVC alloc]init];
    _timePopupPickerVC.sendSignal = @"OPEN_TIME";
    _timePopupPickerVC.parentBoard = self;
    _timePopupPickerVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:_timePopupPickerVC animated:YES completion:NO];
}
-(IBAction)closeDateTouchUpInside:(id)sender
{
    _datePopupPickerVC = [[DatePopupPickerVC alloc]init];
    _datePopupPickerVC.sendSignal = @"CLOSE_DATE";
    _datePopupPickerVC.parentBoard = self;
    _datePopupPickerVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:_datePopupPickerVC animated:YES completion:NO];
}
-(IBAction)closeTimeTouchUpInside:(id)sender
{
    _timePopupPickerVC = [[TimePopupPickerVC alloc]init];
    _timePopupPickerVC.sendSignal = @"CLOSE_TIME";
    _timePopupPickerVC.parentBoard = self;
    _timePopupPickerVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:_timePopupPickerVC animated:YES completion:NO];
}

ON_SIGNAL3(DatePopupPickerVC, OPEN_DATE, signal)
{
    NSString  *dateString = (NSString*)signal.object;
    _openDateTextField.text = dateString;
    [self dismissViewControllerAnimated:YES completion:^{
        _datePopupPickerVC = nil;
    }];
}
ON_SIGNAL3(DatePopupPickerVC, CLOSE_DATE, signal)
{
    NSString  *dateString = (NSString*)signal.object;
    _closeDateTextField.text = dateString;
    [self dismissViewControllerAnimated:YES completion:^{
        _datePopupPickerVC = nil;
    }];
}
ON_SIGNAL3(DatePopupPickerVC, DISMISS_OPEN_DATE, signal)
{
    [self dismissViewControllerAnimated:YES completion:^{
        _datePopupPickerVC = nil;
    }];
}

ON_SIGNAL3(TimePopupPickerVC, OPEN_TIME, signal)
{
    NSString  *timeString = (NSString*)signal.object;
    _openTimeTextField.text = timeString;
    [self dismissViewControllerAnimated:YES completion:^{
        _timePopupPickerVC = nil;
    }];
}
ON_SIGNAL3(TimePopupPickerVC, CLOSE_TIME, signal)
{
    NSString  *timeString = (NSString*)signal.object;
    _closeTimeTextField.text = timeString;
    [self dismissViewControllerAnimated:YES completion:^{
        _timePopupPickerVC = nil;
    }];
}
ON_SIGNAL3(TimePopupPickerVC, DISMISS_OPEN_TIME, signal)
{
    [self dismissViewControllerAnimated:YES completion:^{
        _timePopupPickerVC = nil;
    }];
}
@end
