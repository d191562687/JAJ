//
//  Purchase PurchaseViewController.m
//  JAJ
//
//  Created by 杜彪 on 2016/12/4.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "Purchase PurchaseViewController.h"
#import "NormalTableViewCell.h"

@interface Purchase_PurchaseViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 数据模型 */
@property (strong, nonatomic) UITextField * GJ_BIANM;
@property (strong, nonatomic) UITextField * GJ_PINM;
@property (strong, nonatomic) UITextField * GJ_GUIG;
@property (strong, nonatomic) UITextField * GJ_JIX;
@property (strong, nonatomic) UITextField * GJ_PIZWH;
@property (strong, nonatomic) UITextField * GJ_ZUIXBZDW;
@property (strong, nonatomic) UITextField * GJ_PIH;
@property (strong, nonatomic) UITextField * GJ_SHENGCRQ;
@property (strong, nonatomic) UITextField * GJ_YOUXQ;
@property (strong, nonatomic) UITextField * GJ_WANGLDWBH;
@property (strong, nonatomic) UITextField * GJ_WANGLDWMC;
@property (strong, nonatomic) UITextField * GJ_GOUJSL;
@property (strong, nonatomic) UITextField * GJ_GOUHSJ;
@property (strong, nonatomic) UITextField * GJ_YANSSJ;
@property (strong, nonatomic) UITextField * GJ_YANWDH;
@property (strong, nonatomic) UITextField * GJ_JIGBS;
@property (strong, nonatomic) UITextField * GJ_TXM;
@property (strong, nonatomic) UITextField * GJ_PRICE;
@property (strong, nonatomic) UITextField * ROW_ID;
@property (strong, nonatomic) UITextField * GJ_SHIJJ;
@property (strong, nonatomic) UITextField * GOUJJLSB_ID;


/** 数据 */
@property (strong,nonatomic) NSArray * array;
/** 列表 */
@property (strong,nonatomic) UITableView * tableView;

@end

@implementation Purchase_PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.title = @"采购记录上报";
 
    [self setupSubViews];
    
 //   [self getData];

}
//设置视图
- (void)setupSubViews
{
    self.array = @[@"商品编码：",@"品名：",@"助记码：",@"往来单位：",@"往来单位编码：",@"往来单位名称：",@"规格：",@"剂型：",@"批准文号：",@"最小包装单位："];
    [self.view addSubview:self.tableView];
    
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    footView.backgroundColor = self.view.backgroundColor;
    footView.userInteractionEnabled = YES;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = MainColor;
    [button setTitle:@"提  交" forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10;
    [button setFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 40)];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        
        
    }];
    [footView addSubview:button];
    
    self.tableView.tableFooterView = footView;
}

#pragma mark - 表格相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 用户名
        [cell.contentView addSubview:self.GJ_BIANM];
        return cell;
    }else if (indexPath.section == 1){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 密码
        [cell.contentView addSubview:self.GJ_PINM ];
        return cell;
    }else if (indexPath.section == 2){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 昵称
        [cell.contentView addSubview:self.GJ_GUIG];
        return cell;
    }else if (indexPath.section == 3){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 手机号
        [cell.contentView addSubview:self.GJ_JIX];
        return cell;
    }else if (indexPath.section == 4){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 邮箱
        [cell.contentView addSubview:self.GJ_PIZWH];
        return cell;
    }else if (indexPath.section == 5){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 地址
        [cell.contentView addSubview:self.GJ_ZUIXBZDW];
        return cell;
        
    }else if (indexPath.section == 6){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 性别
        [cell.contentView addSubview:self.GJ_PIH];
        return cell;
    }else if (indexPath.section == 7){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 性别
        [cell.contentView addSubview:self.GJ_SHENGCRQ];
        return cell;
    }else if (indexPath.section == 8){
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 性别
        [cell.contentView addSubview:self.GJ_YOUXQ];
        return cell;
    }else {
        NormalTableViewCell *cell = [NormalTableViewCell sharedNormalTableViewCell:tableView];
        [cell.imageVme removeFromSuperview];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.text = self.array[indexPath.section];
        // 生日
        [cell.contentView addSubview:self.GJ_WANGLDWBH];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 3;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footV = [UIView new];
    footV.backgroundColor = self.view.backgroundColor;
    return footV;
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 60;
    }
    return _tableView;
}

