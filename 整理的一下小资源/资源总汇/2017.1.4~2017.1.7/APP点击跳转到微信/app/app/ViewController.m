//
//  ViewController.m
//  app
//
//  Created by zhong on 16/12/28.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 30);
    [button setTitle:@"打开微信" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openWeixin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)openWeixin {
    NSURL *url = [NSURL URLWithString:@"weixin://"];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
    } else {
        UIAlertView*ale=[[UIAlertView alloc] initWithTitle:@"提示" message:@"没打开" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [ale show];
    }
}


@end
