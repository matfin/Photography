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
@synthesize index;

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
        [self startRendering];
    }
    return self;
}

- (void)startRendering
{
    NSLog(@"Start rendering this?");
    [self setBackgroundColor:[UIColor whiteColor]];
    
    self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2.5f, 2.5f, 145.0f, 145.0f)];
    [self.photoImageView setContentMode:UIViewContentModeScaleAspectFit];
    
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
}

@end
