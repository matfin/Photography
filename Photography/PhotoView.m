//
//  PhotoView.m
//  Photography
//
//  Created by Matt Finucane on 24/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "PhotoView.h"

@implementation PhotoView

@synthesize photo;
@synthesize photoImageView;
@synthesize photoTitleLabel;
@synthesize index;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrameIndexAndPhoto:(CGRect)theFrame :(NSUInteger)theIndex :(Photo *)thePhoto
{
    self = [super initWithFrame:theFrame];
    if(self)
    {
        self.index = theIndex;
        self.photo = thePhoto;
        [self loadView];
    }
    return self;
}

- (void)shadow
{
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 0;
    self.layer.shadowOffset = CGSizeMake(-5, 10);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

- (void)loadView
{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self shadow];
    self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2.5f, 2.5f, 145.0f, 145.0f)];
    [self.photoImageView setContentMode:UIViewContentModeScaleAspectFit];
    self.photoTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(00.0f, 155.0f, 145.0f, 25.0f)];
    [self.photoTitleLabel setFont:[UIFont fontWithName:@"GoodFoot" size:16.0f]];
    [self.photoTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.photoTitleLabel setText:photo.photoTitle];
    
    [self.photoImageView    setImageWithURL:[photo getImageFromSizeLabel:@"Large Square"].imageSource
                            placeholderImage:nil
                            success:^(UIImage *image, BOOL cached)
                            {
                                NSLog(@"Large square image download succesfully");
                                [self.photoImageView setImage:image];
                            }
                            failure:^(NSError *error)
                            {
                                NSLog(@"There was an error downloading the large square image: %@", [error  localizedDescription]);
                            }
     ];
    
    [self addSubview:self.photoImageView];
    [self addSubview:photoTitleLabel];
    [self addTapBehaviour];
}

- (void)addTapBehaviour
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [singleTap setNumberOfTapsRequired:1];
    [self addGestureRecognizer:singleTap];
}

- (void)handleSingleTap
{
    //[[self delegate] photoAtIndexTapped:self.index];
}

@end
