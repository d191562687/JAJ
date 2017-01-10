//
//  FourDetialViewController.h
//  JAJ
//
//  Created by Chan_Sir on 2016/12/20.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "SuperViewController.h"
#import "FourModel.h"
#import "FourBasicViewController.h"

@interface FourDetialViewController : SuperViewController<UIScrollViewDelegate,UIViewControllerTransitioningDelegate>

@property (strong,nonatomic) FourModel *fourModel;



@end
