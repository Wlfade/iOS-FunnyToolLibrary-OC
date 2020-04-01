//
//  ItemCell.h
//  UICollectionViewDemo练习
//
//  Created by jczj on 17/1/19.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemCell;
@class ItemModel;
@protocol ItemCellDelegate <NSObject>

- (void)rightUpperButtonDidTappedWithItemCell:(ItemCell *)selectedItemCell;

@end
@interface ItemCell : UICollectionViewCell
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) ItemModel *itemModel;
@property (nonatomic, weak) id <ItemCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIImageView *theNewIcon;
@property (nonatomic, assign) BOOL isEditing;
@end
