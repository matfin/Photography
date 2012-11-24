//
//  PhotoView.h
//  Photography
//
//  Created by Matt Finucane on 24/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface PhotoView : UIView

@property (nonatomic, retain) IBOutlet UIImageView *photoImageView;
@property (nonatomic, retain) NSURL *photoImageSource;
@property (assign) NSUInteger index;

- (id)initWithFrameIndexAndSourceImageUrl:(CGRect)theFrame :(NSUInteger)theIndex :(NSURL *)thePhotoImageSource;
- (void)startRendering;
@end
