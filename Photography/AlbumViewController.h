//
//  AlbumViewController.h
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "AbstractViewController.h"
#import "Photoset.h"
#import "PhotoLoader.h"

@interface AlbumViewController : AbstractViewController <UITableViewDataSource, UITableViewDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *albumsTable;
@property (nonatomic, retain) NSMutableArray *photoSets;

@end
