//
//  MapViewController.m
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


#import "MapViewController.h"
#import "DetailViewController.h"

#pragma -
#pragma Import Venue Annotation Header Files

/********************************************************
 
    STEP 1:
    Paste Step 1 below this and before the Step 1 Complete line.
    Overwrite the existing demo Venue01Annotation.h & 
    Venue02Annotation.h. As you add more, always overwrite so that there are no duplicates.
 
 ********************************************************/

#import "Venue1Annotation.h"
#import "Venue2Annotation.h"


/** Step 1 Complete *************************************/


#pragma -
#pragma Building Annotations: Define Types
typedef enum AnnotationIndex : NSUInteger
{
    kBuildingAnnotationIndex = 0
} AnnotationIndex;

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapView, venueAnnotationArray, currentURL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set MapView as Self
    [self.mapView setDelegate:self];
    
/** Control the Position and Zoom of the Map when the App Loads **/
    
    // Set the region you want to show on the Map when it first loads
    // By default, these are coordinates for New York City
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 40.744761;
    newRegion.center.longitude = -73.995173;
    
    // Set the zoom level, this will specifiy how much of the Map is
    // visible when the app first loads
    newRegion.span.latitudeDelta = 0.102872;
    newRegion.span.longitudeDelta = 0.099863;

    [self.mapView setRegion:newRegion animated:YES];
    
/** Control the name of the "Back" button that appears in the Navigation Bar when the Detail View appears **/    
    
    // create a custom navigation bar button for the back button when a call to DetailView is made
    UIBarButtonItem *tempBarButtonItem = [[UIBarButtonItem alloc] init];
    
    // set the title of the bar button item to Back
    tempBarButtonItem.title = @"Back";
    self.navigationItem.backBarButtonItem = tempBarButtonItem;
    
/** Run the method for loading and displaying annotations at startup (tidier than putting this all here) **/
    
    [self loadAndShowAnnotations];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
/** The transition from Map View to Detail View is a segue; in this case, it's specifically a custom named segue
    called detailSegue. When an annotation is tapped, the App will automatically run this method (prepareForSegue)
    and will look for "detailSegue". This code tells detailSegue to grab the URL that is associated with the
    annotation a user tapped and passes it to the detailView to load into the webView.
**/
    
    if ([[segue identifier] isEqualToString:@"detailSegue"])
    {
        
    // grab a local copy of Detail View Controller so that we can pass information between classes
    DetailViewController *dvc = (DetailViewController *)[segue destinationViewController];
        
    // pass the currentURL associated with the annotation tapped here to DetailViewController's venueURL string
    // so that it can be loaded into the webView
    dvc.venueURL = currentURL;
        
    }
}

#pragma -
#pragma Define the Code for the Map View UI Buttons (Zoom & Options View)

- (IBAction)zoomToLocation:(id)sender {

/** Here we define what happens when a user taps on the current location button on the MapView **/    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 500, 500);
    MKCoordinateRegion adjustRegion = [mapView regionThatFits:region];
    
    // this code checks to make sure that the user's location is fully loaded into the system
    // if it isn't it will log "invalid region" and wait to try again
    // if the location is in the system, the map will automatically zoom to that location
    
    if(region.center.longitude == -180.00000000)
    {
        // tell the log that this location isn't valid and do nothing until the user taps again
        NSLog(@"Invalid region!");
    
    }
    else
    {

        // the location isn't an invalid region, go ahead and zoom
        [mapView setRegion:adjustRegion animated:YES];
    
    }
    
}

#pragma -
#pragma Load Into Array & Show Method

-(void)loadAndShowAnnotations{
    
/** This is called at the end of ViewDidLoad. This method is responsible for creating an annotation array,
    adding each building to it, and displaying the annotations on the map.
**/
    
    
/** Create the array and define it's capacity (how many venues can it store?) I set it to 1000 by deafault.
    Add more if you need more than 1000.
 **/
    
    self.venueAnnotationArray = [[NSMutableArray alloc] initWithCapacity:851];
    
/********************************************************
     
     STEP 2:
     Paste Step 2 below this and before the Step 2 Complete line.
     Overwrite the existing demo values so that there are no duplicates.
     
********************************************************/
    
/** Now, add each annotation to it. Each Venue should be added individually. **/    
    
    // annotation for Venue1
    Venue1Annotation *venue1Annotation = [[Venue1Annotation alloc] init];
    [self.venueAnnotationArray insertObject:venue1Annotation atIndex:kBuildingAnnotationIndex];
    
    
    // annotation for Venue2
    Venue2Annotation *venue2Annotation = [[Venue2Annotation alloc] init];
    [self.venueAnnotationArray insertObject:venue2Annotation atIndex:kBuildingAnnotationIndex];
  
    
/** Step 2 Complete *************************************/    
    
    
/** Now, clean up the map and display the annotations from the array. **/    
    
    // remove any annotations that exist on the map (shouldn't be any, but just in case)
    // being careful to check to make sure the annotation isn't the blue current location dot
    
    for (id annotation in mapView.annotations)
    {
        NSLog(@"annotation %@", annotation);
        
        if (![annotation isKindOfClass:[MKUserLocation class]]){
            
            [mapView removeAnnotation:annotation];
        }
    }
    
    // now that we've removed anything that shouldn't be there (making sure we're not removing the blue current
    // location dot), we add all of the annotations that we added to the array above.
    
    [self.mapView addAnnotations:self.venueAnnotationArray];
    
}

