//
//  Apple.m
//  CopyTest
//
//  Created by Daruo on 2018/7/19.
//  Copyright © 2018年 BeeSmart. All rights reserved.
//

#import "Apple.h"

@implementation Apple
-(instancetype)initWithColor:(NSString *)color AndTaste:(NSString*)taste {
    if (self == [super init]) {
        self.color = color;
        self.taste = taste;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    Apple *orange = [Apple allocWithZone:zone ];
    orange.color = self.color;
    orange.taste = self.taste;
    return orange;
}
@end
