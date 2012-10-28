//
//  AlbumViewController.h
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "AbstractViewController.h"

@interface AlbumViewController : AbstractViewController

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *albumsTable;

@end
