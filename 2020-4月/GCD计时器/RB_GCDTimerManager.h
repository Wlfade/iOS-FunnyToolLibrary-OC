//
//  RB_GCDTimerManager.h
//  Rainbow
//
//  Created by 单车 on 2019/1/11.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RB_GCDTimerManager : NSObject

/** 单例模式开启计时器 */
+ (RB_GCDTimerManager *)sharedInstance;


/**
 启动一个timer，默认精度为0.01秒。

 @param timerName       timer的名称，作为唯一标识。
 @param interval        执行的时间间隔。
 @param queue           timer将被放入的队列，也就是最终action执行的队列。传入nil将自动放到一个子线程队列中。
 @param repeats         timer是否循环调用。
 @param fireInstantly   timer的第一次执行是否立刻触发，否则会等待interval的时长才会第一次执行。
 @param dispatchBlock          时间间隔到点时执行的block。
 */
- (void)scheduledDispatchTimerWithName:(NSString *)timerName
                          timeInterval:(double)interval
                                 queue:(dispatch_queue_t)queue
                               repeats:(BOOL)repeats
                         fireInstantly:(BOOL)fireInstantly
                                action:(dispatch_block_t)dispatchBlock;


/**
 撤销某个timer。

 @param timerName timer的名称，作为唯一标识。
 */
- (void)cancelTimerWithName:(NSString *)timerName;


/**
 *  是否存在某个名称标识的timer。
 *
 *  @param timerName timer的唯一名称标识。
 *  @param completion 查询结束回调。doExist==YES表示存在，反之。
 */
- (void)checkExistTimer:(NSString *)timerName
             completion:(void (^)(BOOL doExist))completion;
@end

NS_ASSUME_NONNULL_END
