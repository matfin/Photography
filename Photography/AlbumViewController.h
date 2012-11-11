//
//  AlbumViewController.h
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "AbstractViewController.h"

#define FLICKR_USER_ID @"7994187@N06"
#define FLICKR_API_KEY @"613d9cb1d23d4f20d34cbb419dc0eef7"

@interface AlbumViewController : AbstractViewController <UITableViewDataSource, UITableViewDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *albumsTable;
@property (nonatomic, retain) NSDictionary *photoAlbums;

@end
