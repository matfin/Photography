//
//  PhotoView.h
//  Photography
//
//  Created by Matt Finucane on 24/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "Photo.h"


@protocol PhotoTapDelegate <NSObject>

@optional
- (void)photoAtIndexTapped: (NSUInteger)photoIndex;
@end

@interface PhotoView : UIView
{
    id <PhotoTapDelegate> delegate;
}

@property (nonatomic, retain) IBOutlet UIImageView *photoImageView;
@property (nonatomic, retain) IBOutlet UILabel *photoTitleLabel;
@property (nonatomic, retain) Photo *photo;
@property (assign) NSUInteger index;
@property (retain) id delegate;

- (id)initWithFrameIndexAndPhoto:(CGRect)theFrame :(NSUInteger)theIndex :(Photo *)thePhoto;
- (void)loadView;
- (void)handleSingleTap;
@end
