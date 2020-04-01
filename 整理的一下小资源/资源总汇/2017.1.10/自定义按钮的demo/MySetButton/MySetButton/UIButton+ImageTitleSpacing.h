//
//  UIButton+ImageTitleSpacing.h
//  MySetButton
//
//  Created by jczj on 17/1/10.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,DCButtonEdgeInsetsStyle){
    DCButtonEdgeInsetsStyleTop,
    DCButtonEdgeInsetsStyleLeft,
    DCButtonEdgeInsetsStyleBottom,
    DCButtonEdgeInsetsStyleRight
};
@interface UIButton (ImageTitleSpacing)
/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(DCButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
@end
