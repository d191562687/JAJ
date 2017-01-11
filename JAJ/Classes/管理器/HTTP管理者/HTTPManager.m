//
//  HTTPManager.m
//  YLZG
//
//  Created by Chan_Sir on 16/9/29.
//  Copyright © 2016年 陈振超. All rights reserved.
//

#import "HTTPManager.h"

@implementation HTTPManager

+(void)GET:(NSString *)url params:(NSDictionary *)params
   success:(YLZGResponseSuccess)success fail:(YLZGResponseFail)fail{
    
    AFHTTPSessionManager *manager = [HTTPManager managerWithBaseURL:nil sessionConfiguration:NO];
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *URL = [url stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    [manager GET:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [HTTPManager responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(void)GET:(NSString *)url baseURL:(NSString *)baseUrl params:(NSDictionary *)params
   success:(YLZGResponseSuccess)success fail:(YLZGResponseFail)fail{
    
    AFHTTPSessionManager *manager = [HTTPManager managerWithBaseURL:baseUrl sessionConfiguration:NO];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *URL = [url stringByAddingPercentEncodingWithAllowedCharacters:set];
    [manager GET:URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [HTTPManager responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
    
}

+(void)POST:(NSString *)url params:(NSDictionary *)params
    success:(YLZGResponseSuccess)success fail:(YLZGResponseFail)fail{
    
    AFHTTPSessionManager *manager = [HTTPManager managerWithBaseURL:nil sessionConfiguration:NO];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *URL = [url stringByAddingPercentEncodingWithAllowedCharacters:set];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [HTTPManager responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}
+ (void)GETCache:(NSString *)url params:(NSDictionary *)params success:(YLZGResponseSuccess)success fail:(YLZGResponseFail)fail
{
    NSData *cacheData = [[LimiteCache shareInstance] getDataWithNameString:url];
    if (cacheData) {
        // 读取缓存成功
        id dic = [HTTPManager responseConfiguration:cacheData];
        success(nil,dic);
    }else{
        // 读取缓存失败、存数据
        AFHTTPSessionManager *manager = [HTTPManager managerWithBaseURL:nil sessionConfiguration:NO];
        
        NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
        NSString *URL = [url stringByAddingPercentEncodingWithAllowedCharacters:set];
        [manager GET:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            BOOL isSave = [[LimiteCache shareInstance] saveWithData:responseObject andNameString:URL];
            if (isSave) {
                NSError *error;
                NSJSONSerialization *jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
                if (!error) {
                    success(nil,jsonData);
                }
            }else{
                KGLog(@"存入缓存失败");
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail(task,error);
        }];
    }
}
+ (void)ClearCacheDataCompletion:(YLZGComplition)complition
{
    NSString * path = [NSString stringWithFormat:@"%@/Documents/Cache",NSHomeDirectory()];
    NSLog(@"path = %@",path);
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error;
        [fileManager removeItemAtPath:path error:&error];
        if (!error) {
            complition();
        }
    }
    
}
+ (void)uploadWithURL:(NSString *)url params:(NSDictionary *)params fileData:(NSData *)filedata name:(NSString *)name fileName:(NSString *)filename mimeType:(NSString *)mimeType progress:(YLZGProgress)progress success:(YLZGResponseSuccess)success fail:(YLZGResponseFail)fail
{
    AFHTTPSessionManager *manager = [HTTPManager managerWithBaseURL:nil sessionConfiguration:NO];
    
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [HTTPManager responseConfiguration:responseObject];
        success(task,dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL  sessionConfiguration:(BOOL)isconfiguration{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager =nil;
    
    NSURL *url = [NSURL URLWithString:baseURL];
    
    if (isconfiguration) {
        
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    }else{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    
    //申明请求的数据是json类型
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"json/text", nil];
    [manager.requestSerializer setTimeoutInterval:10.0];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    return manager;
}
+(id)responseConfiguration:(id)responseObject{
    
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
//    NSLog(@"--string----%@",string);
//    NSLog(@"--data----%@",data);
//    NSLog(@"--dic----%@",dic);
     
    if (error) {
        return error.localizedDescription;
    }else{
        return dic;
    }
}


@end
