//
//  ViewController.m
//  tableView 部分左右滑动
//
//  Created by jczj on 17/3/22.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "ViewController.h"

#define STATUSBAR_HEIGHT 20
#define SECTION_HEADER_HEIGHT 30
#define SCROLLVIEW_HEIGHT CGRectGetHeight(self.view.frame)-STATUSBAR_HEIGHT-SECTION_HEADER_HEIGHT-25

#define SCROLLVIEW_LEFT_PADDING 80
#define CELL_COUNT 30
#define CELL_HEIGHT 40

#define CELL_BACKGROUND_COLOR [UIColor grayColor]
#define HEADER_COLOR [UIColor purpleColor]

@interface ViewController ()
{
    UIScrollView *scrollView;
    UITableView *bigTabelView;
    NSMutableArray *addedArr;
    UILabel *rightsectionLabel;
    
    UIScrollView *smallScrollView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _addScrollViews];
}
- (void)_addScrollViews{
    //因为先加bigTableView后加smallScrollView才不至于让bigTableView的section header把smallScrollView挡住
    bigTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT, CGRectGetWidth(self.view.frame), SCROLLVIEW_HEIGHT+SECTION_HEADER_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:bigTabelView];
    
    smallScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SCROLLVIEW_LEFT_PADDING, STATUSBAR_HEIGHT, CGRectGetWidth(self.view.frame)-SCROLLVIEW_LEFT_PADDING, SECTION_HEADER_HEIGHT)];
    [bigTabelView addSubview:smallScrollView];
    //此时scrollview的frame相对的是bigTableView的内容视图而不是其frame，所以高度应设置为CELL_HEIGHT*CELL_COUNT才不会显示不全
    //frame的height小于contenSize的height的话scrollview就可以上下滑动，所以这里设置成一样
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SCROLLVIEW_LEFT_PADDING, SECTION_HEADER_HEIGHT, CGRectGetWidth(self.view.frame)-SCROLLVIEW_LEFT_PADDING, CELL_HEIGHT*CELL_COUNT)];
    [bigTabelView addSubview:scrollView];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
