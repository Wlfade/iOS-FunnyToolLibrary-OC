//
//  ViewController.m
//  两个TableView的联动右侧可以左右滑动
//
//  Created by jczj on 17/3/23.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "ViewController.h"
#import "UIView+customView.h"
#import "MetaDataTool.h"
#import "Stock.h"
#import "RightTableViewCell.h"
#import "Masonry.h"
#define LeftTableViewWidth 100
#define RightLabelWidth 80
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *leftTableView, *rightTableView;
@property (nonatomic,strong) UIScrollView *buttomScrollView;
@property (nonatomic,strong) NSArray *rightTitles;
@property (nonatomic,strong) NSArray *customStocks;

@end

@implementation ViewController

#pragma mark - 懒加载数据
- (NSArray *)customStocks{
    if (!_customStocks) {
        _customStocks = [MetaDataTool customStocks];
    }
    return _customStocks;
}
- (NSArray *)rightTitles{
    if (!_rightTitles) {
        _rightTitles = @[@"最新", @"涨幅%", @"涨跌", @"昨收", @"成交量", @"成交额", @"最高", @"最低"];
    }
    return _rightTitles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"自选股票";
    self.navigationController.navigationBar.translucent = NO;
    
    [self loadLeftTableView];
    [self loadRighetTableView];
}
//设置分割线顶格
- (void)viewDidLayoutSubviews{
    [self.leftTableView setLayoutMargins:UIEdgeInsetsZero];
    [self.rightTableView setLayoutMargins:UIEdgeInsetsZero];
}
- (void)loadLeftTableView{
    self.leftTableView = [[UITableView alloc]init];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.leftTableView];
    
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.equalTo(@(LeftTableViewWidth));
    }];
    
}
- (void)loadRighetTableView{
    self.rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.rightTitles.count *RightLabelWidth + 20, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    
    self.buttomScrollView = [[UIScrollView alloc]init];
    self.buttomScrollView.backgroundColor = [UIColor redColor];
    self.buttomScrollView.contentSize = CGSizeMake(self.rightTableView.bounds.size.width, 0);
    self.buttomScrollView.bounces = NO; //设置弹簧属性
    self.buttomScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.buttomScrollView];
    [self.buttomScrollView addSubview:self.rightTableView];
    
    [self.buttomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.view);
        make.left.equalTo(self.leftTableView.mas_right);
    }];
    
}
#pragma mark -tableView dataSouce
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        static NSString *reuseIdentifer = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifer];
            [self resetSeparatorInsetForCell:cell];
        }
        //plist 数据只有7 个 所以取余创建显示
        Stock *stock = self.customStocks[indexPath.row % 7];
        cell.detailTextLabel.text = stock.number;
        cell.textLabel.text = stock.title;
        return cell;
    }else{
        RightTableViewCell *cell = [RightTableViewCell cellWithTabelView:tableView withNumberOfLabels:self.rightTitles.count];
        //这里先使用假数据
        UIView *view = [cell.contentView viewWithTag:100];
        for (UILabel *label in view.subviews) {
//            label.text = nil;
            label.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        }
        return cell;
    }
}
//设置cell分割线顶格
- (void)resetSeparatorInsetForCell:(UITableViewCell *)cell {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}
#pragma mark -- 设置左右两个tableView 的自定义头部View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightTableView) {
        UIView *rightHeaderView = [UIView viewWithLabelNumber:self.rightTitles.count];
        int i = 0;
        for (UILabel *label in rightHeaderView.subviews) {
            label.text = self.rightTitles[i++];
        }
        rightHeaderView.backgroundColor = [UIColor lightGrayColor];
        return rightHeaderView;
    }else{
        UIView *leftHeaderView = [UIView viewWithLabelNumber:1];
        [leftHeaderView.subviews.lastObject setText:@"自选股票"];
        leftHeaderView.backgroundColor = [UIColor lightGrayColor];
        return leftHeaderView;
    }
}
//必须实现以下方法才可以使用自定义头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.rightTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - 两个tableView联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.leftTableView) {
        [self tableView:self.rightTableView scrollFollowTheOther:self.leftTableView];
    }else{
        [self tableView:self.leftTableView scrollFollowTheOther:self.rightTableView];
    }
}
- (void)tableView:(UITableView *)tableView scrollFollowTheOther:(UITableView *)other{
    CGFloat offsetY= other.contentOffset.y;
    CGPoint offset=tableView.contentOffset;
    offset.y=offsetY;
    tableView.contentOffset=offset;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
