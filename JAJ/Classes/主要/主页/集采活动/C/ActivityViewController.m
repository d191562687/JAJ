//
//  ActivityViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/11/28.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//内网ip：192.168.1.70
//外网ip：124.207.212.87

#import "ActivityViewController.h"
#import "ActSearchViewModel.h"
#import "ActSearchTableViewCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <MBProgressHUD.h>
#import "ActSearchDetialViewController.h"
#import "ActIssueSearchViewController.h"

@interface ActivityViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
/** 搜索表 */
@property (nonatomic, strong) UITableView * searchTableView;
/** 搜索数据 */
@property (nonatomic, strong) NSMutableArray * dataSource;
/** 搜索栏 */
@property (nonatomic, strong) UISearchBar * searchBar;
/** 搜索后数据 */
@property (nonatomic, strong) NSArray * resultArray;
/** 品名 */
@property (strong,nonatomic) NSString * pinmingName;
@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动广场";

    [self setupSubviews];
    
    [self setNav];
    
    
}

/**
 设置发布按钮
 */
- (void)setNav
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(addIusse)];

}
- (void)addIusse
{
    ActIssueSearchViewController * issueVC = [[ActIssueSearchViewController alloc]init];
    [self.navigationController pushViewController:issueVC animated:YES];
}

/** 当搜索内容改变时开始搜索 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //如果数据量过大的话  采用多线程防止卡顿
    NSLog(@"正在搜索...");
    //子线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([searchText isEqualToString:@""]) {
            _resultArray = [NSArray array];
        }
        else{
            // 主要功能，调用方法实现搜索
            NSLog(@"searchText  ===   %@",searchText);
            NSString * strname = [NSString stringWithFormat:@"%@",searchText];
            [self loadWithName:strname];
            
        }
        // 主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_searchTableView reloadData];
            NSLog(@"隐藏旋转按钮");
        });
    });
}

#pragma 表格相关
- (void)setupSubviews
{
    //UI创建
    [self createSearchBar];
    [self.view addSubview:self.searchTableView];
    self.searchTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //数据请求
        [self loadWithName:@""];
    }];
    /** 每次加载先刷新数据 */
    [self.searchTableView.mj_header beginRefreshing];
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

    /** 搜索前全查 */
    /** 创建cell */
    ActSearchTableViewCell * cell = [ActSearchTableViewCell actcellWithactSearchModel:tableView];
    /** 获取当前的模型，设置cell数据 */
    ActSearchViewModel * model = self.dataSource[indexPath.row];
    cell.actSearchModel = model;

    return cell;
}
/** cell点击 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ActSearchDetialViewController * detial = [[ActSearchDetialViewController alloc]init];
    detial.model = self.dataSource[indexPath.row];
    NSLog(@"detial.model==22==  %@",detial.model);
    [self.navigationController pushViewController:detial animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 数据请求
- (void)loadWithName:(NSString *)name;
{
    //内网ip：192.168.1.70
    //外网ip：124.207.212.87
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appJzcggl_URL];
    
    NSDictionary *params = @{
                             @"field1":name,
                             @"field2" :@"",
                             @"field3":@"",
                             @"lastLoginStart":@"",
                             @"lastLoginEnd":@""
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.searchTableView.mj_header endRefreshing];
        
        // 成功
        NSArray *data = [responseObject objectForKey:@"data"];
        self.dataSource = [ActSearchViewModel mj_objectArrayWithKeyValuesArray:data];
        
        NSLog(@"self.dataSource = %@",self.dataSource);
        [self.searchTableView reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.searchTableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];
}

#pragma mark - 创建UISearchBar
- (void)createSearchBar {
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"请输入活动商品关键字";
    [self.view addSubview:_searchBar];
}


#pragma mark - 懒加载
- (UITableView *)searchTableView{
    if (!_searchTableView) {
        _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT - 64 -50) style:UITableViewStylePlain];

        _searchTableView.rowHeight = 160;
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

@end
