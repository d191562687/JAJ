//
//  JAJDefineKey.h
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#ifndef JAJDefineKey_h
#define JAJDefineKey_h

#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

// RGB
#define RGBACOLOR(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
// 蒙蒙的图层
#define CoverColor RGBACOLOR(79, 79, 100, 0.8)
// 随机颜色
#define HWRandomColor RGBACOLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256),1)
// 当前控制器默认背景颜色
#define BackGroudColor RGBACOLOR(235, 235, 241, 1)
//  比例
#define CKproportion [[UIScreen mainScreen] bounds].size.width/375.0f
// 主要颜色
#define MainColor RGBACOLOR(31, 139, 229, 1)
// 导航控制器颜色 RGBACOLOR(58, 58, 58, 1)
#define NavColor MainColor
// 子线程
#define ZCGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
// 主线程
#define ZCMainQueue dispatch_get_main_queue()


#ifdef DEBUG // 处于开发阶段
#define KGLog(...) NSLog(__VA_ARGS__)
#else // 处于发布阶段
#define KGLog(...)
#endif

#define LogFuncName KGLog(@"___%s___",__func__);

#endif /* JAJDefineKey_h */
