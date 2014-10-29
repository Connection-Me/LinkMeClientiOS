//
//  ViewController.m
//  CollapseClick
//
//  Created by ChaoSo on 08/26/14.

//

#import "LoginPageViewController.h"
#import "summer_extend.h"
#import "CoreService.h"
#import "CoreModel.h"
@interface LoginPageViewController ()

@end

@implementation LoginPageViewController
SUMMER_DEF_XIB(LoginPageViewController, YES, NO)

#define PULL_TOP_TO_GALLERY 110
#define GALLERY_IMAGE_HEIGHT (ISIPHONE5 ? 230:140)
- (void)viewDidLoad
{
    [super viewDidLoad];
    myCollapseClick.CollapseClickDelegate = self;
    [myCollapseClick reloadCollapseClick];
    
    // If you want a cell open on load, run this method:
    [myCollapseClick openCollapseClickCellAtIndex:0 animated:NO];
    [myCollapseClick setFrame:CGRectMake(0, GALLERY_IMAGE_HEIGHT, myCollapseClick.frame.size.width, myCollapseClick.frame.size.height)];
    [galleryImage setFrame:CGRectMake(galleryImage.frame.origin.x
                                      , galleryImage.frame.origin.x
                                      , galleryImage.frame.size.width
                                      , GALLERY_IMAGE_HEIGHT)];
    [galleryImage setImage:[UIImage imageNamed:@"galleryImage.jpg"]];
    
    [self setTextFieldStyle];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
 
    

    
}
-(void)keyboardWillShow:(int)index{
    
    [myCollapseClick setFrame:CGRectMake(0, GALLERY_IMAGE_HEIGHT-PULL_TOP_TO_GALLERY, myCollapseClick.frame.size.width, myCollapseClick.frame.size.height)];
    [galleryImage setFrame:CGRectMake(0,0,galleryImage.frame.size.width,GALLERY_IMAGE_HEIGHT-PULL_TOP_TO_GALLERY)];
    
}
-(void)keyboardWillHide:(int)index{
    NSLog(@"GALLERY_IMAGE_HEIGHT  === %d",GALLERY_IMAGE_HEIGHT+PULL_TOP_TO_GALLERY);
    [myCollapseClick setFrame:CGRectMake(0, GALLERY_IMAGE_HEIGHT, myCollapseClick.frame.size.width, myCollapseClick.frame.size.height)];
    [galleryImage setFrame:CGRectMake(0,0,galleryImage.frame.size.width,GALLERY_IMAGE_HEIGHT)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Collapse Click Delegate

// Required Methods
-(int)numberOfCellsForCollapseClick {
    return 3;
}

-(NSString *)titleForCollapseClickAtIndex:(int)index {
    switch (index) {
        case 0:
            return @"登陆";
            break;
        case 1:
            return @"注册";
            break;
        case 2:
            return @"找回密码";
            break;
            
        default:
            return @"";
            break;
    }
}

-(UIView *)viewForCollapseClickContentViewAtIndex:(int)index {
    switch (index) {
        case 0:
            return test1View;
            break;
        case 1:
            return test2View;
            break;
        case 2:
            return test3View;
            break;
            
        default:
            return test1View;
            break;
    }
}


// Optional Methods

-(UIColor *)colorForCollapseClickTitleViewAtIndex:(int)index {
    
    if(index==0){
        return COLOR_LIGHT_GRAY;
    }
    if(index==1){
        return COLOR_LIGHT_YELLOW;
    }
    else{
        return COLOR_LIGHT_RED;
    }
}


-(UIColor *)colorForTitleLabelAtIndex:(int)index {
    return [UIColor colorWithWhite:1.0 alpha:0.85];
}

-(UIColor *)colorForTitleArrowAtIndex:(int)index {
    return [UIColor colorWithWhite:0.0 alpha:0.25];
}

-(void)didClickCollapseClickCellAtIndex:(int)index isNowOpen:(BOOL)open {
    NSLog(@"%d and it's open:%@", index, (open ? @"YES" : @"NO"));
    if(open==NO){
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }
}


#pragma mark - TextField Delegate for Demo
#define TAG_LOGIN_NAME 10001
#define TAG_LOGIN_PWD 10002
#define TAG_REGISTER_NAME 20001
#define TAG_REGISTER_PWD 20002
#define TAG_REFIND_NAME 30001
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.tag == TAG_LOGIN_NAME){
        [_loginPwdTextField becomeFirstResponder];
    }else if(textField.tag == TAG_LOGIN_PWD){
        [_loginPwdTextField resignFirstResponder];
        
        if(textField.returnKeyType == UIReturnKeyDone){
            //TODO Login  登录功能
            NSString *loginName = _loginNameTextField.text;
            NSString *loginPwd = _loginPwdTextField.text;
            [self loginEventUserName:loginName pwd:loginPwd];
        }
    }
    
    if(textField.tag == TAG_REGISTER_NAME){
       [_registerPwdTextField becomeFirstResponder];
    }else if(textField.tag == TAG_REGISTER_PWD){
       [_registerPwdTextField resignFirstResponder];
        
        if(textField.returnKeyType == UIReturnKeyDone){
            //TODO Register  注册功能
            NSString *registerName = _registerNameTextField.text;
            NSString *registerPwd = _registerPwdTextField.text;
            [self registerEventUserName:registerName pwd:registerPwd];
        }
    }
    if(textField.tag == TAG_REGISTER_NAME){
//        [_registerPwdTextField becomeFirstResponder];
    }else{
//        [_registerPwdTextField resignFirstResponder];
        
        if(textField.returnKeyType == UIReturnKeyDone){
            //TODO Refind
        }
    }
    return YES;
}

