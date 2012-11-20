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
@synthesize request;

- (id)initWithRawData:(NSString *)thePhotosetId :(NSInteger)thePhotosetCount :(NSString *)thePhotosetTitle :(NSString *)thePhotosetDescription
{
    self = [super init];
    if(self)
    {
        self.photosetId = thePhotosetId;
        self.photosetCount = thePhotosetCount;
        self.photosetTitle = thePhotosetTitle;
        self.photosetDescription = thePhotosetDescription;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)photoSet
{
    self = [super init];
    if(self)
    {
        self.photosetId = [photoSet objectForKey:@"id"];
        self.photosetCount = [[photoSet objectForKey:@"photos"] integerValue];
        self.photosetTitle = [[photoSet objectForKey:@"title"] objectForKey:@"_content"];
        self.photosetDescription = [[photoSet objectForKey:@"description"] objectForKey:@"_content"];
        self.photosetPhotos = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)populatePhotos
{
    self.photosetPhotos = [[NSMutableArray alloc] init];
    NSURL *flickrURL = [NSURL URLWithString:FLICKR_API_URL];
    /*
     *  Set up Flickr API url with params for fetching Photosets
     */
    self.request = [ASIFormDataRequest requestWithURL:flickrURL];
    [self.request addPostValue:@"flickr.photosets.getPhotos" forKey:@"method"];
    [self.request addPostValue:self.photosetId forKey:@"photoset_id"];
    [self.request addPostValue:FLICKR_API_KEY forKey:@"api_key"];
    [self.request addPostValue:FLICKR_USER_ID forKey:@"user_id"];
    [self.request addPostValue:@"json" forKey:@"format"];
    [self.request addPostValue:@"1" forKey:@"nojsoncallback"];
    
    /*
     *  Set Delegate to self then grab data from callback with async request
     */
    [self.request setDelegate:self];
    [self.request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)theRequest
{
    NSLog(@"We got the photos for the photoset id ok!");
    
    NSString *responseString = [theRequest responseString];
    NSDictionary *resultsDictionary = [responseString objectFromJSONString];
    
    NSDictionary *flickrPhotos = [[resultsDictionary objectForKey:@"photoset"] objectForKey:@"photo"];
    for(NSDictionary *flickrPhoto in flickrPhotos)
    {
        NSLog(@"Photo title is: %@", [flickrPhoto objectForKey:@"title"]);
    }
    
    /*
     *  Remove the delegate and set request to nil when done. 
     *  We don't need them anymore
     */
    [self.request setDelegate:nil];
    self.request = nil;
}

- (void)requestFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"We could not get the photoset id. Connection failed!");
    /*
     *  Remove the delegate and set request to nil when done.
     *  We don't need them anymore
     */
    [self.request setDelegate:nil];
    self.request = nil;
}

@end
