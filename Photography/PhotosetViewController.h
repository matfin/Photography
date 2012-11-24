//
//  PhotosetViewController.h
//  Photography
//
//  Created by Matt Finucane on 24/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import "AbstractViewController.h"
#import "Photoset.h"

@interface PhotosetViewController : AbstractViewController
{
    Photoset *photoSet;
}
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *photosetScrollView;
@property (nonatomic, retain) Photoset *photoSet;
@end
