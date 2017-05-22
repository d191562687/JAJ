//
//  CloudViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/11/28.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "CloudViewController.h"
#import "CloudTableViewCell.h"
#import "CloudKnowViewController.h"
#import "SalesReportViewController.h"
#import "MarketquotationViewController.h"
#import "CommentViewController.h"
#import "SignViewController.h"
#import "MoreViewController.h"
#import "FoodViewController.h"
#import "Purchase PurchaseViewController.h"
#import "TipsViewController.h"

#import "UserInfoManager.h"
#import "LoginViewController.h"
#import "RootNavgationController.h"
#import "UserInfoViewController.h"
#import "AccountTool.h"

@interface CloudViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;

@property (copy,nonatomic) NSArray *array;
@end

@implementation CloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"云助手";
    
    [self setupSubviews];
}
- (void)setupSubviews
{
    self.array = @[@[@"云知道",@"签到"],@[@"市场行情",@"商家点评"],@[@"采购记录上报",@"销售记录上报",@"查询食药信息"]];
    
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
    CloudTableViewCell * cell = [CloudTableViewCell sharedCloudTableViewCell:tableView];
    /** icon图片 */
    NSArray * iconArr = @[@[@"icon_cloud_know",@"icon_qiandao"],@[@"icon_hangqing",@"icon_sjdp"],@[@"icon_settings",@"icon_version",@"icon_advice"]];
    cell.imageV.image = [UIImage imageNamed:iconArr[indexPath.section][indexPath.row]];
    cell.label.text = self.array[indexPath.section][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 不加此句时，在二级栏目点击返回时，此行会由选中状态慢慢变成非选中状态。
    // 加上此句，返回时直接就是非选中状态。
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //分页面跳转
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            TipsViewController * cloudKnowVC = [[TipsViewController alloc]init];
            [self
             .navigationController pushViewController:cloudKnowVC animated:YES];
            
        }else if (indexPath.row == 1){

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
                // 已经登录，去签到界面
                SignViewController * signVC = [[SignViewController alloc]init];
                [self
                 .navigationController pushViewController:signVC animated:YES];
            }
       
        }else if (indexPath.row == 2){
            
            MarketquotationViewController * marketVC = [[MarketquotationViewController alloc]init];
            [self
             .navigationController pushViewController:marketVC animated:YES];
            
            
        }else if (indexPath.row == 3){
            
            CommentViewController * commentVC = [[CommentViewController alloc]init];
            [self
             .navigationController pushViewController:commentVC animated:YES];

        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0){
            
            Purchase_PurchaseViewController * purchaseVC = [[Purchase_PurchaseViewController alloc]init];
            [self
             .navigationController pushViewController:purchaseVC animated:YES];
            
            
        }else if (indexPath.row == 1){
            
            //销售记录上报
//            SalesReportViewController * salesReportVC = [[SalesReportViewController alloc]init];
//            [self
//             .navigationController pushViewController:salesReportVC animated:YES];
            
            Purchase_PurchaseViewController * purchaseVC = [[Purchase_PurchaseViewController alloc]init];
            [self
             .navigationController pushViewController:purchaseVC animated:YES];
            
        }else if (indexPath.row == 2){
            
            FoodViewController * foodVC = [[FoodViewController alloc]init];
            [self
             .navigationController pushViewController:foodVC animated:YES];
            
            
        }else if (indexPath.row == 3){
            
            MoreViewController * moreVC = [[MoreViewController alloc]init];
            [self
             .navigationController pushViewController:moreVC animated:YES];
            
            
        }
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
    return 15;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 52;
        _tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    }
    return  _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
}

@end
