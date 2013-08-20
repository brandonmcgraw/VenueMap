//
//  DetailViewController.m
//  VenueMap
//
//  Created by Brandon McGraw on 8/16/13.
//  Copyright (c) 2013 Brandon McGraw. All rights reserved.
//
#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize detailViewWebView, venueURL;

#pragma Detail View - View Did Load Method
- (void)viewDidLoad
{
    NSLog(@"View Did Load - Detail View");
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

#pragma Detail View - View Did Appear Method
-(void)viewDidAppear:(BOOL)animated{
    
/** Since we segue to the Detail view, the loading request should happen when it appears - not when it loads. 
    This is where we handle loading things into the webView.
**/
    
    NSLog(@"View Did Appear Called - Detail View");
    
    // here we tell the webview the VenueURL which was passed to us from the MapView
    NSString *urlStringToLoad = [NSString stringWithFormat: @"%@", venueURL];
    
    // here we tell the webView to load that URL
    detailViewWebView.delegate = self;
    NSURLRequest *requestWebsite = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStringToLoad]];
    [detailViewWebView loadRequest:requestWebsite];
    
}

#pragma Detail View - View Did Disappear Method
-(void)viewDidDisappear:(BOOL)animated{
    
/** I like to have the webView load the equivalent of a blank page when a user taps the back button.
    This way, you don't see the remnants of the last URL visited when you tap another annotation.
**/
    
    NSLog(@"Detail View - View Did Disappear Called");
    
    // clear the web view by loading the equivalent of "about:blank" in javascript
    [detailViewWebView stringByEvaluatingJavaScriptFromString:@"document.open();document.close();"];
    
}


#pragma -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDetailViewWebView:nil];
    [super viewDidUnload];
}

@end
