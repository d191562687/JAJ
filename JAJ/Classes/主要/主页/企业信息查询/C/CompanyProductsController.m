//
//  CompanyProductsController.m
//  JAJ
//
//  Created by Chan_Sir on 2016/12/20.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "CompanyProductsController.h"
#import "HTTPManager.h"
#import "NormalTableViewCell.h"
#import <MJExtension.h>
#import "NormalIconView.h"
#import "CompanyProductModel.h"
#import <MJRefresh.h>

@interface CompanyProductsController ()<UITableViewDataSource,UITableViewDelegate>

{
    int CurrentPage;
}

/** 表格 */
@property (strong,nonatomic) UITableView *tableView;
/** 公司产品列表 */
@property (strong,nonatomic) NSMutableArray *productArr;

@end

@implementation CompanyProductsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业产品列表";
    [self getData];
    [self setupSubViews];
}

- (void)getData
{
    
    // 获取产品列表详情
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSString *page = [NSString stringWithFormat:@"%d",CurrentPage];
        [self getProductsWithType:ProductInfoType CurrentPage:page PageSize:@"20"];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 绘制表格
- (void)setupSubViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 企业产品信息
    CompanyProductModel *model = self.productArr[indexPath.row];
    NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
    cell.textLabel.text = model.YPDA_SPM;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        if (self.productArr.count >= 1) {
            return 1;
        }else{
            // 没有产品列表。展示空视图
            return 100;
        }
    }else{
        return 1;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.productArr.count >= 1) {
        UIView *footV = [UIView new];
        footV.backgroundColor = [UIColor clearColor];
        return footV;
    }else{
        // 没有产品列表。展示空视图
        UIView *footV = [UIView new];
        footV.backgroundColor = [UIColor whiteColor];
        NormalIconView *emptyView = [NormalIconView sharedHomeIconView];
        emptyView.frame = CGRectMake(SCREEN_WIDTH/2 - 45, 5, 90, 90);
        emptyView.iconView.image = [UIImage imageNamed:@"big_nodata"];
        emptyView.label.text = @"还没有产品数据";
        emptyView.label.numberOfLines = 0;
        emptyView.label.textColor = RGBACOLOR(214, 33, 25, 1);
        emptyView.backgroundColor = [UIColor clearColor];
        [footV addSubview:emptyView];
        return footV;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

/**
 获取企业产品列表
 
 @param type type为1显示基本信息 为2显示联系信息 为3显示产品信息 为4显示信用信息（现在信用信息用。。。代替）
 @param currentPage 当前页码。type=3时用
 @param pageSize 每页多少个。type=3时用
 */
- (void)getProductsWithType:(DetialInfoType)type CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize
{
    // http://localhost:8080/SYAQ/appCjcx/cjcxXQ.do?
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appCjXQ_URL];
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    [jsonDict setValue:self.model.qymc forKey:@"qymc"];
    [jsonDict setValue:self.model.qy forKey:@"qy"];
    [jsonDict setValue:self.model.id forKey:@"id"];
    [jsonDict setValue:[NSString stringWithFormat:@"%ld",(long)type] forKey:@"type"];
    [jsonDict setValue:currentPage forKey:@"currentPage"];
    [jsonDict setValue:pageSize forKey:@"pageSize"];
    
    NSDictionary *params = @{@"json":[self switchToJsonStrFrom:jsonDict]};
    
    [HTTPManager POST:url params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *code = [[responseObject objectForKey:@"code"] description];
        NSString *desc = [[responseObject objectForKey:@"desc"] description];
        [self.tableView.mj_header endRefreshing];
        if ([code isEqualToString:@"0000"]) {
            
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            
            if (dataArray.count >= 1) {
                
                int totalPage = [[[responseObject objectForKey:@"totalPage"] description] intValue];
                self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    NSString *page = [NSString stringWithFormat:@"%d",CurrentPage];
                    [self getProductsWithType:ProductInfoType CurrentPage:page PageSize:@"20"];
                }];
                
                if (CurrentPage > totalPage) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    return ;
                }
                
                NSArray *modelArr = [CompanyProductModel mj_objectArrayWithKeyValuesArray:dataArray];
                [self.productArr addObjectsFromArray:modelArr];
                [self.tableView reloadData];
                CurrentPage++;
                
                if (CurrentPage >= totalPage) {
                    // 没有更多的了
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                
            }
        }else{
            [self sendAlertAction:desc];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self sendAlertAction:error.localizedDescription];
    }];
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = self.view.backgroundColor;
    }
    return _tableView;
}

- (NSMutableArray *)productArr
{
    if (!_productArr) {
        _productArr = [NSMutableArray array];
    }
    return _productArr;
}


@end
