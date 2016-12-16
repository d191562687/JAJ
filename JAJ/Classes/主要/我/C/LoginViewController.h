//
//  LoginViewController.h
//  JAJ
//
//  Created by Chan_Sir on 2016/11/29.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "SuperViewController.h"


typedef void (^SaveCompleteBlock)();
@interface LoginViewController : SuperViewController

@property (copy,nonatomic) void (^ReloadTableView)();

@end
