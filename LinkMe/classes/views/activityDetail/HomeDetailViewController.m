//
//  HomeDetailViewController.m
//  LinkMe
//
//  Created by ChaoSo on 14-9-16.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "summer_extend.h"
#import "HeaderVC.h"
#import "CommonHeaderView.h"
#import "FooterVC.h"
#import "DetailEvent.h"
#import "TCMessageBox.h"
#import "CoreService.h"
#import "ImageDownloader.h"
#import "UserModel.h"
#import "HTableViewCell.h"
#import "TimeUtil.h"
@interface HomeDetailViewController ()
{
    HeaderVC                   *_headerVC;
    FooterVC                   *_footerVC;
}
@end

@implementation HomeDetailViewController


DEF_SINGLETON(HomeDetailViewController)
DEF_SIGNAL(CLOSE_CELL_DETAIL)

SUMMER_DEF_XIB(HomeDetailViewController,YES, NO)

ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {
        //load 数据
      //  [self loadDetailData];
        [self initializeObserveEvents];
        //设置 头导航栏
        [self setupHeader];
//        [self drawLineInPage];
        [self setupAcitityView];

        [self.approveUserList setBackgroundColor:[UIColor clearColor]];
        
        
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

#pragma mark - 监听事件
-(void)initializeObserveEvents
{
    [self observeNotification:DetailEvent.LOAD_DETAIL_ACTIVITY_START];
    [self observeNotification:DetailEvent.LOAD_DETAIL_ACTIVITY_SUCCESS];
    [self observeNotification:DetailEvent.LOAD_DETAIL_ACTIVITY_FAILED];
    
}

-(void)loadDetailData
{
    [[CoreService sharedInstance].detailRemoteService queryDetailActivityByActivityId:_sampleActivityModel.activityId];
}

#pragma mark header界面
-(void)setupHeader
{
//    _headerVC = [HeaderVC sharedInstance];
    __block HomeDetailViewController *homeDetailVC = self;
   
    CommonHeaderView *commonHeaderView= [CommonHeaderView createHeader:self.view WithTitle:@"活动详细" LeftButtonType:CommonHeaderBack RightButtonType:CommonHeaderNone  ];
    [commonHeaderView setLeftButtonBlock:^(){
        [homeDetailVC sendUISignal:homeDetailVC.CLOSE_CELL_DETAIL withObject:nil];
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


-(void)setupAcitityView{
    [_activityView removeAllSubviews];
    
    [_activityView setBackgroundColor:[UIColor colorWithRed:253/255.f green:253/255.f blue:253/255.f alpha:0.9]];
    
    //加圆角
    _activityView.layer.cornerRadius = 10;
    //加阴影
    _activityView.layer.shadowColor = [UIColor blackColor].CGColor;
    _activityView.layer.shadowOffset = CGSizeMake(0, 0);
    _activityView.layer.shadowOpacity = 0.5;
    _activityView.layer.shadowRadius = 10.0;
    _activityView.layer.masksToBounds = NO;
    
    UIView *activityHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _activityView.frame.size.width, 42)];
    
    
    [activityHeader setBackgroundColor:[UIColor colorWithRed:24/255.f green:140/255.f blue:209/255.f alpha:0.9]];

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:activityHeader.bounds byRoundingCorners:  UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = activityHeader.bounds;
    maskLayer.path = maskPath.CGPath;
    activityHeader.layer.mask = maskLayer;
    
    //TODO roundAvatar
    
    
    UILabel *timeDis = [[UILabel alloc] initWithFrame:CGRectMake(activityHeader.frame.size.width/3*2, 0, activityHeader.frame.size.width/3, activityHeader.frame.size.height)];
    timeDis.text = @"2010.06.15";
    timeDis.font = AD_FONT(20, 10);
    timeDis.textColor = [UIColor whiteColor];
    [activityHeader addSubview:timeDis];
    
    [_activityView addSubview:activityHeader];
    
}



-(UIView *)drawViewLineX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andLength:(CGFloat)length{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, y, width,length)];
    [line setBackgroundColor:[UIColor whiteColor]];
    return line;
}


-(void)drawLineInView:(UIView *)superView WithX:(CGFloat)X WithY:(CGFloat)Y {
    
    
    UIView *line1 = [self drawViewLineX:X andY:Y andWidth:2 andLength:superView.frame.size.height];
    
    line1.layer.masksToBounds = YES;
    line1.layer.cornerRadius = 10.0;
    
    [superView addSubview:line1];
}
#define DEFAULT_LINE_X 50
#define DEFAULT_LINE_Y 0
-(void)drawLineInView:(UIView *)superView{
    [self drawLineInView:superView WithX:DEFAULT_LINE_X WithY:DEFAULT_LINE_Y];
}

-(void)drawLineInUserView{
    [self drawLineInView:_insertUserView];
}
-(void)drawLineInInformationView{
    [self drawLineInView:_informationView];
}

-(void)drawLineInPage{
    [self drawLineInUserView];
    [self drawLineInInformationView];
    
}

-(void)setUI
{
    ImageDownloader * imageDownloader = [[ImageDownloader alloc]init];
    for (int i=0; i<_detailActivityModel.approveList.count&&i<4; i++) {
        UserModel *userModel = [_detailActivityModel.approveList objectAtIndex:i];
        UIImageView  *userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*45, 0, 42, 42)];
        [imageDownloader startDownloadImage:userModel.profile andLoadImage:^(id data) {
            userImageView.image = data;
        }];
    }
}


ON_NOTIFICATION3(DetailEvent, LOAD_DETAIL_ACTIVITY_START, notification)
{
    [TCMessageBox showMessage:@"Loading..." hideByTouch:NO withActivityIndicator:YES];
}
ON_NOTIFICATION3(DetailEvent, LOAD_DETAIL_ACTIVITY_SUCCESS, notification)
{
    [TCMessageBox hide];
    _detailActivityModel= (ActivityModel*)notification.object;
    [self setUI];
}
ON_NOTIFICATION3(DetailEvent, LOAD_DETAIL_ACTIVITY_FAILED, notification)
{
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载失败..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}


#pragma mark - TableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UIView *view = [self getTableViewCellWithDef:@"HTableViewCell" WithTableView:tableView];
    HTableViewCell *cell = (HTableViewCell *)view;
    
    NSInteger index = indexPath.row;
    [cell updateCell:[self.sampleActivityModel.approveList objectAtIndex:index]];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    return [self.sampleActivityModel.approveList count];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f; 
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(UITableViewCell *)getTableViewCellWithDef:(NSString*)nibName WithTableView:(UITableView *)tableView {
    
    NSString *CustomCellIdentifier = nibName;
    HTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    //cell
    if (cell == nil){
        //类名
        UINib *nib = [UINib nibWithNibName:CustomCellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    }
    return cell;
}

#pragma mark - setDataInUserInformation

-(void)insertDataToSampleActivityView{
    if(self.sampleActivityModel == nil){
        NSLog(@"activity is nil ");
        return;
    }
    self.activityStartDateLabel.text = [TimeUtil stringFromDate:self.sampleActivityModel.openTime];
    self.activityEndingDateLabel.text = [TimeUtil stringFromDate:self.sampleActivityModel.closeTime];
    self.activityLessPeopleLabel.text = [NSString stringWithFormat:@"%d",self.sampleActivityModel.lowerLimit];
    self.activityCompareCurrentyTime.text = [TimeUtil compareCurrentTime:[NSDate date]];
    self.activityImageView.image = [UIImage imageNamed:self.sampleActivityModel.imageURL];
}

-(void)insertUserInfo{
    //TODO sampleActivityModel add userInfo
    
}





@end
