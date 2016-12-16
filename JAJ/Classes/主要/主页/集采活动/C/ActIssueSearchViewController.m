//
//  ActIssueSearchViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/12/1.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "ActIssueSearchViewController.h"
#import "ActIssueSearchModel.h"
#import "ActIssueSearchTableViewCell.h"
#import "ActIssueDetialViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <MBProgressHUD.h>


@interface ActIssueSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 品名 */
@property (strong, nonatomic) IBOutlet UITextField *pinmin;
/** 类别 */
@property (strong, nonatomic) IBOutlet UISegmentedControl *leix;
/** 助记码 */
@property (strong, nonatomic) IBOutlet UITextField *zhujim;
/** 搜索表 */
@property (strong, nonatomic) IBOutlet UITableView * isstableView;
/** 搜索数据 */
@property (nonatomic, strong) NSMutableArray * dataSource;
/** 搜索栏 */
@property (nonatomic, strong) UISearchBar * searchBar;
/** 搜索后数据 */
@property (nonatomic, strong) NSMutableArray * resultArray;

@end

@implementation ActIssueSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布";
    [self setupSubviews];
    [self setType];
}
/** 设置类型选择器 */
- (void)setType
{
    self.leix.selectedSegmentIndex = 0;
    self.leix.momentary = NO;
}
/** 开始搜索 */
- (IBAction)startSearch:(id)sender {
    /** 搜索参数 */
    NSCharacterSet *whiteNewChars = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    /** 品名 */
    NSString * pinming;
    if (self.pinmin.text) {
        pinming = [self.pinmin.text stringByTrimmingCharactersInSet:whiteNewChars];
    }else
    {
        pinming = @"";
    }
     /** 助记码 */
    NSString * zhujima;
    if (self.zhujim.text) {
        zhujima = [self.zhujim.text stringByTrimmingCharactersInSet:whiteNewChars];
    }else{
        zhujima = @"";
    }
    /** 类型 */
    NSString * type = @"1";
    switch (_leix.selectedSegmentIndex) {
        case 0:
            type = @"1";
            break;
        case 1:
            type = @"2";
            break;
        case 3:
            type = @"4";
            break;
        default:
            break;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appJcfbCX_URL];
    //json={zzjg_id:"",pinmin :"",fenl:"",zhujm:""}
    NSDictionary *params = @{
                             @"zzjg_id":@"",
                             @"pinmin":pinming,
                             @"liex":type,
                             @"fenl":@"",
                             @"zhujm":zhujima
                             };
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    NSLog(@"json = %@",json);
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.isstableView.mj_header endRefreshing];
        
        NSLog(@"responseObject = %@",responseObject);
        
        // 成功
        NSArray *data = [responseObject objectForKey:@"data"];
        self.dataSource = [ActIssueSearchModel mj_objectArrayWithKeyValuesArray:data];
        
        
        [self.isstableView reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.isstableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];

    
    
}

/** 懒加载 */
-(NSMutableArray *)resultArray{
    
    if (!_resultArray) {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}
-(NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


//-(UITableView *)isstableView{
//    
//    if (!_isstableView) {
//        _isstableView = [[UITableView alloc]init];
//        _isstableView.rowHeight = 160;
//        _isstableView.dataSource = self;
//        _isstableView.delegate = self;
//        _isstableView.backgroundColor = [UIColor redColor];
//    }
//    return _isstableView;
//}

#pragma 表格相关
- (void)setupSubviews
{

    self.isstableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //数据请求
        [self loadActivityViewControllerData];
    }];
    /** 每次加载先刷新数据 */
    [self.isstableView.mj_header beginRefreshing];
}

#pragma mark - 数据请求
- (void)loadActivityViewControllerData
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appJcfbCX_URL];
    //json={zzjg_id:"",pinmin :"",fenl:"",zhujm:""}
    NSDictionary *params = @{
                             @"zzjg_id":@"",
                             @"pinmin":@"",
                             @"liex":@"1",
                             @"fenl":@"",
                             @"zhujm":@""
                             };
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    NSLog(@"json = %@",json);
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.isstableView.mj_header endRefreshing];
        
        NSLog(@"responseObject = %@",responseObject);
        
        // 成功
        NSArray *data = [responseObject objectForKey:@"data"];
        self.dataSource = [ActIssueSearchModel mj_objectArrayWithKeyValuesArray:data];
        
        
        [self.isstableView reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.isstableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];
}


#pragma mark - 列表
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
    NSLog(@"self.dataSource = %@",self.dataSource);
    ActIssueSearchTableViewCell * cell = [ActIssueSearchTableViewCell actIssueCellWithIssueModel:tableView];
    ActIssueSearchModel * model = self.dataSource[indexPath.row];
    cell.issuemodel = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** 返回非选中 */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /** 创建控制器 */
    ActIssueDetialViewController * detial = [[ActIssueDetialViewController alloc]init];
    detial.model = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:detial animated:YES];
    
}
@end
