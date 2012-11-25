//
//  Album.m
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "Photoset.h"
#import "PhotosetViewController.h"
#import "GalleryViewController.h"
#import "AppDelegate.h"

@implementation Photoset

@synthesize photosetId;
@synthesize photosetCount;
@synthesize photosetTitle;
@synthesize photosetDescription;
@synthesize photosetPhotos;
@synthesize request;
@synthesize countOfsuccesfullyLoadedPhotos;
@synthesize delegate;
@synthesize photosetIndex;

- (id)initWithRawData:(NSString *)thePhotosetId :(NSInteger)thePhotosetCount :(NSString *)thePhotosetTitle :(NSString *)thePhotosetDescription
{
    self = [super init];
    if(self)
    {
        self.photosetId = thePhotosetId;
        self.photosetCount = thePhotosetCount;
        self.photosetTitle = thePhotosetTitle;
        self.photosetDescription = thePhotosetDescription;
        
        self.countOfsuccesfullyLoadedPhotos = 0;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)photoSet
{
    self = [super init];
    if(self)
    {
        self.photosetId = [photoSet objectForKey:@"id"];
        self.photosetCount = [[photoSet objectForKey:@"photos"] integerValue];
        self.photosetTitle = [[photoSet objectForKey:@"title"] objectForKey:@"_content"];
        self.photosetDescription = [[photoSet objectForKey:@"description"] objectForKey:@"_content"];
        self.photosetPhotos = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithDictionaryAndIndex:(NSDictionary *)photoSet :(NSUInteger)index
{
    self = [self initWithDictionary:photoSet];
    self.photosetIndex = index;
    return self;
}

- (void)populatePhotos
{
    self.photosetPhotos = [[NSMutableArray alloc] init];
    NSURL *flickrURL = [NSURL URLWithString:FLICKR_API_URL];
    /*
     *  Set up Flickr API url with params for fetching Photosets
     */
    self.request = [ASIFormDataRequest requestWithURL:flickrURL];
    [self.request addPostValue:@"flickr.photosets.getPhotos" forKey:@"method"];
    [self.request addPostValue:self.photosetId forKey:@"photoset_id"];
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

// This is where our photos tell us they have loaded their images succesfully
- (void)imagesLoaded:(BOOL)success
{
    if(success)
    {
        self.countOfsuccesfullyLoadedPhotos += 1;
    }
    if(countOfsuccesfullyLoadedPhotos == [photosetPhotos count])
    {
        Image *previewImage = [[self.photosetPhotos objectAtIndex:0] getImageFromSizeLabel:@"Square"];
        [[self delegate] photosetOfferedPreviewImageForIndexOnLoaded:previewImage :self.photosetIndex];
    }
}

- (UITableViewCell *)selfPopulatedTableViewCellForTableView:(UITableView *)tableView
{
    static NSString *photosetTableCellIdentifier = @"PhotosetTableCell";
     
    PhotosetTableCell *cell = (PhotosetTableCell *)[tableView dequeueReusableCellWithIdentifier:photosetTableCellIdentifier];
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PhotosetTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    /*
     *  Disable user interaction for each cell until all Photosets are loaded via json.
     *  A custom delegate called in AlbumViewController.m will re-enable user interaction.
     */
    //[cell setUserInteractionEnabled:NO];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    [cell.photosetTitleLabel setText:self.photosetTitle];
    [cell.photosetCountLabel setText:[NSString stringWithFormat:@"%i photos", self.photosetCount]];
    [cell.photosetPreviewImageView setFrame:CGRectMake(5.0f, 5.0f, 60.0f, 60.0f)];
    [cell.imagePreviewLoadingActivityIndicator setHidesWhenStopped:YES];
    [cell.imagePreviewLoadingActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [cell.imagePreviewLoadingActivityIndicator startAnimating];
    return cell;
}

- (void)thisPhotosetHasBeenSelected
{
    NSLog(@"Photoset selected: %@", self.photosetTitle);
    PhotosetViewController *photosetViewController = [[PhotosetViewController alloc] initWithNavBarTitle:self.photosetTitle];
    photosetViewController.photoSet = self;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:photosetViewController animated:YES];
}

- (void)photoSelectedToViewInGallery:(NSUInteger)selectedPhotoIndex;
{
    NSLog(@"Opening Gallery View with this photoset");
    GalleryViewController *galleryViewController = [[GalleryViewController alloc] init];
    galleryViewController.photoset = self;
    galleryViewController.selectedPhotoIndex = selectedPhotoIndex;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //[appDelegate.navigationController pushViewController:galleryViewController animated:YES];
    [appDelegate.navigationController presentModalViewController:galleryViewController animated:YES];
}

- (void)requestFinished:(ASIHTTPRequest *)theRequest
{
    NSString *responseString = [theRequest responseString];
    NSDictionary *resultsDictionary = [responseString objectFromJSONString];
    
    NSDictionary *flickrPhotos = [[resultsDictionary objectForKey:@"photoset"] objectForKey:@"photo"];
    for(NSDictionary *flickrPhoto in flickrPhotos)
    {
        Photo *photo = [[Photo alloc] initWithDictionary:flickrPhoto];
        [photo setDelegate:self];
        [photo populateImages];
        [self.photosetPhotos addObject:photo];
    }
    
    /*
     *  Remove the delegate and set request to nil when done. 
     *  We don't need them anymore
     */
    [self.request setDelegate:nil];
    self.request = nil;
}

- (void)requestFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"We could not get the photoset id. Connection failed!");
    /*
     *  Remove the delegate and set request to nil when done.
     *  We don't need them anymore
     */
    [self.request setDelegate:nil];
    self.request = nil;
}

- (void)dealloc
{
    [self.request clearDelegatesAndCancel];
    [self.request setDelegate:nil];
    self.request = nil;
    self.photosetPhotos = nil;
}

@end
