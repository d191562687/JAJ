//
//  RegisterViewController.h
//  JAJ
//
//  Created by Chan_Sir on 2016/12/12.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "SuperViewController.h"


@interface RegisterViewController : SuperViewController

@property (copy,nonatomic) void (^ReloadTableView)(NSString *userName,NSString *pass);

@end
