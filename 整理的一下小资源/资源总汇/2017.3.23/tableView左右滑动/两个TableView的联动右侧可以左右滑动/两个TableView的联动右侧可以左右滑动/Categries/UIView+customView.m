//
//  UIView+customView.m
//  两个TableView的联动右侧可以左右滑动
//
//  Created by jczj on 17/3/23.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "UIView+customView.h"
#define LabelWidth 80
#define LabelHeight 40
@implementation UIView (customView)
+ (UIView *)viewWithLabelNumber:(NSInteger)num{
    UIView *view = [[self alloc]initWithFrame:CGRectMake(0, 0, LabelWidth * num, LabelHeight)];
    for (int i = 0;i < num; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i, 0, LabelWidth, LabelHeight)];
        label.tag = i;
        label.textAlignment = NSTextAlignmentRight;
        [view addSubview:label];
    }
    return view;
}
@end
