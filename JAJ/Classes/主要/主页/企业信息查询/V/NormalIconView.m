//
//  NormalIconView.m
//  YLZG
//
//  Created by Chan_Sir on 2016/10/8.
//  Copyright © 2016年 陈振超. All rights reserved.
//

#import "NormalIconView.h"
#import <Masonry.h>

@implementation NormalIconView

+ (instancetype)sharedHomeIconView
{
    return [[self alloc]init];
}
- (void)setIndex:(NSInteger)index
{
    _index = index;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MainColor;
        [self setupSubViews];
        
    }
    return self;
}

- (void)setupSubViews
{
    self.iconView = [[UIImageView alloc]init];
    self.iconView.image = [UIImage imageNamed:@"big_nodata"];
    [self addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-5);
        make.width.equalTo(@42);
        make.height.equalTo(@42);
    }];
    
    self.label = [[UILabel alloc]init];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    self.label.textColor = [UIColor whiteColor];
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(2);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@20);
    }];
    
}


@end
