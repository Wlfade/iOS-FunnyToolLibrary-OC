//
//  LoginViewController.m
//  GIFGuideView
//
//  Created by wutong_2 on 16/11/22.
//  Copyright © 2016年 com.admin. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)loginButtonClick:(id)sender {

    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"登录成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alterView show];
}
- (IBAction)signButtonClick:(id)sender {
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"跳转注册页面" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alterView show];

}
- (IBAction)deleteAppVersion:(id)sender {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"appVersion"];
    
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"删除版本信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alterView show];

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
