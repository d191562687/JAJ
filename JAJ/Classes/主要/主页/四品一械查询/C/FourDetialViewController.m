//
//  FourDetialViewController.m
//  JAJ
//
//  Created by Chan_Sir on 2016/12/20.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "FourDetialViewController.h"

@interface FourDetialViewController ()

@end

@implementation FourDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.fourModel.name;
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
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self sendAlertAction:error.localizedDescription];
    }];
    
}

@end
