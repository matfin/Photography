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
    self.carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height - 40)];
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.carousel.decelerationRate = 0.1;
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.currentItemIndex = selectedPhotoIndex;
    [self.carousel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"photosetbackground"]]];
    
    [self.view addSubview:self.carousel];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel.delegate = nil;
    self.carousel.dataSource = nil;
    self.carousel = nil;
    self.photoset = nil;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.photoset.photosetPhotos count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.carousel.bounds.size.width, self.carousel.bounds.size.height)];
    
    UIImageView *photoImageView = nil;
    Photo *photo = [self.photoset.photosetPhotos objectAtIndex:index];
    
    Image *image = [photo getImageFromSizeLabel:@"Small 320"];
    photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, (view.bounds.size.height / 2) - 120, view.bounds.size.width, 240.0f)];
    [photoImageView setContentMode:UIViewContentModeScaleAspectFit];
    [photoImageView     setImageWithURL:   image.imageSource
                        placeholderImage:nil
                        success:^(UIImage *image, BOOL cached)
                        {
                            //[photoImageView setImage:image];
                        }
                        failure:^(NSError *error)
                        {
                            NSLog(@"There was an error downloading the large square image: %@",[error  localizedDescription]);
                        }
    ];
    
    UILabel *photoTitleLabel = nil;
    photoTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 330.0f, view.bounds.size.width, 35.0f)];
    [photoTitleLabel setFont:[UIFont fontWithName:@"GoodFoot" size:25.0f]];
    [photoTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [photoTitleLabel setBackgroundColor:[UIColor clearColor]];
    [photoTitleLabel setTextColor:[UIColor blackColor]];
    [photoTitleLabel setText:photo.photoTitle];
    
    [view addSubview:photoImageView];
    [view addSubview:photoTitleLabel];
    
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
