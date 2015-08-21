//
//  ViewController.h
//  NewBeaconBroadcast
//
//  Created by Kristian Secor on 5/4/14.
//  Copyright (c) 2014 UCSD. All rights reserved.
///Users/kristiansecor/Desktop/NewBeaconBroadcast/NewBeaconBroadcast/ViewController.m

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController <CBPeripheralManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) NSDictionary *myBeaconData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

@end
