//
//  PhotosetViewController.m
//  Photography
//
//  Created by Matt Finucane on 24/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "PhotosetViewController.h"

@interface PhotosetViewController ()

@end

@implementation PhotosetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPhotosetScrollView:nil];
    [super viewDidUnload];
}
@end
