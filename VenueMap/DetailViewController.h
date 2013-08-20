//
//  DetailViewController.h
//  VenueMap
//
//  Created by Brandon McGraw on 8/16/13.
//  Copyright (c) 2013 Brandon McGraw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIWebViewDelegate>

// here we declare the string that we'll store the URL being passed from MapView when a user taps a venue's annotation
@property (nonatomic, strong) NSString *venueURL;

// here we declare an outlet for the webView that we placed on the storyboard
@property (weak, nonatomic) IBOutlet UIWebView *detailViewWebView;


@end
