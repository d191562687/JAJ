//
//  UserInfoViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/12/20.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoManager.h"

@interface UserInfoViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *userimage;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *sex;
@property (strong, nonatomic) IBOutlet UILabel *birthday;
@property (strong, nonatomic) IBOutlet UILabel *user_id;

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
    self.username.text = model.USERNAME;
    self.phone.text = model.PHONE;
    self.email.text = model.EMAIL;
    self.address.text = model.ADDRESS;
    self.sex.text = model.SEX;
    self.birthday.text = model.BIRTHDAY;
    self.user_id.text = model.USER_ID;
}

@end
