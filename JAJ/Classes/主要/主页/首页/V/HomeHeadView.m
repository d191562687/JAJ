//
//  HomeHeadView.m
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "HomeHeadView.h"
#import "SDCycleScrollView.h"
#import "HomeCollectionView.h"



@implementation HomeHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    self.backgroundColor = BackGroudColor;
    
    NSURL *url1 = [NSURL URLWithString:@"http://pic.qiantucdn.com/58pic/15/40/94/06x58PICaEG_1024.jpg"];
    NSURL *url2 = [NSURL URLWithString:@"http://img52.zyzhan.com/9/20160313/635934656165260525743.jpg"];

    NSArray *iconArr = @[url2,url1,url2,url1];
    // 添加滚动栏
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - 64) * 0.55 * 0.5) imageURLsGroup:iconArr];
    cycleScrollView.autoScrollTimeInterval = 3;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [self addSubview:cycleScrollView];
    
    // 添加6表格
    HomeCollectionView *collectionV = [[HomeCollectionView alloc]initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - 64) * 0.55 * 0.5, SCREEN_WIDTH, (SCREEN_HEIGHT - 64) * 0.55 * 0.5)];
    collectionV.DidSelectBlock = ^(NSIndexPath *indexPath){
        if (self.SelectBlock) {
            _SelectBlock(indexPath);
        }
    };
    [self addSubview:collectionV];
    
}

@end
