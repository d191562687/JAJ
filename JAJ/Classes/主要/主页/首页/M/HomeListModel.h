//
//  HomeListModel.h
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeListModel : NSObject

@property (copy,nonatomic) NSString *ID;

@property (copy,nonatomic) NSString *HDZT;

@property (copy,nonatomic) NSString *ROW_ID;

@property (strong,nonatomic) NSString *POST_TIME;

@property (assign,nonatomic) int TYPE;

@property (copy,nonatomic) NSString *TITLE;


@end
