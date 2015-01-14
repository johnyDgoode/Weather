//
//  InterfaceController.m
//  WeatherReport WatchKit Extension
//
//  Created by Kenta Saito on 2015/01/11.
//  Copyright (c) 2015年 Kenta Saito. All rights reserved.
//

#import "InterfaceController.h"
#import <CoreLocation/CoreLocation.h>
#import "KS_APIManager.h"

@interface InterfaceController()
@property(nonatomic,weak)IBOutlet WKInterfaceLabel *label;
@property(nonatomic,weak)IBOutlet WKInterfaceMap *map;
@property (nonatomic) MKCoordinateRegion currentRegion;
@property (nonatomic) MKCoordinateSpan currentSpan;
@end

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.label.text = @"hoge";
    // Configure interface objects here.
    
    _currentSpan = MKCoordinateSpanMake(1.0f, 1.0f);
    
    CLLocationManager *locationManager = [CLLocationManager new];
    
    if([CLLocationManager locationServicesEnabled]){
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusAuthorizedAlways:
                [locationManager startUpdatingHeading];
                break;
            default:
                break;
        }
    }
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(35.4f, 139.4f);
    
    [self setMapToCoordinate:coordinate];
    
    self.label.text = [KS_APIManager weather];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)setMapToCoordinate:(CLLocationCoordinate2D)coordinate {
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, self.currentSpan);
    self.currentRegion = region;
    
    MKMapPoint newCenterPoint = MKMapPointForCoordinate(coordinate);
    
    [self.map setVisibleMapRect:MKMapRectMake(newCenterPoint.x, newCenterPoint.y, self.currentSpan.latitudeDelta, self.currentSpan.longitudeDelta)];
    [self.map setRegion:region];
}

@end



