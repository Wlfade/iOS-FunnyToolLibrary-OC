//
//  ViewController.m
//  UICollectionViewDemo练习
//
//  Created by jczj on 17/1/19.
//  Copyright © 2017年 jczj. All rights reserved.
//

/*
 
    查看UITableView的帮助文档我们会注意到UITableView有两个Delegate分别为：dataSource和delegate。
 　　dataSource 是UITableViewDataSource类型，主要为UITableView提 供显示用的数据(UITableViewCell)，指定UITableViewCell支持的编辑操作类型(insert，delete和 reordering)，并根据用户的操作进行相应的数据更新操作，如果数据没有更具操作进行正确的更新，可能会导致显示异常，甚至crush。
 　　delegate 是UITableViewDelegate类型，主要提供一些可选的方法，用来控制tableView的选择、指定section的头和尾的显示以及协助完成cell的删除和排序等功能。
 　　提到UITableView，就必须的说一说NSIndexPath。UITableView声明了一个NSIndexPath的类别，主要用 来标识当前cell的在tableView中的位置，该类别有section和row两个属性，前者标识当前cell处于第几个section中，后者代 表在该section中的第几行。
 　　UITableView只能有一列数据(cell)，且只支持纵向滑动，当创建好的tablView第一次显示的时候，我们需要调用其reloadData方法，强制刷新一次，从而使tableView的数据更新到最新状态。
 
 
    collectionView 用indexPath.item
    tableView 用indexPath.row
 
 */

#import "ViewController.h"
#import "ItemCell.h"
#import "ItemCellHeaderView.h"

#import "ItemGroup.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1.0];

