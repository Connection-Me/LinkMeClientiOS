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
#import "ActivityManager.h"
#import "ActivityEvent.h"
#import "UserEvent.h"
#import "TCMessageBox.h"
#import "CoreService.h"
#import "ActivityModel.h"
#import "AppCommendVC.h"
#import "ActivityTypeVC.h"
#import "HobbyModel.h"

@interface AddActivityVC ()
{
    NSInteger                   dateOrTimePickerTag;
    HeaderVC                   *_headerVC;
    DatePopupPickerVC          *_datePopupPickerVC;
    TimePopupPickerVC          *_timePopupPickerVC;
    ActivityModel              *_activityModel;
    BOOL                        _isAddSuccess;
    
    UIActionSheet              *_selectFansActionSheet;
    
    ActivityTypeVC             *_activityTypeVC;
    HobbyModel                 *_hobbyModel;
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
       
        _scrollView.contentSize = CGSizeMake(320,600);
        _addButton.layer.cornerRadius = 20;
        _isAddSuccess = NO;
        [self observeNotification];
        [self setupHeader];
        [self setTextFieldUI];
        [self setImageToTextField];
        [self setPlaceHolderSytle];
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
       // [self unobserveAllNotifications];
        [self clearMemory];
    }
    else if ( [signal is:BeeUIBoard.DID_DISAPPEAR] )
    {
    }
}

-(void)observeNotification
{
    [self observeNotification:ActivityEvent.ADD_ACTIVITY_START];
    [self observeNotification:ActivityEvent.ADD_ACTIVITY_SUCCESS];
    [self observeNotification:ActivityEvent.ADD_ACTIVITY_FAILED];
    [self observeNotification:UserEvent.USER_NOT_FOUND];
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
//    _headerVC.parentBoard = self;
//    _headerVC.view.alpha = 1.0f;
//    _headerVC.view.hidden = NO;
//    // _headerVC.view.userInteractionEnabled = YES;
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    _headerVC.view.frame = CGRectMake(0, 0, rect.size.width, 55);
//    [self.view addSubview:_headerVC.view];
}

