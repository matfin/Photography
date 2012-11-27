//
//  AlbumViewController.m
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "AlbumViewController.h"

@implementation AlbumViewController

@synthesize albumsTable;
@synthesize photoSets;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.albumsTable setDelegate:self];
    [self.albumsTable setDataSource:self];
    [self.albumsTable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"photosetbackground"]]];
    
    PhotoLoader *photoLoader = [PhotoLoader sharedInstance];
    
    self.photoSets = photoLoader.photoSets;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"We have %i photosets", [self.photoSets count]);
    return [self.photoSets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.photoSets objectAtIndex:indexPath.row] selfPopulatedTableViewCellForTableView:tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self.photoSets objectAtIndex:indexPath.row] thisPhotosetHasBeenSelected];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self.albumsTable setDelegate:nil];
    [self setAlbumsTable:nil];
    [super viewDidUnload];
}

- (void)dealloc
{
    self.photoSets = nil;
}

@end
