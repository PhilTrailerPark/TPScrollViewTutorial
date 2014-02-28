//
//  TPMasterViewController.m
//  temp
//
//  Created by Philip Starner on 2/19/14.
//  Copyright (c) 2014 Philip Starner. All rights reserved.
//

#import "TPMasterViewController.h"

#import "TPDetailViewController.h"
#import "TPYBase.h"
#import "TPYYoyo.h"
#import "TPYImage.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "JSONKit.h"

@interface TPMasterViewController ()
    @property (strong, nonatomic) TPYBase *yoyoBase;
    //NSMutableArray *_objects;

@end

@implementation TPMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (TPDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    if (isDataLocal) {
        [self loadLocalJSON];
    } else {
        [self loadOnlineJSON];
    }
}

- (void) loadLocalJSON {
    NSString* filepath = [[NSBundle mainBundle]pathForResource:@"yoyo" ofType:@"json"];
    
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
    
    self.yoyoBase = [[TPYBase alloc] initWithDictionary:[jsonString objectFromJSONString]];
    
    [self.tableView reloadData];
}

- (void) loadOnlineJSON {
    
    NSString *yoyoUrl = [NSString stringWithFormat:@"%@popcorn/yoyo.json", BaseURLString];
    NSURL *url = [NSURL URLWithString:yoyoUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.yoyoBase = [[TPYBase alloc] initWithDictionary:responseObject];
        
        [self.tableView reloadData];
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

- (void)insertNewObject:(id)sender
{
    return;
    /*
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
     */
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!self.yoyoBase) return 0;
    
    switch ( [self.yoyoBase.yoyo count] ) {
        case 0:{
            return 1;
        }
        default:
            return [self.yoyoBase.yoyo count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    UIImageView *imageView = (UIImageView*)[cell.contentView viewWithTag:3];
    UIImage *image = [UIImage imageNamed:@"leosniper"];
    [imageView setImage:image];
    
    TPYYoyo *yoyo = (TPYYoyo *)[self.yoyoBase.yoyo objectAtIndex:indexPath.row];
    TPYImage *yoyoImage = (TPYImage *)yoyo.image;
    [imageView setImageWithURL:[NSURL URLWithString:yoyoImage.small]
                   placeholderImage:[UIImage imageNamed:@"yoyop2.png"]];
    
    
    UILabel *title = (UILabel*)[cell.contentView viewWithTag:1];
    title.text = yoyo.name;
    UILabel *subtitle = (UILabel*)[cell.contentView viewWithTag:2];
    subtitle.text = yoyo.manufacturer;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
     */
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        TPYYoyo *yoyo = (TPYYoyo *)[self.yoyoBase.yoyo objectAtIndex:indexPath.row];
        self.detailViewController.detailItem = yoyo;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = _objects[indexPath.row];
        
        TPYYoyo *yoyo = (TPYYoyo *)[self.yoyoBase.yoyo objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:yoyo];
    }
}

@end
