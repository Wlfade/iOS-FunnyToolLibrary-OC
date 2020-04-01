//
//  ItemCell.m
//  UICollectionViewDemo练习
//
//  Created by jczj on 17/1/19.
//  Copyright © 2017年 jczj. All rights reserved.
//

/*
 这两天都遇到这个错误2次了  第一次是 创建了一个 newpassword的textField属性  第二次是 申明了一个 类的对象 copyStateVC；
 
 property follows cocoa naming convention for returning 'owned' objects
 
 查了一番，终于知道原因：命名不规范 ，属性不能以关键字符开头。记得以前刚学OC的时候看到过，不能以alloc，new，copy，mutableCopy 作为开头命名，比如：newPassword, 小细节没注意就会犯错。
 */

#import "ItemCell.h"
#import "ItemModel.h"
@interface ItemCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *rightUpperButton;
@end

@implementation ItemCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat containerX = 10;
        CGFloat containerY = 5;
        CGFloat containerW = self.bounds.size.width - 2 * containerX;
        CGFloat containerH = self.bounds.size.height - 2 * containerY;
        
        _container = [[UIView alloc]initWithFrame:CGRectMake(containerX, containerY, containerW, containerH)];
        _container.backgroundColor = [UIColor whiteColor];
        _container.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        _container.layer.borderColor = [UIColor colorWithRed:232 / 255.0 green:232 / 255.0 blue:232 / 255.0 alpha:1.0].CGColor;
       //[[UIScreen main] scale] == 1; //代表320 x 480 的分辨率
       //[[UIScreen main] scale] == 2; //代表640 x 960 的分辨率
       //[[UIScreen main] scale] == 3; //代表1242 x 2208 的分辨率
        
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake((containerW - 40)/2, 6, 40, 40)];
        
        _theNewIcon = [[UIImageView alloc]initWithFrame:_icon.frame];
        _theNewIcon.image = [UIImage imageNamed:@"专业分析"];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_icon.frame), containerW, containerH - CGRectGetMaxY(_icon.frame))];
        _titleLabel.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:11];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _rightUpperButton = [[UIButton alloc] initWithFrame:CGRectMake(containerW - 40 / 2 - 13 / 2 - 2, -20 + 13 / 2 + 2, 40, 40)];
//        _rightUpperButton = [[UIButton alloc] initWithFrame:CGRectMake(containerW - 23 , 0, 23, 23)];

//        _rightUpperButton.backgroundColor = [UIColor redColor];
        [_rightUpperButton addTarget:self action:@selector(rightUpperButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_container addSubview:_icon];
        [_container insertSubview:_theNewIcon aboveSubview:_icon];
        [_container addSubview:_titleLabel];
        [_container addSubview:_rightUpperButton];
        [self.contentView addSubview:_container];

    }
    return self;
}
- (void)setItemModel:(ItemModel *)itemModel{
    if (_itemModel != itemModel) {
        _itemModel = itemModel;
    }
    _icon.image = [UIImage imageNamed:itemModel.imageName];
    
    _titleLabel.text = itemModel.itemTitle;

    _theNewIcon.hidden = !itemModel.isNew;
    
    switch (itemModel.status) {
        case StatusMinusSign:
            [_rightUpperButton setImage:[UIImage imageNamed:@"图标_06"] forState:UIControlStateNormal];
            break;
        case StatusPlusSign:
            [_rightUpperButton setImage:[UIImage imageNamed:@"图标_10"] forState:UIControlStateNormal];
            break;
        case StatusCheck:
            [_rightUpperButton setImage:[UIImage imageNamed:@"图标_08"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}
- (void)setIsEditing:(BOOL)isEditing{
    _rightUpperButton.hidden = !isEditing;
}
- (void)rightUpperButtonAction {
    if ([self.delegate respondsToSelector:@selector(rightUpperButtonDidTappedWithItemCell:)]) {
        [self.delegate rightUpperButtonDidTappedWithItemCell:self];
    }
}

@end