#pragma -
#pragma Define Action Outlets for Pins

/** We need a method for each venue we create. This is what tells the App what to do
    when a user taps the blue detail arrow on the annotation. Here is where the custom URLS
    we want to load for each building we tap go.
**/


/********************************************************
 
 STEP 3:
 Paste Step 3 below this and before the Step 3 Complete line.
 Overwrite the existing demo values so that there are no duplicates.
 
 ********************************************************/


- (void)showVenue1Details:(id)sender
{
    // set the URL that we want to display on the detail view for this annotation
    currentURL = @"http://www.apple.com";
    
    // perform the segue (this will load the perform segue method where data will pass through)
    [self performSegueWithIdentifier: @"detailSegue" sender: self];
}

- (void)showVenue2Details:(id)sender
{
    // set the URL that we want to display on the detail view for this annotation
    currentURL = @"http://www.google.com";
    
    // perform the segue (this will load the perform segue method where data will pass through)
    [self performSegueWithIdentifier: @"detailSegue" sender: self];
}


/** Step 3 Complete *************************************/  

#pragma -
#pragma Define the Pins & Their Actions/Appearance

/** Here we're telling the App the idenfier for each pin (among other uses, this is how we know what pin
    a user has tapped so that we can call the right method above to show the right URL) and are defining what
    the pins should look like (pinColor, if it animates in with a drop or just appears, if it can show a callout,
    and if it can show a callout-whether it has a button the user can tap). In our case, the pins are red (more on color
    options or custom image options here: http://developer.apple.com/library/ios/documentation/userexperience/conceptual/LocationAwarenessPG/AnnotatingMaps/AnnotatingMaps.html) they don't animate when they come in (which can look 
    clunky if you have quite a few, and they have a callout button a user can tap to load the detail page.
 
    This also tells the app the name of the Class file where the annotation details are stored (title + subtitle).
 
**/

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{

/********************************************************
     
     STEP 4:
     Paste Step 4 below this and before the Step 4 Complete line.
     Overwrite the existing demo values so that there are no duplicates.
     
********************************************************/
    
    
    // start copying from here
    if ([annotation isKindOfClass:[Venue1Annotation class]])   // for Venue1
    {
        // try to dequeue an existing pin view first
        static NSString* Venue1AnnotationIdentifier = @"venue1AnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
        [mapView dequeueReusableAnnotationViewWithIdentifier:Venue1AnnotationIdentifier];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc]
                                                  initWithAnnotation:annotation reuseIdentifier:Venue1AnnotationIdentifier];
            customPinView.pinColor = MKPinAnnotationColorRed;
            customPinView.animatesDrop = NO;
            customPinView.canShowCallout = YES;
            
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self
                            action:@selector(showVenue1Details:)
                  forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    // stop copying here
    
    // start copying from here
    else if ([annotation isKindOfClass:[Venue2Annotation class]])   // for Venue2
    {
        // try to dequeue an existing pin view first
        static NSString* Venue2AnnotationIdentifier = @"venue2AnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
        [mapView dequeueReusableAnnotationViewWithIdentifier:Venue2AnnotationIdentifier];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc]
                                                  initWithAnnotation:annotation reuseIdentifier:Venue2AnnotationIdentifier];
            customPinView.pinColor = MKPinAnnotationColorRed;
            customPinView.animatesDrop = NO;
            customPinView.canShowCallout = YES;
            
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self
                            action:@selector(showVenue2Details:)
                  forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    // stop copying here
    

    
/** Step 4 Complete *************************************/      
    
    
    // this just returns nil after the above;
    return nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
