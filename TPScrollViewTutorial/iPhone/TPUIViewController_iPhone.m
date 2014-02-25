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
    NSString* filepath = [[NSBundle mainBundle]pathForResource:@"yoyo" ofType:@"json"];
    
    //NSData *data = [NSData dataWithContentsOfFile:filepath];
    
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
    
    self.yoyoBase = [[TPYBase alloc] initWithDictionary:[jsonString objectFromJSONString]];
    
    [self.collectionView reloadData];
}

- (void) loadOnlineJSON {
    NSString *weatherUrl = [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@", responseObject);
        //self.yoyoBase = (TPYBase *)responseObject;
        self.yoyoBase =[[TPYBase alloc] initWithDictionary:responseObject];
        //self.title = @"JSON Retrived";
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving YoYos" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [av show];
    }];
    
    [operation start];
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
    
    UIImage *image = [UIImage imageNamed:@"leosniper"];
    [cell.imageView setImage:image];
    
    return cell;
}

#pragma mark -
#pragma mark ScrollingCellDelegate
- (void)scrollingCellDidBeginPulling:(TPScrollingCell_iPhone *)cell {
    [self.scrollView setScrollEnabled:NO];
    
    self.detailView.backgroundColor = cell.color;
    [_detailImage setImage:cell.imageView.image];
    _detailTitle.text = @"Sturm Panzer Leo Sniper";
    _detailText.text = @"The SY-002 is the yo-yo used by Sturm Panzer protagonist, Kyoshiro Aoi.\n\"The 21st century's new form of combat: Yo-Yo Fist. Since the Stealth Ogre incident in 2013, team Sturm Panzer was disqualified from the league, and won't be present at the competition in 2014. But the dissolved team has turned their sights on a comeback in 2015.";
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
