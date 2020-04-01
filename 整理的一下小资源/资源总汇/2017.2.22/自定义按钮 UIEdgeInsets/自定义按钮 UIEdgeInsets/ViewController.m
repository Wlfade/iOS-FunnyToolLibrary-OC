//
//  ViewController.m
//  自定义按钮 UIEdgeInsets
//
//  Created by jczj on 17/2/22.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+LZCategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor redColor];
    button1.frame = CGRectMake(40, 90, 100, 30);
    [button1 setTitle:@"标题在左" forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateNormal];
    [self.view addSubview:button1];
    [button1 LZSetbuttonType:LZCategoryTypeLeft];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(40, 280, 80, 90);
    [button setTitle:@"标题在下" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"AppIcon60x60"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button LZSetbuttonType:LZCategoryTypeBottom];
    
}
- (void)clickAction{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
