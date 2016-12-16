//
//  CompanyDetialController.m
//  JAJ
//
//  Created by Chan_Sir on 2016/12/15.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "CompanyDetialController.h"
#import "HTTPManager.h"
#import "CompanyProductModel.h"
#import <MJExtension/MJExtension.h>
#import "NormalTableViewCell.h"
#import "NormalIconView.h"
#import <MJRefresh.h>
#import "WebViewTableCell.h"
#import <Masonry.h>

#define LocalHTMLString @"<!doctypehtml><html><head><metacharset='utf-8'/></head><body><p>&nbsp;&nbsp;&nbsp;&nbsp;怎样判断宝宝便秘了?宝宝便秘应该怎么办?很多妈妈都会遇到这种难题。<br><p>&nbsp;&nbsp;&nbsp;&nbsp;有的宝宝可能会三四天才排便次，但如果排便比较顺畅的话，则不能算是便秘;反之，宝宝即使每天都排便，然而排出的便又干又少，同时伴食欲不佳、腹胀，也可认定为便秘。引起婴幼儿便秘的因素有饮食不足、食物成分不当、肠道功能失常、体格与生理的异常及精神因素所造成的。<br><h3>应对宝宝便秘的良策</h3><br><p><br>、矫正饮食<br><p>&nbsp;&nbsp;&nbsp;&nbsp;如果因饮食不足造成便秘，应增加食物摄入量。母乳喂养的宝宝应更频繁地哺乳，人工喂养的宝宝则应增加配方奶量。<br><br>二、食补纤维素<br><p>&nbsp;&nbsp;&nbsp;&nbsp;可在饮食中添加西红柿汁、橘子汁、菜汁等，或把婴儿蜂蜜加在温水中，每天给宝宝喝60～90毫升，促进肠道蠕动。较大些宝宝便秘时，可给吃些粗谷类的食物或红薯，还要多吃芹菜、韭菜等粗纤维蔬菜，多喝白水，尤其在过多摄取高蛋白、高热量食物后，更要及时喝水及吃果蔬。如果是母乳喂养，妈妈自身也应及时调整饮食，多吃蔬菜、水果和粗粮。<br><br>三、增加肠道益生菌<br><p>&nbsp;&nbsp;&nbsp;&nbsp;可以给宝宝补充些益生菌制剂，尤其要含有双歧杆菌、乳酸菌、粪肠球菌等肠道益生菌。<br><br>四、腹部按摩<br><p>&nbsp;&nbsp;&nbsp;&nbsp;右手四指并拢，在孩子的脐击按顺时针方向轻轻推揉按摩。这样不仅可以帮助排便而且有助化。<br><br>五、适当运动<br><p>&nbsp;&nbsp;&nbsp;&nbsp;让宝宝积极进行户外运动，如跑、爬、跳、骑小车、踢球等，以此增强腹肌的力量，并且可促进肠道蠕动。对于胆小的宝宝，尽量在家里排便，不要轻易改变排便环境。当宝宝出现类似情况时要及早做心理疏导。<br><br>六、直肠或肛门局部刺激<br><p>&nbsp;&nbsp;&nbsp;&nbsp;用手指蘸上肥皂水或婴儿油在宝宝肛门处按摩，这种方法能有效刺激肛门，使肛门括约肌松弛，利于排便。<br></p><body></html>"

@interface CompanyDetialController ()<UITableViewDataSource,UITableViewDelegate>

{
    int CurrentPage;
}

/** 表格 */
@property (strong,nonatomic) UITableView *tableView;
/** 公司产品列表 */
@property (strong,nonatomic) NSMutableArray *productArr;
/** basicHtmlStr */
@property (copy,nonatomic) NSString *basicHtmlStr;
/** contactHtmlStr */
@property (copy,nonatomic) NSString *contactHtmlStr;


@end

@implementation CompanyDetialController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业详情";
    CurrentPage = 1;
    
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
    
    // 获取公司基本信息
    [self getCompanyInfoWithType:BasicInfoType];
    // 获取公司联系信息
    [self getCompanyInfoWithType:ContactInfoType];
    
    [self.tableView.mj_header beginRefreshing];
}


/**
 获取公司信息

 @param type BasicInfoType = 1,  // 企业基本信息
             ContactInfoType =2, // 联系信息
 */
- (void)getCompanyInfoWithType:(DetialInfoType)type
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appCjXQ_URL];
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    [jsonDict setValue:self.model.QYMC forKey:@"QYMC"];
    [jsonDict setValue:self.model.QY forKey:@"QY"];
    [jsonDict setValue:self.model.ID forKey:@"ID"];
    [jsonDict setValue:[NSString stringWithFormat:@"%ld",(long)type] forKey:@"type"];
    
    NSDictionary *params = @{@"json":[self switchToJsonStrFrom:jsonDict]};
    
    [HTTPManager POST:url params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject_type = %@",responseObject);
        if (type == BasicInfoType) {
            // 基本信息
            NSString *data = [[responseObject objectForKey:@"data"] description];
//            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[data dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            data = [data stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            self.basicHtmlStr = data;
            
            [self.tableView reloadData];
        }else{
            // 联系信息
            NSString *data = [[responseObject objectForKey:@"data"] description];
//            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[data dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            self.contactHtmlStr = data;
            [self.tableView reloadData];
        }
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self sendAlertAction:error.localizedDescription];
    }];
}

#pragma mark - 绘制表格
- (void)setupSubViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 1;
    }else{
        return self.productArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 企业基本信息
        WebViewTableCell *cell = [WebViewTableCell sharedWebViewTableCell:tableView];
        cell.htmlString = self.basicHtmlStr;
//        __weak __block CompanyDetialController *weakSelf = self;
//        cell.reloadBlock = ^(){
//            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
//        };
        
        return cell;
    }else if (indexPath.section == 1){
        // 企业联系信息
        WebViewTableCell *cell = [WebViewTableCell sharedWebViewTableCell:tableView];
        cell.htmlString = self.contactHtmlStr; // LocalHTMLString
//        __weak __block CompanyDetialController *weakSelf = self;
//        cell.reloadBlock = ^(){
//            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        };
        return cell;
    }else{
        // 企业产品信息
        CompanyProductModel *model = self.productArr[indexPath.row];
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        cell.textLabel.text = model.YPDA_SPM;
        return cell;
    }
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
    if (section == 2) {
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
    }else{
        UIView *footV = [UIView new];
        footV.backgroundColor = [UIColor clearColor];
        return footV;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 50;
    }else{
        CGFloat webHeight = [WebViewTableCell cellHeight];
        if (indexPath.section == 0) {
            webHeight = webHeight * 0.3;
        }else{
            webHeight = webHeight * 0.7f;
        }
        NSLog(@"webHeight = %f",webHeight);
        return webHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    headView.backgroundColor = MainColor;
    NSArray *titleArr = @[@"企业基本信息",@"企业联系信息",@"企业产品列表"];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 60, 30)];
    label.text = titleArr[section];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [headView addSubview:label];
    return headView;
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
    [jsonDict setValue:self.model.QYMC forKey:@"QYMC"];
    [jsonDict setValue:self.model.QY forKey:@"QY"];
    [jsonDict setValue:self.model.ID forKey:@"ID"];
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
