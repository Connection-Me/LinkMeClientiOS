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

@interface HomeVC ()

@end

@implementation HomeVC

SUMMER_DEF_XIB(HomeVC, YES, NO)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#define COLLECTION_CELL_WIDTH (ISIPAD ? 220 : 140)
#define COLLECTION_CELL_HEIGHT (ISIPAD ? 200 : 100)
- (void)viewDidLoad
{
    [super viewDidLoad];
    //流布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(COLLECTION_CELL_WIDTH,COLLECTION_CELL_HEIGHT)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumLineSpacing:20];
    [self.mainView setCollectionViewLayout:flowLayout];
    
    //指定xib文件
    UINib *nib = [UINib nibWithNibName:@"HomeCollectionVCCell" bundle:nil];
    [self.mainView registerNib:nib forCellWithReuseIdentifier:@"HomeCollectionVCCell"];
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
    return cell;
}
#pragma mark -- UICollectionViewDataSource

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#define UI_EDGE_INSERTS_MAKE (ISIPAD ? 20 : 8)
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(UI_EDGE_INSERTS_MAKE, UI_EDGE_INSERTS_MAKE, UI_EDGE_INSERTS_MAKE, UI_EDGE_INSERTS_MAKE);
}

@end