-(void)assembleRegisterText{
    //注册text
    [self.registerNameTextField
     setBackgroundColor:
     COLOR_COMPONENT_BACKGROUND];
    [self.registerNameTextField.layer setCornerRadius:5];
    [self.registerNameTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //注册密码 text
//    self.registerPwdTextField.layer.borderWidth = 1.0;
//    self.registerPwdTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    
    [self.registerPwdTextField
     setBackgroundColor:
     COLOR_COMPONENT_BACKGROUND];
    [self.registerPwdTextField.layer setCornerRadius:5];
    [self.registerPwdTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark - 装配页面组件
-(void)assembleLoginText{
    //登陆text
    [self.loginNameTextField
     setBackgroundColor:
     COLOR_COMPONENT_BACKGROUND];
    [self.loginNameTextField.layer setCornerRadius:5];
    [self.loginNameTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    //密码 text
    [self.loginPwdTextField
     setBackgroundColor:
     COLOR_COMPONENT_BACKGROUND];
    [self.loginPwdTextField.layer setCornerRadius:5];
    [self.loginPwdTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
}

-(void)assembleRefindText{
    [self.refindNameTextField
     setBackgroundColor:
     COLOR_COMPONENT_BACKGROUND];
    [self.refindNameTextField.layer setCornerRadius:5];
    [self.refindNameTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
}

-(void)setTextFieldStyle{
    [self assembleLoginText];
    [self assembleRefindText];
    [self assembleRegisterText];
}


#pragma mark - 页面事件
-(void)loginEventUserName:(NSString *)name pwd:(NSString *)pwd{
    [[CoreService sharedInstance].userRemoteService queryLoginByUsername:name andPassWord:pwd andController:CONTROLLER_NAME andMethodName:METHOD_NAME];
}
-(void)registerEventUserName:(NSString *)name pwd:(NSString *)pwd{
    [[CoreService sharedInstance].userRemoteService queryRegisterByUserName:name andPassWord:pwd andController:CONTROLLER_NAME andMethodName:REGISTER_METHOD_NAME];
}
-(void)refindListeningUserName:(NSString *)name{
    //TODO to do refind service
    
}


- (IBAction)clickRegisterBtn:(id)sender {
    NSString *registerName = _registerNameTextField.text;
    NSString *registerPwd = _registerPwdTextField.text;
    [self registerEventUserName:registerName pwd:registerPwd];
}
@end
