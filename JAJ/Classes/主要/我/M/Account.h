//
//  Account.h
//  JAJ
//
//  Created by Chan_Sir on 2016/11/29.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 此模型主要为了记录账户是否登录 */


@interface Account : NSObject


/** 在服务器端的用户ID */
@property (nonatomic, strong) NSString *userID;
/** 登录账户 */
@property (strong,nonatomic) NSString *username;
/** 登录密码 */
@property (strong,nonatomic) NSString *password;



+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
