//
//  Album.h
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject
@property (assign) NSInteger albumId;
@property (nonatomic, retain) NSString *albumTitle;
@property (nonatomic, retain) NSString *albumDescription;
@property (nonatomic, retain) NSMutableArray *albumPhotos;

-(id)initWithRawData:(NSInteger)theAlbumId :(NSString *)theAlbumTitle :(NSString *)theAlbumDescription;

@end
