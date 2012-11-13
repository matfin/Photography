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
@synthesize photosetTitle;
@synthesize photosetDescription;
@synthesize photosetPhotos;

- (id)initWithRawData:(NSInteger)thePhotosetId :(NSString *)thePhotosetTitle :(NSString *)thePhotosetDescription
{
    self = [super init];
    if(self)
    {
        self.photosetId = thePhotosetId;
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
        self.photosetTitle = [[photoSet objectForKey:@"title"] objectForKey:@"_content"];
        self.photosetDescription = [[photoSet objectForKey:@"description"] objectForKey:@"_content"];
    }
    return self;
}

@end
