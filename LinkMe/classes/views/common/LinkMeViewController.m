//
//  BeeUIBoradAndWhiteStatusBar.m
//  LinkMe
//
//  Created by ChaoSo on 14-10-29.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "LinkMeViewController.h"

@interface LinkMeViewController ()

@end

#define TITLE_FONT [UIFont fontWithName:@"TrebuchetMS-Bold" size:22]
@implementation LinkMeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
