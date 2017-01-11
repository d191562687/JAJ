//
//  BackDetailsViewController.m
//  JAJ
//
//  Created by 金安健 on 2017/1/11.
//  Copyright © 2017年 JinAnJian. All rights reserved.
//

#import "BackDetailsViewController.h"
#import "TimeModel.h"
#import "RightSlidetabletableViewCell.h"

@interface BackDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * listTableView;
@property(strong,nonatomic)NSMutableArray * dataList;

@end

@implementation BackDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"追溯详情";

    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    [self setData];

}

-(void)initView{
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    [self.view addSubview:self.listTableView];
}

-(void)setData
{
    self.dataList=[NSMutableArray arrayWithCapacity:0];
    NSDictionary *dic=@{@"timeStr":@"业务单号：KZDA0104902972",@"titleStr":@"时间：2016-09-10",@"detailSrtr":@"品名：防风同生颗粒 \n往来单位名称：烟台天正药业有限公司 \n购进数量：50\n购货时间：5015-1-4 \n验收时间：2015-1-4"};
    TimeModel *model=[[TimeModel alloc]initData:dic];
    [self.dataList addObject:model];
    
    NSDictionary *dic2=@{@"timeStr":@"业务单号：KZDA0104902972",@"titleStr":@"时间：2016-09-10",@"detailSrtr":@"品名：防风同生颗粒 \n往来单位名称：烟台天正药业有限公司 \n购进数量：50\n购货时间：5015-1-4 \n验收时间：2015-1-4"};
    TimeModel *model2=[[TimeModel alloc]initData:dic2];
    [self.dataList addObject:model2];
    
    NSLog(@"--ssself.dataList--%@",self.dataList);
    
    [self.listTableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * iden = @"testTime";
    RightSlidetabletableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[RightSlidetabletableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    TimeModel * model = self.dataList[indexPath.row];
    cell.model = model;
    self.listTableView.separatorColor = UITableViewCellSeparatorStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TimeModel * model = self.dataList[indexPath.row];
    NSDictionary * fontDic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGSize size1 = CGSizeMake(WIDTH_OF_PROCESS_LABLE, 0);
    CGSize titleLabelSize=[model.detailSrtr boundingRectWithSize:size1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading   attributes:fontDic context:nil].size;
    if (titleLabelSize.height < 15) {
        titleLabelSize.height = 40;
    }else{
        titleLabelSize.height = titleLabelSize.height + 30;
    }
    return titleLabelSize.height + 50;
}



@end
