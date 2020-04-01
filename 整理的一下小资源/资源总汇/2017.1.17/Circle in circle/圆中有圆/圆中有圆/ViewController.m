//
//  ViewController.m
//  圆中有圆
//
//  Created by jczj on 17/1/18.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "ViewController.h"
#import "HDRandomView.h"

@interface ViewController ()<HDRandomViewDataSource,HDRandomViewDelegate>
@property (nonatomic, strong) HDRandomView *randomView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    
    _randomView = [[HDRandomView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    _randomView.center = self.view.center;
    _randomView.hdDelegate = self;
    _randomView.hdDataSource  =self;
    [self.view addSubview:_randomView];
    [_randomView reloadDataAnimated:YES];
}
#pragma mark - HDRandomViewDelegate
- (void)hdRandomView:(HDRandomView *)hdRandomView selectIndex:(NSInteger)index{
    NSLog(@"第%ld圆被点击",index);
    UIView *view = [hdRandomView hdRandomViewAtIndex:index];
    
    view.alpha = 0.3;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         view.transform = CGAffineTransformMakeScale(1.2, 1.2);
                         view.alpha = 0.6;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 animations:^{
                             view.transform = CGAffineTransformMakeScale(1, 1);
                             view.alpha = 1;
                         }];
                     }];
}
- (IBAction)reloadAction:(id)sender {
    [_randomView reloadDataAnimated:YES];
}
#pragma mark - HDRandomViewDataSource
- (NSInteger)numberOfRandomViewInHDRandomView:(HDRandomView *)hdRandomView{
    return random() % 20 + 6;
}

- (UIView *)hdRandomView:(HDRandomView *)hdRandomView randomViewAtIndex:(NSInteger)index{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0
                                           green:arc4random() % 255 / 255.0
                                            blue:arc4random() % 255 / 255.0
                                           alpha:1];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
