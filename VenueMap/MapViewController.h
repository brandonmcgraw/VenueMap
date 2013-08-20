//
//  MapViewController.h
//  VenueMap
//
//  Created by Brandon McGraw on 8/16/13.
//  Copyright (c) 2013 Brandon McGraw. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

// declare the map view outlet so that we can link with the storyboard
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

// declare the array that we'll be keeping the venues in
@property (nonatomic, retain) NSMutableArray *venueAnnotationArray;

// declare currentURL, an NSString that we'll store a current URL for each building in
// to pass to the Detail View Controller
@property (weak, nonatomic) NSString *currentURL;

// declare the action for the current location button
- (IBAction)zoomToLocation:(id)sender;

@end
