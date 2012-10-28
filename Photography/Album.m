//
//  Album.m
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "Album.h"

@implementation Album

@synthesize albumId;
@synthesize albumTitle;
@synthesize albumDescription;
@synthesize albumPhotos;

-(id)initWithRawData:(NSInteger)theAlbumId :(NSString *)theAlbumTitle :(NSString *)theAlbumDescription
{
    self = [super init];
    if(self)
    {
        self.albumId = theAlbumId;
        self.albumTitle = theAlbumTitle;
        self.albumDescription = theAlbumDescription;
        self.albumPhotos = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
