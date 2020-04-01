//
//  ItemModel.h
//  UICollectionViewDemo练习
//
//  Created by jczj on 17/1/19.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger) {
    StatusMinusSign = 1, // 减号
    StatusPlusSign, // 加号
    StatusCheck, // 对勾
}Status;
@interface ItemModel : NSObject
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, assign) BOOL isNew;
@property (nonatomic, assign) Status status;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
