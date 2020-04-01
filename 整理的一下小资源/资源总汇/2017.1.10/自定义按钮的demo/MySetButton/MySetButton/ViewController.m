//
//  ViewController.m
//  MySetButton
//
//  Created by jczj on 17/1/10.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+ImageTitleSpacing.h"
@interface ViewController ()
{
    UIButton *topBtn;
    UIButton *leftBtn;
    UIButton *bottomBtn;
    UIButton *rightBtn;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _creatButtonView];
    [self _updateUI];
}
- (void)_creatButtonView{
    topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn.frame = CGRectMake(150, 50, 200, 50);
    [topBtn setTitle:@"点击按钮" forState:UIControlStateNormal];

    [topBtn setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    [topBtn setBackgroundColor:[UIColor yellowColor]];
    [topBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [topBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateSelected];
    [topBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topBtn];
    
    leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [leftBtn setTitle:@"点击按钮" forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    [leftBtn setBackgroundColor:[UIColor yellowColor]];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    CGSize size = [self sizeWithText: leftBtn.titleLabel.text font:leftBtn.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    leftBtn.frame = CGRectMake(150, 150, size.width + 40, 40);
    [self.view addSubview:leftBtn];
    
    bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(150, 250, 200, 50);
    [bottomBtn setTitle:@"点击按钮" forState:UIControlStateNormal];
//    [bottomBtn sizeToFit];
    [bottomBtn setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    [bottomBtn setBackgroundColor:[UIColor yellowColor]];
    [bottomBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(150, 350, 200, 50);
    [rightBtn setTitle:@"点击按钮" forState:UIControlStateNormal];
//    [rightBtn sizeToFit];
    [rightBtn setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    [rightBtn setBackgroundColor:[UIColor yellowColor]];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
}
- (void)_updateUI{
    CGFloat space = 5.0;
    [topBtn layoutButtonWithEdgeInsetsStyle:DCButtonEdgeInsetsStyleTop
                                    imageTitleSpace:space];
    
    [leftBtn layoutButtonWithEdgeInsetsStyle:DCButtonEdgeInsetsStyleLeft
                                     imageTitleSpace:space];
    
    [bottomBtn layoutButtonWithEdgeInsetsStyle:DCButtonEdgeInsetsStyleBottom
                                       imageTitleSpace:space];
    
    [rightBtn layoutButtonWithEdgeInsetsStyle:DCButtonEdgeInsetsStyleRight
                                      imageTitleSpace:space];
}
-(void)initData
{
    
    //调用上面的方法，获取 字体的 Size
    CGSize size = [self sizeWithText: @"此处是测试字体" font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    UILabel * noDataLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 120, size.width, size.height)];
    noDataLab.text = @"此处是测试字体";
    noDataLab.font = [UIFont systemFontOfSize:15];
    noDataLab.textColor = [UIColor grayColor];
    
}
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (void)clickAction:(UIButton *)sender{
    sender.selected =!sender.selected;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
