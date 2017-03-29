//
//  CompanyViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/11/28.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "CompanyViewController.h"
#import <MBProgressHUD.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "CompayModel.h"
#import "CompanyDetialController.h"
#import "NormalTableViewCell.h"



@interface CompanyViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

{
    int currentPage;
}
/** 搜索名称 */
@property (strong,nonatomic) NSString * name;
/** 搜索表 */
@property (nonatomic, strong) UITableView * searchTableView;
/** 搜索数据 */
@property (nonatomic, strong) NSMutableArray * dataSource;
/** 搜索栏 */
@property (nonatomic, strong) UISearchBar * searchBar;
///** 搜索后数据 */
//@property (nonatomic, strong) NSArray * resultArray;

@end

@implementation CompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业查询";
    currentPage = 1;
    [self setupSubview];
   
}


#pragma mark - 搜索
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    // 开始搜搜
    [self.dataSource removeAllObjects];
    [self.searchTableView reloadData];
    currentPage = 1;
    NSString *page = [NSString stringWithFormat:@"%d",currentPage];
    [self loacWithName:searchBar.text Page:page];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    // 开始搜搜
    [self.dataSource removeAllObjects];
    [self.searchTableView reloadData];
    currentPage = 1;
    NSString *page = [NSString stringWithFormat:@"%d",currentPage];
    [self loacWithName:searchBar.text Page:page];
}
#pragma UI
- (void)setupSubview
{
    //UI创建
    [self createSearchBar];
    [self.view addSubview:self.searchTableView];
    //初始化刷新searchTableView
    self.searchTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //数据请求
        NSString *page = [NSString stringWithFormat:@"%d",currentPage];
        [self loacWithName:@"" Page:page];
    }];
    /** 每次加载先刷新数据 */
    [self.searchTableView.mj_header beginRefreshing];
}
#pragma mark - 创建UISearchBar
- (void)createSearchBar
{
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"请输入企业关键字";
    [self.view addSubview:_searchBar];
}

#pragma mark - 懒加载
- (UITableView *)searchTableView
{
    if (!_searchTableView) {
        _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:UITableViewStylePlain];
        _searchTableView.rowHeight = 60;
        _searchTableView.dataSource = self;
        _searchTableView.delegate = self;
        _searchTableView.backgroundColor = self.view.backgroundColor;
        [self.view addSubview:_searchTableView];
        
    }
    return _searchTableView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)loacWithName:(NSString *)name Page:(NSString *)page{
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appCjcx_URL];
//    请求参数：json={code:"",currentPage:"",pageSize:""}
    NSDictionary *params = @{@"code" :name,
                             @"currentPage" :page,
                             @"pageSize" :@500};
    
    NSString *p1Str = [self switchToJsonStrFrom:params];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.searchTableView.mj_header endRefreshing];
        
        NSString *code = [[responseObject objectForKey:@"code"] description];
        NSString *desc = [[responseObject objectForKey:@"desc"] description];
        if ([code isEqualToString:@"0000"]) {
            // 成功
            NSArray *data = [responseObject objectForKey:@"data"];
            NSArray *modelArray = [CompayModel mj_objectArrayWithKeyValuesArray:data];
            int totalPage = [[[responseObject objectForKey:@"totalPage"] description] intValue];
            if (currentPage <= totalPage) {
                currentPage++;
            }else{
                [self.searchTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            self.searchTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                NSString *page = [NSString stringWithFormat:@"%d",currentPage];
                [self loacWithName:name Page:page];
            }];
            
            [self.dataSource addObjectsFromArray:modelArray];
            [self.searchTableView reloadData];
        }else{
            // 不成功
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self sendAlertAction:desc];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.searchTableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];

}

#pragma mark - 列表创建
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** 创建cell */
    NormalTableViewCell * cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
    /** 获取数据 */
    CompayModel * model = self.dataSource[indexPath.section];
    cell.textLabel.text = model.qymc;
    
    return cell;
}
//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CompayModel * model = self.dataSource[indexPath.section];
    CompanyDetialController *company = [CompanyDetialController new];
    company.model = model;
    [self.navigationController pushViewController:company animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footV = [UIView new];
    footV.backgroundColor = [UIColor clearColor];
    return footV;
}


@end
