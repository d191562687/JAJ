//
//  TipsViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/12/6.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "TipsViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <MBProgressHUD.h>
#import "HomeListModel.h"
#import "HangyeListTableCell.h"
#import "HangyeDetialViewController.h"



@interface TipsViewController ()
/** 表格 */
@property (strong,nonatomic) IBOutlet UITableView * tableView;
/** 数据 */
@property (strong,nonatomic) NSArray * tipsArray;
/** 类型 */
@property (strong, nonatomic) IBOutlet UISegmentedControl *tipsType;


@end

@implementation TipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"贴士";
    
    [self setupSubviews];
    [self setipsType];

}

#pragma mark - 表格
- (void)setupSubviews
{
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getData:@"1"];
        
    }];
    /** 每次加载数据 */
    [self.tableView.mj_header beginRefreshing];
}
/** 设置类型 */
- (void)setipsType
{
    self.tipsType.selectedSegmentIndex = 0;
    self.tipsType.momentary = NO;
}

- (IBAction)tips:(id)sender {
    
    
    /** 类型 */
    NSString * type = @"1";
    switch (_tipsType.selectedSegmentIndex) {
        case 0:
            type = @"1";
            [self getData:type];
            break;
        case 1:
            type = @"2";
            [self getData:type];
            break;
        case 2:
            type = @"3";
            [self getData:type];
            break;
        case 3:
            type = @"4";
            [self getData:type];
            break;
        default:
            break;
    }
    
    
}


/** 列表数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
/** table行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tipsArray.count;
}
/** cell赋值 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HangyeListTableCell *cell = [HangyeListTableCell sharedHangyeListTableCell:tableView];
    HomeListModel *model = self.tipsArray[indexPath.row];
    cell.model = model;
    return cell;
}
/** cell点击事件 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HangyeDetialViewController *detial = [[HangyeDetialViewController alloc]init];
    detial.model = self.tipsArray[indexPath.row];
    [self.navigationController pushViewController:detial animated:YES];
}
/** 高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}



#pragma mark - 获取数据
- (void)getData:(NSString *)type
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appShiyts_URL];
  
    NSDictionary *params = @{
                             @"type":type,
                             @"currentPage":@"1",
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
            self.tipsArray = [HomeListModel mj_objectArrayWithKeyValuesArray:data];
            
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
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.rowHeight = 100;
    }
    return _tableView;
}



@end
