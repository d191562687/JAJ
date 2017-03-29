//
//  MapViewController.m
//  JAJ
//
//  Created by 金安健 on 2016/11/28.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//
//系统版本号是否大于8.0
#define IS_SystemVersionGreaterThanEight  ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0)

#import "MapViewController.h"
#import "JAJAnnotation.h"
#import <CoreLocation/CoreLocation.h>

@interface MapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
/** 终点坐标 */
@property (assign,nonatomic) CLLocationCoordinate2D coordinate;
/** 地图 */
@property (strong,nonatomic) MKMapView * mapView;
//创建管理者
@property (nonatomic,strong)CLLocationManager *locationManager;
//位置数据
@property (nonatomic, strong)NSMutableArray *pointArray;
/** 导航按钮 */
@property (strong,nonatomic) UIButton * buttonMap;
///地理编码器
@property(nonatomic, strong)CLGeocoder *geocoder;

@end

@implementation MapViewController
//懒加载
- (NSMutableArray *)pointArray {
    if (_pointArray == nil) {
        self.pointArray = [NSMutableArray array];
    }
    return _pointArray;
}
- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
    }
    return _locationManager;
}
- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地图";
//    [AMapServices sharedServices].apiKey = MapSecret;   //初始化地图
  
    //把地图放在底层
    [self.view insertSubview:self.mapView atIndex:0];

    [self setlocationManager];
    
}
//设置定位服务
- (void)setlocationManager
{
    //初始化locationManger管理器对象
    CLLocationManager *locationManager=[[CLLocationManager alloc]init];
    self.locationManager=locationManager;
    
    //判断当前设备定位服务是否打开
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"设备尚未打开定位服务");
    }
    
    //判断当前设备版本大于iOS8以后的话执行里面的方法
    if ([UIDevice currentDevice].systemVersion.floatValue >=8.0) {
        //持续授权
        [locationManager requestAlwaysAuthorization];
        //当用户使用的时候授权
        [locationManager requestWhenInUseAuthorization];
    }
    
    //或者使用这种方式,判断是否存在这个方法,如果存在就执行,没有的话就忽略
    //if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
    //   [locationManager requestWhenInUseAuthorization];
    //}

    //设置代理
    locationManager.delegate=self;
    //设置定位的精度
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    //设置定位的频率,这里我们设置精度为100,也就是100米定位一次
    CLLocationDistance distance= 100;
    //给精度赋值
    locationManager.distanceFilter=distance;
    //开始启动定位
    [locationManager startUpdatingLocation];
 
}

//当位置发生改变的时候调用(上面我们设置的是100米,也就是当位置发生>100米的时候该代理方法就会调用)
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //取出第一个位置
    CLLocation *location=[locations firstObject];
    NSLog(@"%@",location.timestamp);
    //位置坐标
    CLLocationCoordinate2D coordinate=location.coordinate;
    NSLog(@"您的当前位置:经度：%f,纬度：%f,海拔：%f,航向：%f,速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    //[_locationManager stopUpdatingLocation];

    NSString * lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    NSString * lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    [self getDataWithLat:lat Lon:lon];
    
}


//地图懒加载
- (MKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
        
        [_mapView setUserTrackingMode: MKUserTrackingModeFollow animated:NO]; //地图跟着位置移动
//        //自定义定位经度圈样式
//        _mapView.customizeUserLocationAccuracyCircleRepresentation = YES ;
        //地图跟踪模式
        _mapView.userTrackingMode = MKUserTrackingModeFollow;
      
    }
    return _mapView;
}
/** 导航 */
- (void)setMapData
{
    
    //1. 申请授权
    [self.locationManager requestAlwaysAuthorization];
    
    //2. 设置导航参数
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    ///字典中的value不能是基本数据类型?
    dicM[MKLaunchOptionsShowsTrafficKey] = @YES;
    dicM[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
    //3.获得当前位置
    MKMapItem *item1 = [MKMapItem mapItemForCurrentLocation];
    
    //4. 地理解码
    [self.geocoder geocodeAddressString:@"故宫" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        ///从字典中拿出地点信息
        CLPlacemark *place = placemarks.firstObject;
        ///转化成MKPlacemark
        MKPlacemark *placemark = [[MKPlacemark alloc]initWithPlacemark:place];
        
        ///创建终点
        MKMapItem *item2 = [[MKMapItem alloc] initWithPlacemark:placemark];
        
        ///进行导航
        [MKMapItem openMapsWithItems:@[item1, item2] launchOptions:dicM];
    }];
}

