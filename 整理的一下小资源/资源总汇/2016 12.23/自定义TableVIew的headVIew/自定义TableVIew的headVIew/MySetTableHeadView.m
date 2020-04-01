//
//  MySetTableHeadView.m
//  自定义TableVIew的headVIew
//
//  Created by jczj on 16/12/23.
//  Copyright © 2016年 jczj. All rights reserved.
//

#import "MySetTableHeadView.h"
#import "common.h"
@interface MySetTableHeadView (){
    UILabel *titleLabel;
}
@end
@implementation MySetTableHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor blueColor];
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
    
    _clickBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    
    _clickBtn.backgroundColor = [UIColor redColor];
    
    //[pullDownbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    pullDownbtn.tag = section;
    
//    [pullDownbtn addTarget:self action:@selector(pullDownAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_clickBtn];
}
- (void)setTitle:(NSString *)title{
    if (_title != title) {
        _title = title;
    }
    titleLabel.text = _title;
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectMake(20,0, titleLabel.frame.size.width, 20);
    
    _clickBtn.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, 20, 20);
}
@end
