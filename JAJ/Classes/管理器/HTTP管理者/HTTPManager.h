//
//  HTTPManager.h
//  YLZG
//
//  Created by Chan_Sir on 16/9/29.
//  Copyright © 2016年 陈振超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "LimiteCache.h"


/**
 *  宏定义请求成功的block
 *
 *  @param responseObject 请求成功返回的数据
 */
typedef void (^YLZGResponseSuccess)(NSURLSessionDataTask * task,id responseObject);

/**
 *  宏定义请求失败的block
 *
 *  @param error 报错信息
 */
typedef void (^YLZGResponseFail)(NSURLSessionDataTask * task, NSError * error);

/**
 *  上传或者下载的进度
 *
 *  @param progress 进度
 */

typedef void (^YLZGProgress)(NSProgress *progress);

/**
 完成某件事件后的回调
 */
typedef void(^YLZGComplition)();

@interface HTTPManager : NSObject


/**
 *  普通get方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+(void)GET:(NSString *)url
    params:(NSDictionary *)params success:(YLZGResponseSuccess)success
      fail:(YLZGResponseFail)fail;

/**
 *  普通post方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+(void)POST:(NSString *)url
     params:(NSDictionary *)params
    success:(YLZGResponseSuccess)success
       fail:(YLZGResponseFail)fail;


/**
 ⚠️需要缓存的数据。缓存时间48小时

 @param url     请求网址路径
 @param params  请求参数
 @param success 成功回调
 @param fail    失败回调
 */

+ (void)GETCache:(NSString *)url params:(NSDictionary *)params success:(YLZGResponseSuccess)success fail:(YLZGResponseFail)fail;


/**
 清除Data缓存
 */
+ (void)ClearCacheDataCompletion:(YLZGComplition)complition;

/**
 *  普通路径上传文件（图片、小视频、文件等）
 *
 *  @param url      请求网址路径
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param fail     失败回调
 */

+(void)uploadWithURL:(NSString *)url
              params:(NSDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(YLZGProgress)progress
             success:(YLZGResponseSuccess)success
                fail:(YLZGResponseFail)fail;

/**
 *  含有baseURL的get方法
 *
 *  @param url     请求网址路径
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+(void)GET:(NSString *)url baseURL:(NSString *)baseUrl
    params:(NSDictionary *)params success:(YLZGResponseSuccess)success fail:(YLZGResponseFail)fail;


@end
