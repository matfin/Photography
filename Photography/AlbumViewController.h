//
//  AlbumViewController.h
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "AbstractViewController.h"


#define FLICKR_USER_ID  @"7994187@N06"
#define FLICKR_API_KEY  @"ca85ac818eb4301d772ffa07cde809c4"
#define FLICKR_SECRET   @"608dd2303e2c4148"
#define FLICKR_API_URL  @"http://api.flickr.com/services/rest/?"

@interface AlbumViewController : AbstractViewController <UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *albumsTable;
@property (nonatomic, retain) NSMutableArray *photoAlbums;

- (void)grabURLInBackground;

@end
