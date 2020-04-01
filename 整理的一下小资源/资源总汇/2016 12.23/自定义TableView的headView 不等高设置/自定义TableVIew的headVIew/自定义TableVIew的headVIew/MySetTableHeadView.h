//
//  MySetTableHeadView.h
//  自定义TableVIew的headVIew
//
//  Created by jczj on 16/12/23.
//  Copyright © 2016年 jczj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySetTableHeadView : UITableViewHeaderFooterView

/**
 title
 */
@property (nonatomic,copy)NSString *title;

@property (nonatomic,retain)UIButton *clickBtn;
//+(instancetype)headerViewWithTableView:(UITableView *)tableView;
+ (CGFloat)loadTheCellHeight:(NSInteger)section;
@end
