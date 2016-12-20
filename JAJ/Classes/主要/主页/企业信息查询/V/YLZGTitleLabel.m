//
//  YLZGTitleLabel.m
//  YLZG
//
//  Created by Chan_Sir on 2016/10/10.
//  Copyright © 2016年 陈振超. All rights reserved.
//

#import "YLZGTitleLabel.h"
#import <Masonry.h>

@interface YLZGTitleLabel ()


@end

@implementation YLZGTitleLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = MainColor;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        self.userInteractionEnabled = YES;
        self.scale = 0.0;
        
        [self kkk];
    }
    return self;
}

- (void)kkk
{
    UIImageView *xian = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xuxian"]];
    xian.frame = CGRectMake(0, 0, self.width, 1);
    [self addSubview:xian];
}

/** 通过scale的改变改变多种参数 */
- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    self.textColor = [UIColor whiteColor];
    CGFloat minScale = 0.8;
    CGFloat trueScale = minScale + (1 - minScale) * scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
    
}



@end
