//
//  PhotosetCellViewController.h
//  Photography
//
//  Created by Matt Finucane on 19/11/2012.
//  Copyright (c) 2012 Matt Finucane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosetTableCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *photosetPreviewImageView;
@property (nonatomic, strong) IBOutlet UILabel *photosetTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *photosetCountLabel;

@end
