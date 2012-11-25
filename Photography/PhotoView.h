//
//  PhotoView.h
//  Photography
//
//  Created by Matt Finucane on 24/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "Photo.h"

@interface PhotoView : UIView

@property (nonatomic, retain) IBOutlet UIImageView *photoImageView;
@property (nonatomic, retain) Photo *photo;
@property (assign) NSUInteger index;

- (id)initWithFrameIndexAndPhoto:(CGRect)theFrame :(NSUInteger)theIndex :(Photo *)thePhoto;
- (void)startRendering;
@end
