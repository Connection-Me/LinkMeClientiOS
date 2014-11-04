//
//  HomeVC.m
//  LinkMe
//
//  Created by ChaoSo on 14-8-31.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "HomeVC.h"
#import "summer_extend.h"
#import "HomeCollectionVCCell.h"
#import "ActivityEvent.h"
#import "TCMessageBox.h"
#import "CoreService.h"
#import "MJRefresh.h"
#import "LoginVC.h"

@interface HomeVC ()
{
    NSMutableArray    *activityList;
    NSInteger    offset;
    NSInteger    limit;
    NSInteger    isAddActivity;
    BOOL    isUpRefresh;
}
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation HomeVC
DEF_SIGNAL(TEST)
DEF_SIGNAL(OPEN_CELL_DETAIL)
DEF_SINGLETON(HomeVC)
SUMMER_DEF_XIB(HomeVC, YES, NO)


#define COLLECTION_CELL_WIDTH (ISIPAD ? 220 : 155)
#define COLLECTION_CELL_HEIGHT (ISIPAD ? 200 : 155)

#define WINDOW_BOUNDS [UIScreen mainScreen ].bounds
ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {
        offset = 0;
        limit = 10;
        isAddActivity = 0;
        isUpRefresh = NO;
        activityList = [[NSMutableArray alloc]init];
        [self initializeRouterObserveEvents];
        
        [self setupCollectionView];
        [self addHeader];
        [self addFooter];
        [self startDownloadHomeActivity];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
        
    }
    else if([signal isKindOf:BeeUIBoard.LAYOUT_VIEWS])
    {
        
    }
    else if([signal isKindOf:BeeUIBoard.DELETE_VIEWS])
    {
    }
    else if ( [signal is:BeeUIBoard.WILL_APPEAR] )
	{
      
        if(isAddActivity>0)
        {
            offset = activityList.count+isAddActivity;
            limit = 10;
            [[CoreService sharedInstance].activityRemoteService queryHomeActivity:offset andLimit:limit];
            isAddActivity = 0;
        }
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

-(void)setupCollectionView{
    
    UINib *nib = [UINib nibWithNibName:@"HomeCollectionVCCell" bundle:nil];
    [self.mainView registerNib:nib forCellWithReuseIdentifier:@"HomeCollectionVCCell"];
    //设置title
   // [self setHeaderView];
    self.mainView.alwaysBounceVertical = YES;
    //指定xib文件
    self.mainView.dataSource = self;
    self.mainView.delegate = self;
}

#pragma mark - 监听事件
-(void)initializeRouterObserveEvents
{
    [self observeNotification:ActivityEvent.LOAD_ACTIVITY_START];
    [self observeNotification:ActivityEvent.LOAD_ACTIVITY_SUCCESS];
    [self observeNotification:ActivityEvent.LOAD_ACTIVITY_FAILED];
    [self observeNotification:ActivityEvent.LOAD_LOCAL_ACTIVITY];
    
    [self observeNotification:ActivityEvent.ADD_ACTIVITY_SUCCESS];
    
}

-(void)startDownloadHomeActivity
{
    [[CoreService sharedInstance].activityRemoteService queryHomeActivity:offset andLimit:limit];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   // return 4;
    if(activityList==nil){
        return 0;
    }
    return [activityList count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionVCCell *cell = (HomeCollectionVCCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionVCCell" forIndexPath:indexPath];
   // [cell updateCell:indexPath.row];
    [cell updatecellByActivityModel:[activityList objectAtIndex:indexPath.row]];

    return cell;
}
#pragma mark -- UICollectionViewDataSource

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//-(void)setAutoLayoutLocation{
//    
//    [_mainView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [_headerView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    
//     NSMutableArray *constraints = [[NSMutableArray alloc] init];
//    NSDictionary *views = NSDictionaryOfVariableBindings(_headerView, _mainView);
//    if(ISIOS7){
//        NSString *topView = @"V:|-20-[_headerView(==55)]";
//        [constraints addObject:topView];
//    }else{
//        NSString *topView = @"V:|-0-[_headerView(==55)]";
//        [constraints addObject:topView];
//    }
//    
//    NSString *headerAndMain_Constraints = @"V:[_headerView]-10-[_mainView]";
//    [constraints addObject:headerAndMain_Constraints];
//    
//    for (NSString *string in constraints) {
//        [self.view addConstraints:[NSLayoutConstraint
//                                   constraintsWithVisualFormat:string
//                                   options:0 metrics:nil
//                                   views:views]];
//    }
//    
//}
//

- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [self.mainView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        NSLog(@"刷新开始");
        //这里传给后台的值还需要和后台协商
        vc->offset = 0;
        vc->limit = vc->activityList.count;
        vc->isUpRefresh = YES;
        [vc startDownloadHomeActivity];
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.mainView reloadData];
            // 结束刷新
            [vc.mainView headerEndRefreshing];
        });
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    //[self.mainView headerBeginRefreshing];
}

- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.mainView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        NSLog(@"刷新开始");
        vc->offset = vc->activityList.count;
        vc->limit = 10;
        [vc startDownloadHomeActivity];
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.mainView reloadData];
            // 结束刷新
            [vc.mainView footerEndRefreshing];
        });
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self sendUISignal:self.OPEN_CELL_DETAIL withObject:[activityList objectAtIndex:indexPath.row]];
}


ON_NOTIFICATION3(ActivityEvent, LOAD_ACTIVITY_START, notification)
{
    [TCMessageBox showMessage:@"Loading..." hideByTouch:NO withActivityIndicator:YES];
}
ON_NOTIFICATION3(ActivityEvent, LOAD_ACTIVITY_SUCCESS, notification)
{
    [TCMessageBox hide];
    if (isUpRefresh) {
        [activityList removeAllObjects];
        [activityList addObjectsFromArray:(NSArray*)notification.object];
        isUpRefresh = NO;
    }
    else
        [activityList addObjectsFromArray:(NSArray*)notification.object];

    if(activityList==nil||[activityList count]==0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有活动列表,亲，赶紧新建一个" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    [self.mainView reloadData];
}
ON_NOTIFICATION3(ActivityEvent, LOAD_ACTIVITY_FAILED, notification)
{
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载失败..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

ON_NOTIFICATION3(ActivityEvent, LOAD_LOCAL_ACTIVITY, notification)
{
    activityList = (NSArray*)notification.object;
    
    if(activityList==nil||[activityList count]==0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有活动列表,亲，赶紧新建一个" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    [self.mainView reloadData];
}

ON_NOTIFICATION3(ActivityEvent, ADD_ACTIVITY_SUCCESS, notification)
{
    isAddActivity ++;
}

ON_SIGNAL3(HomeCollectionVCCell, TESTVC, signal)
{
    NSLog(@"sdfsdfs");
}

@end
