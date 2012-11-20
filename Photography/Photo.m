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
    NSURL *flickrURL = [NSURL URLWithString:FLICKR_API_URL];
    /*
     *  Set up Flickr API url with params for fetching Photosets
     */
    self.request = [ASIFormDataRequest requestWithURL:flickrURL];
    [self.request addPostValue:@"flickr.photos.getSizes" forKey:@"method"];
    [self.request addPostValue:self.photoId forKey:@"photo_id"];
    [self.request addPostValue:FLICKR_API_KEY forKey:@"api_key"];
    [self.request addPostValue:FLICKR_USER_ID forKey:@"user_id"];
    [self.request addPostValue:@"json" forKey:@"format"];
    [self.request addPostValue:@"1" forKey:@"nojsoncallback"];

    [self.request setDelegate:self];
    [self.request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)theRequest
{
    NSString *responseString = [theRequest responseString];
    NSDictionary *resultsDictionary = [responseString objectFromJSONString];
    
    NSDictionary *flickrImages = [[resultsDictionary objectForKey:@"sizes"] objectForKey:@"size"];
    for(NSDictionary *flickrImage in flickrImages)
    {
        NSLog(@"URL is: %@", [flickrImage objectForKey:@"source"]);
    }
    
    [self.request setDelegate:nil];
    self.request = nil;
}

- (void)requestFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"Request to get images failed!");
}

@end
