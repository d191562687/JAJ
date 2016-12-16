//
//  MapViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/11/28.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "MapViewController.h"




@interface MapViewController ()<MAMapViewDelegate, AMapSearchDelegate>

@property (strong,nonatomic) MAMapView * mapView;
@end

@implementation MapViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地图";
    [AMapServices sharedServices].apiKey = MapSecret;   //初始化地图

    //把地图放在底层
    [self.view insertSubview:self.mapView atIndex:0];
    
    
    //构造圆
    MACircle *circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(39.952136, 116.50095) radius:5000];
    
    //在地图上添加圆
    [_mapView addOverlay: circle];
    
}

//地图懒加载
- (MAMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
        
        [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:NO]; //地图跟着位置移动
        
        //自定义定位经度圈样式
        _mapView.customizeUserLocationAccuracyCircleRepresentation = NO;
        //地图跟踪模式
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        
        //后台定位
        _mapView.pausesLocationUpdatesAutomatically = NO;
        
        _mapView.allowsBackgroundLocationUpdates = YES;//iOS9以上系统必须配置
        
    }
    return _mapView;
}



-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}



@end
