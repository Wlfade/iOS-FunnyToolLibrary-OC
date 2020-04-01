//
//  ItemCellHeaderView.m
//  UICollectionViewDemo练习
//
//  Created by jczj on 17/1/19.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "ItemCellHeaderView.h"
@interface ItemCellHeaderView ()
@property (nonatomic, strong) UILabel *typeLabel;
@end
@implementation ItemCellHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 2 * 10, frame.size.height)];
        _typeLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1.0];
        _typeLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_typeLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _typeLabel.text = _title;
}
@end
