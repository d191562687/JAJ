//
//  UIViewController+Actions.m
//  JAJ
//
//  Created by Chan_Sir on 2016/11/28.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "UIViewController+Actions.h"
#import <MBProgressHUD.h>


static CGFloat HideMinites = 3;

@implementation UIViewController (Actions)

- (UIImage *)imageWithBgColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

- (void)sendAlertAction:(NSString *)message
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:action1];
    [self presentViewController:alertC animated:YES completion:^{
        
    }];
}

- (NSString *)switchToJsonStrFrom:(id)object
{
    NSError *error = nil;
    // ⚠️ 参数可能是模型数组，需要转字典数组
    if (object) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
        if (jsonData.length < 5 || error) {
            KGLog(@"解析错误");
        }
        NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}

- (void)showErrorTips:(NSString *)errorMsg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = UIPushBehaviorModeInstantaneous;
    hud.label.text = errorMsg;
    hud.customView.backgroundColor = [UIColor blackColor];
    hud.animationType = MBProgressHUDModeIndeterminate;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.mode = MBProgressHUDModeCustomView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(HideMinites * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
    
}
- (void)showSuccessTips:(NSString *)successMsg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = UIPushBehaviorModeInstantaneous;
    hud.label.text = successMsg;
    hud.customView.backgroundColor = [UIColor blackColor];
    hud.animationType = MBProgressHUDModeIndeterminate;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.mode = MBProgressHUDModeCustomView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(HideMinites * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
}

- (void)showHudMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = UIPushBehaviorModeContinuous;
    hud.label.text = message;
    hud.customView.backgroundColor = [UIColor blackColor];
    hud.animationType = MBProgressHUDModeIndeterminate;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;

}

@end
