//
//  ViewController.m
//  自定义TableVIew的headVIew
//
//  Created by jczj on 16/12/22.
//  Copyright © 2016年 jczj. All rights reserved.
//

#import "ViewController.h"
#import "MySetTableHeadView.h"
#import "MySetTableFootView.h"
#import "common.h"
static NSString *cellIdentify = @"tableViewCell";
static NSString *headViewIdentify = @"tableViewHeadView";
static NSString *footViewIdentify = @"tableViewFootView";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    BOOL flag[1];
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self _creatTableView];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)_creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentify];
    [_tableView registerClass:[MySetTableHeadView class] forHeaderFooterViewReuseIdentifier:headViewIdentify];
    
    [_tableView registerClass:[MySetTableFootView class] forHeaderFooterViewReuseIdentifier:footViewIdentify];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
#pragma mark HeaderView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 40;
    CGFloat height = [MySetTableHeadView loadTheCellHeight:section];
    return height;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MySetTableHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headViewIdentify];
    headView.title = [NSString stringWithFormat:@"第%ld个headView",section];
    
    headView.clickBtn.tag = section;
    [headView.clickBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//    headView.backgroundColor = [UIColor blueColor];
    
    return headView;
}
- (void)clickAction:(UIButton *)sender{
    NSInteger section = sender.tag;
    flag[section] = !flag[section];
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];
    
//    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];

    
    [_tableView reloadData];
}
#pragma mark FooterView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 20;
    CGFloat height = [MySetTableFootView loadTheCellHeight:section];
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    MySetTableFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footViewIdentify];
    footView.title = [NSString stringWithFormat:@"第%ld个footView",section];
//    footView.backgroundColor = [UIColor greenColor];
    footView.contentView.backgroundColor = [UIColor greenColor];
    return footView;
}
#pragma mark Cell Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    BOOL f = flag[section]; //NO :展开
    
    if(!f){
        
        return 0;  //场景列表不展开
        
    }
    else{
        
        return 10;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld,%ld",indexPath.section,indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
