//
//  Stock.h
//  两个TableView的联动右侧可以左右滑动
//
//  Created by jczj on 17/3/23.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stock : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,strong) NSArray *data;
@end
