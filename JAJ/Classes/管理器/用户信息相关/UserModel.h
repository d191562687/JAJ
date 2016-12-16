//
//  UserModel.h
//  JAJ
//
//  Created by Chan_Sir on 2016/11/29.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <Foundation/Foundation.h>


/*********** 用户详细信息模型 **********/

@interface UserModel : NSObject

/** 上次登录时间 */
@property (copy,nonatomic) NSString *LAST_LOGIN;
/** SKIN */
@property (copy,nonatomic) NSString *SKIN;
/** NUMBER */
@property (copy,nonatomic) NSString *NUMBER;
/** 密码 */
@property (copy,nonatomic) NSString *PASSWORD;
/** 用户ID */
@property (copy,nonatomic) NSString *USER_ID;
/** 登录名 */
@property (copy,nonatomic) NSString *USERNAME;
/** STATUS */
@property (copy,nonatomic) NSString *STATUS;
/** 昵称 */
@property (copy,nonatomic) NSString *NAME;
/** 邮箱 */
@property (copy,nonatomic) NSString *EMAIL;
/** RIGHTS */
@property (copy,nonatomic) NSString *RIGHTS;
/** ROLE_ID */
@property (copy,nonatomic) NSString *ROLE_ID;
/** 电话号码 */
@property (copy,nonatomic) NSString *PHONE;
/** IP */
@property (copy,nonatomic) NSString *IP;
/** BZ */
@property (copy,nonatomic) NSString *BZ;
/** R1 */
@property (copy,nonatomic) NSString *R1;


/** 万一将来新增用户字段，存在这里 */
@property (copy,nonatomic) NSString *OTHERS;


//后加
/** 地址 */
@property (copy,nonatomic) NSString *ADDRESS;
/** 性别 */
@property (copy,nonatomic) NSString *SEX;
/** 生日 */
@property (copy,nonatomic) NSString *BIRTHDAY;


@end
