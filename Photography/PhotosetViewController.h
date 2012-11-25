//
//  PhotosetViewController.h
//  Photography
//
//  Created by Matt Finucane on 24/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "AbstractViewController.h"
#import "Photoset.h"
#import "PhotoView.h"

@interface PhotosetViewController : AbstractViewController <PhotoTapDelegate>
{
    Photoset *photoSet;
}
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *photosetScrollView;
@property (nonatomic, retain) Photoset *photoSet;
@end
