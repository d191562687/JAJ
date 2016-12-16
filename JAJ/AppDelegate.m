//
//  AppDelegate.m
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "AppDelegate.h"
#import "RootNavgationController.h"
#import "RootTabbarController.h"
#import <IQKeyboardManager.h>
#import <AMapFoundationKit/AMapFoundationKit.h>


@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setRootViewController];
 //   [self setupThirdSDK];
    
    return YES;
}

/**
 设置跟控制器
 */
- (void)setRootViewController
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    RootTabbarController *loginVC = [[RootTabbarController alloc] init];
    self.window.rootViewController = loginVC;
    [self.window makeKeyAndVisible];
}

/**
 初始化第三方SDK
 */
- (void)setupThirdSDK
{
    // 高德地图
    [self configureAPIKey];
    
    
}
/** 高德地图 */
- (void)configureAPIKey{
    
    if ([MapSecret length] == 0)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"apiKey为空，请检查key是否正确设置" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        
    }
    
    [AMapServices sharedServices].apiKey = MapSecret;

    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
