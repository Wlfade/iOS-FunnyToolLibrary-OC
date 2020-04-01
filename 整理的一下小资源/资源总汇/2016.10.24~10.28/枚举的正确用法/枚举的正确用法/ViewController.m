//
//  ViewController.m
//  枚举的正确用法
//
//  Created by jczj on 16/10/24.
//  Copyright © 2016年 jczj. All rights reserved.
//

#import "ViewController.h"
#import "TheFourStyleAlertView.h"
@interface ViewController ()
{
    UILabel *moneyLabel;
    UILabel *nextLabel;

    testNSInteger _testInt;
//    NSString *myGetStr;
}
@property (nonatomic,copy)NSString *myGetStr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    moneyLabel = [[UILabel alloc]init];
    moneyLabel.text = @"已转账金额";
    moneyLabel.textColor = [UIColor blackColor];
    moneyLabel.font = [UIFont systemFontOfSize:19];
    [moneyLabel sizeToFit];
    moneyLabel.frame = CGRectMake(20, 15, 100, 20);
    [self.view addSubview:moneyLabel];
    
    
    nextLabel = [[UILabel alloc]init];
    nextLabel.text = @"wahaha";
    nextLabel.textColor = [UIColor blackColor];
    nextLabel.font = [UIFont systemFontOfSize:19];
    [nextLabel sizeToFit];
    nextLabel.frame = CGRectMake(120, 15, 100, 20);
    [self.view addSubview:nextLabel];
    
    UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clickBtn.frame = CGRectMake(100, 100, 50, 50);
    [clickBtn setTitle:@"点击按钮1" forState:UIControlStateNormal];
    [clickBtn sizeToFit];
    //    clickBtn setImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
    [clickBtn setBackgroundColor:[UIColor yellowColor]];
    [clickBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [clickBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn];
    _testInt = 0;
    
    
    UIButton *nextClickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextClickBtn.frame = CGRectMake(100, 300, 50, 50);
    [nextClickBtn setTitle:@"点击按钮2" forState:UIControlStateNormal];
    [nextClickBtn sizeToFit];
    //    clickBtn setImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
    [nextClickBtn setBackgroundColor:[UIColor yellowColor]];
    [nextClickBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nextClickBtn addTarget:self action:@selector(nextClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextClickBtn];
    
    UIButton *thirdClickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdClickBtn.frame = CGRectMake(100, 400, 50, 50);
    [thirdClickBtn setTitle:@"点击按钮2" forState:UIControlStateNormal];
    [thirdClickBtn sizeToFit];
    //    clickBtn setImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
    [thirdClickBtn setBackgroundColor:[UIColor yellowColor]];
    [thirdClickBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [thirdClickBtn addTarget:self action:@selector(thirdAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdClickBtn];
    
}
- (void)nextClickAction{
    TTGDirection direction = TTGDirectionTop | TTGDirectionLeft | TTGDirectionBottom;
    
    //用“与”运算取出对应位
//    if (direction & TTGDirectionNone) {
//        NSLog(@"None  code will never be executed");
//    }
    if (direction & TTGDirectionTop) {
        NSLog(@"top");
    }
    if (direction & TTGDirectionLeft) {
        NSLog(@"left");
    }
    if (direction & TTGDirectionRight) {
        NSLog(@"right");
    }
    if (direction & TTGDirectionBottom) {
        NSLog(@"bottom");
    }
}
- (void)clickAction:(testNSInteger)testInt{
    testInt = _testInt;
    NSString *resultStr = nil;
    switch (testInt) {
        case testZero:
            resultStr = @"结果是0";
            break;
        case testOne:
            resultStr = @"结果是1";
            break;
        case testTwo:
            resultStr = @"结果是2";
            break;
        case testThree:
            resultStr = @"结果是3";
            break;
        case testFour:
            resultStr = @"结果是4";
            break;
        default:
            break;
    }
    if (resultStr != nil) {
        moneyLabel.text = resultStr;
    }else{
    }
    _testInt ++;
    if (_testInt > 4) {
        _testInt = 0;
    }
}
- (void)thirdAction{
    TheFourStyleAlertView *alertView = [[TheFourStyleAlertView alloc]initWithTransAcountTip];
    alertView.curtainBlock =^(NSString *result){
        nextLabel.text = result;
    };
    [alertView showAlert];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
