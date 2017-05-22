//
//  NearbyViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "NearbyViewController.h"
// 引入地图坐标转换库函数
#import "JZLocationConverter.h"

@interface NearbyViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>

// 当前城市
@property (nonatomic, copy) NSString * currentCity;
// 位置
// @property (nonatomic, strong) CLLocation * newLocation;
// 经度
@property (nonatomic, copy) NSString * latitude;
// 纬度
@property (nonatomic, copy) NSString * longitude;

@end

@implementation NearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self locate];
}


- (void) setUI {
    self.mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_WIDTH)];
    [self.view addSubview:self.mapView];

    UIButton * startLocateButton = [[UIButton alloc]initWithFrame:CGRectMake(50, SCREEN_WIDTH * 1.2, SCREEN_WIDTH - 100, 45)];
    startLocateButton.backgroundColor = [UIColor blueColor];
    [startLocateButton setTitle:@"开始定位" forState:UIControlStateNormal];
    [startLocateButton addTarget:self action:@selector(startUpdateLocation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startLocateButton];
    
}

- (void)locate {
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        // 设置寻址经度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0f;
        [_locationManager startUpdatingLocation];
        // 地图属性设置
        _mapView.showsUserLocation = YES;
        _mapView.rotateEnabled = NO;
    }
}

// 更新位置
- (void)startUpdateLocation:(id)sender {
    [_locationManager startUpdatingLocation];
    
    
    
}


// iOS7及之后的方法<定位成功>
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * newLocation = [locations lastObject];
    NSTimeInterval locationAge = - [newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 1.0){//如果调用已经一次，不再执行
        return;
    }
    // 处理相关定位信息
    _longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    _latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    NSLog(@"longitude = %@", _longitude);
    NSLog(@"latitude = %@", _latitude);
    //将经度显示到label上
    self.lblLongitude.text = [NSString stringWithFormat:@"%@", _longitude];
    //将纬度现实到label上
    self.lblLatitude.text = [NSString stringWithFormat:@"%@", _latitude];
    [manager stopUpdatingLocation];
    
    
    // 反向编码部分
    CLLocation * currentLocation = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark * placeMark = placemarks[0];
            _currentCity = placeMark.locality;
            //            NSLog(@"国家：%@", placeMark.country);
            //            NSLog(@"城市：%@", _currentCity);
            //            NSLog(@"当前位置：%@", placeMark.subLocality);
            //            NSLog(@"街道：%@", placeMark.thoroughfare);
            //            NSLog(@"详细地址：%@", placeMark.name);
            
            _txtViewLocation.text = [NSString stringWithFormat:@"详细地址：%@%@%@%@%@", placeMark.country,_currentCity,placeMark.subLocality,placeMark.thoroughfare,placeMark.name];
            
            //创建一个地图坐标
            CLLocationCoordinate2D coord;
            //设置坐标的经度
            coord.longitude = newLocation.coordinate.longitude;
            //设置坐标的纬度
            coord.latitude = newLocation.coordinate.latitude;
            //设置地图的缩放级别
            MKCoordinateSpan span;
            //设置经度的缩放级别
            span.longitudeDelta = 0.05;
            //设置纬度的缩放级别
            span.latitudeDelta = 0.05;
            // 地球坐标转换高德坐标
            CLLocationCoordinate2D coord2dConverted = [JZLocationConverter wgs84ToGcj02:(coord)];
            //设置当前地图的显示范围<参数1：地图的位置，参数2：地图显示的缩放级别>
            [self.mapView setRegion:MKCoordinateRegionMake(coord2dConverted, span)];
            _lblLongitudeMars.text = [NSString stringWithFormat:@"%f",coord2dConverted.longitude];
            _lblLatitudeMars.text = [NSString stringWithFormat:@"%f",coord2dConverted.latitude];
        }
        else if (error == nil && placemarks.count == 0){
            NSLog( @"没有找到地址");
        }
        else if (error) {
            NSLog(@"定位错误");
        }
    }];
}

// 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位失败");
}

// 地图显示
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
}


@end
