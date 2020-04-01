//
//  ItemGroup.h
//  UICollectionViewDemo练习
//
//  Created by jczj on 17/1/19.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemModel.h"

@interface ItemGroup : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSMutableArray<ItemModel *> *items;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
