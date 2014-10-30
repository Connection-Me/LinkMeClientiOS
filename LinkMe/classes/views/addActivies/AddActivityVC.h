//
//  AddActivityVC.h
//  LinkMe
//
//  Created by ChaoSo on 14-10-25.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bee.h"

@interface AddActivityVC : BeeUIBoard<UITextViewDelegate>

AS_SIGNAL(CLOSE_ADDVC)


@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *openTimeView;
@property (weak, nonatomic) IBOutlet UIView *endingTimeView;
@property (weak, nonatomic) IBOutlet UIView *limitCount;
@property (weak, nonatomic) IBOutlet UIView *downCountView;
@property (weak, nonatomic) IBOutlet UIView *approveTime;
@property (weak, nonatomic) IBOutlet UIView *closeTime;
@property (weak, nonatomic) IBOutlet UIView *descView;




#pragma mark textField
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *ceilingCountTf;
@property (weak, nonatomic) IBOutlet UITextField *lowerLimitCountTf;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTf;

@property (weak, nonatomic) IBOutlet UITextField  *openDateTextField;
@property (weak, nonatomic) IBOutlet UITextField  *openTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField  *closeDateTextField;
@property (weak, nonatomic) IBOutlet UITextField  *closeTimeTextField;

@property (weak, nonatomic) IBOutlet UITextField  *openSignDateTextField;
@property (weak, nonatomic) IBOutlet UITextField  *openSignTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField  *closeSignDateTextField;
@property (weak, nonatomic) IBOutlet UITextField  *closeSignTimeTextField;
@property (weak, nonatomic) IBOutlet UILabel *textViewPlaceHolder;


@end
