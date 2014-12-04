//
//  PersonalSettingVC.m
//  LinkMe
//
//  Created by ChaoSo on 14-11-29.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "PersonalSettingVC.h"
#import "summer_extend.h"
#import "HeaderVC.h"
@interface PersonalSettingVC (){
    HeaderVC  *_headerVC;
}

@end

@implementation PersonalSettingVC
SUMMER_DEF_XIB(PersonalSettingVC, YES, NO)
DEF_SIGNAL(CLOSE_PERSONAL_VC)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupHeader];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupHeader
{
    //    _headerVC = [HeaderVC sharedInstance];
    __block PersonalSettingVC *personalSetting = self;
    
    CommonHeaderView *commonHeaderView= [CommonHeaderView createHeader:self.view WithTitle:@"个人资料" LeftButtonType:CommonHeaderBack RightButtonType:CommonHeaderNone  ];
    [commonHeaderView setLeftButtonBlock:^(){
        [personalSetting sendUISignal:personalSetting.CLOSE_PERSONAL_VC withObject:nil];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
