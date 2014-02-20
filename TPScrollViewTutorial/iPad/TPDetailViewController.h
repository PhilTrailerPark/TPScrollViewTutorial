//
//  TPDetailViewController.h
//  temp
//
//  Created by Philip Starner on 2/19/14.
//  Copyright (c) 2014 Philip Starner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLabel;

@end
