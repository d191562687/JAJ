//
//  CommentViewController.m
//  JAJ
//
//  Created by 杜彪 on 2016/12/4.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "CommentViewController.h"


@interface CommentViewController ()

@property (strong, nonatomic) CWStarRateView *starRateView1;
@property (strong, nonatomic) CWStarRateView *starRateView2;
@property (strong, nonatomic) CWStarRateView *starRateView3;
@property (strong, nonatomic) CWStarRateView *starRateView4;



@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商家点评";
    
    [self initSubView];
    
}

//初始化星星
- (void)initSubView
{
    self.starRateView1 = [[CWStarRateView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4.5, SCREEN_HEIGHT / 4.7, SCREEN_WIDTH / 2.2, SCREEN_HEIGHT / 16) numberOfStars:5];
    self.starRateView1.scorePercent = 1.0;
    self.starRateView1.allowIncompleteStar = NO;
    self.starRateView1.hasAnimation = YES;
    [self.view addSubview:self.starRateView1];
    
    self.starRateView2 = [[CWStarRateView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4.5, SCREEN_HEIGHT / 3.8, SCREEN_WIDTH / 2.2, SCREEN_HEIGHT / 16) numberOfStars:5];
    self.starRateView2.scorePercent = 1.0;
    self.starRateView2.allowIncompleteStar = NO;
    self.starRateView2.hasAnimation = YES;
    [self.view addSubview:self.starRateView2];
    
    self.starRateView3 = [[CWStarRateView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4.5, SCREEN_HEIGHT / 3.1, SCREEN_WIDTH / 2.2, SCREEN_HEIGHT / 16) numberOfStars:5];
    self.starRateView3.scorePercent = 1.0;
    self.starRateView3.allowIncompleteStar = NO;
    self.starRateView3.hasAnimation = YES;
    [self.view addSubview:self.starRateView3];
    
    self.starRateView4 = [[CWStarRateView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4.5, SCREEN_HEIGHT / 2.6, SCREEN_WIDTH / 2.2, SCREEN_HEIGHT / 16) numberOfStars:5];
    self.starRateView4.scorePercent = 1.0;
    self.starRateView4.allowIncompleteStar = NO;
    self.starRateView4.hasAnimation = YES;
    [self.view addSubview:self.starRateView4];
    
}
@end
