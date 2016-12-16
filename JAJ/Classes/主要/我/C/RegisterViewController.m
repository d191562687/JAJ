//
//  RegisterViewController.m
//  JAJ
//
//  Created by Chan_Sir on 2016/12/12.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "RegisterViewController.h"
#import "NormalTableViewCell.h"
#import "HTTPManager.h"
#import "ClearCacheTool.h"
#import <MBProgressHUD.h>
#import "AccountTool.h"
#import <MJExtension/MJExtension.h>
#import "UserInfoManager.h"


@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITextField *username;
@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UITextField *name;
@property (strong, nonatomic) UITextField *phone;
@property (strong, nonatomic) UITextField *email;
@property (strong, nonatomic) UITextField *address;
@property (strong, nonatomic) UITextField *sex;
@property (strong, nonatomic) UITextField *birthday;


@property (strong,nonatomic) UITableView *tableView;

@property (copy,nonatomic) NSArray *array;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self setupSubViews];
}

- (void)setupSubViews
{
    self.array = @[@"用户名：",@"密码：",@"昵称：",@"手机号：",@"邮箱：",@"地址：",@"性别：",@"生日："];
    [self.view addSubview:self.tableView];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    footView.backgroundColor = self.view.backgroundColor;
    footView.userInteractionEnabled = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = MainColor;
    [button setTitle:@"注  册" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 4;
    [button setFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 40)];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [self RegisterAction];
    }];
    [footView addSubview:button];
    
    self.tableView.tableFooterView = footView;
}
#pragma mark - 注册方法
- (void)RegisterAction
{
    if (self.username.text.length < 1) {
        return;
    }
    if (self.password.text.length < 1) {
        return;
    }
    if (self.name.text.length < 1) {
        return;
    }
    if (self.phone.text.length < 1) {
        return;
    }
    if (self.email.text.length < 1) {
        return;
    }
    if (self.address.text.length < 1) {
        return;
    }
    if (self.sex.text.length < 1) {
        return;
    }
    if (self.birthday.text.length < 1) {
        return;
    }
    
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    NSString *name = self.name.text;
    NSString *phone = self.phone.text;
    NSString *email = self.email.text;
    NSString *address = self.address.text;
    NSString *sex = self.sex.text;
    NSString *birthday = self.birthday.text;
    //不实现实体
    NSString * birthdaytype = @"公历";
    NSString * bz = @"HONG";
    
    //网络请求
    NSString * url = [NSString stringWithFormat:@"%@%@",ip_port,appRRegister_URL];
    
    NSDictionary *params = @{@"USERNAME":username,
                             @"PASSWORD":password,
                             @"NAME":name,
                             @"PHONE":phone,
                             @"EMAIL":email,
                             @"ADDRESS":address,
                             @"SEX":sex,
                             @"BIRTHDAY":birthday,
                             @"BIRTHDAYTYPE":birthdaytype,
                             @"BZ":bz
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"responseObject = %@",responseObject);
        NSString *code = [[responseObject objectForKey:@"code"] description];
        NSString *desc = [[responseObject objectForKey:@"desc"] description];
        
        
        if ([code isEqualToString:@"2009"]) {
            // 成功
            if (self.ReloadTableView) {
                _ReloadTableView(self.username.text,self.password.text);
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }else{
            // 不成功
            [self sendAlertAction:desc];
            
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self sendAlertAction:error.localizedDescription];
    }];
}

#pragma mark - 表格相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 用户名
        [cell.contentView addSubview:self.username];
        return cell;
    }else if (indexPath.section == 1){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 密码
        [cell.contentView addSubview:self.password];
        return cell;
    }else if (indexPath.section == 2){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 昵称
        [cell.contentView addSubview:self.name];
        return cell;
    }else if (indexPath.section == 3){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 手机号
        [cell.contentView addSubview:self.phone];
        return cell;
    }else if (indexPath.section == 4){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 邮箱
        [cell.contentView addSubview:self.email];
        return cell;
    }else if (indexPath.section == 5){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 地址
        [cell.contentView addSubview:self.address];
        return cell;
        
    }else if (indexPath.section == 6){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 性别
        [cell.contentView addSubview:self.sex];
        return cell;
    }else {
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 生日
        [cell.contentView addSubview:self.birthday];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 3;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footV = [UIView new];
    footV.backgroundColor = self.view.backgroundColor;
    return footV;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 60;
    }
    return _tableView;
}

- (UITextField *)username
{
    if (!_username) {
        _username = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH - 100, 40)];
        _username.placeholder = @"如：czc1943";
        _username.font = [UIFont systemFontOfSize:15];
        
    }
    return _username;
}

- (UITextField *)password
{
    if (!_password) {
        _password = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH - 100, 40)];
        _password.secureTextEntry = YES;
        _password.placeholder = @"······";
        _password.font = [UIFont systemFontOfSize:15];
        
    }
    return _password;
}

- (UITextField *)name
{
    if (!_name) {
        _name = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH - 100, 40)];
        _name.placeholder = @"如：周大福";
        _name.font = [UIFont systemFontOfSize:15];
        
    }
    return _name;
}

- (UITextField *)phone
{
    if (!_phone) {
        _phone = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH - 100, 40)];
        _phone.placeholder = @"如：13692839293";
        _phone.keyboardType = UIKeyboardTypeNumberPad;
        _phone.font = [UIFont systemFontOfSize:15];
        
    }
    return _phone;
}
- (UITextField *)address
{
    if (!_address) {
        _address = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH - 100, 40)];
        _address.placeholder = @"如：北京丰台";
        _address.font = [UIFont systemFontOfSize:15];
    }
    return _address;
}
- (UITextField *)email
{
    if (!_email) {
        _email = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH - 100, 40)];
        _email.placeholder = @"如：62638281@qq.com";
        _email.font = [UIFont systemFontOfSize:15];
    }
    return _email;
}

- (UITextField *)birthday
{
    if (!_birthday) {
        _birthday = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH - 100, 40)];
        _birthday.placeholder = @"如：1989.01.01";
        _birthday.font = [UIFont systemFontOfSize:15];
    }
    return _birthday;
}

- (UITextField *)sex
{
    if (!_sex) {
        _sex = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH - 100, 40)];
        _sex.placeholder = @"男";
        _sex.font = [UIFont systemFontOfSize:15];
    }
    return _sex;
}



@end
