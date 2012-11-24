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
    NSUInteger index = 0;
    float containerX = 5.0f;
    float containerY = 5.0f;
    for(Photo *photo in self.photoSet.photosetPhotos)
    {
        if(index > 2 && index % 2 == 0)
        {
            containerY += 155.0f;
            containerX = 165.0f;
        }
        else
        {
            containerX = 5.0f;
        }
        
        [photo speakAllImages];
        
        CGRect photoContainerViewFrame = CGRectMake(containerX, containerY, 150.0f, 150.0f);
                
        PhotoView *photoView = [[PhotoView alloc] initWithFrameIndexAndSourceImageUrl:photoContainerViewFrame :index :[photo getImageFromSizeLabel:@"Large Square"].imageSource];
        [self.photosetScrollView addSubview:photoView];
        
        index++;
    }
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
