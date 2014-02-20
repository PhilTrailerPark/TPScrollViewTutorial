//
//  TPUIViewController.h
//  TPScrollViewTutorial
//
//  Created by Philip Starner on 2/18/14.
//  Copyright (c) 2014 Philip Starner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPUIViewController_iPhone : UIViewController <UICollectionViewDataSource>

@property (retain, nonatomic) IBOutlet UIScrollView * scrollView;
@property (retain, nonatomic) IBOutlet UIView * detailView;
@property (strong, nonatomic) IBOutlet UILabel *detailTitle;
@property (strong, nonatomic) IBOutlet UIImageView *detailImage;
@property (strong, nonatomic) IBOutlet UITextView *detailText;
@property (retain, nonatomic) IBOutlet UICollectionView * collectionView;
@property (retain, nonatomic) IBOutlet UICollectionViewFlowLayout * flowLayout;

@end
