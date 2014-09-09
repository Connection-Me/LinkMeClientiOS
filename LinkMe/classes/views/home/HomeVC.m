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
#import "HomeEvent.h"
#import "TCMessageBox.h"
#import "CoreService.h"


@interface HomeVC ()
{
    NSArray    *activityList;
}
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation HomeVC

SUMMER_DEF_XIB(HomeVC, YES, NO)
SUPPORT_AUTOMATIC_LAYOUT(YES)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#define COLLECTION_CELL_WIDTH (ISIPAD ? 220 : 155)
#define COLLECTION_CELL_HEIGHT (ISIPAD ? 200 : 155)
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//}

#define WINDOW_BOUNDS [UIScreen mainScreen ].bounds
ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {
        [self initializeRouterObserveEvents];
        
//        //流布局
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        [flowLayout setItemSize:CGSizeMake(COLLECTION_CELL_WIDTH,COLLECTION_CELL_HEIGHT)];
//        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//        [flowLayout setMinimumLineSpacing:20];
//        [self.mainView setCollectionViewLayout:flowLayout];
        
//        [self  setAutoLayoutLocation];
//        [self.mainView setBackgroundColor:[UIColor whiteColor]];

        UINib *nib = [UINib nibWithNibName:@"HomeCollectionVCCell" bundle:nil];
        [self.mainView registerNib:nib forCellWithReuseIdentifier:@"HomeCollectionVCCell"];
        //设置title
        [self setHeaderView];
        
        //指定xib文件
        self.mainView.dataSource = self;
        self.mainView.delegate = self;
        [self startDownloadHomeActivity];
                
        
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
-(void)initializeRouterObserveEvents
{
    [self observeNotification:HomeEvent.LOAD_ACTIVITY_START];
    [self observeNotification:HomeEvent.LOAD_ACTIVITY_SUCCESS];
    [self observeNotification:HomeEvent.LOAD_ACTIVITY_FAILED];
    
}

-(void)startDownloadHomeActivity
{
    [[CoreService sharedInstance].homeRemoteService queryHomeActivity];
}

-(void)setHeaderView{
    self.headerView = [CommonHeaderView createHeaderView:self.view AndStyle:1 AndTitle:@"首 页"];
    
    
    [self.headerView.leftButton addTarget:self action:@selector(onBurger:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(activityList==nil){
        return 0;
    }
    return [activityList count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionVCCell *cell = (HomeCollectionVCCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionVCCell" forIndexPath:indexPath];
    [cell updateCell:indexPath.row];
    return cell;
}
#pragma mark -- UICollectionViewDataSource

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(void)setAutoLayoutLocation{
    
    [_mainView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_headerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
     NSMutableArray *constraints = [[NSMutableArray alloc] init];
    NSDictionary *views = NSDictionaryOfVariableBindings(_headerView, _mainView);
    if(ISIOS7){
        NSString *topView = @"V:|-20-[_headerView(==55)]";
        [constraints addObject:topView];
    }else{
        NSString *topView = @"V:|-0-[_headerView(==55)]";
        [constraints addObject:topView];
    }
    
    NSString *headerAndMain_Constraints = @"V:[_headerView]-10-[_mainView]";
    [constraints addObject:headerAndMain_Constraints];
    
    for (NSString *string in constraints) {
        [self.view addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:string
                                   options:0 metrics:nil
                                   views:views]];
    }
    
}

#pragma mark - click button
- (IBAction)onBurger:(id)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"globe"],
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"star"],
                      
                    ];
    NSArray *colors = @[
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.delegate = self;
    //    callout.showFromRight = YES;
    [callout show];
}

ON_NOTIFICATION3(HomeEvent, LOAD_ACTIVITY_START, notification)
{
    [TCMessageBox showMessage:@"Loading..." hideByTouch:NO withActivityIndicator:YES];
}
ON_NOTIFICATION3(HomeEvent, LOAD_ACTIVITY_SUCCESS, notification)
{
    [TCMessageBox hide];
    activityList = (NSArray*)notification.object;
    if(activityList==nil||[activityList count]==0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有活动列表,亲，赶紧新建一个" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];

    }
}
ON_NOTIFICATION3(HomeEvent, LOAD_ACTIVITY_FAILED, notification)
{
    [TCMessageBox hide];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载失败..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

@end
