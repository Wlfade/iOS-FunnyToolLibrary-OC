//
//  AdvertiseView.m
//  启动页广告
//
//  Created by jczj on 16/10/26.
//  Copyright © 2016年 jczj. All rights reserved.
//

#import "AdvertiseView.h"
@interface AdvertiseView()
@property (nonatomic,strong)UIImageView *adView;
@property (nonatomic,strong)UIButton *countBtn;
@property (nonatomic,strong)NSTimer *countTimer;
@property (nonatomic,assign)int count;
@end

// 广告显示的时间
static int const showtime = 3;

@implementation AdvertiseView
- (NSTimer *)countTimer{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _adView = [[UIImageView alloc]initWithFrame:frame];
        _adView.userInteractionEnabled = YES;
        _adView.contentMode = UIViewContentModeScaleAspectFill;
        _adView.clipsToBounds = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToAd)];
        [_adView addGestureRecognizer:tap];
        
        CGFloat btnW = 62;
        CGFloat btnH = 23;
        
        _countBtn = [[UIButton alloc]initWithFrame:CGRectMake(kscreenWidth - btnW - 15, 1.6*btnH, btnW, btnH)];
        [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_countBtn setTitle:[NSString stringWithFormat:@"%d跳过",showtime] forState:UIControlStateNormal];
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countBtn.backgroundColor = [UIColor colorWithRed:38 / 255.0 green:38 / 255.0 blue:38 / 255.0 alpha:0.6];
        _countBtn.layer.cornerRadius = btnH/2;
        
        [self addSubview:_adView];
        [self addSubview:_countBtn];
    }
    return self;
}
- (void)setFilePath:(NSString *)filePath{
    if (_filePath != filePath) {
        _filePath = filePath;
    }
    _adView.image = [UIImage imageWithContentsOfFile:filePath];
}
- (void)pushToAd{
    [self dismiss];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushtoad" object:nil userInfo:nil];
}
- (void)countDown{
    _count -- ;
    [_countBtn setTitle:[NSString stringWithFormat:@"%d跳过",_count] forState:UIControlStateNormal];
    if (_count == 0) {
        [self dismiss];
    }
    
}
- (void)show{
    //倒计时 方法1：GCD
//    [self startCoundown];
    
    // 倒计时方法2：定时器
    [self startTimer];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}
// GCD倒计时
- (void)startCoundown{
    __block int timeout = showtime + 1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self dismiss];
                
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
// 定时器倒计时
- (void)startTimer
{
    _count = showtime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}
//移除广告页面
- (void)dismiss{
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}
@end
