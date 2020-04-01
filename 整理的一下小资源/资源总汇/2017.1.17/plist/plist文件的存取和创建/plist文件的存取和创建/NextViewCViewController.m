//
//  NextViewCViewController.m
//  plist文件的存取和创建
//
//  Created by jczj on 17/1/20.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "NextViewCViewController.h"

@interface NextViewCViewController ()

@end

@implementation NextViewCViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];

    [self save];
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeBtn.frame = CGRectMake(100, 100, 50, 50);
    [changeBtn setTitle:@"change" forState:UIControlStateNormal];
    [changeBtn sizeToFit];
    //    clickBtn setImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
    [changeBtn setBackgroundColor:[UIColor yellowColor]];
    [changeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(changeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
}
//编辑
- (void)changeAction{
    NSString *filePath = [self filePath];
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:filePath];
    [array addObject:@"逗逼福"];
    [array writeToFile:filePath atomically:YES];

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
- (NSString *)filePath{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
     NSString *filePath = [cachePath stringByAppendingPathComponent:@"fu.plist"];
    NSLog(@"%@", filePath);
    return filePath;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self read];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
