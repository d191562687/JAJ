//
//  ClearCacheTool.m
//  佛友圈
//
//  Created by Chan_Sir on 16/3/30.
//  Copyright © 2016年 陈振超. All rights reserved.
//

#import "ClearCacheTool.h"
#import "SDImageCache.h"
#import "UserInfoManager.h"


@implementation ClearCacheTool

+ (CGFloat)fileSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error;
        long long size = [fileManager attributesOfItemAtPath:path error:&error].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

+ (CGFloat)fonderSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize += [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

+ (void)clearSDWebImageCache:(NSString *)path{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            KGLog(@"---fileName = %@---",fileName);
            if ([fileName isEqualToString:@"t_user.sqlite"]) {
                // ⚠️ 在这里删除数据 但不删除数据库📂
                [UserInfoManager deleteAllData];
                
            }else{
                // ⚠️ 连同文件夹一起删掉
                NSError *error;
                NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:&error];
            }
        }
    }
    
    [[SDImageCache sharedImageCache] cleanDisk];
}

/*********************获取文件路径********************/

+ (NSString *)homePath{
    return NSHomeDirectory();
}

+ (NSString *)appPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)docPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

+ (NSString *)libPrefPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}

+ (NSString *)libCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+ (NSString *)tmpPath
{
    return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}

+ (BOOL)hasLive:(NSString *)path
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    
    return NO;
}

@end