- (UITextField *)GJ_BIANM
{
    if (!_GJ_BIANM) {
        _GJ_BIANM = [[UITextField alloc]initWithFrame:CGRectMake(150, 10, SCREEN_WIDTH - 100, 40)];
        _GJ_BIANM.placeholder = @"如：YHL00000003";
        _GJ_BIANM.font = [UIFont systemFontOfSize:15];
        
    }
    return _GJ_BIANM;
}
- (UITextField *)GJ_PINM
{
    if (!_GJ_PINM) {
        _GJ_PINM = [[UITextField alloc]initWithFrame:CGRectMake(150, 10, SCREEN_WIDTH - 100, 40)];
        _GJ_PINM.secureTextEntry = YES;
        _GJ_PINM.placeholder = @"雀巢咖啡（盒装）";
        _GJ_PINM.font = [UIFont systemFontOfSize:15];
        
    }
    return _GJ_PINM;
}
- (UITextField *)GJ_GUIG
{
    if (!_GJ_GUIG) {
        _GJ_GUIG = [[UITextField alloc]initWithFrame:CGRectMake(150, 10, SCREEN_WIDTH - 100, 40)];
        _GJ_GUIG.secureTextEntry = YES;
        _GJ_GUIG.placeholder = @"品名首字母";
        _GJ_GUIG.font = [UIFont systemFontOfSize:15];
        
    }
    return _GJ_GUIG;
}
- (UITextField *)GJ_JIX
{
    if (!_GJ_JIX) {
        _GJ_JIX = [[UITextField alloc]initWithFrame:CGRectMake(150, 10, SCREEN_WIDTH - 100, 40)];
        _GJ_JIX.secureTextEntry = YES;
        _GJ_JIX.placeholder = @"往来单位编号／名称";
        _GJ_JIX.font = [UIFont systemFontOfSize:15];
        
    }
    return _GJ_JIX;
}
- (UITextField *)GJ_PIZWH
{
    if (!_GJ_PIZWH) {
        _GJ_PIZWH = [[UITextField alloc]initWithFrame:CGRectMake(150, 10, SCREEN_WIDTH - 100, 40)];
        _GJ_PIZWH.secureTextEntry = YES;
        _GJ_PIZWH.placeholder = @"往来单位编号";
        _GJ_PIZWH.font = [UIFont systemFontOfSize:15];
        
    }
    return _GJ_PIZWH;
}
- (UITextField *)GJ_ZUIXBZDW
{
    if (!_GJ_ZUIXBZDW) {
        _GJ_ZUIXBZDW = [[UITextField alloc]initWithFrame:CGRectMake(150, 10, SCREEN_WIDTH - 100, 40)];
        _GJ_ZUIXBZDW.secureTextEntry = YES;
        _GJ_ZUIXBZDW.placeholder = @"往来单位名称";
        _GJ_ZUIXBZDW.font = [UIFont systemFontOfSize:15];
        
    }
    return _GJ_ZUIXBZDW;
}
- (UITextField *)GJ_PIH
{
    if (!_GJ_PIH) {
        _GJ_PIH = [[UITextField alloc]initWithFrame:CGRectMake(150, 10, SCREEN_WIDTH - 100, 40)];
        _GJ_PIH.secureTextEntry = YES;
        _GJ_PIH.placeholder = @"12支／盒";
        _GJ_PIH.font = [UIFont systemFontOfSize:15];
        
    }
    return _GJ_PIH;
}
- (UITextField *)GJ_SHENGCRQ
{
    if (!_GJ_SHENGCRQ) {
        _GJ_SHENGCRQ = [[UITextField alloc]initWithFrame:CGRectMake(150, 10, SCREEN_WIDTH - 100, 40)];
        _GJ_SHENGCRQ.secureTextEntry = YES;
        _GJ_SHENGCRQ.placeholder = @"剂型";
        _GJ_SHENGCRQ.font = [UIFont systemFontOfSize:15];
        
    }
    return _GJ_SHENGCRQ;
}
- (UITextField *)GJ_YOUXQ
{
    if (!_GJ_YOUXQ) {
        _GJ_YOUXQ = [[UITextField alloc]initWithFrame:CGRectMake(150, 10, SCREEN_WIDTH - 100, 40)];
        _GJ_YOUXQ.secureTextEntry = YES;
        _GJ_YOUXQ.placeholder = @"批准文号";
        _GJ_YOUXQ.font = [UIFont systemFontOfSize:15];
        
    }
    return _GJ_YOUXQ;
}
- (UITextField *)GJ_WANGLDWBH
{
    if (!_GJ_WANGLDWBH) {
        _GJ_WANGLDWBH = [[UITextField alloc]initWithFrame:CGRectMake(150, 10, SCREEN_WIDTH - 100, 40)];
        _GJ_WANGLDWBH.secureTextEntry = YES;
        _GJ_WANGLDWBH.placeholder = @"最小单位";
        _GJ_WANGLDWBH.font = [UIFont systemFontOfSize:15];
        
    }
    return _GJ_WANGLDWBH;
}



- (void)getData
{
    
    
    //网络请求
    NSString * url = [NSString stringWithFormat:@"%@%@",ip_port,appRRegister_URL];
    
    NSDictionary *data = @{
                           @"GJ_BIANM":@"测试",
                           @"GJ_GUIG": @"测试",
                           @"GJ_JIX": @"测试",
                           @"GJ_PIH": @"测试",
                           @"GJ_PINM": @"测试",
                           @"GJ_PIZWH": @"测试",
                           @"GJ_SHENGCRQ": @"测试",
                           @"GJ_YOUXQ": @"测试",
                           @"GJ_ZUIXBZDW": @"测试"
                          };
    
    NSDictionary *params = @{@"userName":@"admin",
                             @"passWord":@"1",
                             @"data":data
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
     NSLog(@"json = %@",json);
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"responseObject = %@",responseObject);
        
        NSString *code = [[responseObject objectForKey:@"code"] description];
        NSString *desc = [[responseObject objectForKey:@"desc"] description];
        
        if ([code isEqualToString:@"2009"]) {
            // 成功
//            if (self.ReloadTableView) {
//                _ReloadTableView(self.username.text,self.password.text);
//                [self.navigationController popViewControllerAnimated:YES];
//            }
            
        }else{
            // 不成功
            [self sendAlertAction:desc];
            
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self sendAlertAction:error.localizedDescription];
    }];
}


@end
