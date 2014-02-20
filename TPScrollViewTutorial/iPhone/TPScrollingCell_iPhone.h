//
//  SVScrollingCell.h
//  iOS7ScrollViews
//
//  Created by Pierre Felgines on 20/06/13.
//  Copyright (c) 2013 Pierre Felgines. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TPScrollingCellDelegate;

@interface TPScrollingCell_iPhone : UICollectionViewCell <UIScrollViewDelegate>
@property (nonatomic, assign) id<TPScrollingCellDelegate> delegate;
@property (nonatomic, retain) UIColor * color;

@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) UIView * colorView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@protocol TPScrollingCellDelegate <NSObject>
- (void)scrollingCellDidBeginPulling:(TPScrollingCell_iPhone *)cell;
- (void)scrollingCell:(TPScrollingCell_iPhone *)cell didChangePullOffset:(CGFloat)offset;
- (void)scrollingCellDidEndPulling:(TPScrollingCell_iPhone *)cell;
@end