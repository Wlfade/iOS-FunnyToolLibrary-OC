//
//  UIButton+LZCategory.m
//  自定义按钮 UIEdgeInsets
//
//  Created by jczj on 17/2/22.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "UIButton+LZCategory.h"

@implementation UIButton (LZCategory)
- (void)LZSetbuttonType:(LZCategoryType)lzType{
    //需要在外部修改标题背景色的时候将此代码注释
    self.titleLabel.backgroundColor = self.backgroundColor;
    self.imageView.backgroundColor = self.backgroundColor;
    
    CGSize titleSize = self.titleLabel.bounds.size;
    CGSize imageSize = self.imageView.bounds.size;
    CGFloat interval = 1.0;
    
    if (lzType == LZCategoryTypeLeft) {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleSize.width + interval, 0, - (titleSize.width + interval))];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval)];
    } else if(lzType == LZCategoryTypeBottom) {
        
        [self setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height + interval, -(titleSize.width))];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + interval, -(imageSize.width), 0, 0)];
    }

}
@end
