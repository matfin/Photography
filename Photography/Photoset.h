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
#import "PhotosetTableCell.h"

#define FLICKR_USER_ID  @"7994187@N06"
#define FLICKR_API_KEY  @"ca85ac818eb4301d772ffa07cde809c4"
#define FLICKR_SECRET   @"608dd2303e2c4148"
#define FLICKR_API_URL  @"http://api.flickr.com/services/rest/?"

@protocol PhotoSetDelegate <NSObject>

@optional
- (void) photosLoaded: (BOOL)success;
- (void) photosetAtIndexHasLoadedPhotos: (NSUInteger)photosetIndex;
- (void) photosetHasLoadedAllPhotos: (NSMutableArray *)thePhotos;
- (void) photosetOfferedPreviewImageForIndexOnLoaded: (Image *)previewImage :(NSUInteger)forTableIndex;
@end

@interface Photoset : NSObject <ASIHTTPRequestDelegate, PhotoDelegate>
{
    id <PhotoSetDelegate> delegate;
}
@property (assign) NSString *photosetId;
@property (assign) NSInteger photosetCount;
@property (nonatomic, retain) NSString *photosetTitle;
@property (nonatomic, retain) NSString *photosetDescription;
@property (nonatomic, retain) NSMutableArray *photosetPhotos;
@property (nonatomic, retain) ASIFormDataRequest *request;
@property (assign) NSUInteger countOfsuccesfullyLoadedPhotos;
@property (assign) NSUInteger photosetIndex;
@property (retain) id delegate;

- (id)initWithRawData:(NSString *)thePhotosetId :(NSInteger)thePhotosetCount :(NSString *)thePhotosetTitle :(NSString *)thePhotosetDescription;
- (id)initWithDictionary:(NSDictionary *)photoSet;
- (id)initWithDictionaryAndIndex:(NSDictionary *)photoSet :(NSUInteger)index;
- (void)populatePhotos;
- (UITableViewCell *)selfPopulatedTableViewCellForTableView:(UITableView *)tableView;
@end
