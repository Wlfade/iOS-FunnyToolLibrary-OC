- 给计时器加标识

```objective-c
static NSString * const messageTimer = @"message_hash";
```

- 开启计时器

```objective-c
/** 开启定时器 */
- (void)demoGCDTimer {
    __weak typeof(self) weakSelf = self;
    [[RB_GCDTimerManager sharedInstance] scheduledDispatchTimerWithName:messageTimer
                                                           timeInterval:5.0
                                                                  queue:dispatch_get_main_queue()
                                                                repeats:YES
                                                          fireInstantly:YES
                                                                 action:^{
                                                                   //执行方法 轮训调用
                                                                    // [weakSelf requestMessageInfro];
                                                                 }];
}
```



- 关闭计时器 （在dealloc 中删除计时器 否则存在循环引用 ）

```objective-c
- (void)dealloc{
    [self closeGCDTimer];
}

- (void)closeGCDTimer{
    //判断是否有messageTimer的计时器
    [[RB_GCDTimerManager sharedInstance]checkExistTimer:messageTimer completion:^(BOOL doExist) {
        if (doExist == YES) {
            //存在则删除
            [[RB_GCDTimerManager sharedInstance]cancelTimerWithName:messageTimer];
        }
    }];
}

```





- 源码

  ```objective-c
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
  ```

  

  ```objective-c
  //
  //  RB_GCDTimerManager.m
  //  Rainbow
  //
  //  Created by 单车 on 2019/1/11.
  //  Copyright © 2019 gwh. All rights reserved.
  //
  
  #import "RB_GCDTimerManager.h"
  
  @interface RB_GCDTimerManager ()
  
  @property (nonatomic, strong) NSMutableDictionary *timerContainer;
  @property (nonatomic, strong) dispatch_queue_t queue;
  
  @end
  
  @implementation RB_GCDTimerManager
  - (NSMutableDictionary *)timerContainer
  {
      if (!_timerContainer) {
          _timerContainer = [NSMutableDictionary dictionary];
      }
      return _timerContainer;
  }
  /** 单例模式开启计时器 */
  + (RB_GCDTimerManager *)sharedInstance{
      static RB_GCDTimerManager *_gcdTimerManager = nil;
      static dispatch_once_t onceToken;
  
      dispatch_once(&onceToken,^{
          _gcdTimerManager = [[RB_GCDTimerManager alloc] init];
      });
  
      return _gcdTimerManager;
  }
  - (instancetype)init {
      self = [super init];
      if (self) {
          dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, QOS_CLASS_USER_INITIATED, 0);
          dispatch_queue_t queue = dispatch_queue_create("com.RB_GCDTimerManager.queue", attr);
          _queue = queue;
      }
      return self;
  }
  
  - (void)scheduledDispatchTimerWithName:(NSString *)timerName
                            timeInterval:(double)interval
                                   queue:(dispatch_queue_t)queue
                                 repeats:(BOOL)repeats
                           fireInstantly:(BOOL)fireInstantly
                                  action:(dispatch_block_t)dispatchBlock {
      if (!timerName || timerName.length == 0 || !dispatchBlock) return;
  
      if (nil == queue)
          queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  
      dispatch_barrier_async(self.queue, ^{
          dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
          if (!timer) {
              timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
              [self.timerContainer setObject:timer forKey:timerName];
              dispatch_resume(timer);
          }
  
          if (repeats && fireInstantly) {
              dispatch_async(queue, dispatchBlock);
          }
  
          dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.01 * NSEC_PER_SEC);
          dispatch_source_set_event_handler(timer, ^{
              if (!repeats) {
                  [self.timerContainer removeObjectForKey:timerName];
                  dispatch_source_cancel(timer);
              }
  
              dispatchBlock();
          });
      });
  }
  
  - (void)cancelTimerWithName:(NSString *)timerName {
      dispatch_barrier_async(self.queue, ^{
          dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
  
          if (!timer) {
              return;
          }
  
          [self.timerContainer removeObjectForKey:timerName];
          dispatch_source_cancel(timer);
      });
  }
  
  - (void)checkExistTimer:(NSString *)timerName completion:(void (^)(BOOL))completion {
      dispatch_async(self.queue, ^{
          if ([self.timerContainer objectForKey:timerName]) {
              completion(YES);
          } else {
              completion(NO);
          }
      });
  }
  @end
  
  ```

  