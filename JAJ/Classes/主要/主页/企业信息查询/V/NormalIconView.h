//
//  NormalIconView.h
//  YLZG
//
//  Created by Chan_Sir on 2016/10/8.
//  Copyright © 2016年 陈振超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalIconView : UIButton

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *label;
@property (assign,nonatomic) NSInteger index;


+ (instancetype)sharedHomeIconView;


@end
