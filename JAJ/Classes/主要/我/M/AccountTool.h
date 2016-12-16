//
//  AccountTool.h
//  JAJ
//
//  Created by Chan_Sir on 2016/11/29.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AccountTool : NSObject

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(Account *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型
 */
+ (Account *)account;

@end
