//
//  PhotosetViewController.m
//  Photography
//
//  Created by Matt Finucane on 24/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "PhotosetViewController.h"

@implementation PhotosetViewController

@synthesize photosetScrollView;
@synthesize photoSet;

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
    NSUInteger index = 1;
    float containerX = 5.0f;
    float containerY = 5.0f;
    for(Photo *photo in self.photoSet.photosetPhotos)
    {
        if(index % 2 == 0)
        {
            containerX = 165.0f;
        }
        else
        {
            containerX = 5.0f;
        }
        if(index > 2 && index % 2 != 0)
        {
            containerY += 190.0f;
        }
        
        CGRect photoContainerViewFrame = CGRectMake(containerX, containerY, 150.0f, 180.0f);
        PhotoView *photoView = [[PhotoView alloc] initWithFrameIndexAndPhoto:photoContainerViewFrame :index - 1 :photo];
        [photoView setDelegate:self];
        [self.photosetScrollView addSubview:photoView];
        [self.photosetScrollView setContentSize:CGSizeMake(320.0f, (containerY + 190.0f))];
        [self.photosetScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"photosetbackground"]]];
        index++;
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)photoAtIndexHasBeenTapped:(NSUInteger)photoIndex
{
    NSLog(@"The Photo at index %i was tapped", photoIndex);
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
