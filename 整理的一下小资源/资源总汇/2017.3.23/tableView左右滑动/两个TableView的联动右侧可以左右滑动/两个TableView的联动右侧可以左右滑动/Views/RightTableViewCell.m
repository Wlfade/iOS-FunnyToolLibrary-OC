//
//  RightTableViewCell.m
//  两个TableView的联动右侧可以左右滑动
//
//  Created by jczj on 17/3/23.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "RightTableViewCell.h"
#import "UIView+customView.h"
@implementation RightTableViewCell
+ (instancetype)cellWithTabelView:(UITableView *)tebleView withNumberOfLabels:(NSInteger)number{
    static NSString *identifier = @"cell";
    //1.缓存中取
    RightTableViewCell *cell = [tebleView dequeueReusableCellWithIdentifier:identifier];
    //2.创建
    if (cell == nil) {
        cell = [[RightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        UIView *view = [UIView viewWithLabelNumber:number];
        view.tag = 100;
        [cell.contentView addSubview:view];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
