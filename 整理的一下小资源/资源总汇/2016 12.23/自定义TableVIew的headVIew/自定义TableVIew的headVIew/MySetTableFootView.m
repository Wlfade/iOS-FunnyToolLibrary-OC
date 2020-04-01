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

@property (nonatomic,retain)UIButton *clickBtn;
@end
@implementation MySetTableFootView

/** <#注释#> */
- (UIButton *)clickBtn{
    if (_clickBtn == nil) {
        _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clickBtn.backgroundColor = [UIColor blueColor];
        [_clickBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickBtn;
}

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
    [self.contentView addSubview:self.clickBtn];
}
- (void)setTitle:(NSString *)title{
    if (_title != title) {
        _title = title;
    }
    titleLabel.text = _title;
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectMake(20,0, titleLabel.frame.size.width, 20);
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.clickBtn.frame = CGRectMake(200, 0, 20, 20);
}
- (void)clickAction{
    NSLog(@"按钮点击");
}
@end
