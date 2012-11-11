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
    
    [self grabURLInBackground];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:flickrURL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:flickrURL];
    
    [request addPostValue:@"flickr.photosets.getList" forKey:@"method"];
    [request addPostValue:FLICKR_API_KEY forKey:@"api_key"];
    [request addPostValue:FLICKR_USER_ID forKey:@"user_id"];
    [request addPostValue:@"json" forKey:@"format"];
    [request addPostValue:@"1" forKey:@"nojsoncallback"];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"We finished the request succesfully - Data is as follows");
    NSString *responseString = [request responseString];
    NSLog(responseString);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"Could not finish the request");
}

@end
