//
//  AbstractViewController.h
//  Photography
//
//  Created by Matt Finucane on 28/10/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractViewController : UIViewController

@property (strong, nonatomic) NSString *navBarTitle;
- (id)initWithNavBarTitle:(NSString *)theNavBarTitle;
@end
