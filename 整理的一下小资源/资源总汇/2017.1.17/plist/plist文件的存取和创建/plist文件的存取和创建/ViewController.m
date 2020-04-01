//
//  ViewController.m
//  plist文件的存取和创建
//
//  Created by jczj on 17/1/20.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "ViewController.h"
#import "NextViewCViewController.h"
@interface ViewController ()

@end
/*
 /Users/jczj/Desktop/plist文件的存取和创建/plist文件的存取和创建/FuList.plist
 */

/*
 创建.plist文件
    方法：
    1.选中Xcode,File-New-File...;
    2.在工程目录处右键，New File...;
    3.选中Xcode,使用快捷方式cmd+n组合键;
    4.选择iOS和OS X中任意一个“Resource” 中的 “Property List” 创建并命名保存。当前名称为：usersList.plist.
 
 往.plist文件添加数据并显示
    在Xcode项目中点击usersList.plist,可以打开显示usersList.plist文件中的内容。
    可以在空白处右键“Add Row” 添加数据或点中“root”行，点击“+”号即可 添加。
    一般数据类型（Type）可以选择Array、Dictionary、String等类型。同时也可以给添加的数据赋值（Value）.
    除了以Property List 列表形式显示外，选中usersList.plist文件，右键“Open As” - “Source Code” 可以以XML格式显示。
 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self filPath];
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeBtn.frame = CGRectMake(50, 200, 50, 50);
    [changeBtn setTitle:@"changeInfro" forState:UIControlStateNormal];
    [changeBtn sizeToFit];
    [changeBtn setBackgroundColor:[UIColor yellowColor]];
    [changeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(changeInfro) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
    
    UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clickBtn.frame = CGRectMake(100, 50, 50, 50);
    [clickBtn setTitle:@"Push" forState:UIControlStateNormal];
    [clickBtn sizeToFit];
    //    clickBtn setImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
    [clickBtn setBackgroundColor:[UIColor yellowColor]];
    [clickBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [clickBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn];
}
- (void)clickAction{
    NextViewCViewController *nextVC = [[NextViewCViewController alloc]init];
    [self.navigationController pushViewController:nextVC animated:YES];
}
- (void)filPath{
    //获取本地沙盒路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
//    NSString *documentsPath = [path objectAtIndex:0];
    NSString *documentsPath = [path firstObject];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"userList.plist"];
    
    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc]init];
    
    //设置属性值
    [usersDic setObject:@"chan" forKey:@"name"];
    [usersDic setObject:@"123456" forKey:@"passWord"];
    
    //写入文件
    [usersDic writeToFile:plistPath atomically:YES];
    
    NSLog(@"%@",plistPath);
    
}
- (void)changeInfro{
    //添加或修改已有数据。此文件不是已有的usersList.plist文件，而是存在沙盒里面的文件。usersList.plist内容是不变的。需要查看可以到模拟器沙盒查看。
    //获取已有完整路径
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"userList" ofType:@"plist"];
    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    
    //设置属性值，没有的数据就新建，已有的数据就修改。
    [[usersDic objectForKey:@"users"]setObject:@"逗逼" forKey:@"name"];
    [[usersDic objectForKey:@"users"]setObject:@"dbdbdb" forKey:@"password"];
    
    //写入文件
    [usersDic writeToFile:plistPath atomically:YES];
    
    NSLog(@"%@",plistPath);
    //如果是想用其他文件名称可以根据路径创建新plist文件
//    NSString *filename=[plistPath stringByAppendingPathComponent:@"test.plist"];//已有该名称文件就不新建，没有就新建。
//    
//    //如果多层次结构
//    
//    //首先读取usersList.plist中的数据
//    NSString *newPlistPath = [[NSBundle mainBundle]pathForResource:@"userList" ofType:@"plist"];
//    NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:newPlistPath];
//    
//    //多层次结构
//    //定义第一个类的属性
//    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
//    [dic1 setObject:@"chan" forKey:@"name"];
//    [dic1 setObject:@"123456" forKey:@"password"];
//    //定义第二个类的属性
//    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
//    [dic2 setObject:@"db" forKey:@"name"];
//    [dic2 setObject:@"sbsbsbsb" forKey:@"password"];
//    
//    //设置属性值
//    [newDictionary setObject:dic1 forKey:@"用户1"];
//    [newDictionary setObject:dic2 forKey:@"用户2"];
//    
//    //写入文件
//    [newDictionary writeToFile:plistPath atomically:YES];
//    
//    NSString *plistPath1 = [[NSBundle mainBundle]pathForResource:@"usersList" ofType:@"plist"];
//    //读取
//    NSMutableDictionary *data1 = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath1];
//    NSLog(@"data文件%@",data1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
