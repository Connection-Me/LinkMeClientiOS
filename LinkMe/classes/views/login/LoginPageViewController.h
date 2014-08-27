//
//  ViewController.h
//  CollapseClick
//
//  Created by ChaoSo on 08/26/14.

//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"

@interface LoginPageViewController : UIViewController <CollapseClickDelegate,UITextFieldDelegate> {
    IBOutlet UIView *test1View;
    IBOutlet UIView *test2View;
    IBOutlet UIView *test3View;
    
    __weak IBOutlet CollapseClick *myCollapseClick;
    
    __weak IBOutlet UIImageView *galleryImage;
}
@property (weak, nonatomic) IBOutlet UITextField *loginNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *registerNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *registerPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *refindNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;


@end
