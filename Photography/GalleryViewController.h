//
//  GalleryViewController.h
//  Photography
//
//  Created by Matt Finucane on 25/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "iCarousel.h"
#import "UIImageView+WebCache.h"
#import "AbstractViewController.h"
#import "Photoset.h"

@interface GalleryViewController : AbstractViewController <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, retain) IBOutlet iCarousel *carousel;
@property (nonatomic, retain) Photoset *photoset;
@property (assign) NSUInteger selectedPhotoIndex;

@end
