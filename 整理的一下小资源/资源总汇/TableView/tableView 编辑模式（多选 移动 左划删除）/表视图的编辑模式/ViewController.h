//
//  ViewController.h
//  表视图的编辑模式
//
//  Created by apple on 15/6/2.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    NSMutableArray *array;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)editAction:(id)sender;
- (IBAction)doneAction:(id)sender;

@end

