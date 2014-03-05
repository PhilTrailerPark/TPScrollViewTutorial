//
//  TPUIViewController.m
//  TPScrollViewTutorial
//
//  Created by Philip Starner on 2/18/14.
//  Copyright (c) 2014 Philip Starner. All rights reserved.
//

#import "TPUIViewController_iPhone.h"
#import "TPScrollingCell_iPhone.h"
#import "TPYBase.h"
#import "TPYYoyo.h"
#import "TPYImage.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "JSONKit.h"
#import "TPJSONArrayNetworkRequest.h"

static NSString * cellIdentifier = @"CellIdentifier";

@interface TPUIViewController_iPhone () <TPScrollingCellDelegate, UIScrollViewDelegate>

@property (strong) TPYBase *yoyoBase;
@end

@implementation TPUIViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.collectionView registerClass:[TPScrollingCell_iPhone class] forCellWithReuseIdentifier:cellIdentifier];
    self.scrollView.contentSize = CGSizeMake(2 * self.view.frame.size.width, self.view.frame.size.height);
    
    self.scrollView.contentSize = CGSizeMake(2 * self.view.frame.size.width, self.view.frame.size.height);
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    
    if (isDataLocal) {
        [self loadLocalJSON];
    } else {
        [self loadOnlineJSON];
    }

}

- (void) loadLocalJSON {
    TPJSONArrayNetworkRequest *tpjson = [TPJSONArrayNetworkRequest sharedInstance];
    [tpjson loadLocalJSON:^(NSString *jsonString) {
        self.yoyoBase = [[TPYBase alloc] initWithDictionary:[jsonString objectFromJSONString]];
        [self.collectionView reloadData];
    }];
}

- (void) loadOnlineJSON
{
    TPJSONArrayNetworkRequest *tpjson = [TPJSONArrayNetworkRequest sharedInstance];
    [tpjson loadOnlineJSON:^(NSObject *jsonData) {
        self.yoyoBase = [[TPYBase alloc] initWithDictionary:(NSDictionary*)jsonData];
        [self.collectionView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(!self.yoyoBase) return 0;
    
    //TPYYoyo *yoyos = [self.yoyoBase.yoyo objectAtIndex:0];
    
    switch ( [self.yoyoBase.yoyo count] ) {
        case 0:{
            return 1;
        }
        default:
            return [self.yoyoBase.yoyo count];
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TPScrollingCell_iPhone *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //cell.color = [self randomColor];
    cell.color = [UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1];
    cell.delegate = self;
    
    //UIImage *image = [UIImage imageNamed:@"leosniper"];
    //[cell.imageView setImage:image];
    TPYYoyo *yoyo = (TPYYoyo *)[self.yoyoBase.yoyo objectAtIndex:indexPath.row];
    TPYImage *yoyoImage = (TPYImage *)yoyo.image;
    [cell.imageView setImageWithURL:[NSURL URLWithString:yoyoImage.small]
                   placeholderImage:[UIImage imageNamed:@"yoyop2.png"]];
    
    cell.dataObject = yoyo;
    
    cell.title.text = yoyo.name;
    cell.subtitle.text = yoyo.manufacturer;
    
    return cell;
}

#pragma mark -
#pragma mark ScrollingCellDelegate
- (void)scrollingCellDidBeginPulling:(TPScrollingCell_iPhone *)cell {
    [self.scrollView setScrollEnabled:NO];
    
    self.detailView.backgroundColor = cell.color;
    TPYYoyo *yoyo = (TPYYoyo *)cell.dataObject;
    TPYImage *yoyoImage = (TPYImage *)yoyo.image;
    [_detailImage setImage:cell.imageView.image];
    [_detailImage setImageWithURL:[NSURL URLWithString:yoyoImage.large]
                   placeholderImage:[UIImage imageNamed:@"yoyop2.png"]];
    
    _detailTitle.text = [NSString stringWithFormat:@"%@ %@", yoyo.name, yoyo.manufacturer];
    _detailText.text = yoyo.yoyoDescription;
}

- (void)scrollingCell:(TPScrollingCell_iPhone *)cell didChangePullOffset:(CGFloat)offset {
    [self.scrollView setContentOffset:CGPointMake(offset, 0)];
}

- (void)scrollingCellDidEndPulling:(TPScrollingCell_iPhone *)cell {
    [self.scrollView setScrollEnabled:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

#pragma mark -
#pragma mark rotation
/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
    // Use this to allow upside down as well
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
*/


#pragma mark -

-(UIColor *) randomColor {
    return [UIColor colorWithRed:(random()%100)/(float)100 green:(random()%100)/(float)100 blue:(random()%100)/(float)100 alpha:1];
}
@end
