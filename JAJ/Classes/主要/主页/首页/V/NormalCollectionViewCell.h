//
//  NormalCollectionViewCell.h
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalCollectionViewCell : UICollectionViewCell


@property (copy,nonatomic) NSString *iconName;

@property (copy,nonatomic) NSString *title;

+ (instancetype)sharedNormalCell:(UICollectionView *)collectionV IndexPath:(NSIndexPath *)indexPath;


@end
