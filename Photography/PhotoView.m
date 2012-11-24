//
//  PhotoView.m
//  Photography
//
//  Created by Matt Finucane on 24/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "PhotoView.h"

@implementation PhotoView

@synthesize photoImageSource;
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

- (id)initWithFrameIndexAndSourceImageUrl:(CGRect)theFrame :(NSUInteger)theIndex :(NSURL *)thePhotoImageSource;
{
    self = [super initWithFrame:theFrame];
    if(self)
    {
        self.index = theIndex;
        self.photoImageSource = thePhotoImageSource;
        [self startRendering];
    }
    return self;
}

- (void)startRendering
{
    [self setBackgroundColor:[UIColor blackColor]];
    
    self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2.5f, 2.5f, 145.0f, 145.0f)];
    [self.photoImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.photoImageView    setImageWithURL:photoImageSource
                            placeholderImage:nil
                            success:^(UIImage *image, BOOL cached)
                            {
                            }
                            failure:nil
     ];
    
    [self addSubview:self.photoImageView];
}

@end
