//
//  AppCommendVC.m
//  LinkMe
//
//  Created by Summer Wu on 14-11-21.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "AppCommendVC.h"
#import "CommonHeaderView.h"
#import "summer_extend.h"
#import "CoreService.h"
#import "CommendEvent.h"
#import "TCMessageBox.h"
#import "AppCommendCollectionViewCell.h"

#import "MJRefresh.h"

@interface AppCommendVC ()
{
    NSInteger         _offset;
    NSInteger         _limit;
    
    NSMutableArray    *_userArray;
    BOOL              _isAllRefresh;

}

@end

@implementation AppCommendVC

DEF_SIGNAL(CLOSE_APPCOMMENDVC)
SUMMER_DEF_XIB(AppCommendVC, YES, NO);
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self observeNotifications];
    [self setupCollectionView];
    [self setupHeader];
    [self addHeader];
    [self addFooter];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)initData
{
    _offset = 1;
    _limit = 10;
    _isAllRefresh = NO;
    _userArray = [[NSMutableArray alloc]init];
}
-(void)observeNotifications
{
    [self observeNotification:CommendEvent.LOAD_APP_COMMEND_START];
    [self observeNotification:CommendEvent.LOAD_APP_COMMEND_SUCCESS];
    [self observeNotification:CommendEvent.LOAD_APP_COMMEND_FAILED];
}

-(void)setupCollectionView{
    
    UINib *nib = [UINib nibWithNibName:@"AppCommendCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"AppCommendCollectionViewCell"];
    //设置title
    // [self setHeaderView];
    self.collectionView.alwaysBounceVertical = YES;
    //指定xib文件
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // return 4;
    if(_userArray==nil){
        return 0;
    }
    return [_userArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppCommendCollectionViewCell *cell = (AppCommendCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"AppCommendCollectionViewCell" forIndexPath:indexPath];
    // [cell updateCell:indexPath.row];
    [cell updateCellByUser:[_userArray objectAtIndex:indexPath.row]];
    return cell;
}
#pragma mark -- UICollectionViewDataSource

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark header界面
-(void)setupHeader
{
    //    _headerVC = [HeaderVC sharedInstance];
    __block AppCommendVC *appCommendVC = self;
    
    CommonHeaderView *commonHeaderView= [CommonHeaderView createHeader:self.view WithTitle:@"App好友推荐" LeftButtonType:CommonHeaderBack RightButtonType:CommonHeaderInvite];
    [commonHeaderView setLeftButtonBlock:^(){
        [appCommendVC sendUISignal:appCommendVC.CLOSE_APPCOMMENDVC withObject:nil];
    }];
    
    [commonHeaderView setRightButtonBlock:^(){
        [appCommendVC inviteFriends];
    }];
}

-(void)inviteFriends
{
    
}


- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [self.collectionView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        NSLog(@"刷新开始");
        //这里传给后台的值还需要和后台协商
        vc->_offset = 1;
        vc->_limit = vc->_userArray.count;
        if(vc->_limit == 0)
        {
            vc->_limit = 10;
        }
        vc->_isAllRefresh = YES;
        [vc startQueryCommendUsers];
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.collectionView reloadData];
            // 结束刷新
            [vc.collectionView headerEndRefreshing];
        });
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    //[self.mainView headerBeginRefreshing];
}

- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.collectionView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        NSLog(@"刷新开始");
        vc->_offset = vc->_userArray.count;
        vc->_limit = 10;
        [vc startQueryCommendUsers];
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.collectionView reloadData];
            // 结束刷新
            [vc.collectionView footerEndRefreshing];
        });
    }];
}

-(void)loadData
{
    [self startQueryCommendUsers];
}

-(void)startQueryCommendUsers
{
    //todo:因为还没有用户兴趣设置,设置为0代表不限兴趣
    _hobbyModel.hid = 0;
    [[CoreService sharedInstance].commendRemoteService queryCommendUsersBy:_hobbyModel andOffset:_offset andLimit:_limit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

ON_NOTIFICATION3(CommendEvent, LOAD_APP_COMMEND_START, notification)
{
    [TCMessageBox showMessage:@"正在为您推荐..." hideByTouch:NO withActivityIndicator:YES];
}

ON_NOTIFICATION3(CommendEvent, LOAD_APP_COMMEND_SUCCESS, notification)
{
    [TCMessageBox hide];
    [TCMessageBox hide];
    if (_isAllRefresh) {
        [_userArray removeAllObjects];
        [_userArray addObjectsFromArray:(NSArray*)notification.object];
        _isAllRefresh = NO;
    }
    else
        [_userArray addObjectsFromArray:(NSArray*)notification.object];
    if(_userArray==nil||[_userArray count]==0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有活动列表,亲，赶紧新建一个" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    [self.collectionView reloadData];
}

ON_NOTIFICATION3(CommendEvent, LOAD_APP_COMMEND_FAILED, notification)
{
    [TCMessageBox hide];
}

@end
