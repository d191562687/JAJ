//
//  RootNavgationController.m
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "RootNavgationController.h"

@interface RootNavgationController ()

@end

@implementation RootNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setTranslucent:NO]; // 清除默认的半透明颜色
    [bar setBarTintColor:NavColor];
    [bar setBarStyle:UIBarStyleBlackTranslucent];
    [bar setTintColor:[UIColor whiteColor]];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
}

@end
