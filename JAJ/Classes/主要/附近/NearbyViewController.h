//
//  NearbyViewController.h
//  JAJ
//
//  Created by 金安健 on 2016/11/27.
//  Copyright © 2016年 JinAnJian. All rights reserved.
//

#import "SuperViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface NearbyViewController : SuperViewController


@property (weak, nonatomic)  UILabel *lblLongitude;
@property (weak, nonatomic)  UILabel *lblLatitude;
@property (weak, nonatomic)  UILabel *lblLongitudeMars;
@property (weak, nonatomic)  UILabel *lblLatitudeMars;
@property (weak, nonatomic)  UITextView *txtViewLocation;
@property (strong, nonatomic)  MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;


@end