static NSString *reuseID = @"itemCell";
static NSString *sectionHeaderID = @"sectionHeader";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ItemCellDelegate>
{
    NSIndexPath *_originalIndexPath; //cell 原先的位置
    NSIndexPath *_moveIndexPath; //cell 移动后的位置
    UIView *_snapshotView;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *itemGroups;
@property (nonatomic, strong) NSArray *allItemModel;
@property (nonatomic, assign) BOOL isEditing;

@end

@implementation ViewController
//itemGroups 的get方法
- (void)setIsEditing:(BOOL)isEditing {
    if (_isEditing != isEditing) {
        _isEditing = isEditing;
    }
    UIBarButtonItem *managerItem = self.navigationItem.rightBarButtonItem;
    UIButton *managerButton = managerItem.customView;
    managerButton.selected = isEditing;
}
- (NSArray *)itemGroups{
    if (!_itemGroups) {
        NSArray *datas = @[
                           @{
                               @"type" : @"首页快捷入口",
                               @"items" :[NSMutableArray array]
//                               @"items" :@[@{@"imageName" : @"我的订阅",@"itemTitle" : @"我的订阅"},
//                                           @{@"imageName" : @"球爆",@"itemTitle" : @"球爆"},
//                                           @{@"imageName" : @"名人名单",@"itemTitle" : @"名人名单"},
//                                           @{@"imageName" : @"竞彩足球",@"itemTitle" : @"竞彩足球"},
//                                           @{@"imageName" : @"竞彩篮球",@"itemTitle" : @"竞彩篮球"},
//                                           @{@"imageName" : @"足彩",@"itemTitle" : @"足彩"},]
                               },
                           @{
                               @"type" : @"我的",
                               @"items" : @[@{@"imageName" : @"我的订阅",@"itemTitle" : @"我的订阅",@"isNew" : @NO},
                                            @{@"imageName" : @"球爆",@"itemTitle" : @"球爆",@"isNew" : @NO},]
                               },
                           @{
                               @"type" : @"基础服务",
                               @"items" : @[@{@"imageName" : @"名人名单",@"itemTitle" : @"名人名单",@"isNew" : @1},
                                            @{@"imageName" : @"竞彩足球",@"itemTitle" : @"竞彩足球",@"isNew" : @0},
                                            @{@"imageName" : @"竞彩篮球",@"itemTitle" : @"竞彩篮球",@"isNew" : @0},
                                            @{@"imageName" : @"足彩",@"itemTitle" : @"足彩",@"isNew" : @0},]
                               },
                           @{
                               @"type" : @"发现新鲜事",
                               @"items" : @[@{@"imageName" : @"爆单",@"itemTitle" : @"爆单",@"isNew" : @0},
                                            @{@"imageName" : @"专业分析",@"itemTitle" : @"专业分析",@"isNew" : @0},
                                            @{@"imageName" : @"最新话题",@"itemTitle" : @"最新话题",@"isNew" : @0},
                                            @{@"imageName" : @"热门话题",@"itemTitle" : @"热门话题",@"isNew" : @0},]
                               },
                           @{
                               @"type":@"新闻资讯",
                               @"items" : @[@{@"imageName" : @"热点资讯",@"itemTitle" : @"热点资讯",@"isNew" : @0},
                                            @{@"imageName" : @"我不是头条",@"itemTitle" : @"我不是头条",@"isNew" : @0},
                                            @{@"imageName" : @"名人专访",@"itemTitle" : @"名人专访",@"isNew" : @0},
                                            @{@"imageName" : @"焦点赛事",@"itemTitle" : @"焦点赛事",@"isNew" : @0},
                                            @{@"imageName" : @"活动专栏",@"itemTitle" : @"活动专栏",@"isNew" : @0},]
                               },
                           ];
        [datas writeToFile:@"/Users/jczj/Desktop/JJJ/items.plist" atomically:YES]; //将数组写入一个路径的plist文件中
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:datas.count];
        NSMutableArray *allItemModels = [[NSMutableArray alloc]init];
        for ( NSDictionary *dict in datas) {
            ItemGroup *group = [[ItemGroup alloc]initWithDict:dict]; //将大数组中的各个字典 存入 ItemGroup 中
            if ([group.type isEqualToString:@"首页快捷入口"]) {
                for (ItemModel *model in group.items) {
                    model.status = StatusMinusSign;
                }
            }else{
                [allItemModels addObjectsFromArray:group.items];
                self.allItemModel = [allItemModels copy];
            }
            [array addObject:group];
        }
        _itemGroups = [array copy];
    }
    NSLog(@"调用get方法");
    return _itemGroups;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
    [self setupNavigationBar];
    [self setupCollectionView];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)setupNavigationBar {
    self.navigationItem.title = @"全部";
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"管理" forState:UIControlStateNormal];
    [rightButton setTitle:@"完成" forState:UIControlStateSelected];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton sizeToFit];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
    [rightButton addTarget:self action:@selector(managerAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
#pragma mark - 管理按钮点击事件
- (void)managerAction:(UIButton *)managerButton{
    managerButton.selected = !managerButton.selected;
    self.isEditing = managerButton.selected;
    [self.collectionView reloadData];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.itemSize = CGSizeMake(kScreenWidth / 4, kScreenHeight/4);
    layout.itemSize = CGSizeMake(kScreenWidth / 4, kScreenWidth / 4);
    layout.minimumLineSpacing = 1; //设置行与行之间的间距的最小距离
    layout.minimumInteritemSpacing = 0; //设置列与列之间的间距的最小距离
    
    layout.headerReferenceSize = CGSizeMake(kScreenWidth, 35);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseID];
    [_collectionView registerClass:[ItemCell class] forCellWithReuseIdentifier:reuseID];

    [_collectionView registerClass:[ItemCellHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionHeaderID];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [_collectionView addGestureRecognizer:longPress];
}
#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.itemGroups.count;
//    return 4;

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    ItemGroup *group = self.itemGroups[section];
    return group.items.count;
//    return 5;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
//    cell.backgroundColor = kRandomColor;
    cell.delegate = self;
    ItemGroup *group = self.itemGroups[indexPath.section];
    ItemModel *itemModel = group.items[indexPath.row];
    
    if (indexPath.section != 0) { //单元格不在第一行
        BOOL isAdded = NO;
        ItemGroup *homeGroup = self.itemGroups[0];
        for (ItemModel *homeItemModel in homeGroup.items) {
            
            if ([homeItemModel.itemTitle isEqualToString:itemModel.itemTitle]) { //与第一行有相同元素
                isAdded = YES;
                break;
            }
        }
        
        if (isAdded) {
            itemModel.status = StatusCheck;
        }else {
            itemModel.status = StatusPlusSign;
        }
    }
    cell.isEditing = _isEditing;
    cell.itemModel = itemModel;
    cell.indexPath = indexPath;
    
//    if ([cell.itemModel.itemTitle isEqualToString:@"名人名单"]) {
//        cell.theNewIcon.hidden = NO;
//    }else{
//        cell.theNewIcon.hidden = YES;
//    }
    return cell;
}
#pragma mark
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        ItemCellHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionHeaderID forIndexPath:indexPath];
        ItemGroup *group = self.itemGroups[indexPath.section];
        headerView.title = group.type;
        return headerView;
    }
    else {
        return nil;
    }
}
#pragma mark 设置section头部间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 30, 0);
    }else {
        return UIEdgeInsetsMake(0, 0, 1 / [UIScreen mainScreen].scale, 0);
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"第%ld行 第%ld个 按钮被点击",indexPath.section,indexPath.item);
    ItemGroup *selectGroup = _itemGroups[indexPath.section];
    ItemModel *model = selectGroup.items[indexPath.item];
    NSString *titleString = model.itemTitle;
    NSLog(@"%@按钮被点击了",titleString);
    
