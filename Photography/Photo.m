//
//  Photo.m
//  Photography
//
//  Created by Matt Finucane on 20/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "Photo.h"

@implementation Photo

@synthesize photoTitle;
@synthesize photoImages;
@synthesize request;

- (id)initWithRawData:(NSString *)thePhotoId :(NSString *)thePhotoTitle
{
    self = [super init];
    if(self)
    {
        self.photoId = thePhotoId;
        self.photoTitle = thePhotoTitle;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)photo
{
    self = [super init];
    if(self)
    {
        self.photoId = [photo objectForKey:@"id"];
        self.photoTitle = [photo objectForKey:@"title"];
    }
    return self;
}

- (void)populateImages
{
    self.photoImages = [[NSMutableArray alloc] init];
}

@end
