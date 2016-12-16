//
//  ActSearchDetialViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/11/30.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "ActSearchDetialViewController.h"
#import "AccountTool.h"
#import "LoginViewController.h"
#import "RootNavgationController.h"
#import "UserModel.h"
#import "UserInfoManager.h"
#import "ActivityViewController.h"

@interface ActSearchDetialViewController ()<UITextFieldDelegate>

/** 活动发起时间 */
@property (strong, nonatomic) IBOutlet UILabel *FQSJ;

/** 活动终止时间 */
@property (strong,nonatomic) IBOutlet UILabel *CJZZSJ;
/** 集采现价 */
@property (assign,nonatomic) IBOutlet UILabel * CJJG;
/** 市场价 */
@property (assign,nonatomic) IBOutlet UILabel * SCJ;
/** 限购数量*/
@property (assign,nonatomic) IBOutlet UILabel * XGSL;
/** 集采数量*/
@property (assign,nonatomic) IBOutlet UILabel * CJSL;
/** 品名 */
@property (strong,nonatomic) IBOutlet UILabel * PINM;
/** 生产厂家 */
@property (strong,nonatomic) IBOutlet UILabel * SCCJ;
/** 已集采数 */
@property (assign,nonatomic) IBOutlet UILabel * YCJSL;
/** 单据编号 */
@property (strong, nonatomic) IBOutlet UILabel *DJBH;
/** 规格 */
@property (strong,nonatomic) IBOutlet UILabel * GUIG;
/** 单位 */
@property (strong,nonatomic) IBOutlet UILabel * DANW;
/** 发起人 */
@property (strong,nonatomic) IBOutlet UILabel * FQR;
/** 活动机构 */
@property (strong,nonatomic) IBOutlet UILabel * ZZJG_NAME;
/** 订购金额 */
@property (strong,nonatomic) IBOutlet UILabel * DG;
/** 数量 */
@property (strong,nonatomic) IBOutlet UITextField * DGSL;

@property (strong,nonatomic) NSString * username;

@end

@implementation ActSearchDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品详情";
    
    [self setData];
    [self setTextfield];
    
}


- (void)setData
{
    /** 赋值 */
    self.FQSJ.text = _model.FQSJ;
    self.CJZZSJ.text = _model.CJZZSJ;
    self.CJJG.text = _model.CJJG;
    self.SCJ.text = _model.SCJ;
    self.XGSL.text = _model.XGSL;
    self.CJJG.text = _model.CJJG;
    self.PINM.text = _model.PINM;
    self.SCCJ.text = _model.SCCJ;
    self.YCJSL.text = _model.YCJSL;
    self.DJBH.text = _model.DJBH;
    self.GUIG.text = _model.GUIG;
    self.DANW.text = _model.DANW;
    self.FQR.text = _model.FQR;
    self.ZZJG_NAME.text = _model.ZZJG_NAME;
    
}

- (void)setTextfield
{
    self.DGSL.placeholder = @"请输入订购数量";
    self.DGSL.textColor = [UIColor redColor];
    self.DGSL.clearButtonMode = UITextFieldViewModeAlways;
    self.DGSL.delegate = self;
    //键盘类型
//        self.DGSL.keyboardType = UIKeyboardTypeNumberPad;

    [self.DGSL addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    

}
-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed --- : %@", theTextField.text);
    /** 输入数量得到价格 */
        if ([theTextField isEqual:@""]) {
            self.DG.text = nil;
        }
            [self getData];
    
}


- (void)getData
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,Jzcggl_URL];
    
    NSCharacterSet *whiteNewChars = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString * cjjg = [self.CJJG.text stringByTrimmingCharactersInSet:whiteNewChars];
    NSString * dgsl = [self.DGSL.text stringByTrimmingCharactersInSet:whiteNewChars];
    
//    NSLog(@"whiteNewChars ===  %@",whiteNewChars);
    if (dgsl > 0) {
        NSDictionary *params = @{
                                 @"CJJG":cjjg,
                                 @"DGSL":dgsl
                                 };
        
        NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
        NSDictionary *json = @{@"json":p1Str};
        
        [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
            
            
            NSLog(@"responseObject = %@",responseObject);
            NSString *code = [[responseObject objectForKey:@"code"] description];
//            NSString *desc = [[responseObject objectForKey:@"desc"] description];
            if ([code isEqualToString:@"0000"]) {
                // 成功
                NSArray *data = [responseObject objectForKey:@"data"];
                self.DG.text = [NSString stringWithFormat:@"%@",data];
            }else{
                // 不成功
            //    [self sendAlertAction:desc];
                self.DG.text = nil;
            }
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self sendAlertAction:error.localizedDescription];
        }];
    }
}


//设置只能输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (IBAction)sureOders:(id)sender {
    /** 获得账号信息 */
    Account * account = [AccountTool account];
    if (!account) {
        //没有登陆去登陆页
        LoginViewController * loginVC = [LoginViewController new];
        RootNavgationController * nav = [[RootNavgationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:NO completion:nil];
        
        
    }else{
        //已经登陆情况发布订购信息
        if ([self.DG.text isEqualToString:@"0"]) {
            [self showErrorTips:@"请输入订购数量"];
            return ;
        }
        NSLog(@"发布");
        UserModel * model = [UserInfoManager getUserInfo];
        self.username = [NSString stringWithFormat:@"%@",model.USER_ID];
        [self pushChangeNumber];
        
        
    }
}

/** 上传修改订购 */
- (void)pushChangeNumber
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,changeJCSL_URL];
    
           //json={uname:""，JZCGFB_ID:"",DGSL:"",DGJE:""} 用户名，发布ID，订购数量，订购金额
        NSDictionary *params = @{
                                 @"uname":self.username,
                                 @"JZCGFB_ID":_model.JZCGFB_ID,
                                 @"DGSL":[NSString stringWithFormat:@"%@",self.DGSL.text],
                                 @"DGJE":[NSString stringWithFormat:@"%@",self.DG.text]
                                 };
        NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
        NSDictionary *json = @{@"json":p1Str};
    
        [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
            
            
            //     NSLog(@"responseObject = %@",responseObject);
            NSString *code = [[responseObject objectForKey:@"code"] description];
            NSString *desc = [[responseObject objectForKey:@"desc"] description];
            if ([code isEqualToString:@"0000"]) {
                // 成功  跳转搜索页
                ActivityViewController * actVC = [[ActivityViewController alloc]init];
                [self.navigationController pushViewController:actVC animated:YES];
                
            }else{
                // 不成功
                    [self sendAlertAction:desc];
         
            }
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self sendAlertAction:error.localizedDescription];
        }];

}
@end
