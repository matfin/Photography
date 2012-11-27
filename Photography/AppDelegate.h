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
#import "LoadingView.h"
#import "PhotoLoader.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, PhotoLoaderDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NavigationViewController *navigationController;

/*  The view controllers we will be using   */
@property (strong, nonatomic) AlbumViewController *albumViewController;
@property (strong, nonatomic) LoadingView *loadingView;

- (void)showLoadingView;
- (void)hideLoadingView;

@end