-(void)setTextFieldUI
{
//    _openDateTextField.placeholder = @"月/日/年";
//    _openTimeTextField.placeholder = @"时/分";
//    _closeDateTextField.placeholder = @"月/日/年";
//    _closeTimeTextField.placeholder = @"时/分";
    int viewTag;
    //time picker
    for(viewTag = 41;viewTag < 50 ; viewTag ++){
         UITextField *tf = (UITextField *)[self.view viewWithTag:(viewTag)];
        tf.placeholder = @"时/分";
        [tf setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    for(viewTag = 51;viewTag < 60 ; viewTag ++){
        UITextField *tf = (UITextField *)[self.view viewWithTag:(viewTag)];
        tf.placeholder = @"月/日/年";
        [tf setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    [self setPlaceHolderSytle];
    [_descriptionTf.layer setCornerRadius:5];
    
}


-(void)configViewStyle{
    
    
    
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

-(IBAction)typeTouchUpInside:(id)sender
{
    _activityTypeVC = [[ActivityTypeVC alloc] init];
    _activityTypeVC.parentBoard = self;
    _activityTypeVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:_activityTypeVC animated:YES completion:nil];
}

-(IBAction)openDateTouchUpInside:(id)sender
{
    UIButton *button = (UIButton *)sender;
    dateOrTimePickerTag = button.tag;
    
    // 打开TImePicker 的条件
    if(dateOrTimePickerTag > 20 && dateOrTimePickerTag < 30){
        _timePopupPickerVC = [[TimePopupPickerVC alloc]init];
        _timePopupPickerVC.sendSignal = @"OPEN_TIME";
        _timePopupPickerVC.parentBoard = self;
        _timePopupPickerVC.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:_timePopupPickerVC animated:YES completion:NO];
    }
    //打开 DatePicker
    else if(dateOrTimePickerTag >30 && dateOrTimePickerTag <40){
        _datePopupPickerVC = [[DatePopupPickerVC alloc]init];
        _datePopupPickerVC.sendSignal = @"OPEN_DATE";
        _datePopupPickerVC.parentBoard = self;
        _datePopupPickerVC.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:_datePopupPickerVC animated:YES completion:NO];
    }
}



-(void)setTextIntoTextField:(NSString *)dataString{
    
    UITextField *tf = (UITextField *)[self.view viewWithTag:(dateOrTimePickerTag+20)];
    [tf setText:dataString];
}

-(BOOL)checkActivity
{
    if (_type==nil||[_type.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写活动类型 ！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    return YES;
}

-(IBAction)saveActivityTouchUpInside:(id)sender
{
    if (![self checkActivity]) {
        return;
    }
    _activityModel = [[ActivityModel alloc] init];
    _activityModel.name = _nameTf.text;
    _activityModel.type = @"";
    _activityModel.desc = _descriptionTf.text;
    _activityModel.imageURL = @"";
    
    NSLog(@"link me  ＝＝＝＝＝%@ %@",_openSignDateTextField.text,_openSignTimeTextField.text);
    
    _activityModel.openTime = (long)[[self StringToDate:[NSString stringWithFormat:@"%@ %@",_openSignDateTextField.text,_openSignTimeTextField.text]] timeIntervalSince1970];
     _activityModel.closeTime = (long)[[self StringToDate:[NSString stringWithFormat:@"%@ %@",_closeSignDateTextField.text,_closeSignTimeTextField.text]] timeIntervalSince1970];
    
     _activityModel.startTime = (long)[[self StringToDate:[NSString stringWithFormat:@"%@ %@",_openDateTextField.text,_openTimeTextField.text]] timeIntervalSince1970];
     _activityModel.stopTime = (long)[[self StringToDate:[NSString stringWithFormat:@"%@ %@",_closeDateTextField.text,_closeTimeTextField.text]] timeIntervalSince1970];
    
    
//    _activityModel.openTime = [self StringToDate:[NSString stringWithFormat:@"%@ %@",_openSignDateTextField.text,_openSignTimeTextField.text]];
//    _activityModel.closeTime = [self StringToDate:[NSString stringWithFormat:@"%@ %@",_closeSignDateTextField.text,_closeSignTimeTextField.text]];
//    _activityModel.startTime = [self StringToDate:[NSString stringWithFormat:@"%@ %@",_openDateTextField.text,_openTimeTextField.text]];
//    _activityModel.stopTime = [self StringToDate:[NSString stringWithFormat:@"%@ %@",_closeDateTextField.text,_closeTimeTextField.text]];
    
    
    
    _activityModel.lowerLimit = [_lowerLimitCountTf.text intValue];
    _activityModel.upperLimit = [_ceilingCountTf.text intValue];
    //todo:新创建的活动的时间应该只能是todo，用户添加活动时，要加条件限制。
    [CoreModel sharedInstance].whenActivities = @"todo";
    [[CoreService sharedInstance].activityRemoteService addActivityByActivityModel:_activityModel];
}
-(NSDate*)StringToDate:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *dateAndTime = [dateFormatter dateFromString:dateString];
    return dateAndTime;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_isAddSuccess) {
        
        _isAddSuccess = NO;
        _selectFansActionSheet = [[UIActionSheet alloc] initWithTitle:@"选择好友推荐方式" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: nil];
        NSArray *selectFans = [NSArray arrayWithObjects:@"app用户",@"微信好友",@"微博好友", nil];
        for(NSString *fan in selectFans) {
            [_selectFansActionSheet addButtonWithTitle:fan];
        }
        [_selectFansActionSheet setCancelButtonIndex:[_selectFansActionSheet addButtonWithTitle:@"Cancel"]];
        [_selectFansActionSheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _selectFansActionSheet = nil;
    if (buttonIndex == 0) {
        AppCommendVC *appCommendVC = [[AppCommendVC alloc]init];
        appCommendVC.parentBoard = self;
        appCommendVC.hobbyModel = _hobbyModel;
        appCommendVC.activityModel = _activityModel;
        [self.navigationController pushViewController:appCommendVC animated:YES];
    }
}

#pragma mark - receive signal

ON_SIGNAL3(AppCommendVC, CLOSE_APPCOMMENDVC, signal)
{
    [self.navigationController popViewControllerAnimated:YES ];
}

ON_SIGNAL3(DatePopupPickerVC, OPEN_DATE, signal)
{
    NSString  *dateString = (NSString*)signal.object;
    
    [self setTextIntoTextField:dateString];
    
    [self dismissViewControllerAnimated:YES completion:^{
        _datePopupPickerVC = nil;
    }];
}


//ON_SIGNAL3(DatePopupPickerVC, CLOSE_DATE, signal)
//{
//    NSString  *dateString = (NSString*)signal.object;
//    _closeDateTextField.text = dateString;
//    [self dismissViewControllerAnimated:YES completion:^{
//        _datePopupPickerVC = nil;
//    }];
//}


ON_SIGNAL3(DatePopupPickerVC, DISMISS_OPEN_DATE, signal)
{
    [self dismissViewControllerAnimated:YES completion:^{
        _datePopupPickerVC = nil;
    }];
}



ON_SIGNAL3(TimePopupPickerVC, OPEN_TIME, signal)
{
    NSString  *timeString = (NSString*)signal.object;
        [self setTextIntoTextField:timeString];
    
    [self dismissViewControllerAnimated:YES completion:^{
        _timePopupPickerVC = nil;
    }];
}

ON_SIGNAL3(ActivityTypeVC, CLOSE_ACTIVITY_TYPE_VC, signal)
{
    _hobbyModel = (HobbyModel*)signal.object;
    self.type.text = _hobbyModel.name;
    [self dismissViewControllerAnimated:YES completion:^{
        _activityTypeVC = nil;
    }];
}

//ON_SIGNAL3(TimePopupPickerVC, CLOSE_TIME, signal)
//{
//    NSString  *timeString = (NSString*)signal.object;
//    _closeTimeTextField.text = timeString;
//    [self dismissViewControllerAnimated:YES completion:^{
//        _timePopupPickerVC = nil;
//    }];
//}
ON_SIGNAL3(TimePopupPickerVC, DISMISS_OPEN_TIME, signal)
{
    [self dismissViewControllerAnimated:YES completion:^{
        _timePopupPickerVC = nil;
    }];
}
-(void)setImageToTextField{
    ActivityManager *am = [ActivityManager sharedInstance];
    [am setAddPageTextFieldImage:self];
}

-(void)setPlaceHolderSytle{
    [_nameTf setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_type setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_ceilingCountTf setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_lowerLimitCountTf setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
}

-(void)clearMemory
{
    _headerVC = nil;
}

#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if(![text isEqualToString:@""]){
        _textViewPlaceHolder.hidden = YES;
    }
    if([text isEqualToString:@""] && range.location == 0 && range.length == 1){
        _textViewPlaceHolder.hidden = NO;
    }
    
    return YES;
}

#pragma mark - receive notification
ON_NOTIFICATION3(ActivityEvent, ADD_ACTIVITY_START, notification)
{
    _isAddSuccess = NO;
    [TCMessageBox showMessage:@"Adding..." hideByTouch:NO withActivityIndicator:YES];
}

ON_NOTIFICATION3(ActivityEvent, ADD_ACTIVITY_SUCCESS, notification)
{
    _activityModel = (ActivityModel*)notification.object;
    _isAddSuccess = YES;
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"添加成功 ！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

ON_NOTIFICATION3(ActivityEvent, ADD_ACTIVITY_FAILED, notification)
{
    _isAddSuccess = NO;
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器异常，请稍后添加 ！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark -
#pragma mark ImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    
    NSLog(@"info = %@",info);
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if([mediaType isEqualToString:@"public.movie"])			//被选中的是视频
    {
       
    }
    else if([mediaType isEqualToString:@"public.image"])	//被选中的是图片
    {
        //获取照片实例
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        NSString *fileName = [[NSString alloc] init];
        
        if ([info objectForKey:UIImagePickerControllerReferenceURL]) {
            fileName = [[info objectForKey:UIImagePickerControllerReferenceURL] absoluteString];
            //ReferenceURL的类型为NSURL 无法直接使用  必须用absoluteString 转换，照相机返回的没有UIImagePickerControllerReferenceURL，会报错
            
            _activityModel.imageURL = fileName ;
            
            
            fileName = [self getFileName:fileName];
        }
        else
        {
            fileName = [self timeStampAsString];
        }
        
        NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
        
        [myDefault setValue:fileName forKey:@"fileName"];
        //保存到相册
//        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//        [library writeImageToSavedPhotosAlbum:[image CGImage]
//                                  orientation:(ALAssetOrientation)[image imageOrientation]
//                              completionBlock:nil];
        
        
        [self performSelector:@selector(saveImg:) withObject:image afterDelay:0.0];
    }
    else
    {
        NSLog(@"Error media type");
        return;
    }



}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Cancle it");
//    isCamera = FALSE;
    [picker dismissModalViewControllerAnimated:YES];
    
}

#pragma mark -
#pragma mark userFunc



-(NSString *)getFileName:(NSString *)fileName
{
    NSArray *temp = [fileName componentsSeparatedByString:@"&ext="];
    NSString *suffix = [temp lastObject];
    
    temp = [[temp objectAtIndex:0] componentsSeparatedByString:@"?id="];
    
    NSString *name = [temp lastObject];
    
    name = [name stringByAppendingFormat:@".%@",suffix];
    return name;
}

-(void)saveImg:(UIImage *) image
{
    NSLog(@"Review Image");
    self.activityImgView.image = image;
}

-(NSString *)timeStampAsString
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"EEE-MMM-d"];
    NSString *locationString = [df stringFromDate:nowDate];
    return [locationString stringByAppendingFormat:@".png"];
}



- (IBAction)clickAddPicBtn:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //混合类型 photo + movie
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    [self presentModalViewController:picker animated:YES];

    
}
@end
