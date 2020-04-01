//
//  MetaDataTool.m
//  两个TableView的联动右侧可以左右滑动
//
//  Created by jczj on 17/3/23.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "MetaDataTool.h"
#import "Stock.h"
@implementation MetaDataTool
+(NSArray *)customStocks{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"customStocks" ofType:@"plist"]];
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        Stock *stock = [Stock new];
        [stock setValuesForKeysWithDictionary:dic];
        [mutableArr addObject:stock];
    }
    return mutableArr;
}
@end
