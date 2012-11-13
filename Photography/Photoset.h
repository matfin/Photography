//
//  Album.h
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photoset : NSObject
@property (assign) NSInteger photosetId;
@property (nonatomic, retain) NSString *photosetTitle;
@property (nonatomic, retain) NSString *photosetDescription;
@property (nonatomic, retain) NSMutableArray *photosetPhotos;

- (id)initWithRawData:(NSInteger)thePhotosetId :(NSString *)thePhotosetTitle :(NSString *)thePhotosetDescription;
- (id)initWithDictionary:(NSDictionary *)photoSet;

@end
