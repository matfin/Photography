//
//  Image.h
//  Photography
//
//  Created by Matt Finucane on 20/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject

@property (nonatomic, retain) NSString *imageLabel;
@property (assign) NSUInteger imageWidth;
@property (assign) NSUInteger imageHeight;
@property (nonatomic, retain) NSURL *imageSource;
@property (nonatomic, retain) NSURL *imageURL;
@property (nonatomic, retain) NSString *imageMedia;

- (id)initWithRawData:(NSString *)theImageLabel :(NSUInteger)theImageWidth :(NSUInteger)theImageHeight :(NSString *)theImageSource :(NSString *)theImageURL :(NSString *)theImageMedia;
- (id)initWithDictionary:(NSDictionary *)image;

@end
