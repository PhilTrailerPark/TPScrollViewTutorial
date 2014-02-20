//
//  TPDetailViewController.m
//  temp
//
//  Created by Philip Starner on 2/19/14.
//  Copyright (c) 2014 Philip Starner. All rights reserved.
//

#import "TPDetailViewController.h"

@interface TPDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation TPDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        
        UIImage *image = [UIImage imageNamed:@"leosniper"];
        [self.imageView setImage:image];
        self.titleLabel.text = @"Leo Sniper";
        self.subtitleLabel.text = @"by Sturm Panzer";
        self.textView.text = @"The SY-002 is the yo-yo used by Sturm Panzer protagonist, Kyoshiro Aoi.\n\"The 21st century's new form of combat: Yo-Yo Fist. Since the Stealth Ogre incident in 2013, team Sturm Panzer was disqualified from the league, and won't be present at the competition in 2014. But the dissolved team has turned their sights on a comeback in 2015.";
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
