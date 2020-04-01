//
//  MainTabBarViewController.m
//  StationManageUserEnd
//
//  Created by Accelerator on 16/4/11.
//  Copyright © 2016年 ccxx. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "HeadViewController.h"
#import "MyFourSViewController.h"
#import "MyCarViewController.h"
#import "MineViewController.h"
#import "Common.h"
#import "CommonTool.h"
#import "UIViewExt.h"
#import "NavViewController.h"
//#import "TabBarButton.h"
@interface MainTabBarViewController (){
    UIImageView *myView;
    UIImageView *selectImg;
    NSArray *aryImage;    //未选中时的图片
    NSArray *arySelImage; //选中时的图片
    NSArray *aryTitle;    //所有标题
    int num;   //按钮的数量

}
@property (nonatomic,strong) UIButton *selectedBtn;


@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self _createChildVC];
    //自定义tabbar
    [self _createTabbar];
}
- (void)_createTabbar{
    self.tabBar.hidden = YES;
    num= 4;
   aryImage = @[@"icon_bottom_homeg",@"icon_bottom_4sg",@"icon_bottom_carg",@"icon_bottom_mineg"];//未选中按钮的图片
    arySelImage = @[@"icon_bottom_homeb",@"icon_bottom_4sb",@"icon_bottom_carb",@"icon_bottom_mineb"];
    aryTitle = @[@"首页",@"我的4S",@"我的车",@"我的"];
    CGRect rect = self.tabBar.frame;
    //[self.tabBar removeFromSuperview];
    for (UIView *view in self.tabBar.subviews) {
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    myView = [[UIImageView alloc]init];
    myView.userInteractionEnabled = YES;
    myView.frame = rect;
    myView.backgroundColor = [CommonTool getColor:@"393a3e"];
    [self.view addSubview:myView];
    //TabBar 上的按钮的图片 和 字体的布局设置
    for(int i = 0; i < num; i++){
        UIButton *btn = [[UIButton alloc]init];
        CGFloat x = i * myView.frame.size.width / num;
        btn.frame = CGRectMake(x, 0, myView.frame.size.width / num, myView.frame.size.height);
        [myView addSubview:btn];
        
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((btn.bounds.size.width - kScreenWidth / 375 *35) / 2, kScreenHeight / 667 *2, kScreenWidth / 375 * 35,kScreenHeight / 667 * 35)];
////        imageView.backgroundColor = [UIColor redColor];
//        imageView.tag = 200 + i;
//        imageView.image = [UIImage imageNamed:aryImage[i]];
//        [btn addSubview:imageView];
//        
//        UILabel *labTitle = [[UILabel alloc]init];
//        labTitle.tag = 100 + i;
//        labTitle.frame = CGRectMake(0,imageView.bottom + 1, btn.bounds.size.width, kScreenHeight / 667 *11);
////        labTitle.backgroundColor = [UIColor yellowColor];
//        labTitle.textColor = [CommonTool getColor:@"a9adb9"];
//        labTitle.backgroundColor = [UIColor clearColor];
//        labTitle.font = [UIFont systemFontOfSize:kScreenHeight / 667 *11-1];
//        labTitle.textAlignment = NSTextAlignmentCenter;
//        labTitle.text = aryTitle[i];
//        [btn addSubview:labTitle];
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((btn.bounds.size.width - 35) / 2,2,35,35)];
//        imageView.backgroundColor = [UIColor redColor];
        imageView.tag = 200 + i;
        imageView.image = [UIImage imageNamed:aryImage[i]];
        [btn addSubview:imageView];

        UILabel *labTitle = [[UILabel alloc]init];
        labTitle.tag = 100 + i;
        labTitle.frame = CGRectMake(0,imageView.bottom + 1, btn.bounds.size.width, 11);
//        labTitle.backgroundColor = [UIColor yellowColor];
        labTitle.textColor = [CommonTool getColor:@"a9adb9"];
        labTitle.backgroundColor = [UIColor clearColor];
        labTitle.font = [UIFont systemFontOfSize:10];
        labTitle.textAlignment = NSTextAlignmentCenter;
        labTitle.text = aryTitle[i];
        [btn addSubview:labTitle];
        
        btn.tag = i;
        
//        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        if(0 == i){
            imageView.image = [UIImage imageNamed:arySelImage[i]];
            labTitle.textColor = [CommonTool getColor:@"5b9bd5"];
            btn.selected = YES;
            self.selectedBtn = btn;
        }
    }
}
- (void)clickBtn:(UIButton *)button {
    for (int i=0; i<num; i++) {
        UILabel *labTitle = (UILabel *)[self.view viewWithTag:100+i];
        UIImageView *imgView = (UIImageView *)[self.view viewWithTag:200+i];
        if(i == button.tag){
            imgView.image = [UIImage imageNamed:arySelImage[i]];
            labTitle.textColor = [CommonTool getColor:@"5b9bd5"]; //选中蓝 亮
        }else{
            imgView.image = [UIImage imageNamed:aryImage[i]];
            labTitle.textColor = [CommonTool getColor:@"a9adb9"]; //未选中灰色
        }
    }
    
    if (button.selected == YES) {
        if (button.tag == 0) {
            NSNotification *noti = [[NSNotification alloc] initWithName:@"downPush" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:noti];
        }
        
    } else {
        //1.先将之前选中的按钮设置为未选中
        self.selectedBtn.selected = NO;
        //2.再将当前按钮设置为选中
        button.selected = YES;
        //3.最后把当前按钮赋值为之前选中的按钮
        self.selectedBtn = button;
        //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
        self.selectedIndex = button.tag;
    }
}
//导航控制器切换时 是否显示标签控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSLog(@"%@将要显示",viewController);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.2];
    //隐藏标签栏
    if (navigationController.viewControllers.count == 1){ // 显示标签栏
        //        tabar.hidden = NO;
        CGRect frame = myView.frame;
        frame.origin.x = 0;
        myView.frame = frame;
        
    }
    else if(navigationController.viewControllers.count > 1){//隐藏标签
        //        tabar.hidden = YES;
        //将tabbar移动到屏幕的左侧
        CGRect frame = myView.frame;
        frame.origin.x = -kScreenWidth;
        myView.frame = frame;
        
    }
    [UIView commitAnimations];
}
- (void)_createChildVC{
    //首页
    HeadViewController *headVC = [[HeadViewController alloc]init];
    //我的4s
    MyFourSViewController *fourSVC = [[MyFourSViewController alloc]init];
    //我的车
    MyCarViewController *myCarVC = [[MyCarViewController alloc]init];
    //我的
    MineViewController *mineVC = [[MineViewController alloc]init];
    
    NSArray *viewControls = @[headVC,fourSVC,myCarVC,mineVC];
    
    //创建可变数组，存储导航控制器
    NSMutableArray *navs = [NSMutableArray arrayWithCapacity:viewControls.count];
    //创建二级控制器导航控制器
    for (UIViewController *ctrl in viewControls) {
        NavViewController *nav = [[NavViewController alloc]initWithRootViewController:ctrl];
        nav.delegate = self;
        [navs addObject:nav];
    }
    //将导航控制器交给标签控制器管理
    self.viewControllers = navs;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
