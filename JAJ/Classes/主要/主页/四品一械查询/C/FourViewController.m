//
//  FourViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/11/28.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "FourViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <MBProgressHUD.h>
#import "FourDetialViewController.h"
#import "FoueTableViewCell.h"
#import "FourModel.h"
#import "FourBasicViewController.h"

@interface FourViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

/** 搜索表 */
@property (nonatomic, strong) UITableView * searchTableView;
/** 搜索数据 */
@property (nonatomic, strong) NSArray * dataSource;
/** 搜索栏 */
@property (nonatomic, strong) UISearchBar * searchBar;
/** 搜索后数据 */
@property (nonatomic, strong) NSArray * resultArray;
/** 品名 */
@property (strong,nonatomic) NSString * pinmingName;

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"药品查询";
    
    [self setupSubviews];
}

#pragma 表格相关
- (void)setupSubviews
{
    //UI创建
    [self createSearchBar];
    [self.view addSubview:self.searchTableView];
    self.searchTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //数据请求
        [self loadWithName:self.searchBar.text];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** 创建cell */
    FoueTableViewCell * cell = [FoueTableViewCell fourCellWithModel:tableView];
    /** 获取模型，设置cell数据 */
   
    FourModel * model = _dataSource[indexPath.row];
    cell.model = model;
    
    return cell;
}
/** cell点击 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FourDetialViewController *detial = [FourDetialViewController new];
    detial.fourModel = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:detial animated:YES];
}


/** 当搜索内容改变时开始搜索 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    //子线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([searchBar.text isEqualToString:@""]) {
            return ;
        }
        // 主要功能，调用方法实现搜索
        [self.searchTableView.mj_header beginRefreshing];
        
    });
}


- (void)loadWithName:(NSString *)name
{
    [self.view endEditing:YES];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appSpyx_URL];
//    json={keyword :"王老吉"}
    NSDictionary *params = @{
                             @"keyword":name,
                             };

    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.searchTableView.mj_header endRefreshing];
        // 成功
        NSString *code = [[responseObject objectForKey:@"code"] description];
        NSString *message = [[responseObject objectForKey:@"desc"] description];
        if ([code isEqualToString:@"0000"]) {
            NSArray *data = [responseObject objectForKey:@"data"];
            self.dataSource = [FourModel mj_objectArrayWithKeyValuesArray:data];
            [self.searchTableView reloadData];
            self.searchTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                
            }];
            [self.searchTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self sendAlertAction:message];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.searchTableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];
    
}

#pragma mark - 创建UISearchBar
- (void)createSearchBar {
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchBar.delegate = self;
    _searchBar.returnKeyType = UIReturnKeySearch;
    _searchBar.placeholder = @"请输入查询物品关键字";
    [self.view addSubview:_searchBar];
}
#pragma mark - 懒加载
- (UITableView *)searchTableView{
    if (!_searchTableView) {
        _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT - 64 -50) style:UITableViewStylePlain];
        _searchTableView.rowHeight = 150;
        _searchTableView.dataSource = self;
        _searchTableView.delegate = self;
        _searchTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _searchTableView.backgroundColor = self.view.backgroundColor;
        [self.view addSubview:_searchTableView];
    }
    return _searchTableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
}
@end
