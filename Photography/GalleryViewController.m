//
//  GalleryViewController.m
//  Photography
//
//  Created by Matt Finucane on 25/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "GalleryViewController.h"

@implementation GalleryViewController

@synthesize carousel;
@synthesize photoset;
@synthesize selectedPhotoIndex;

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
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel.delegate = nil;
    self.carousel.dataSource = nil;
    self.carousel = nil;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [photoset.photosetPhotos count];
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    return nil;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.carousel.delegate = nil;
    self.carousel.dataSource = nil;
}

@end
