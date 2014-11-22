//
//  ActivityTypeVC.m
//  LinkMe
//
//  Created by Summer Wu on 14-11-21.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "ActivityTypeVC.h"
#import "summer_extend.h"
#import "HobbyService.h"
#import "HobbyModel.h"

@interface ActivityTypeVC ()
{
    NSArray        *hobbyList;
}

@end

@implementation ActivityTypeVC
SUMMER_DEF_XIB(ActivityTypeVC, YES, NO)
DEF_SIGNAL(CLOSE_ACTIVITY_TYPE_VC)

-(CGSize)sizeOfContent:(NSString *)name
{
    if (name.length == 0) {
        return CGSizeMake(0, 0);
    }
    NSMutableString *string = [NSMutableString stringWithString:name];
    return [string sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(1000, 1000) lineBreakMode:NSLineBreakByWordWrapping];  //一行宽度最大为 1000 高度1000
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBackground];
    [self setUpUI];
}

-(void)setUpBackground
{
    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    self.mainView.backgroundColor = [UIColor colorWithRed:40/255.0f green:44/255.0f blue:49/255.0f alpha:1];
    self.mainView.layer.cornerRadius = 20;
}

-(void)setUpUI
{
    HobbyService *hobbyService = [[HobbyService alloc]init];
    hobbyList = [hobbyService getHobbies];
    int i=-1;
    float x = 5,y=-40;
    NSInteger tag = 100;
//    NSInteger hobbySum = hobbyList.count-12;
//    if (hobbySum>0) {
//        self.mainView.frame.size.height = self.mainView.frame.size.height+ (hobbySum/4 + 1)*40;
//    }
    
    for (HobbyModel *hobbyModel in hobbyList) {
        i++;
        if (i%4 == 0) {
            x = 5;
            y = y + 40;
        }
        CGSize size = [self sizeOfContent:hobbyModel.name];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x+10, y+10, size.width+20, 30)];
        x = x+size.width + 20 + 10;
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        btn.backgroundColor = [UIColor blackColor];
        //btn.titleLabel.textColor = [UIColor blackColor];
        [btn setTitle:hobbyModel.name forState:UIControlStateNormal];
       // btn.titleLabel.text = hobbyModel.name;
        btn.layer.cornerRadius = 6.0;
        btn.tag = tag++;
        [btn addTarget:self action:@selector(hobbyTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:btn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)hobbyTouchUpInside:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    [self sendUISignal:self.CLOSE_ACTIVITY_TYPE_VC withObject:[hobbyList objectAtIndex:(btn.tag-100)]];
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
