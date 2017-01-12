//
//  AboutViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/12/8.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()<UITextViewDelegate>

@property (strong,nonatomic) UITextView * textview;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    
    [self setupSuView];
    
}

- (void)setupSuView
{
    
    self.textview = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 1000)];
    self.textview.delegate = self;
    self.textview.text = @"       北京市金安健医药经销中心成立于1997年1月6日，是一家从事医药商品批发、社区配送、零售连锁的医药企业，于2003年首批通过了北京市药品监督管理局的“药品经营质量管理规范”认证，2008年再次通过了GSP认证。公司经营范围包括中成药、中药饮片、化学药制剂、化学原料、抗生素、生化药品、蛋白同化制剂、肽类激素等。公司拥有经营面积1200平方米，仓储面积4000平方米，经营品种3000余种，2008年销售额3亿多元人民币。公司设有办公室、人力资源部、质量管理部、业务部、财务部、储运部、零售连锁部等部门。  \n       北京市金安健医药经销中心于2007年获得了北京市近300家社区卫生服务中心（站）的零差率药品配送资格。认真的态度，严谨的流程，迅捷的速度，保证了我们的物流配送能力，圆满地完成了北京市政府的零差率药品配送任务，为北京市社区卫生医疗改革作出了贡献。立足于企业的长远发展，公司于2005年引进了一批高素质管理人才，对公司进行了全面改革，建立了高效的管理机制，现已取得长足的进步。\n        作为一个飞速发展中的企业，公司本着“质量是生命、管理是灵魂、人才是财富、用户是上帝”的经营理念，为广大客户提供了优质的服务。凭借可靠的商业信誉，赢得了医疗机构以及企业的信赖。公司的快速发展，为每一个合作伙伴提供了足够的空间。为了迎接更开放、更成熟、更规范、更竞争激烈的医药市场，我们期待与您携手共进，共创辉煌.";
    self.textview.editable = NO;
    self.textview.font
    = [UIFont fontWithName:@"Arial"size:18.0];//设置字体名字和字体大小
    [self.view addSubview:self.textview];
    
}

@end
