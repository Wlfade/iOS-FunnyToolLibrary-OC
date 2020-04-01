//
//  RightTableViewCell.h
//  两个TableView的联动右侧可以左右滑动
//
//  Created by jczj on 17/3/23.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightTableViewCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tebleView withNumberOfLabels:(NSInteger)number;
@end
