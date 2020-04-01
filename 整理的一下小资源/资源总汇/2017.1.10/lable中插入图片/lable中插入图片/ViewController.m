//
//  ViewController.m
//  lable中插入图片
//
//  Created by jczj on 17/1/14.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _creatImageLabel];
 
}
- (void)_creatImageLabel{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:@"哈哈哈哈哈123456789"];
    // 修改富文本中的不同文字的样式
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 5)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 5)];
    
    // 设置数字为红色
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 9)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(5, 9)];
    //在这段代码中，分别设置了range为（0，5）的文字，也就是哈哈哈哈哈为font20号字体大小，颜色为蓝色的样式；设置了range为（6，9）也就是123456789为font30号字体大小，颜色为红色样式
    
    
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:@"emoji_1_big"];
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, 32, 32);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
//    [attri appendAttributedString:string];
    [attri insertAttributedString:string atIndex:0];
    
    
    UILabel *moneyLabel = [[UILabel alloc]init];
 // 用label的attributedText属性来使用富文本
    moneyLabel.attributedText = attri;
//    moneyLabel.textColor = [UIColor blackColor];
//    moneyLabel.font = [UIFont systemFontOfSize:19];
    [moneyLabel sizeToFit];
//    moneyLabel.frame = CGRectMake(20, 100, 300, 40);
    moneyLabel.frame = CGRectMake(20, 100, moneyLabel.bounds.size.width, 40);
    moneyLabel.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:moneyLabel];
}
//练习                                                                                                                                                                                                                                                
#pragma mark 创建发话题等级提示Label
- (UILabel *)_creatLevelTipLabel:(CGRect)imageFrame{
    /*  ------ test demo ----
     NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:@"哈哈哈哈哈123456789"];
     // 修改富文本中的不同文字的样式
     [attri addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 5)];
     [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 5)];
     
     // 设置数字为红色
     [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 9)];
     [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(5, 9)];
     //在这段代码中，分别设置了range为（0，5）的文字，也就是哈哈哈哈哈为font20号字体大小，颜色为蓝色的样式；设置了range为（6，9）也就是123456789为font30号字体大小，颜色为红色样式
     */
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:@"未达到LV7等级发表话题不会展示在公共发现栏目" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],
                                                                                                                                NSForegroundColorAttributeName:[UIColor redColor]
                                                                                                                                }];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(3, 3)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(3, 3)];
    
    /* --- spread ---
     // 添加表情
     NSTextAttachment *attch = [[NSTextAttachment alloc] init];
     // 表情图片
     attch.image = [UIImage imageNamed:@"定制承接页_03"];
     // 设置图片大小
     attch.bounds = CGRectMake(0, 0, 14, 14);
     
     
     // 创建带有图片的富文本
     NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
     [attri appendAttributedString:string];  //图片添加到尾部
     [attri insertAttributedString:string atIndex:0];  //图片插入下标 位置
     */
    
    UILabel *moneyLabel = [[UILabel alloc]init];
    // 用label的attributedText属性来使用富文本
    moneyLabel.attributedText = attri;
    [moneyLabel sizeToFit];
    moneyLabel.frame = CGRectMake(CGRectGetMaxX(imageFrame), CGRectGetMinY(imageFrame), moneyLabel.bounds.size.width, 29);
    return moneyLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
