//
//  HomeViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "HomeViewController.h"
#import "WoViewController.h"
#import "HangyeListTableCell.h"
#import "SDCycleScrollView.h"
#import <MJRefresh.h>
#import "HomeListModel.h"
#import <MJExtension.h>
#import <MBProgressHUD.h>
#import "HangyeDetialViewController.h"
#import "HomeHeadView.h"
/** icon控制页 */
#import "FourViewController.h"
#import "CloudViewController.h"
#import "ActivityViewController.h"
#import "CompanyViewController.h"
#import "MapViewController.h"
#import "BackViewController.h"


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 表格 */
@property (strong,nonatomic) UITableView *tableView;
/** 头部 */
@property (strong,nonatomic) HomeHeadView *headView;
/** 行业动态数据 */
@property (copy,nonatomic) NSArray *hangyeArray;


@end

@implementation HomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"食药";
    [self setupSubviews];
    
}
#pragma 表格相关
- (void)setupSubviews
{
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData:@"2" Page:@"1"];
    }];
    
    /** 每次加载先刷新数据 */
    [self.tableView.mj_header beginRefreshing];
}
/** 列表数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
/** table行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hangyeArray.count;
}
/** cell赋值 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HangyeListTableCell *cell = [HangyeListTableCell sharedHangyeListTableCell:tableView];
    HomeListModel *model = self.hangyeArray[indexPath.row];
    cell.model = model;
    return cell;
}
/** cell点击事件 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HangyeDetialViewController *detial = [[HangyeDetialViewController alloc]init];
    detial.model = self.hangyeArray[indexPath.row];
    [self.navigationController pushViewController:detial animated:YES];
}
/** 高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
#pragma 标题栏
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headV = [[UIView alloc]initWithFrame:CGRectZero];
    headV.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.view.width - 30, 30)];
    label.text = @"市场行情";
    label.font =  [UIFont systemFontOfSize:14];
    [headV addSubview:label];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.width - 70, 0, self.view.width - 30, 30)];
    label1.text = @"查看更多";
    label1.font =  [UIFont systemFontOfSize:14];
    [headV addSubview:label1];
    
    return headV;
}

#pragma 获取数据
- (void)getData:(NSString *)type Page:(NSString *)page
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appShiyts_URL];

    NSDictionary *params = @{
                             @"type":type,
                             @"currentPage":page,
                             @"pageSize":@"20"
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        
   //     NSLog(@"responseObject = %@",responseObject);
        NSString *code = [[responseObject objectForKey:@"code"] description];
        NSString *desc = [[responseObject objectForKey:@"desc"] description];
        if ([code isEqualToString:@"0000"]) {
            // 成功
            NSArray *data = [responseObject objectForKey:@"data"];
            self.hangyeArray = [HomeListModel mj_objectArrayWithKeyValuesArray:data];
            
            [self.tableView reloadData];
            
        }else{
            // 不成功
            [self sendAlertAction:desc];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];
    
}


#pragma 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.rowHeight = 100;
    }
    return _tableView;
}
- (HomeHeadView *)headView
{
    if (!_headView) {
        _headView = [[HomeHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - 64) * 0.55)];
        _headView.backgroundColor = BackGroudColor;
        __weak __block HomeViewController *weakSelf = self;
        _headView.SelectBlock = ^(NSIndexPath *indexPath){
            if (indexPath.row == 0) {
                // 四品一械查询
                FourViewController * fourV = [[FourViewController alloc]init];
                [weakSelf.navigationController pushViewController:fourV animated:YES];
                
            } else if(indexPath.row == 1){
                // 地图定位
                MapViewController * mapV = [[MapViewController alloc]init];
                [weakSelf.navigationController pushViewController:mapV animated:YES];
                
            }else if(indexPath.row == 2){
                // 厂家
                CompanyViewController * companyV = [[CompanyViewController alloc]init];
                [weakSelf.navigationController pushViewController:companyV animated:YES];
            }else if (indexPath.row == 3){
                // 四品一些追溯
                BackViewController * backV = [[BackViewController alloc]init];
                [weakSelf.navigationController pushViewController:backV animated:YES];
            }else if (indexPath.row == 4){
                // 云助手
                CloudViewController * cloudV = [[CloudViewController alloc]init];
                [weakSelf.navigationController pushViewController:cloudV animated:YES];
            }else{
                // 集采活动
                ActivityViewController * activityV = [[ActivityViewController alloc]init];
                [weakSelf.navigationController pushViewController:activityV animated:YES];
            }
        };
    }
    return _headView;
}

//隐藏首页标题栏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
