//
//  ClearCacheTool.h
//  佛友圈
//
//  Created by Chan_Sir on 16/3/30.
//  Copyright © 2016年 陈振超. All rights reserved.
//

#import <Foundation/Foundation.h>

/************ 清除缓存工具 ***********/

@interface ClearCacheTool : NSObject

/** 计算单个文件的大小 */
+ (CGFloat)fileSizeAtPath:(NSString *)path;
/** 计算文件目录的大小 */
+ (CGFloat)fonderSizeAtPath:(NSString *)path;
/** 清理SD图片缓存 */
+ (void)clearSDWebImageCache:(NSString *)path;

/*********************获取文件路径********************/
+ (NSString *)homePath;     // 程序主目录，可见子目录(3个):Documents、Library、tmp
+ (NSString *)appPath;        // 程序目录，不能存任何东西
+ (NSString *)docPath;        // 文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据
+ (NSString *)libPrefPath;    // 配置目录，配置文件存这里
+ (NSString *)libCachePath;    // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tmpPath;        // 临时缓存目录，APP退出后，系统可能会删除这里的内容
+ (BOOL)hasLive:(NSString *)path; //判断目录是否存在，不存在则创建

@end
