//
//  PhotoLoader.h
//  Photography
//
//  Created by Matt Finucane on 27/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#define FLICKR_USER_ID  @"7994187@N06"
#define FLICKR_API_KEY  @"ca85ac818eb4301d772ffa07cde809c4"
#define FLICKR_SECRET   @"608dd2303e2c4148"
#define FLICKR_API_URL  @"http://api.flickr.com/services/rest/?"

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Photoset.h"

@protocol PhotoLoaderDelegate <NSObject>
@optional
- (void)percentLoaded:(float)percentage;
- (void)allPhotosetsLoaded:(BOOL)loaded;
@end

@interface PhotoLoader : NSObject <ASIHTTPRequestDelegate, PhotoSetDelegate>
{
    id <PhotoLoaderDelegate> delegate;
}
@property (nonatomic, retain) NSMutableArray *photoSets;
@property (nonatomic, retain) ASIFormDataRequest *request;
@property (assign) NSUInteger numberOfPhotosetsLoaded;
@property (retain) id delegate;

+ (id)sharedInstance;
- (void)grabDataInBackground;

@end
