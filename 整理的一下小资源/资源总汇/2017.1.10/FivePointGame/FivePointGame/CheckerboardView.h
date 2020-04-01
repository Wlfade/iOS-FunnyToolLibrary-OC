//
//  CheckerboardView.h
//  FivePointGame
//
//  Created by jczj on 17/1/7.
//  Copyright © 2017年 jczj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckerboardView : UIView
- (void)backOneStep:(UIButton *)sender;
- (void)newGame;
- (void)changeBoardLevel;
@end
