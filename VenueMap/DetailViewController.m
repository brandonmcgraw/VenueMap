//
//  DetailViewController.m
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
