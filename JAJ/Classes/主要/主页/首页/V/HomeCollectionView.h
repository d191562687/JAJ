//
//  HomeCollectionView.h
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionView : UIView

@property (copy,nonatomic) void (^DidSelectBlock)(NSIndexPath *indexPath);

- (void)reloadData;

@end
