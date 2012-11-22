//
//  Album.h
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "Photo.h"

#define FLICKR_USER_ID  @"7994187@N06"
#define FLICKR_API_KEY  @"ca85ac818eb4301d772ffa07cde809c4"
#define FLICKR_SECRET   @"608dd2303e2c4148"
#define FLICKR_API_URL  @"http://api.flickr.com/services/rest/?"

@interface Photoset : NSObject <ASIHTTPRequestDelegate, PhotoDelegate>
@property (assign) NSString *photosetId;
@property (assign) NSInteger photosetCount;
@property (nonatomic, retain) NSString *photosetTitle;
@property (nonatomic, retain) NSString *photosetDescription;
@property (nonatomic, retain) NSMutableArray *photosetPhotos;
@property (nonatomic, retain) ASIFormDataRequest *request;

- (id)initWithRawData:(NSString *)thePhotosetId :(NSInteger)thePhotosetCount :(NSString *)thePhotosetTitle :(NSString *)thePhotosetDescription;
- (id)initWithDictionary:(NSDictionary *)photoSet;
- (void)populatePhotos;
@end
