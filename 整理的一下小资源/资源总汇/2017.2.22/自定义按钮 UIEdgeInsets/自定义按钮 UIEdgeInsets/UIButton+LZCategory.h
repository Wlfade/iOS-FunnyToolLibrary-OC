//
//  UIButton+LZCategory.h
//  自定义按钮 UIEdgeInsets
//
//  Created by jczj on 17/2/22.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,LZCategoryType) {
    LZCategoryTypeLeft = 0,
    LZCategoryTypeBottom,
};
@interface UIButton (LZCategory)
- (void)LZSetbuttonType:(LZCategoryType)lzType;
@end
