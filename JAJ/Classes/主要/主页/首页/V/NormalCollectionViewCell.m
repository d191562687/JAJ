//
//  NormalCollectionViewCell.m
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "NormalCollectionViewCell.h"
#import <Masonry.h>


@interface NormalCollectionViewCell ()

@property (strong,nonatomic) UIImageView *iconV;

@property (strong,nonatomic) UILabel *titleL;

@end

@implementation NormalCollectionViewCell

+ (instancetype)sharedNormalCell:(UICollectionView *)collectionV IndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"NormalCollectionViewCell";
    NormalCollectionViewCell *cell = [collectionV dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (!cell) {
        cell = [[NormalCollectionViewCell alloc]init];
    }
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.iconV = [[UIImageView alloc]init];
    [self addSubview:self.iconV];
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-6);
        make.width.and.height.equalTo(@30);
    }];
    
    self.titleL = [[UILabel alloc]init];
    self.titleL.font = [UIFont systemFontOfSize:12];
    self.titleL.textAlignment = NSTextAlignmentCenter;
    self.titleL.textColor = RGBACOLOR(56, 56, 56, 1);
    [self addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconV.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@21);
    }];
}

- (void)setTitle:(NSString *)title
{
    _titleL.text = title;
}
- (void)setIconName:(NSString *)iconName
{
    _iconV.image = [UIImage imageNamed:iconName];
}

@end
