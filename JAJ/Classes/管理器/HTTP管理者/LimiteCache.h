//
//  LimiteCache.h
//  YLZG
//
//  Created by Chan_Sir on 16/9/30.
//  Copyright © 2016年 陈振超. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 缓存工具 */
@interface LimiteCache : NSObject
{
    NSTimeInterval myTime;//设置缓存的有效时间
}

//创建单利
+ (instancetype)shareInstance;
//存缓存
- (BOOL)saveWithData:(NSData *)data andNameString:(NSString *)urlString;
//读取缓存
- (NSData *)getDataWithNameString:(NSString *)urlString;


@end
