//
//  PhotoLoader.m
//  Photography
//
//  Created by Matt Finucane on 27/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "PhotoLoader.h"

@implementation PhotoLoader

@synthesize photoSets;
@synthesize request;
@synthesize numberOfPhotosetsLoaded;
@synthesize delegate;

+ (PhotoLoader *)sharedInstance
{
    /*
     *  Singletons the ARC way - http://stackoverflow.com/questions/7568935/how-do-i-implement-an-objective-c-singleton-that-is-compatible-with-arc
     */
    static PhotoLoader *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PhotoLoader alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        self.photoSets = [[NSMutableArray alloc] init];
        self.numberOfPhotosetsLoaded = 0;
        [self grabDataInBackground];
    }
    return self;
}

- (void)grabDataInBackground
{
    NSURL *flickrURL = [NSURL URLWithString:FLICKR_API_URL];
    /*
     *  Set up Flickr API url with params for fetching Photosets
     */
    self.request = [ASIFormDataRequest requestWithURL:flickrURL];
    [self.request addPostValue:@"flickr.photosets.getList" forKey:@"method"];
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
    NSString *responseString = [theRequest responseString];
    // Grab the json and create a JSON Kit NSDictionary from it.
    NSDictionary *resultsDictionary = [responseString objectFromJSONString];
    
    NSDictionary *flickrPhotoSets = [[resultsDictionary objectForKey:@"photosets"] objectForKey:@"photoset"];
    NSUInteger photosetIndex = 0;
    for(NSDictionary *flickrPhotoSet in flickrPhotoSets)
    {
        Photoset *photoSet = [[Photoset alloc] initWithDictionaryAndIndex:flickrPhotoSet :photosetIndex];
        photosetIndex++;
        [photoSet setDelegate:self];
        [photoSet populatePhotos];
        [self.photoSets addObject:photoSet];
    }
}

- (void)photosLoaded:(BOOL)success
{
    self.numberOfPhotosetsLoaded++;
    float percentLoaded = (float)self.numberOfPhotosetsLoaded / (float)[self.photoSets count];
    [[self delegate] percentLoaded:percentLoaded];
    if(self.numberOfPhotosetsLoaded == [self.photoSets count])
    {
        [[self delegate] allPhotosetsLoaded:YES];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"Could not finish the request");
}

@end
