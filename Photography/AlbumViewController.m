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
@synthesize request;
@synthesize numberOfPhotosetsLoaded;

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
    self.photoSets = [[NSMutableArray alloc] init];
    self.numberOfPhotosetsLoaded = 0;
    
    [self grabURLInBackground];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"We have %i photosets", [photoSets count]);
    return [photoSets count];
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
    [self.request clearDelegatesAndCancel];
    self.request = nil;
}

- (void)grabURLInBackground
{    
    NSURL *flickrURL = [NSURL URLWithString:FLICKR_API_URL];
    /*
     *  Set up Flickr API url with params for fetching Photosets
     */
    self.request = [ASIFormDataRequest requestWithURL:flickrURL];
    [self.request addPostValue:@"flickr.photosets.getList" forKey:@"method"];
    [self.request addPostValue:FLICKR_API_KEY forKey:@"api_key"];
    [self.request addPostValue:FLICKR_USER_ID forKey:@"user_id"];
    [self.request addPostValue:@"json" forKey:@"format"];
    [self.request addPostValue:@"1" forKey:@"nojsoncallback"];
    
    /*
     *  Set Delegate to self then grab data from callback with async request
     */
    [self.request setDelegate:self];
    [self.request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)theRequest
{
    NSLog(@"We finished the request succesfully");
    
    NSString *responseString = [theRequest responseString];
    // Grab the json and create a JSON Kit NSDictionary from it.
    NSDictionary *resultsDictionary = [responseString objectFromJSONString];
    
    NSDictionary *flickrPhotoSets = [[resultsDictionary objectForKey:@"photosets"] objectForKey:@"photoset"];
    NSUInteger photosetIndex = 0;
    for(NSDictionary *flickrPhotoSet in flickrPhotoSets)
    {
        Photoset *photoSet = [[Photoset alloc] initWithDictionaryAndIndex:flickrPhotoSet :photosetIndex];
        photosetIndex++;
        [photoSet setDelegate:self];
        [photoSet populatePhotos];
        [self.photoSets addObject:photoSet];
    }
    [self.albumsTable reloadData];
}

- (void)photosetOfferedPreviewImageForIndexOnLoaded:(Image *)previewImage :(NSUInteger)forTableIndex
{
    PhotosetTableCell *cell = (PhotosetTableCell *)[self.albumsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:forTableIndex inSection:0]];
    /*
     *  Only enable user interaction when all json data for this photoset is fetched.
     */
    
    [cell.photosetPreviewImageView      setImageWithURL:previewImage.imageSource
                                        placeholderImage:nil
                                        success:^(UIImage *image, BOOL cached)
                                        {
                                            [cell.imagePreviewLoadingActivityIndicator stopAnimating];
                                            cell.imagePreviewLoadingActivityIndicator = nil;
                                            [cell.photosetPreviewImageView setHidden:NO];
                                        }
                                        failure:nil
     ];
}

- (void)photosLoaded:(BOOL)success
{
    NSLog(@"A photoset has loaded all its photos");
    self.numberOfPhotosetsLoaded++;
    if(self.numberOfPhotosetsLoaded == [self.photoSets count])
    {
        NSLog(@"All photosets have been loaded");
    }
}

- (void)requestFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"Could not finish the request");
}

@end
