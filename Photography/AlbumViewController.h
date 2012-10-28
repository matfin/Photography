//
//  AlbumViewController.h
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "AbstractViewController.h"
#import "ObjectiveFlickr.h"

@interface AlbumViewController : AbstractViewController <UITableViewDataSource, UITableViewDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *albumsTable;
@property (nonatomic, retain) NSDictionary *photoAlbums;

@end
