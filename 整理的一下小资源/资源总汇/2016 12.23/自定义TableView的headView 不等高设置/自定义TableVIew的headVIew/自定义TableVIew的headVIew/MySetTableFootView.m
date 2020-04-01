//
//  MySetTableFootView.m
//  自定义TableVIew的headVIew
//
//  Created by jczj on 16/12/23.
//  Copyright © 2016年 jczj. All rights reserved.
//

#import "MySetTableFootView.h"
@interface MySetTableFootView ()
{
    UILabel *titleLabel;
}
@end
@implementation MySetTableFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor greenColor];
        [self _creatSubView];
    }
    return self;
}
- (void)_creatSubView{
    titleLabel = [[UILabel alloc]init];
    //    titleLabel.text = @"已转账金额";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:19];
    
    [self addSubview:titleLabel];
}
- (void)setTitle:(NSString *)title{
    if (_title != title) {
        _title = title;
    }
    titleLabel.text = _title;
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectMake(20,0, titleLabel.frame.size.width, 20);
}
+ (CGFloat)loadTheCellHeight:(NSInteger)section{
    CGFloat height = 20*(section+1) + section;
    return height;
}
@end
