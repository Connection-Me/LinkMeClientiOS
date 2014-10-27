//
//  AddActivityVC.m
//  LinkMe
//
//  Created by ChaoSo on 14-10-25.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "AddActivityVC.h"
#import "summer_extend.h"

@interface AddActivityVC ()
{
    NSArray *titleName;
    
}

@end

@implementation AddActivityVC
SUMMER_DEF_XIB(AddActivityVC, YES, NO)
ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {
        titleName  = @[@"",@"活动名字",@"活动开始日期",@"活动结束日期",@"上限人数",@"下限人数",@"开始报名时间",@"截止报名时间",@"活动简介"];
        
//        [self setAllViewBorader];
        [self setAllViewTitle];
        
        
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




@end
