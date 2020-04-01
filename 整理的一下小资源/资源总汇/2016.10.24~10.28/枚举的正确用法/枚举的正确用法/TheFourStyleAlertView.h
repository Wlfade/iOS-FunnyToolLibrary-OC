//
//  TheFourStyleAlertView.h
//  自定义UIAlertView
//
//  Created by jczj on 16/9/26.
//  Copyright © 2016年 jczj. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^curtainBlock)(void);

typedef void(^curtainBlock)(NSString *);
typedef void(^checkBlock)(void);
typedef void(^goBackBlock)(void);
typedef void(^applyBlock)(void);
typedef void(^serviceBlock)(NSString *);

@interface TheFourStyleAlertView : UIView
@property (nonatomic,copy)curtainBlock curtainBlock; //确定按钮
@property (nonatomic,copy)checkBlock checkBlock; //查看明细
@property (nonatomic,copy)goBackBlock goBackBlock; //返回个人中心
@property (nonatomic,copy)applyBlock applyBlock; //申请到账按钮
@property (nonatomic,copy)serviceBlock serviceBlock; //客服QQ

- (instancetype)initWithApplyTheAccount:(NSString *)QQStr;
- (instancetype)initWithTransToOthersAcount:(NSString *)tipSting withInfo:(NSString *)inforSting withColorStr:(NSString *)colorStr;
- (instancetype)initWithTransAcountTip;

//- (instancetype)initWithTransAcountTopTip:(NSString *)topTipStr WithMidTip:(NSString *)midTipStr WithBottomTip:(NSString *)bottomTipStr;
- (instancetype)initWithTransSuccess;
- (void)showAlert;
@end
