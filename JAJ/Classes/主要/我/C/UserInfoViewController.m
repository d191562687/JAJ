//
//  UserInfoViewController.m
//  JAJ
//
//  Created by Chan_Sir on 2016/11/29.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoManager.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}

- (void)setupSubViews
{
    UserModel *model = [UserInfoManager getUserInfo];
    self.title = model.NAME.length >= 1 ? model.NAME : @"用户信息";
    
}

@end
