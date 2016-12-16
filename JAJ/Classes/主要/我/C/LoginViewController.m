//
//  LoginViewController.m
//  JAJ
//
//  Created by Chan_Sir on 2016/11/29.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "LoginViewController.h"
#import <Masonry.h>
#import "ClearCacheTool.h"
#import <MJExtension/MJExtension.h>
#import "RegisterViewController.h"
#import "AccountTool.h"
#import "UserInfoManager.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UIButton *clickButton;
}
/** 菊花圈 */
@property (nonatomic, strong) UIActivityIndicatorView *indicatorV;
/** 头像 */
@property (strong,nonatomic) UIImageView *headImageV;
/** 账号 */
@property (strong,nonatomic) UITextField *accountField;
/** 密码 */
@property (strong,nonatomic) UITextField *passField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self setupSubViews];
}
- (void)setupSubViews
{
    
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cm2_fm_bg"]];
    backImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    backImage.userInteractionEnabled = YES;
    [self.view addSubview:backImage];
    
    self.headImageV = [[UIImageView alloc]init];
    self.headImageV.image = [UIImage imageNamed:@"user_place"];
    [backImage addSubview:self.headImageV];
    self.headImageV.layer.masksToBounds = YES;
    self.headImageV.layer.cornerRadius = 45;
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backImage.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(95*CKproportion);
        make.width.equalTo(@90);
        make.height.equalTo(@90);
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"leftbar_cancle"] forState:UIControlStateNormal];
    [backBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    [backBtn setFrame:CGRectMake(18, 30, 35, 35)];
    [backImage addSubview:backBtn];
    
    self.accountField = [[UITextField alloc]init];
    self.accountField.delegate = self;
    self.accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.accountField.borderStyle = UITextBorderStyleNone;
    self.accountField.background = [UIImage imageNamed:@"userImage"];
    self.accountField.textAlignment = NSTextAlignmentCenter;
    self.accountField.placeholder = @"账户名";
    self.accountField.tag = 43;
    self.accountField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.accountField.keyboardType = UIKeyboardTypeEmailAddress;
    self.accountField.textColor = [UIColor whiteColor];
    self.accountField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.accountField.placeholder attributes:@{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.accountField.attributedText = [[NSAttributedString alloc]initWithString:self.accountField.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    [backImage addSubview:self.accountField];
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageV.mas_bottom).offset(50*CKproportion);
        make.left.equalTo(backImage.mas_left).offset(40);
        make.right.equalTo(backImage.mas_right).offset(-40);
        make.height.equalTo(@40);
    }];
    
    self.passField = [[UITextField alloc]init];
    self.passField.delegate = self;
    self.passField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passField.borderStyle = UITextBorderStyleNone;
    self.passField.background = [UIImage imageNamed:@"passworkImage"];
    self.passField.textAlignment = NSTextAlignmentCenter;
    self.passField.placeholder = @"账户密码";
    self.passField.secureTextEntry = YES;
    self.passField.tag = 44;
    self.passField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.passField.textColor = [UIColor whiteColor];
    self.passField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.passField.placeholder attributes:@{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.passField.attributedText = [[NSAttributedString alloc]initWithString:self.passField.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    [backImage addSubview:self.passField];
    [self.passField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountField.mas_bottom).offset(10);
        make.left.equalTo(backImage.mas_left).offset(40);
        make.right.equalTo(backImage.mas_right).offset(-40);
        make.height.equalTo(@40);
    }];
    
    Account *account = [AccountTool account];
    if (account) {
        self.accountField.text = account.username;
        self.passField.text = account.password;
    }
    
    clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickButton setTitle:@"登  录" forState:UIControlStateNormal];
    [clickButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    clickButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [clickButton addTarget:self action:@selector(loginSuccess) forControlEvents:UIControlEventTouchUpInside];
    clickButton.layer.masksToBounds = YES;
    clickButton.layer.cornerRadius = 4;
    clickButton.backgroundColor = MainColor;
    [backImage addSubview:clickButton];
    [clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backImage.mas_left).offset(40);
        make.right.equalTo(backImage.mas_right).offset(-40);
        make.height.equalTo(@40);
        make.top.equalTo(self.passField.mas_bottom).offset(50*CKproportion);
    }];
    
    // 26 180 8
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setTitle:@"一键注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitleColor:MainColor forState:UIControlStateNormal];
    registerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    registerButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [backImage addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backImage.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        make.height.equalTo(@21);
    }];
    
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetButton addTarget:self action:@selector(forgetPassAction) forControlEvents:UIControlEventTouchUpInside];
    [forgetButton setTitleColor:MainColor forState:UIControlStateNormal];
    forgetButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [backImage addSubview:forgetButton];
    [forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backImage.mas_left).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        make.height.equalTo(@21);
    }];
    
    
    UserModel *model = [UserInfoManager getUserInfo];
    self.accountField.text = model.USERNAME;
    self.passField.text = @"";
}
#pragma mark - 登录注册
- (void)loginSuccess
{
    
    if (self.accountField.text.length < 1) {
        [self showErrorTips:@"请输入账号"];
        return;
    }
    if (self.passField.text.length < 1) {
        [self showErrorTips:@"密码不能为空"];
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,Login_URL];
    
    NSDictionary *params = @{
                             @"USERNAME":self.accountField.text,
                             @"PASSWORD" :self.passField.text
                             };
    NSDictionary *json = @{@"json":[self switchToJsonStrFrom:params]};
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        NSString *code = [[responseObject objectForKey:@"code"] description];
        NSString *message = [[responseObject objectForKey:@"desc"] description];
        if ([code isEqualToString:@"0000"]) {
            // 存储数据
            NSDictionary *data = [responseObject objectForKey:@"data"];
            [self saveUserInfo:data Complete:^{
                
                if (self.ReloadTableView) {
                    _ReloadTableView();
                }
                
                CATransition *animation = [CATransition animation];
                animation.duration = 0.5;
                animation.timingFunction = UIViewAnimationCurveEaseInOut;
                animation.type = @"cube";
                animation.subtype = kCATransitionFromBottom;
                [self.view.window.layer addAnimation:animation forKey:nil];
                [self.navigationController dismissViewControllerAnimated:NO completion:nil];
            }];
            
        }else{
            [self sendAlertAction:message];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self sendAlertAction:error.localizedDescription];
    }];
}
- (void)forgetPassAction
{
    
}
#pragma mark - 保存数据
- (void)saveUserInfo:(NSDictionary *)data Complete:(SaveCompleteBlock)block
{
    // 先删除之前的
    
    [ClearCacheTool clearSDWebImageCache:[ClearCacheTool docPath]];
    
    
    NSString *path = [ClearCacheTool homePath];
    NSLog(@"根目录 =  %@",path);
    // 归档
    UserModel *userModel = [UserModel mj_objectWithKeyValues:data];
    NSMutableDictionary *newDic = [NSMutableDictionary dictionary];
    newDic[@"username"] = userModel.USERNAME;
    newDic[@"password"] = userModel.PASSWORD;
    newDic[@"userID"] = userModel.USER_ID;
    Account *account = [Account accountWithDict:newDic];
    [AccountTool saveAccount:account];
    // 保存用户信息到数据库
    BOOL isSave = [UserInfoManager saveInfoToSandBox:userModel];
    NSLog(@"用户信息保存--%d",isSave);
    block();
    
}
- (void)registerAction
{
    RegisterViewController *registerVC = [RegisterViewController new];
    registerVC.ReloadTableView = ^(NSString *userName,NSString *pass){
        self.accountField.text = userName;
        self.passField.text = pass;
    };
    [self.navigationController pushViewController:registerVC animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}


@end
