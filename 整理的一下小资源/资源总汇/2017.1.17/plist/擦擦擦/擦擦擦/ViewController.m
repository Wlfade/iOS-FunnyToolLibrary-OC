//
//  ViewController.m
//  擦擦擦
//
//  Created by zhong on 17/1/19.
//  Copyright © 2017年 Xz Studio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self save];
}

/// 保存
- (void)save {
    NSString *filePath = [self filePath];
    
    NSArray *array = @[@"爱国福",@"富强福",@"和谐福",@"友善福",@"敬业福"];
    // 将数组存储到文件中
    [array writeToFile:filePath atomically:YES];
}

/// 读取
- (void)read {
    NSString *filePath = [self filePath];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"%@",array);
}

/// 文件路径
- (NSString *)filePath {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"fu.plist"];
    NSLog(@"%@", filePath);
    return filePath;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self read];
}


@end
