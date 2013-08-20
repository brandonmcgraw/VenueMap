//
//  MapViewController.h
//  VenueMap
//
//  Created by Brandon McGraw on 8/16/13.
//  Copyright (c) 2013 Brandon McGraw. All rights reserved.
//
/**
 The MIT License (MIT)
 
 Copyright (c) 2013 Brandon McGraw
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 **/

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
