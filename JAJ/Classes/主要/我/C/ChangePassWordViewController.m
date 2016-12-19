//
//  ChangePassWordViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/12/8.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import "UserInfoManager.h"

@interface ChangePassWordViewController ()
@property (strong, nonatomic) IBOutlet UITextField *textPassword;
@property (strong, nonatomic) IBOutlet UITextField *textNEWPAS1;
@property (strong, nonatomic) IBOutlet UITextField *textNEWPAS2;

@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    

}
- (IBAction)changePassWord:(id)sender {
    
    /** 密码修改 */
    [self getData];
    
}

- (void)getData
{
    
    if (self.textPassword.text.length < 1) {
        [self showErrorTips:@"密码不能为空"];
        return;
    }
    if (self.textNEWPAS1.text.length < 1) {
        [self showErrorTips:@"密码不能为空"];
        return;
    }
    if (self.textNEWPAS2.text.length < 1) {
        [self showErrorTips:@"密码不能为空"];
        return;
    }

    
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appShiyts_URL];
//    请求参数：json={USERNAME :"san",PASSWORD:"1",NEWPAS1:"2",NEWPAS2:"2"}
//    用户名		密码		新密码		确认密码
    
    UserModel * model = [UserInfoManager getUserInfo];
    
    NSDictionary *params = @{
                             @"USERNAME":model.USERNAME,
                             @"PASSWORD":self.textPassword.text,
                             @"NEWPAS1":self.textNEWPAS1.text,
                             @"NEWPAS2":self.textNEWPAS2.text
                             };

    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    
    NSLog(@"json = %@",json);
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {

        NSLog(@"responseObject = %@",responseObject);
        
        NSString *code = [[responseObject objectForKey:@"code"] description];
        NSString *desc = [[responseObject objectForKey:@"desc"] description];
        if ([code isEqualToString:@"0000"]) {
            // 成功
            [self showErrorTips:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            // 不成功
            [self sendAlertAction:desc];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self sendAlertAction:error.localizedDescription];
    }];
    
    
    
    
}


@end
