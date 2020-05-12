//
//  Orange.h
//  CopyTest
//
//  Created by Daruo on 2018/7/19.
//  Copyright © 2018年 BeeSmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Orange : NSObject<NSCopying>
/** <#param#>     */
@property (nonatomic, copy)  NSString                    *color;
/** <#param#>     */
@property (nonatomic, copy) NSString                     *taste;
-(instancetype)initWithColor:(NSString *)color AndTaste:(NSString*)taste;
@end
