//
//  AbstractViewController.m
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "AbstractViewController.h"

@interface AbstractViewController ()

@end

@implementation AbstractViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNavBarTitle:(NSString *)theNavBarTitle
{
    self = [super init];
    if(self)
    {
        self.navBarTitle = theNavBarTitle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    int navBarWidth = self.navigationController.navigationBar.frame.size.width;
    int navBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    [[self.navigationController navigationBar] setTintColor:[UIColor blackColor]];
    
    UILabel *navBarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, navBarWidth - 140, navBarHeight)];
    [navBarTitleLabel setBackgroundColor:[UIColor clearColor]];
    [navBarTitleLabel setFont:[UIFont fontWithName:@"Lucida Console" size:14.0f]];
    [navBarTitleLabel setTextColor:[UIColor whiteColor]];
    [navBarTitleLabel setText:self.navBarTitle];
    [self.navigationItem setTitleView:navBarTitleLabel];
}

- (void)viewWillUnload
{
    self.navBarTitle = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
