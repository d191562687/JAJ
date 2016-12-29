//
//  JAJAnnotation.h
//  JAJ
//
//  Created by 金安健 on 2016/12/28.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface JAJAnnotation : NSObject<MKAnnotation>
//创建大头针标注模型，必须遵守标注模型的协议

//遵循协议之后，必须要声明三个属性
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subtitle;

@end
