//
//  UserInfoManager.m
//  JAJ
//
//  Created by Chan_Sir on 2016/11/29.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "UserInfoManager.h"
#import <MJExtension.h>
#import <FMDB.h>


static FMDatabase *_db;
@implementation UserInfoManager


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)initialize
{
    // 打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"t_user.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    BOOL open = [_db open];
    if (open) {
        KGLog(@"打开数据库成功");
    } else {
        KGLog(@"打开数据库失败");
        return;
    }
    
    // 建表语句 缺少head、
    BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_user (id integer PRIMARY KEY AUTOINCREMENT,LAST_LOGIN text,SKIN text,NUMBER text,PASSWORD text,USER_ID text,USERNAME text,STATUS text,NAME text,EMAIL text,RIGHTS text,ROLE_ID text,PHONE text,IP text,BZ text,R1 text,OTHERS text,ADDRESS text,SEX text,BIRTHDAY text);"];
    if (result) {
        KGLog(@"表格创建成功");
    }else{
        KGLog(@"表格创建失败");
    }
}

#pragma mark - 保存
+ (BOOL)saveInfoToSandBox:(UserModel *)model
{
    
    NSString *sql = [NSString stringWithFormat:@"insert into t_user (LAST_LOGIN,SKIN,NUMBER,PASSWORD,USER_ID,USERNAME,STATUS,NAME,EMAIL,RIGHTS,ROLE_ID,PHONE,IP,BZ,R1,OTHERS,ADDRESS,SEX,BIRTHDAY) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",model.LAST_LOGIN,model.SKIN,model.NUMBER,model.PASSWORD,model.USER_ID,model.USERNAME,model.STATUS,model.NAME,model.EMAIL,model.RIGHTS,model.ROLE_ID,model.PHONE,model.IP,model.BZ,model.R1,model.OTHERS,model.ADDRESS,model.SEX,model.BIRTHDAY];
    
    BOOL result = [_db executeUpdate:sql];
    return result;
}
#pragma mark - 修改
+ (BOOL)updataUserInfoWithKey:(NSString *)key Value:(NSString *)value
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE t_user SET '%@' = '%@'",key,value];
    BOOL result = [_db executeUpdate:sql];
    return result;
}

#pragma mark - 查询我的信息
+ (UserModel *)getUserInfo
{
    if (![_db open]) {
        return nil;
    }
    
    NSString *sql = @"select * from t_user";
    FMResultSet *result = [_db executeQuery:sql];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        UserModel *user = [[UserModel alloc]init];
        user.LAST_LOGIN = [result stringForColumn:@"LAST_LOGIN"];
        user.SKIN = [result stringForColumn:@"SKIN"];
        user.NUMBER = [result stringForColumn:@"NUMBER"];
        user.PASSWORD = [result stringForColumn:@"PASSWORD"];
        user.USER_ID = [result stringForColumn:@"USER_ID"];
        user.USERNAME = [result stringForColumn:@"USERNAME"];
        user.STATUS = [result stringForColumn:@"STATUS"];
        user.NAME = [result stringForColumn:@"NAME"];
        user.EMAIL = [result stringForColumn:@"EMAIL"];
        user.RIGHTS = [result stringForColumn:@"RIGHTS"];
        user.ROLE_ID = [result stringForColumn:@"ROLE_ID"];
        user.PHONE = [result stringForColumn:@"PHONE"];
        user.IP = [result stringForColumn:@"IP"];
        user.BZ = [result stringForColumn:@"BZ"];
        user.R1 = [result stringForColumn:@"R1"];
        user.OTHERS = [result stringForColumn:@"OTHERS"];
        user.ADDRESS = [result stringForColumn:@"ADDRESS"];
        user.SEX = [result stringForColumn:@"SEX"];
        user.BIRTHDAY = [result stringForColumn:@"BIRTHDAY"];

        
        [array addObject:user];
    }
    UserModel *model = [array lastObject];
    return model;
}
#pragma mark - 删除数据
+ (BOOL)deleteOneDataInfo:(NSInteger)indexID
{
    BOOL result;
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"delete from t_user where id = '%ld'",(long)indexID];
        result = [_db executeUpdate:sql];
        return result;
    }else{
        return result;
    }
    
}

#pragma mark - 删除t_user表格中的全部数据
+ (BOOL)deleteAllData
{
    NSString *sql = @"DELETE FROM t_user";
    BOOL result = [_db executeUpdate:sql];  // NO
    return result;
}

- (void)dealloc
{
    [_db close];
}


@end
