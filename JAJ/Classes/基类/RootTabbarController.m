//
//  RootTabbarController.m
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "RootTabbarController.h"
#import "HomeViewController.h"
#import "TipsViewController.h"
#import "NearbyViewController.h"
#import "WoViewController.h"
#import "RootNavgationController.h"
#import "SaleRecordViewController.h"

#import "MapViewController.h"
#import "CompanyViewController.h"

@interface RootTabbarController ()

@end

@implementation RootTabbarController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroudColor;
    [self addChildViewControllers];
    
}
- (void)addChildViewControllers
{
    self.selectedIndex = 0;
    // 首页
    HomeViewController *vc1 = [HomeViewController new];
    [self addChildVC:vc1 Title:@"食药" image:@"xintiao" selectedImage:@"xintiaoX" Tag:1];
    
    // 企业信息
    CompanyViewController *vc2 = [CompanyViewController new];
    [self addChildVC:vc2 Title:@"厂家" image:@"changjia" selectedImage:@"changjiaX" Tag:1];
    
    // 附近
    NearbyViewController *vc3 = [NearbyViewController new];
    [self addChildVC:vc3 Title:@"附近" image:@"position" selectedImage:@"positionX" Tag:1];
    // 贴士
    TipsViewController *vc4 = [TipsViewController new];
    [self addChildVC:vc4 Title:@"贴士" image:@"tips" selectedImage:@"tipsX" Tag:1];
    
    // 我
    WoViewController *vc5 = [WoViewController new];
    [self addChildVC:vc5 Title:@"账户" image:@"user" selectedImage:@"userX" Tag:1];
}

#pragma mark - 添加子控制器
- (void)addChildVC:(UIViewController *)childVC Title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage Tag:(NSInteger)tag
{
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.tag = tag;

    //    childVC.tabBarItem.imag
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttres = [NSMutableDictionary dictionary];
    textAttres[NSFontAttributeName] = [UIFont systemFontOfSize:9];
    textAttres[NSForegroundColorAttributeName] = RGBACOLOR(191, 191, 191, 1);
    
    NSMutableDictionary *selectTextAttres = [NSMutableDictionary dictionary];
    selectTextAttres[NSForegroundColorAttributeName] = MainColor;
    selectTextAttres[NSFontAttributeName] = [UIFont systemFontOfSize:9];
    
    [childVC.tabBarItem setTitleTextAttributes:textAttres forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selectTextAttres forState:UIControlStateSelected];
    RootNavgationController *normalNav = [[RootNavgationController alloc]initWithRootViewController:childVC];
    [self addChildViewController:normalNav];
    
}

@end
