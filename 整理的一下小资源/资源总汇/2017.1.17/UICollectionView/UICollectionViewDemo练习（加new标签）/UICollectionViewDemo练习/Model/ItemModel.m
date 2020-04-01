//
//  ItemModel.m
//  UICollectionViewDemo练习
//
//  Created by jczj on 17/1/19.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.imageName = dict[@"imageName"];
        self.itemTitle = dict[@"itemTitle"];
        self.isNew = [dict[@"isNew"] boolValue];
    }
    return self;
}
@end
