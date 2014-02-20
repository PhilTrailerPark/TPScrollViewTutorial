//
//  TPMasterViewController.h
//  temp
//
//  Created by Philip Starner on 2/19/14.
//  Copyright (c) 2014 Philip Starner. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPDetailViewController;

@interface TPMasterViewController : UITableViewController

@property (strong, nonatomic) TPDetailViewController *detailViewController;

@end
