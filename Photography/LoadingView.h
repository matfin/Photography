//
//  LoadingView.h
//  Photography
//
//  Created by Matt Finucane on 25/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface LoadingView : UIView 

@property IBOutlet UILabel *titleLabel;
@property IBOutlet UILabel *subTitleLabel;
@property IBOutlet UIActivityIndicatorView *activitySpinner;
@property IBOutlet UIProgressView *progressIndicator;

@end
