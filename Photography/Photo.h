//
//  Photo.h
//  Photography
//
//  Created by Matt Finucane on 20/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "JSONKit.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "Image.h"

#define FLICKR_USER_ID  @"7994187@N06"
#define FLICKR_API_KEY  @"ca85ac818eb4301d772ffa07cde809c4"
#define FLICKR_SECRET   @"608dd2303e2c4148"
#define FLICKR_API_URL  @"http://api.flickr.com/services/rest/?"

@protocol PhotoDelegate <NSObject>

@required
- (void) imagesLoaded: (BOOL)success;
@end

@interface Photo : NSObject <ASIHTTPRequestDelegate>
{
    id <PhotoDelegate> delegate;
}

@property (nonatomic, retain) NSString *photoId;
@property (nonatomic, retain) NSString *photoTitle;
@property (nonatomic, retain) NSMutableArray *photoImages;
@property (nonatomic, retain) ASIFormDataRequest *request;
@property (retain) id delegate;

- (id)initWithRawData:(NSString *)thePhotoId :(NSString *)thePhotoTitle;
- (id)initWithDictionary:(NSDictionary *)photo;
- (void)populateImages;
- (void)speakAllImages;
- (Image *)getImageFromSizeLabel:(NSString *)sizeLabel;
@end
