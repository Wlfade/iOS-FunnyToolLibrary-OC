//
//  ViewController.m
//  表视图的编辑模式
//
//  Created by apple on 15/6/2.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    array = [NSMutableArray arrayWithArray:[UIFont familyNames]];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return array.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    static NSString *indenty = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenty];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indenty];

    }
    
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

#pragma mark UITableViewDeleagte

//实现此协议方法,左划会出现删除按钮
//当删除或插入按钮被点击时会调用此方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //如果插入按钮被点击
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        NSLog(@"插入一个单元格");
        [tableView beginUpdates];
        //1. 添加数据
        [array insertObject:@"测试" atIndex:indexPath.row];
//        [tableView reloadData];
        //2 .插入一个单元格
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [tableView endUpdates];
       
        //如果删除按钮被点击
    }else if (editingStyle == UITableViewCellEditingStyleDelete){
    
    [tableView beginUpdates];
    //1. 删除一个单元格
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    //2. 删除数组中的数据
    [array removeObjectAtIndex:indexPath.row];
    [tableView endUpdates];
    //刷新表视图
//   [tableView reloadData];
    }
}

//控制表视图进入到编辑模式后,显示的样式,如果不实现此方法,所有的单元格均显示删除按钮
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        //第一个单元格显示插入按钮
        return UITableViewCellEditingStyleInsert;
        
    }
    //其它的单元格显示删除
    return UITableViewCellEditingStyleDelete;
}

//实现此方法后,当表视图进入到编辑模式,单元格的右侧会出现移动按钮
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{

    //更新数据
    [array exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];

}

- (IBAction)editAction:(id)sender {
    
    //进入到编辑模式
//    [_tableView setEditing:YES];
    //单元格是否可以多选,开启多选后,删除与添加按钮会消失
    _tableView.allowsMultipleSelectionDuringEditing = YES;
    [_tableView setEditing:YES animated:YES];
    
}

- (IBAction)doneAction:(id)sender {
    
    //退出编辑模式
    [_tableView setEditing:NO animated:YES];
}
@end