/** 数据请求 */
- (void)getDataWithLat:(NSString *)lat Lon:(NSString *)lon
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ip_port,appMap_URL];
//    json={"lat":"","lng":""}
    NSDictionary *params = @{
                             @"lat":lat,
                             @"lng":lon
                             };
    NSString *p1Str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSDictionary *json = @{@"json":p1Str};
    NSLog(@"----json------%@",json);
    [HTTPManager POST:url params:json success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject = %@",responseObject);
 
        /** UD存储地图坐标 */
        NSUserDefaults * map = [NSUserDefaults standardUserDefaults];
        [map setObject:responseObject forKey:UDmap];
       
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self sendAlertAction:error.localizedDescription];
    }];
    /** 显示大头针 */
    [self showPOIAnnotations];
}

/** 创建大头针 */
- (void)showPOIAnnotations
{
    /** 获取数据 */
    NSUserDefaults *map = [NSUserDefaults standardUserDefaults];
    NSDictionary *mapArray = [map objectForKey:@"UDmap"];
    NSData *jsdata = [NSJSONSerialization dataWithJSONObject:mapArray[@"data"] options:NSJSONWritingPrettyPrinted error:nil];
    /** 提取数据 */
    if (jsdata) {
        NSArray *dicArray = [NSJSONSerialization JSONObjectWithData:jsdata options:NSJSONReadingAllowFragments error:nil];

        for (NSDictionary * dic in dicArray ) {
            //位置
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = [dic[@"LAT"] doubleValue];
            coordinate.longitude = [dic[@"LNG"] doubleValue];
            //信息
            NSString * titleMap = [NSString stringWithFormat:@"%@",dic[@"GSDZ"]];
            NSString * subtitleMap = [NSString stringWithFormat:@"%@",dic[@"ZZJG_NAME"]];
            //关键点，创建模型
            JAJAnnotation *annocation = [[JAJAnnotation alloc]init];
            annocation.coordinate = coordinate;
            annocation.title = titleMap;
            annocation.subtitle = subtitleMap;
            
            //将大头针标注信息添加在地图上
            [self.mapView addAnnotation:annocation];
            
        }
    }
}

#pragma mark -- MapKit代理方法
//此方法是地图空间根据大头针信息标注模型创建大头针的方法
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[JAJAnnotation class]]) {
        //设置重用标识符
        static NSString *identifier = @"view";
        //按照标识符取出大头针
        MKPinAnnotationView *view  = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        //判断大头针是否可用
        if (view == nil) {
            view = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        //此属性是代替大头针的，但是只有在父类中MKAnnotationView中才会有效果。大头针颜色和降落的效果只有在子类MKPinAnnotationView中才有效。
        view.image = [UIImage imageNamed:@"1"];
        //开始给大头针赋值
        view.annotation = annotation;
        //设置大头针从天而降的效果
        view.animatesDrop = NO;
        //设置大头针的颜色
        view.pinTintColor = [UIColor greenColor];
        //设置弹出框的动画效果
        view.canShowCallout = YES;
        //设置弹出框左边导航按钮
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
        [button setTitle:@"导航" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor blueColor];
        [button addTarget:self action:@selector(setMapData) forControlEvents:UIControlEventTouchUpInside];
        view.leftCalloutAccessoryView = button;
        
        return view;
    }
    return nil;
}



@end
