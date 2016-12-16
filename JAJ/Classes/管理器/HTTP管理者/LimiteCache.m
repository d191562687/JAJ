//
//  LimiteCache.m
//  YLZG
//
//  Created by Chan_Sir on 16/9/30.
//  Copyright © 2016年 陈振超. All rights reserved.
//

#import "LimiteCache.h"
#import "NSString+Hashing.m"

static LimiteCache * cache = nil;

@implementation LimiteCache

+ (instancetype)shareInstance {
    @synchronized(self){//给这个类上锁
        if (cache == nil) {
            cache = [[LimiteCache alloc] init];
        }
    }
    return cache;
}

// 保证分配了空间,不会出错
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self){
        if (cache == nil) {
            cache = [super allocWithZone:zone];
        }
        return cache;
    }
}

// 存入
// 根据接口不同保存文件 保存的是请求下来的data
- (BOOL)saveWithData:(NSData *)data andNameString:(NSString *)urlString{
    // 设置缓存路径
    NSString * path = [NSString stringWithFormat:@"%@/Documents/Cache/",NSHomeDirectory()];
    // 根据路径创建文件
    NSFileManager * mangager = [NSFileManager defaultManager];
    BOOL ret = [mangager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    if (ret) {
        KGLog(@"创建缓存路径成功");
    }else{
        KGLog(@"创建缓存路径失败");
    }
    // 根据接口加密保存文件,区分文件
    urlString = [urlString MD5Hash];
    // 根据接口拼接每个界面的缓存文件的路径
    NSString * cacheFilePath = [NSString stringWithFormat:@"%@%@",path,urlString];
    BOOL isWrite = [data writeToFile:cacheFilePath atomically:YES];
    if (isWrite) {
        KGLog(@"写入缓存成功");
    }else{
        KGLog(@"写入缓存失败");
    }
    return isWrite;
}

// 读取
- (NSData *)getDataWithNameString:(NSString *)urlString{
    // 根据接口获取路径
    urlString = [urlString MD5Hash];
    NSString * path = [NSString stringWithFormat:@"%@/Documents/Cache/%@",NSHomeDirectory(),urlString];
    // 判断路径是否存在
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        return nil;
    }
    // 根据缓存时间,判断是否需要重新请求
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:[self getLastWithFileDate:path]];
    if (timeInterval > 20*30*5*60) {  // 约缓存48小时
        return nil;
    }
    // 存在缓存,读取缓存
    NSData * data = [NSData dataWithContentsOfFile:path];
    return data;
}

// 获取本地缓存文件的最后写入时间
- (NSDate *)getLastWithFileDate:(NSString *)path{
    NSFileManager * manager = [NSFileManager defaultManager];
    // 获取制定的路径的下面的文件的最后修改时间属性,并返回
    NSDictionary * dic = [manager attributesOfItemAtPath:path error:nil];
    return dic[NSFileModificationDate];
}



@end
