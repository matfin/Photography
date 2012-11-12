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
@synthesize photoAlbums;

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
    
    self.photoAlbums = [NSMutableArray alloc];
    
    [self grabURLInBackground];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [photoAlbums count];
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"UndefinedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setAlbumsTable:nil];
    [super viewDidUnload];
}

- (void)grabURLInBackground
{    
    NSURL *flickrURL = [NSURL URLWithString:FLICKR_API_URL];
    /*
     *  Set up Flickr API url with params for fetching Photosets
     */
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:flickrURL];
    [request addPostValue:@"flickr.photosets.getList" forKey:@"method"];
    [request addPostValue:FLICKR_API_KEY forKey:@"api_key"];
    [request addPostValue:FLICKR_USER_ID forKey:@"user_id"];
    [request addPostValue:@"json" forKey:@"format"];
    [request addPostValue:@"1" forKey:@"nojsoncallback"];
    
    /*
     *  Set Delegate to self then grab data from callback with async request
     */
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"We finished the request succesfully");
    NSString *responseString = [request responseString];
    // Grab the json and create a JSON Kit NSDictionary from it.
    //self.photoAlbums = [responseString objectFromJSONString];
    NSDictionary *resultsDictionary = [responseString objectFromJSONString];
    
    NSDictionary *flickrPhotoSets = [[resultsDictionary objectForKey:@"photosets"] objectForKey:@"photoset"];
    NSLog(@"We have %i here", [flickrPhotoSets count]);
    for(NSDictionary *flickrPhotoSet in flickrPhotoSets)
    {
        NSDictionary *tmp = flickrPhotoSet;
        NSLog(@"testing: %@", [[tmp objectForKey:@"title"] objectForKey:@"_content"]);
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"Could not finish the request");
}

@end
