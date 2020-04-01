//
//  ViewController.m
//  图文混排
//
//  Created by zhong on 16/9/11.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 220, 100, 30);
    [button setTitle:@"插入" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick {
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"emoji_1_big"];
    attach.bounds = CGRectMake(0, 0, 30, 30);
    NSAttributedString *attr = [NSAttributedString attributedStringWithAttachment:attach];
    
    self.textView.attributedText = attr;

}



@end
