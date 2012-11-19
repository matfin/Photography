//
//  Album.m
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "Photoset.h"

@implementation Photoset

@synthesize photosetId;
@synthesize photosetCount;
@synthesize photosetTitle;
@synthesize photosetDescription;
@synthesize photosetPhotos;

- (id)initWithRawData:(NSInteger)thePhotosetId :(NSInteger)thePhotosetCount :(NSString *)thePhotosetTitle :(NSString *)thePhotosetDescription
{
    self = [super init];
    if(self)
    {
        self.photosetId = thePhotosetId;
        self.photosetCount = thePhotosetCount;
        self.photosetTitle = thePhotosetTitle;
        self.photosetDescription = thePhotosetDescription;
        self.photosetPhotos = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)photoSet
{
    self = [super init];
    if(self)
    {
        self.photosetId = [[photoSet objectForKey:@"id"] integerValue];
        self.photosetCount = [[photoSet objectForKey:@"photos"] integerValue];
        self.photosetTitle = [[photoSet objectForKey:@"title"] objectForKey:@"_content"];
        self.photosetDescription = [[photoSet objectForKey:@"description"] objectForKey:@"_content"];
        self.photosetPhotos = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
