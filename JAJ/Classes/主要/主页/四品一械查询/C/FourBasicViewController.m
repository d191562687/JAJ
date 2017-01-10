//
//  FourBasicViewController.m
//  JAJ
//
//  Created by 金安健 on 2017/1/10.
//  Copyright © 2017年 JinAnJian. All rights reserved.
//

#import "FourBasicViewController.h"

@interface FourBasicViewController ()

@property (strong, nonatomic) IBOutlet UILabel *qIX_TONGYM;
@property (strong, nonatomic) IBOutlet UILabel *qIX_ZHUCH;
@property (strong, nonatomic) IBOutlet UILabel *qIX_GUIGXHBB;
@property (strong, nonatomic) IBOutlet UILabel *qIX_CANGJ;
@property (strong, nonatomic) IBOutlet UILabel *qIX_ZSJBM;


@end

@implementation FourBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基本信息";
    
    [self getData];
}

- (void)getData
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appSpyxDetial_URL];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.fourModel.type forKey:@"type"];
    [dict setValue:self.fourModel.id forKey:@"id"];
    NSDictionary *json = @{@"json":[self switchToJsonStrFrom:dict]};
    
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        NSDictionary *data = [responseObject objectForKey:@"info"];
        /** 赋值 */
        if ([data objectForKey:@"QIX_TONGYM"]) {
            _qIX_TONGYM.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"QIX_TONGYM"]];
            _qIX_ZHUCH.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"QIX_ZHUCH"]];
            _qIX_GUIGXHBB.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"QIX_GUIGXHBB"]];
            _qIX_CANGJ.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"QIX_CANGJ"]];
            _qIX_ZSJBM.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"QIX_ZSJBM"]];
        }else{
           _qIX_TONGYM.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"YPZSJBMSH_TYM"]];
           _qIX_CANGJ.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"YPZSJBMSH_CHANGJ"]];
        }
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self sendAlertAction:error.localizedDescription];
    }];
}



@end
