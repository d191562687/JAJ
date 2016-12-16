//
//  UserInfoManager.h
//  JAJ
//
//  Created by Chan_Sir on 2016/11/29.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

/********** 用户信息的管理者--对个人信息增删查改存 ************/

@interface UserInfoManager : NSObject
/**
 *  第一次智诚服务器后保存用户信息
 *
 *  @param model 用户模型
 */
+ (BOOL)saveInfoToSandBox:(UserModel *)model;

/**
 *  返回用户所有的数据
 *
 *  @return 用户模型
 */
+ (UserModel *)getUserInfo;

/**
 *  更新某条信息
 *
 *  @param key   ⚠️用户表格里的字段名。必须参照建表语句⚠️
 *  @param value ⚠️字段对应的值，需要更新的内容⚠️
 *
 *  @return 修改是否成功
 */
+ (BOOL)updataUserInfoWithKey:(NSString *)key Value:(NSString *)value;

/**
 *  先删除某条数据，再保存新的
 *
 *  @param indexID 是否成功
 */
+ (BOOL)deleteOneDataInfo:(NSInteger)indexID;


/**
 *  删除全部数据
 *
 *  @return 是否成功
 */
+ (BOOL)deleteAllData;



@end
