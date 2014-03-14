//
//  TPDetailViewController.m
//  temp
//
//  Created by Philip Starner on 2/19/14.
//  Copyright (c) 2014 Philip Starner. All rights reserved.
//

#import "TPDetailViewController.h"
#import "TPYBase.h"
#import "TPYYoyo.h"
#import "TPYImage.h"
#import "UIImageView+AFNetworking.h"
#import "ShareKit.h"

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
        TPYYoyo *yoyo = (TPYYoyo *)self.detailItem;
        self.yoyoObject = yoyo;
        TPYImage *yoyoImage = (TPYImage *)yoyo.image;
        [self.imageView setImageWithURL:[NSURL URLWithString:yoyoImage.large]
                  placeholderImage:[UIImage imageNamed:@"yoyop2.png"]];
        self.titleLabel.text = yoyo.name;
        self.subtitleLabel.text = yoyo.manufacturer;
        self.textView.text = yoyo.yoyoDescription;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(onShare:)];
    self.navigationItem.rightBarButtonItem = actionButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Yo Yo", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - button bar
- (void)onShare:(id)sender
{
    SHKItem *item = nil;
    if (TRY_ENHANCED_URL_SHARE) {
        NSString *pageTitle = self.yoyoObject.name;
        TPYImage *yoyoImage = (TPYImage *)self.yoyoObject.image;
        
        item = [SHKItem URL:[NSURL URLWithString:yoyoImage.large] title:self.yoyoObject.name contentType:SHKURLContentTypeImage];
        item.URL = [NSURL URLWithString:yoyoImage.large];
        item.title = pageTitle;
        item.URLPictureURI = [NSURL URLWithString:yoyoImage.large];
        item.URLDescription = self.yoyoObject.yoyoDescription;
        item.tags = [NSArray arrayWithObjects:self.yoyoObject.name,self.yoyoObject.manufacturer, nil];
        
        // bellow are examples how to preload SHKItem with some custom sharer specific settings. You can prefill them ad hoc during each particular SHKItem creation, or set them globally in your configurator, so that every SHKItem is prefilled with the same values. More info in SHKItem.h or DefaultSHKConfigurator.m.
        item.mailToRecipients = [NSArray arrayWithObjects:@"philip.starner@trailerpark.com", nil];
        item.textMessageToRecipients = [NSArray arrayWithObjects: @"581347615", @"581344543", nil];
        
    } else {
        
        NSString *pageTitle = self.yoyoObject.name;
        
        TPYImage *yoyoImage = (TPYImage *)self.yoyoObject.image;
        item = [SHKItem URL:[NSURL URLWithString:yoyoImage.large] title:pageTitle contentType:SHKURLContentTypeWebpage];
    }
    
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    [SHK setRootViewController:self];
	[actionSheet showFromToolbar:self.navigationController.toolbar];
    
}

@end
