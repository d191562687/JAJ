//
//  WoViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "WoViewController.h"
#import "NormalTableViewCell.h"
#import "LoginViewController.h"
#import "UserInfoManager.h"
#import "RootNavgationController.h"
#import "UserInfoViewController.h"
#import "AccountTool.h"
#import <LCActionSheet.h>
#import "HomeViewController.h"
#import "ClearCacheTool.h"

#import "AboutViewController.h"
#import "FeedBackViewController.h"
#import "EditionViewController.h"
#import "JAJSetViewController.h"
#import "ChangePassWordViewController.h"
#import "WoSetViewController.h"

@interface WoViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 表格 */
@property (strong,nonatomic) UITableView *tableView;
/** 数据源 */
@property (copy,nonatomic) NSArray *array;
/** 头像 */
@property (strong,nonatomic) UIImageView *headImgV;
/** 昵称 */
@property (strong,nonatomic) UILabel *nameLabel;
/** 电话 */
@property (strong,nonatomic) UILabel *phoneLabel;
/** 退出按钮 */
@property (strong,nonatomic) UIButton *returnButton;

@end

@implementation WoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self setupSubviews];
}

- (void)setupSubviews
{
    self.array = @[@[@"我的"],@[@"修改密码",@"分享金安健",@"意见反馈",@"关于我们",@"设置"],@[@"退出当前账号"]];
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UserModel *model = [UserInfoManager getUserInfo];
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell addSubview:self.headImgV];
        [cell addSubview:self.nameLabel];
        [cell addSubview:self.phoneLabel];
        if (model) {
            self.headImgV.image = [UIImage imageNamed:@"user_place"];
            self.nameLabel.text = model.NAME;
            self.phoneLabel.text = [NSString stringWithFormat:@"Tel:%@",model.PHONE];
        }else{
            self.headImgV.image = [UIImage imageNamed:@"user_place"];
            self.nameLabel.text = @"未登录";
            self.phoneLabel.text = @"";
        }
        return cell;
    }else if(indexPath.section == 1){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        /** 添加icon图 */
        NSArray *iconArr = @[@[@"icon_cloud_know"],@[@"icon_updatepassword",@"ic_share",@"icon_advice",@"icon_version",@"icon_settings"]];
        cell.imageVme.image = [UIImage imageNamed:iconArr[indexPath.section][indexPath.row]];
        cell.label.text = self.array[indexPath.section][indexPath.row];
        return cell;
    }else{
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        cell.backgroundColor = self.view.backgroundColor;
        [cell.imageVme removeFromSuperview];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        if ([AccountTool account]) {
            // 添加按钮
            [cell addSubview:self.returnButton];
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 不加此句时，在二级栏目点击返回时，此行会由选中状态慢慢变成非选中状态。
    // 加上此句，返回时直接就是非选中状态。
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        Account *account = [AccountTool account];
        if (!account) {
            // 没有登录，去登录界面
            LoginViewController *loginVC = [LoginViewController new];
            loginVC.ReloadTableView = ^(){
                [self.tableView reloadData];
            };
            RootNavgationController *nav = [[RootNavgationController alloc]initWithRootViewController:loginVC];
            CATransition *animation = [CATransition animation];
            animation.duration = 0.5;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = @"cube";
            animation.subtype = kCATransitionFromTop;
            [self.view.window.layer addAnimation:animation forKey:nil];
            [self presentViewController:nav animated:NO completion:nil];
        }else{
            // 已经登录，去用户详情界面
            UserInfoViewController *userInfo = [UserInfoViewController new];
            [self.navigationController pushViewController:userInfo animated:YES];
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            // 修改密码
            ChangePassWordViewController * changeVC = [ChangePassWordViewController new];
            [self.navigationController pushViewController:changeVC animated:YES];
            
        }else if (indexPath.row == 1){
            //分享
            EditionViewController *editionVC = [EditionViewController new];
            [self.navigationController pushViewController:editionVC animated:YES];
            
        }else if (indexPath.row == 2){
            
            //意见反馈
            FeedBackViewController *feedbackVC = [FeedBackViewController new];
            [self.navigationController pushViewController:feedbackVC animated:YES];
            
        }else if (indexPath.row == 3){
            
            //关于
            AboutViewController *aboutVC = [AboutViewController new];
            [self.navigationController pushViewController:aboutVC animated:YES];
            
        }else if (indexPath.row == 4){
           
            // 设置
             WoSetViewController * jajsetVC = [WoSetViewController new];
            [self.navigationController pushViewController:jajsetVC animated:YES];
            
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }else if(indexPath.section == 1){
        return 50;
    }else{
        return 100;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *foot = [UIView new];
    foot.backgroundColor = [UIColor clearColor];
    return foot;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 6;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(8, 0, 0, 0);
    }
    return _tableView;
}
- (UIButton *)returnButton
{
    if (!_returnButton) {
        _returnButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 50, SCREEN_WIDTH - 60, 40)];
        _returnButton.layer.masksToBounds = YES;
        _returnButton.layer.cornerRadius = 4;
        _returnButton.backgroundColor = RGBACOLOR(227, 69, 69, 1);
        [_returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_returnButton setTitle:@"退出登录" forState:UIControlStateNormal];
        __weak __block WoViewController *weakSelf = self;
        [_returnButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            LCActionSheet *sheet = [LCActionSheet sheetWithTitle:@"确定退出，换号登录？" cancelButtonTitle:@"取消" clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    LoginViewController *loginVC = [LoginViewController new];
                    loginVC.ReloadTableView = ^(){
                        [weakSelf.tableView reloadData];
                    };
                    RootNavgationController *nav = [[RootNavgationController alloc]initWithRootViewController:loginVC];
                    CATransition *animation = [CATransition animation];
                    animation.duration = 0.5;
                    animation.timingFunction = UIViewAnimationCurveEaseInOut;
                    animation.type = @"cube";
                    animation.subtype = kCATransitionFromTop;
                    [weakSelf.view.window.layer addAnimation:animation forKey:nil];
                    [weakSelf presentViewController:nav animated:NO completion:nil];
                    /** 删除用户数据 */
                    [ClearCacheTool clearSDWebImageCache:[ClearCacheTool docPath]];
                }
            } otherButtonTitles:@"确定退出", nil];
            sheet.destructiveButtonIndexSet = [NSSet setWithObjects:@1, nil];
            [sheet show];
        }];
    }
    return _returnButton;
}
- (UIImageView *)headImgV
{
    if (!_headImgV) {
        _headImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_place"]];
        [_headImgV setFrame:CGRectMake(15, 10, 60, 60)];
    }
    return _headImgV;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 15, SCREEN_WIDTH - 90, 30)];
        _nameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 45, SCREEN_WIDTH - 90, 21)];
        _phoneLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        _phoneLabel.textColor = RGBACOLOR(56, 56, 56, 1);
        
    }
    return _phoneLabel;
}



@end
