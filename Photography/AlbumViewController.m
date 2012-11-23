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
    
    self.photoSets = [[NSMutableArray alloc] init];
    
    [self grabURLInBackground];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"We have %i photosets", [photoSets count]);
    return [photoSets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Photoset *photoSet = [self.photoSets objectAtIndex:indexPath.row];
    static NSString *photosetTableCellIdentifier = @"PhotosetTableCell";
    
    PhotosetTableCell *cell = (PhotosetTableCell *)[tableView dequeueReusableCellWithIdentifier:photosetTableCellIdentifier];
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PhotosetTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell.photosetTitleLabel setText:photoSet.photosetTitle];
    [cell.photosetCountLabel setText:[NSString stringWithFormat:@"%i photos", photoSet.photosetCount]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Something was tapped.");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78.0f;
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

- (void)photosetAtIndexHasLoadedPhotos:(NSUInteger)photosetIndex
{
    NSLog(@"Photoset at index %i has loaded all photos", photosetIndex);
}

- (void)photosetHasLoadedAllPhotos:(NSMutableArray *)thePhotos
{
    NSLog(@"Photoset was loaded here with %i photos", [thePhotos count]);
}

- (void)photosetOfferedPreviewImageForIndexOnLoaded:(UIImage *)previewImage :(NSUInteger)forTableIndex
{
    
}

- (void)photosLoaded:(BOOL)success
{
    
}

- (void)requestFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"Could not finish the request");
}

@end
