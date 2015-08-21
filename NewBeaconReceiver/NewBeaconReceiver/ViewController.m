//
//  ViewController.m
//  NewBeaconReceiver
//
//  Created by Kristian Secor on 5/4/14.
//  Copyright (c) 2014 UCSD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.myBeaconRegion.notifyEntryStateOnDisplay = YES;
    

    // Do any additional setup after loading the view, typically from a nib.
    
    // Initialize location manager and set ourselves as the delegate
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Create a NSUUID with the same UUID as the broadcasting beacon
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"5B9E9B55-7CC7-4FE5-AB67-3D9D33FF746A"];
    
    // Setup a new region with that UUID and same identifier as the broadcasting beacon
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                             identifier:@"com.mm214.testbeacon"];
    
   
    // Tell location manager to start monitoring for the beacon region
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];
   
    [self.locationManager requestStateForRegion:self.myBeaconRegion];
    
    /*
    NSArray *locationServicesAuthStatuses = @[@"Not determined",@"Restricted",@"Denied",@"Authorized"];
    NSArray *backgroundRefreshAuthStatuses = @[@"Restricted",@"Denied",@"Available"];
     */
    
    // Check if beacon monitoring is available for this device
    if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Monitoring not available" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil]; [alert show]; return;
    }
}


- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    if (state == CLRegionStateInside){
   self.statusLabel.text = @"is in target region";
        [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
    }
        else{
   self.statusLabel.text = @"is out of target region";
        }
}

- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion *)region
{
    // We entered a region, now start looking for our target beacons!
    self.statusLabel.text = @"Finding beacons.";
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion *)region
{
    // Exited the region
    self.statusLabel.text = @"None found.";
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager*)manager
       didRangeBeacons:(NSArray*)beacons
              inRegion:(CLBeaconRegion*)region
{
    // Beacon found!
    self.statusLabel.text = @"Beacon found!";
    
    CLBeacon *foundBeacon = [beacons firstObject];
    
    // You can retrieve the beacon data from its properties
    NSString *uuid = foundBeacon.proximityUUID.UUIDString;
    NSString *major = [NSString stringWithFormat:@"\nBeacon found\nMajor is %@", foundBeacon.major];
    NSString *minor = [NSString stringWithFormat:@"\nMinor is %@", foundBeacon.minor];
    NSString *str = [@[uuid,major,minor] componentsJoinedByString:@","];

    self.statusLabel.text =str;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
