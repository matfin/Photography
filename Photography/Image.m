//
//  Image.m
//  Photography
//
//  Created by Matt Finucane on 20/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "Image.h"

@implementation Image

@synthesize imageLabel;
@synthesize imageWidth;
@synthesize imageHeight;
@synthesize imageSource;
@synthesize imageURL;
@synthesize imageMedia;

- (id)initWithRawData:(NSString *)theImageLabel :(NSUInteger)theImageWidth :(NSUInteger)theImageHeight :(NSString *)theImageSource :(NSString *)theImageURL :(NSString *)theImageMedia
{
    self = [super init];
    if(self)
    {
        self.imageLabel = theImageLabel;
        self.imageWidth = theImageWidth;
        self.imageHeight = theImageHeight;
        self.imageSource = [NSURL URLWithString:theImageSource];
        self.imageURL = [NSURL URLWithString:theImageURL];
        self.imageMedia = theImageMedia;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)image
{
    self = [super init];
    if(self)
    {
        self.imageLabel = [image objectForKey:@"label"];
        self.imageWidth = [[image objectForKey:@"width"] integerValue];
        self.imageHeight = [[image objectForKey:@"height"] integerValue];
        self.imageSource = [NSURL URLWithString:[image objectForKey:@"source"]];
        self.imageURL = [NSURL URLWithString:[image objectForKey:@"url"]];
        self.imageMedia = [image objectForKey:@"media"];
    }
    return self;
}

@end
