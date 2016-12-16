//
//  UIViewController+Actions.h
//  JAJ
//
//  Created by Chan_Sir on 2016/11/28.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Actions)

/** 颜色生成图片 */
- (UIImage *)imageWithBgColor:(UIColor *)color;
/** AlertC提示 */
- (void)sendAlertAction:(NSString *)message;
/** 成功的提示 */
- (void)showSuccessTips:(NSString *)successMsg;
/** 错误的提示 */
- (void)showErrorTips:(NSString *)errorMsg;
/** 正在加载 */
- (void)showHudMessage:(NSString *)message;


/**
 将数组或字典转成json字符串

 @param object 数组、字典···
 @return json字符串
 */
- (NSString *)switchToJsonStrFrom:(id)object;


@end
