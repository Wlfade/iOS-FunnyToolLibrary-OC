//
//  ViewController.h
//  枚举的正确用法
//
//  Created by jczj on 16/10/24.
//  Copyright © 2016年 jczj. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,testNSInteger){
    testZero = 0,
    testOne,
    testTwo,
    testThree,
    testFour
};
typedef NS_OPTIONS(NSUInteger, TTGDirection) {
    TTGDirectionNone = 0,
    TTGDirectionTop = 1 << 0,
    TTGDirectionLeft = 1 << 1,
    TTGDirectionRight = 1 << 2,
    TTGDirectionBottom = 1 << 3
};
@interface ViewController : UIViewController
//@property(nonatomic,assign)testNSInteger testInt;

@end

