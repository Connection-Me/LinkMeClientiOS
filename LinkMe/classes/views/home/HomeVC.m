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
#import "CommonHeaderView.h"
@interface HomeVC ()

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

ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {

//        //流布局
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        [flowLayout setItemSize:CGSizeMake(COLLECTION_CELL_WIDTH,COLLECTION_CELL_HEIGHT)];
//        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//        [flowLayout setMinimumLineSpacing:20];
//        [self.mainView setCollectionViewLayout:flowLayout];
        
//        [self  setAutoLayoutLocation];
//        [self.mainView setBackgroundColor:[UIColor whiteColor]];
        //指定xib文件
        self.mainView.dataSource = self;
        self.mainView.delegate = self;
        UINib *nib = [UINib nibWithNibName:@"HomeCollectionVCCell" bundle:nil];
        [self.mainView registerNib:nib forCellWithReuseIdentifier:@"HomeCollectionVCCell"];
        
        //设置title
        [self setHeaderView];

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
-(void)setHeaderView{
    [CommonHeaderView createHeaderView:self.view AndStyle:1 AndTitle:@"首页"];
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
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


@end