//    for (ItemModel *model in self.allItemModel) {
//        if (model.isNew ) {
//            model.isNew = NO;
//            break;
//        }
//    }
//    for (ItemModel *model in self.itemGroups[0]) {
//        if (model.isNew ) {
//            model.isNew = NO;
//            break;
//        }
//    }
//    [self.collectionView reloadData];
//    [self.collectionView layoutIfNeeded];
    for (ItemGroup *group in self.itemGroups) {
        ItemGroup *itemgroup = group;
        for (ItemModel *model in itemgroup.items) {
            BOOL isNew  = model.isNew;
            NSNumber *boolNumber = [NSNumber numberWithBool:isNew];
            NSLog(@"%@",boolNumber);
            if (model.isNew) {
                model.isNew = NO;
            }
        }
    }
    [self.collectionView reloadData];
//    [self.collectionView layoutIfNeeded];
}
#pragma mark - 长按手势
- (void)longPressAction:(UILongPressGestureRecognizer *)recognizer {
    CGPoint touchuPoint = [recognizer locationInView:self.collectionView];
    _moveIndexPath = [self.collectionView indexPathForItemAtPoint:touchuPoint];
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            if (_isEditing == NO) {
                self.isEditing = YES;
                [self.collectionView reloadData];
//                [self.collectionView layoutIfNeeded];
            }
            if (_moveIndexPath.section == 0) {
                ItemCell *selectedItemCell = (ItemCell *)[self.collectionView cellForItemAtIndexPath:_moveIndexPath];
                _originalIndexPath = [self.collectionView indexPathForItemAtPoint:touchuPoint];
                if (!_originalIndexPath) {
                    return;
                }
                _snapshotView = [selectedItemCell snapshotViewAfterScreenUpdates:YES];
                _snapshotView.center = [recognizer locationInView:self.collectionView];
                [self.collectionView addSubview:_snapshotView];
                selectedItemCell.hidden = YES;
                [UIView animateWithDuration:0.2 animations:^{
                    _snapshotView.transform = CGAffineTransformMakeScale(1.03, 1.03);
                    _snapshotView.alpha = 0.98;
                }];
            }
        
            break;
        case UIGestureRecognizerStateChanged:
            _snapshotView.center = [recognizer locationInView:self.collectionView];
            if (_moveIndexPath.section == 0) {
                if (_moveIndexPath && ![_moveIndexPath isEqual:_originalIndexPath] && _moveIndexPath.section == _originalIndexPath.section) {
                    ItemGroup *homeGroup = self.itemGroups[0];
                    NSMutableArray *array = homeGroup.items;
                    NSInteger fromIndex = _originalIndexPath.item;
                    NSInteger toIdex = _moveIndexPath.item;
                    if (fromIndex < toIdex) {
                        for (NSInteger i = fromIndex; i < toIdex; i ++) {
                            [array exchangeObjectAtIndex:i withObjectAtIndex:i + 1]; //交互数组元素
                        }
                    }else{
                        for (NSInteger i = fromIndex; i > toIdex; i --) {
                            [array exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
                        }
                    }
                    [self.collectionView moveItemAtIndexPath:_originalIndexPath toIndexPath:_moveIndexPath]; //将item从原先的位置移动到后来的位置
                    _originalIndexPath = _moveIndexPath;
                    }
                }
            
            break;
        case UIGestureRecognizerStateEnded:{
            ItemCell *cell = (ItemCell *)[self.collectionView cellForItemAtIndexPath:_originalIndexPath];
            cell.hidden = NO;
            [_snapshotView removeFromSuperview];
        }
        default:
            break;
    }

}
- (void)rightUpperButtonDidTappedWithItemCell:(ItemCell *)itemCell {
    ItemModel *itemModel = itemCell.itemModel;
    if (itemModel.status == StatusMinusSign) {
        ItemGroup *homeGroup = self.itemGroups[0];
        [(NSMutableArray *)homeGroup.items removeObject:itemModel];
        for (ItemModel *model in self.allItemModel) {
            if ([itemModel.itemTitle isEqualToString:model.itemTitle]) {
                model.status = StatusPlusSign;
                break;
            }
        }
        UIView *snapshotView = [itemCell snapshotViewAfterScreenUpdates:YES];
        snapshotView.frame = [itemCell convertRect:itemCell.bounds toView:self.view];
        [self.view addSubview:snapshotView];
        
        itemCell.hidden = YES;
        
        [UIView animateWithDuration:0.4 animations:^{
            snapshotView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }completion:^(BOOL finished){
            [snapshotView removeFromSuperview];
            itemCell.hidden = NO;
            [self.collectionView reloadData];
        }];
    }else if (itemModel.status == StatusPlusSign){
        itemModel.status = StatusCheck;
        ItemGroup *homeGroup = self.itemGroups[0];
        ItemModel *homeItemModel = [[ItemModel alloc]init];
        homeItemModel.imageName = itemModel.imageName;
        homeItemModel.itemTitle = itemModel.itemTitle;
        homeItemModel.isNew = itemModel.isNew;
        homeItemModel.status = StatusMinusSign; //设置加入第一行的元素的状态为 减
        [homeGroup.items addObject:homeItemModel];
        
        UIView *snapshotView = [itemCell snapshotViewAfterScreenUpdates:YES];
        snapshotView.frame = [itemCell convertRect:itemCell.bounds toView:self.view];
        [self.view addSubview:snapshotView];
        
        [self.collectionView reloadData];
//        [self.collectionView layoutIfNeeded];
        
        ItemCell *lastCell = (ItemCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:homeGroup.items.count - 1 inSection:0]];
        lastCell.hidden = YES;
        CGRect targetFrame = [lastCell convertRect:lastCell.bounds toView:self.view];
        
        [UIView animateWithDuration:0.4 animations:^{
            snapshotView.frame = targetFrame;
        } completion:^(BOOL finished) {
            [snapshotView removeFromSuperview];
            lastCell.hidden = NO;
        }];
    }else if (itemModel.status == StatusCheck) {
        ///
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
