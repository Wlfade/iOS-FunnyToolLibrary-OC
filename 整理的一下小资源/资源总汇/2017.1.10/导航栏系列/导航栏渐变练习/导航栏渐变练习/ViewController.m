//
//  ViewController.m
//  导航栏渐变练习
//
//  Created by jczj on 17/1/11.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "ViewController.h"
static NSString *cellIdentify = @"cellIdentify";
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    [self _creatTableView];
}
- (void)_creatTableView{
    UITableView * tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentify];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"test%ld",(long)indexPath.row];
//    
//    return cell;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"test%ld",(long)indexPath.row];;
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset<=0&&offset<=-90) {
        
        self.navigationController.navigationBar.alpha = 0;
        
    }else if(offset<=500){
        
        self.navigationController.navigationBar.alpha = offset/200;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
