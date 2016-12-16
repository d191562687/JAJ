//
//  ActIssueDetialViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/12/2.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "ActIssueDetialViewController.h"
#import "UserModel.h"
#import "UserInfoManager.h"
#import "Account.h"
#import "AccountTool.h"
#import "RootNavgationController.h"
#import "LoginViewController.h"
#import "ActivityViewController.h"

@interface ActIssueDetialViewController ()
/** 商品编号 */
@property (strong,nonatomic) IBOutlet UILabel * labelSPDA_SPBH;
/** 品名 */
@property (strong,nonatomic) IBOutlet UILabel * labelSPDA_PINM;
/** 规格 */
@property (strong,nonatomic) IBOutlet UILabel * labelSPDA_GUIG;
/** 市场价 */
@property (strong,nonatomic) IBOutlet UILabel * labelSPDA_PRICE;
/** 单位 */
@property (strong,nonatomic) IBOutlet UILabel * labelSPDA_ZXBZDW;
/** 生产厂家 */
@property (strong,nonatomic) IBOutlet UILabel * labelSPDA_SCG;
/** 终止时间 */
@property (strong, nonatomic) IBOutlet UITextField *textcjsk;
/** 集采数量 */
@property (strong, nonatomic) IBOutlet UITextField *textcjzzsj;
/** 集采价格 */
@property (strong, nonatomic) IBOutlet UITextField *textcjjg;
/** 市场价 */
@property (strong, nonatomic) IBOutlet UITextField *textscj;
/** 限购数量 */
@property (strong, nonatomic) IBOutlet UITextField *xgsl;
/** user信息 */
@property (strong,nonatomic) NSString * username;
@end

@implementation ActIssueDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布活动";
    
    [self addData];
    
}
- (IBAction)addissue:(id)sender {
    
    /**  获取登陆账号信息 */
    
    Account * account = [AccountTool account];
    if (account) {
    }
    if (!account) {
        //没有登陆去登陆页
        LoginViewController * loginVC = [LoginViewController new];
        RootNavgationController * nav = [[RootNavgationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:NO completion:nil];
   
    }else{
        //已经登陆情况发布订购信息
        NSLog(@"发布");
      
        UserModel * model = [UserInfoManager getUserInfo];
        self.username = [NSString stringWithFormat:@"%@",model.USER_ID];
        [self getData];
    }

    
}

/** 赋值 */
- (void)addData
{
    self.labelSPDA_SCG.text = _model.SPDA_SCG;
    self.labelSPDA_GUIG.text = _model.SPDA_GUIG;
    self.labelSPDA_PINM.text = _model.SPDA_PINM;
    self.labelSPDA_SPBH.text = _model.SPDA_SPBH;
    self.labelSPDA_PRICE.text = _model.SPDA_PRICE;
    self.labelSPDA_ZXBZDW.text = _model.SPDA_ZXBZDW;
    
   
}
- (void)getData
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appJCadd_URL];
    
    NSCharacterSet *whiteNewChars = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString * userId = [self.username stringByTrimmingCharactersInSet:whiteNewChars];
    NSString * zsjbm = [self.labelSPDA_SPBH.text stringByTrimmingCharactersInSet:whiteNewChars];
    NSString * pinm = [self.labelSPDA_PINM.text stringByTrimmingCharactersInSet:whiteNewChars];
    NSString * guig = [self.labelSPDA_GUIG.text stringByTrimmingCharactersInSet:whiteNewChars];
    NSString * danw = [self.labelSPDA_ZXBZDW.text stringByTrimmingCharactersInSet:whiteNewChars];
    NSString * sccj = [self.labelSPDA_SCG.text stringByTrimmingCharactersInSet:whiteNewChars];
    NSString * cjsl = [self.textcjjg.text stringByTrimmingCharactersInSet:whiteNewChars];
    NSString * cjzzsj = [self.textcjzzsj.text stringByTrimmingCharactersInSet:whiteNewChars];
    NSString * cjjg = [self.textcjjg.text stringByTrimmingCharactersInSet:whiteNewChars];
    NSString * scj = [self.textscj.text stringByTrimmingCharactersInSet:whiteNewChars];
    NSString * xgsl = [self.xgsl.text stringByTrimmingCharactersInSet:whiteNewChars];
    
    NSLog(@"whiteNewChars ===  %@",whiteNewChars);
    /** 属性判断 */
    if ([self.textcjjg.text isEqualToString:@""]) {
        [self showErrorTips:@"请输入终止时间"];
        return;
    }else
    if ([self.textcjzzsj.text isEqualToString:@""]) {
        [self showErrorTips:@"请输入集采数量"];
        return;
    }else
    if ([self.textcjjg.text isEqualToString:@""]) {
        [self showErrorTips:@"请输入集采价格"];
        return;
    }else
    if ([self.textscj.text isEqualToString:@""]) {
        [self showErrorTips:@"请输入市场价"];
        return;
    }else
    if ([self.xgsl.text isEqualToString:@""]) {
        [self showErrorTips:@"限购数量"];
        return;
    }

  //  请求参数：json={userId:"",zzjgId :"",zsjbm:"",pinm:"",guig:"",danw:"",sccj:"",cpzs:"",cjsl:"",cjzzsj:"",cjjg:"",scj:"",xgsl:""}
    NSDictionary *params = @{
                             @"userId":userId,
                             @"zzjgId" :cjzzsj,
                             @"zsjbm":zsjbm,
                             @"pinm":pinm,
                             @"guig":guig,
                             @"danw":danw,
                             @"sccj":sccj,
                             @"cpzs":@"",
                             @"cjsl":cjsl,
                             @"cjzzsj":cjzzsj,
                             @"cjjg":cjjg,
                             @"scj":scj,
                             @"xgsl":xgsl
                             };
    
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    NSLog(@"json ==  %@",json);
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject == %@",responseObject);
       
        NSString * code = [responseObject objectForKey:@"code"];
        NSString * desc = [responseObject objectForKey:@"desc"];
        if ([code isEqualToString:@"0000"]) {
            //成功
            ActivityViewController * actVC = [[ActivityViewController alloc]init];
            [self.navigationController pushViewController:actVC animated:YES];
        }else{
            //失败
            [self sendAlertAction:desc];
        }

        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self sendAlertAction:error.localizedDescription];
    }];
  
}

@end
