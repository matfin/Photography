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
    self.carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.carousel.decelerationRate = 0.1;
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.currentItemIndex = selectedPhotoIndex;
    
    [self.view addSubview:self.carousel];
    
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
    return [self.photoset.photosetPhotos count];
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    return nil;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    /*
    if(view == nil)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
    */
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    UIImageView *photoImageView = nil;
    
    Image *image = [[self.photoset.photosetPhotos objectAtIndex:index] getImageFromSizeLabel:@"Small 320"];
    photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.bounds.size.width, view.bounds.size.height)];
    [photoImageView setContentMode:UIViewContentModeScaleAspectFit];
    [photoImageView     setImageWithURL:   image.imageSource
                        placeholderImage:nil
                        success:^(UIImage *image, BOOL cached)
                        {
                            NSLog(@"Large square image download succesfully");
                            //[photoImageView setImage:image];
                        }
                        failure:^(NSError *error)
                        {
                            NSLog(@"There was an error downloading the large square image: %@", [error  localizedDescription]);
                        }
    ];
    
    [view addSubview:photoImageView];
    
    return view;
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
    self.carousel = nil;
    self.photoset = nil;
}

@end
