//
//  AppDelegate.m
//  GIFGuideView
//
//  Created by wutong_2 on 16/11/22.
//  Copyright © 2016年 com.admin. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "GuidePageController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.window.backgroundColor = [UIColor whiteColor];
    //保存当前版本
    NSString * currentAppVersion = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * appVersion = [userDefaults objectForKey:@"appVersion"];
    
//    判断当前版本和之前版本，如果为nil或不一样，执行启动图
    if (appVersion == nil || ![appVersion isEqualToString:currentAppVersion]) {
        [userDefaults setValue:currentAppVersion forKey:@"appVersion"];
        NSLog(@"启动引导图");
        GuidePageController * guideVC = [[GuidePageController alloc]init];
        
        self.window.rootViewController  = guideVC;

    }else{
        
        NSLog(@"直接跳转登录页");
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        
        self.window.rootViewController  = loginVC;
        
        
    }
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
