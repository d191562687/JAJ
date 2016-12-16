//
//  HomeCollectionView.m
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "HomeCollectionView.h"
#import "NormalCollectionViewCell.h"

@interface HomeCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (strong,nonatomic) UICollectionView *collectionView;

@end

static NSInteger const cols = 3;
static CGFloat const margin = 2;

@implementation HomeCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}
#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}


#pragma mark 每个UICollectionViewCell展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *titleArr = @[@"四品一械查询",@"地图定位",@"企业查询",@"四品一械追溯",@"云助手",@"集采活动"];
    NSArray *iconArr = @[@"query_normal",@"map_normal",@"factory_normal",@"query_normal",@"factory_normal",@"tips_normal"];
    
    NormalCollectionViewCell *cell = [NormalCollectionViewCell sharedNormalCell:collectionView IndexPath:indexPath];
    cell.iconName = iconArr[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.title = titleArr[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_DidSelectBlock) {
        _DidSelectBlock(indexPath);
    }
}

- (void)reloadData
{
    [self.collectionView reloadData];
}


- (UICollectionView *)collectionView{
    CGFloat cellW = (SCREEN_WIDTH - 2 * margin)/cols;
    CGFloat cellH = cellW;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(cellW,cellH/1.51);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        //让collectionView滚动
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = self.backgroundColor;
        [_collectionView registerClass:[NormalCollectionViewCell class] forCellWithReuseIdentifier:@"NormalCollectionViewCell"];
        
    }
    
    return _collectionView;
    
}



@end
