//
//  LoadingView.m
//  Photography
//
//  Created by Matt Finucane on 25/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

@synthesize titleLabel;
@synthesize subTitleLabel;
@synthesize activitySpinner;
@synthesize progressIndicator;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setOpaque:NO];
        [self loadView];
    }
    return self;
}

- (void)loadView
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 40.0f, self.bounds.size.width, 100)];
    [self.titleLabel setFont:[UIFont fontWithName:@"Lucida Console" size:30.0f]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self.titleLabel setText:@"Matt Finucane"];
    
    self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 100.0f, self.bounds.size.width, 50)];
    [self.subTitleLabel setFont:[UIFont fontWithName:@"Lucida Console" size:20.0f]];
    [self.subTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.subTitleLabel setTextColor:[UIColor blackColor]];
    [self.subTitleLabel setText:@"Photography"];
    
    self.activitySpinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150.0f, 250.0f, 20.0f, 20.0f)];
    
    [self.activitySpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    if([self.activitySpinner respondsToSelector:@selector(setColor:)])
    {
        [self.activitySpinner setColor:[UIColor blackColor]];
    }
    [self.activitySpinner startAnimating];
    
    self.progressIndicator = [[UIProgressView alloc] initWithFrame:CGRectMake(50.0f, self.bounds.size.height - 100, 220.0f, 10.0f)];
    [self.progressIndicator setProgress:0.0f];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.activitySpinner];
    [self addSubview:self.progressIndicator];
}

@end
