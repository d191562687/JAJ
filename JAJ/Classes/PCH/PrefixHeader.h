//
//  PrefixHeader.h
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h


#import "JAJDefineKey.h"
#import "UIView+Extension.h"
#import "NSDate+Category.h"
#import "HTTPManager.h"
#import "UIViewController+Actions.h"
#import <YYKit.h>
#import "PCH_HTTP_URL.h"
#import "JAJConstKey.h"

/** 高德地图密钥 */ // @"10e451dfecff3a5367e4aa484ab72e59"
#define MapSecret @"10e451dfecff3a5367e4aa484ab72e59"

/** 四品一械追溯 */
#define PADDING_OF_LEFT_STEP_LINE 50
#define PADDING_OF_LEFT_RIGHT 15
#define WIDTH_OF_PROCESS_LABLE (300 *[UIScreen mainScreen].bounds.size.width / 375)

#endif
