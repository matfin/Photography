//
//  AppDelegate.h
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationViewController.h"
#import "AlbumViewController.h"

#define FLICKR_USER_ID @"7994187@N06"
#define FLICKR_API_URL @"http://api.flickr.com/services/rest/?"
#define FLICKR_API_KEY @"613d9cb1d23d4f20d34cbb419dc0eef7" 

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NavigationViewController *navigationViewController;

/*  The view controllers we will be using   */
@property (strong, nonatomic) AlbumViewController *albumViewController;

@end
