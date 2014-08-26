//
//  ViewController.m
//  CollapseClick
//
//  Created by Ben Gordon on 2/28/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import "LoginPageViewController.h"

@interface LoginPageViewController ()

@end

@implementation LoginPageViewController

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
    [myCollapseClick setFrame:CGRectMake(0, 140, myCollapseClick.frame.size.width, myCollapseClick.frame.size.height)];
    [galleryImage setFrame:CGRectMake(0,0,galleryImage.frame.size.width,GALLERY_IMAGE_HEIGHT+PULL_TOP_TO_GALLERY)];
    
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
        return [UIColor colorWithRed:200/255.0f green:242/255.0f blue:110/255.0f alpha:1.0];
    }
    if(index==1){
        return [UIColor colorWithRed:85/255.0f green:204/255.0f blue:195/255.0f alpha:1.0];
    }
    else{
        return [UIColor colorWithRed:252/255.0f green:108/255.0f blue:110/255.0f alpha:1.0];
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
#define TAG_REGISTER_NAME 20001
#define TAG_REFIND_NAME 30001
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
   
    
    if(textField.tag == TAG_LOGIN_NAME){
        [_loginPwdTextField becomeFirstResponder];
    }else{
        [_loginPwdTextField resignFirstResponder];
        
        if(textField.returnKeyType == UIReturnKeyDone){
            //TODO Login
        }
    }
    
    if(textField.tag == TAG_REGISTER_NAME){
       [_registerPwdTextField becomeFirstResponder];
    }else{
       [_registerPwdTextField resignFirstResponder];
        
        if(textField.returnKeyType == UIReturnKeyDone){
            //TODO Register
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

-(void)setTextFieldStyle{
    //登陆text
    self.loginNameTextField.layer.borderWidth = 1.0;
    self.loginNameTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.loginNameTextField.layer setCornerRadius:5];
    [self.loginNameTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    //密码 text
    self.loginPwdTextField.layer.borderWidth = 1.0;
    self.loginPwdTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.loginPwdTextField.layer setCornerRadius:5];
    [self.loginPwdTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //注册text
    self.registerNameTextField.layer.borderWidth = 1.0;
    self.loginNameTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.registerNameTextField.layer setCornerRadius:5];
    [self.registerNameTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    //注册密码 text
    self.registerPwdTextField.layer.borderWidth = 1.0;
    self.registerPwdTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.registerPwdTextField.layer setCornerRadius:5];
    [self.registerPwdTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    self.refindNameTextField.layer.borderWidth = 1.0;
    self.refindNameTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.refindNameTextField.layer setCornerRadius:5];
    [self.refindNameTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];

    
}




@end
