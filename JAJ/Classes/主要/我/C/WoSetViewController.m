//
//  WoSetViewController.m
//  JAJ
//
//  Created by 金安健 on 2017/1/12.
//  Copyright © 2017年 JinAnJian. All rights reserved.
//

#import "WoSetViewController.h"

@interface WoSetViewController ()

@end

@implementation WoSetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    
    // 1.1
    ZFSettingItem *item1 = [ZFSettingItem itemWithIcon:nil title:@"接收新消息通知" type:ZFSettingItemTypeNone];
    //开关事件
    item1.switchBlock = ^(BOOL on) {
        NSLog(@"接收新消息通知%zd",on);
    };
    
    // 1.2
    ZFSettingItem *item2 = [ZFSettingItem itemWithIcon:nil title:@"通知显示消息详情" type:ZFSettingItemTypeSwitch];
    item2.switchBlock = ^(BOOL on) {
        NSLog(@"通知显示消息详情%zd",on);
    };
    
    // 1.3
    ZFSettingItem *item3 = [ZFSettingItem itemWithIcon:nil title:@"功能消息免打扰" type:ZFSettingItemTypeArrow];
    item3.switchBlock = ^(BOOL on) {
        NSLog(@"功能消息免打扰%zd",on);
    };
    
    // 1.4
    ZFSettingItem *item4 = [ZFSettingItem itemWithIcon:nil title:@"声音" type:ZFSettingItemTypeSwitch];
    item4.switchBlock = ^(BOOL on) {
        NSLog(@"声音%zd",on);
    };
    
    // 1.5
    ZFSettingItem *item5 = [ZFSettingItem itemWithIcon:nil title:@"振动" type:ZFSettingItemTypeSwitch];
    item5.switchBlock = ^(BOOL on) {
        NSLog(@"振动%zd",on);
    };
    
    // 1.6
    ZFSettingItem *item6 = [ZFSettingItem itemWithIcon:nil title:@"清除缓存" type:ZFSettingItemTypeNone];
    item6.switchBlock = ^(BOOL on) {
        NSLog(@"清除缓存%zd",on);
    };
    
    ZFSettingGroup *group1 = [[ZFSettingGroup alloc] init];
    group1.items = @[item1];
    group1.footer = @"如果你要关闭或者开启金安健的新消息通知，请在iPhone的“设置”-“通知”功能中，找到应用程序“金安健”更改";
    [_allGroups addObject:group1];
    
    ZFSettingGroup *group2 = [[ZFSettingGroup alloc] init];
    group2.items = @[item2];
    group2.footer = @"关闭后，当收到金安健消息时，通知提示将不显示内容摘要";
    [_allGroups addObject:group2];
    
    ZFSettingGroup *group3 = [[ZFSettingGroup alloc] init];
    group3.items = @[item3];
    group3.footer = @"设置系统功能消息提示声音和振动的时段";
    [_allGroups addObject:group3];
    
    ZFSettingGroup *group4 = [[ZFSettingGroup alloc] init];
    group4.items = @[item4,item5];
    group4.footer = @"当金安健运行时，你可以设置是否需要声音或振动";
    [_allGroups addObject:group4];
    
    ZFSettingGroup *group5 = [[ZFSettingGroup alloc] init];
    group5.items = @[item6];
    group5.footer = @"清除缓存";
    [_allGroups addObject:group5];
    
}

@end
