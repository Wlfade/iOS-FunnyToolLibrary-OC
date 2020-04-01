//
//  TheFourStyleAlertView.m
//  自定义UIAlertView
//
//  Created by jczj on 16/9/26.
//  Copyright © 2016年 jczj. All rights reserved.
//

#import "TheFourStyleAlertView.h"
//获取屏幕 宽度、高度
#define WIDTH ([UIScreen mainScreen].bounds.size.width)/320
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)/568
#define TheLabelFont WIDTH *17
@implementation TheFourStyleAlertView
{
    UIView *backGroundView; //背景视图
    UIView *destView; //提示视图桌面视图
    NSString *QQstring;

}
//申请到账处理弹出框
- (instancetype)initWithApplyTheAccount:(NSString *)QQStr{
    self = [self initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self _creatSubView];
        [self _creatApplyTheAccountView:QQStr];
    }
    return self;
}

//已转入其他账号弹出框
- (instancetype)initWithTransToOthersAcount:(NSString *)tipSting withInfo:(NSString *)inforSting withColorStr:(NSString *)colorStr{
    self = [self initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self _creatSubView];
        [self _creatOtherAcountInformation:tipSting withInfo:inforSting withColorSre:colorStr];
    }
    return self;
}

//转账到支付宝提示弹出框
- (instancetype)initWithTransAcountTip{
    self = [self initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self _creatSubView];
        [self _creatTransAcountTip];
    }
    return self;
}
//到账成功弹出框
- (instancetype)initWithTransSuccess{
    self = [self initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self _creatSubView];
        [self _creatTransSuccess];
    }
    return self;
}
- (void)_creatSubView{
    backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
//    NSLog(@"%f,%f",self.bounds.size.width,self.bounds.size.height);
//    backGroundView.backgroundColor = [self getColor:@"7F7F7F"];
    backGroundView.backgroundColor = [self getColor:@"000000"];
    backGroundView.alpha = 0.5;
    [self insertSubview:backGroundView atIndex:0];
    
    destView = [[UIView alloc]init];
    destView.backgroundColor = [UIColor whiteColor];
    destView.layer.cornerRadius = 6*HEIGHT;
    destView.layer.masksToBounds = YES;
    [self addSubview:destView];
}
#pragma mark 申请到账弹出框
- (void)_creatApplyTheAccountView:(NSString *)QQStr{
    destView.frame = CGRectMake(0, 0, WIDTH*276, HEIGHT*121);
    destView.center = self.center;
    
    QQstring = QQStr;
    //创建关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    clickBtn setImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
//    [closeBtn setBackgroundColor:[UIColor yellowColor]];
    [closeBtn setBackgroundColor:[UIColor clearColor]];

    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    closeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [closeBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.adjustsImageWhenHighlighted = NO; //关闭按钮图片点击出现高亮状态
    [destView addSubview:closeBtn];
    
    closeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSNumber *leftSpacing = @(246*WIDTH);
    NSNumber *rightSpacing = @(10*WIDTH);
    NSNumber *topSpacing = @(10*HEIGHT);
    NSNumber *buttonSpacing = @(91*HEIGHT);
    NSDictionary *views = NSDictionaryOfVariableBindings(closeBtn);
    NSString *Hfl = @"H:|-leftSpacing-[closeBtn]-rightSpacing-|";
    NSDictionary *Hmertrics = NSDictionaryOfVariableBindings(leftSpacing,rightSpacing);
    NSArray *Hconstraints = [NSLayoutConstraint constraintsWithVisualFormat:Hfl options:0 metrics:Hmertrics views:views];
    [NSLayoutConstraint activateConstraints:Hconstraints];
    
    NSString *Vfl = @"V:|-topSpacing-[closeBtn]-buttonSpacing-|";
    NSDictionary *Vmertrics = NSDictionaryOfVariableBindings(topSpacing,buttonSpacing);

    NSArray *Vconstraints = [NSLayoutConstraint constraintsWithVisualFormat:Vfl options:0 metrics:Vmertrics views:views];
    [NSLayoutConstraint activateConstraints:Vconstraints];
    
    //创建灰色中间线
    UIView *grayLineView = [[UIView alloc]init];
    grayLineView.backgroundColor = [self getColor:@"EFEFEF"];
    [destView addSubview:grayLineView];
    grayLineView.translatesAutoresizingMaskIntoConstraints = NO;
    NSNumber *glLeftSpacing = @(WIDTH * 20);
    NSNumber *glRightSpacing = @(WIDTH * 20);
    NSString *glHfl = @"H:|-glLeftSpacing-[grayLineView]-glRightSpacing-|";
    NSDictionary *glView = NSDictionaryOfVariableBindings(grayLineView);
    NSDictionary *glHmetrics = NSDictionaryOfVariableBindings(glLeftSpacing,glRightSpacing);
    NSArray *glHconstraints = [NSLayoutConstraint constraintsWithVisualFormat:glHfl options:0 metrics:glHmetrics views:glView];
    [NSLayoutConstraint activateConstraints:glHconstraints];
    
    NSNumber *glTopSpacing = @(HEIGHT * 60);
    NSNumber *glBottomSpacing = @(HEIGHT * 60);
    NSString *glVfl = @"V:|-glTopSpacing-[grayLineView(1)]-glBottomSpacing-|";
    NSDictionary *glVmetrics = NSDictionaryOfVariableBindings(glTopSpacing,glBottomSpacing);
    NSArray *glVconstraints = [NSLayoutConstraint constraintsWithVisualFormat:glVfl options:0 metrics:glVmetrics views:glView];
    [NSLayoutConstraint activateConstraints:glVconstraints];
    
    //创建申请处理到账按钮
    UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [applyBtn addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [applyBtn setTitle:@"申请到账处理" forState:UIControlStateNormal];
    applyBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT*20];
    [applyBtn setTitleColor:[self getColor:@"3d93d0"] forState:UIControlStateNormal];
    [destView addSubview:applyBtn];

    applyBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *apHfl = @"H:|-glLeftSpacing-[applyBtn]-glRightSpacing-|";
    NSDictionary *apView = NSDictionaryOfVariableBindings(applyBtn);
    NSArray *apHconstrains = [NSLayoutConstraint constraintsWithVisualFormat:apHfl options:0 metrics:glHmetrics views:apView];
    [NSLayoutConstraint activateConstraints:apHconstrains];
    
    NSNumber *apTopSpacing = @(HEIGHT * 21);
    NSNumber *apBottomSpacing = @(HEIGHT * 21);
    NSString *apVfl = @"V:|-apTopSpacing-[applyBtn]-apBottomSpacing-[grayLineView]-glBottomSpacing-|";
    NSDictionary *apVmetrics = NSDictionaryOfVariableBindings(apTopSpacing,apBottomSpacing,glBottomSpacing);
    NSDictionary *apVView = NSDictionaryOfVariableBindings(applyBtn,grayLineView);
    NSArray *apVconstraints = [NSLayoutConstraint constraintsWithVisualFormat:apVfl options:0 metrics:apVmetrics views:apVView];
    [NSLayoutConstraint activateConstraints:apVconstraints];
    
    NSMutableAttributedString *serviceBtnTitleString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"联系客服QQ(%@)",QQStr]];
    [serviceBtnTitleString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:HEIGHT*20] range:NSMakeRange(0, 6)];
    [serviceBtnTitleString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:HEIGHT*16] range:NSMakeRange(6, serviceBtnTitleString.length - 6)];
    [serviceBtnTitleString addAttribute:NSForegroundColorAttributeName value:[self getColor:@"3d93d0"] range:NSMakeRange(0, serviceBtnTitleString.length)];
    
    //创建联系客服QQ按钮
    UIButton *serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [serviceBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [serviceBtn addTarget:self action:@selector(serviceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [serviceBtn setAttributedTitle:serviceBtnTitleString forState:UIControlStateNormal];
    [destView addSubview:serviceBtn];
    
    serviceBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *seHfl = @"H:|-glLeftSpacing-[serviceBtn]-glRightSpacing-|";
    NSDictionary *seView = NSDictionaryOfVariableBindings(serviceBtn);
    NSArray *seHconstrains = [NSLayoutConstraint constraintsWithVisualFormat:seHfl options:0 metrics:glHmetrics views:seView];
    [NSLayoutConstraint activateConstraints:seHconstrains];
    
    NSNumber *seTopSpacing = @(HEIGHT * 21);
    NSNumber *seBottomSpacing = @(HEIGHT * 21);
    NSString *seVfl = @"V:|-glTopSpacing-[grayLineView]-seTopSpacing-[serviceBtn]-seBottomSpacing-|";
    NSDictionary *seVmetrics = NSDictionaryOfVariableBindings(seTopSpacing,seBottomSpacing,glTopSpacing);
    NSDictionary *seVView = NSDictionaryOfVariableBindings(serviceBtn,grayLineView);
    NSArray *seVconstraints = [NSLayoutConstraint constraintsWithVisualFormat:seVfl options:0 metrics:seVmetrics views:seVView];
    [NSLayoutConstraint activateConstraints:seVconstraints];
}
#pragma mark 转账到其他账号 或角色 弹出框
- (void)_creatOtherAcountInformation:(NSString *)tipSting withInfo:(NSString*)inforSting withColorSre:colorStr{
    destView.frame = CGRectMake(0, 0, WIDTH*281, HEIGHT*160);
    destView.center = self.center;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor redColor];
    imageView.image = [UIImage imageNamed:@"worning"];
    [destView addSubview:imageView];
    
    CGFloat labelFont = HEIGHT * 15;
    UILabel *firstTipLabel = [[UILabel alloc]init];
    firstTipLabel.textColor = [self getColor:@"333333"];
    firstTipLabel.font = [UIFont systemFontOfSize:labelFont];
    firstTipLabel.text = tipSting;
    firstTipLabel.textAlignment = NSTextAlignmentCenter;
    [destView addSubview:firstTipLabel];
    
    UILabel *secondTipLabel = [[UILabel alloc]init];
    secondTipLabel.text = inforSting;
    secondTipLabel.textColor = [self getColor:colorStr];
    secondTipLabel.font = [UIFont systemFontOfSize:labelFont];
    secondTipLabel.textAlignment = NSTextAlignmentCenter;
    [destView addSubview:secondTipLabel];
    
    //创建灰色中间线
    UIView *grayLineView = [[UIView alloc]init];
    grayLineView.backgroundColor = [self getColor:@"EFEFEF"];
    [destView addSubview:grayLineView];
    
    UIButton *curtainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [curtainBtn setTitle:@"确定" forState:UIControlStateNormal];
    [curtainBtn setTitleColor:[self getColor:@"333333"] forState:UIControlStateNormal];
    [curtainBtn addTarget:self action:@selector(curtainAction) forControlEvents:UIControlEventTouchUpInside];
    [destView addSubview:curtainBtn];
    
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    firstTipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    secondTipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    grayLineView.translatesAutoresizingMaskIntoConstraints = NO;
    curtainBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    NSNumber *Spacing = @(((WIDTH*281)-(HEIGHT*40))/2);
    NSDictionary *views = NSDictionaryOfVariableBindings(imageView);
    NSString *Hfl = @"H:|-Spacing-[imageView]-Spacing-|";
    NSDictionary *Hmertrics = NSDictionaryOfVariableBindings(Spacing);
    NSArray *Hconstraints = [NSLayoutConstraint constraintsWithVisualFormat:Hfl options:0 metrics:Hmertrics views:views];
    [NSLayoutConstraint activateConstraints:Hconstraints];
    
    NSArray* fTHArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[firstTipLabel]-0-|" options:0 metrics:nil views:@{@"firstTipLabel": firstTipLabel}];
    [NSLayoutConstraint activateConstraints:fTHArray];
    
    NSArray* sTHArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[secondTipLabel]-0-|" options:0 metrics:nil views:@{@"secondTipLabel": secondTipLabel}];
    [NSLayoutConstraint activateConstraints:sTHArray];
    
    NSArray* glHArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[grayLineView]-0-|" options:0 metrics:nil views:@{@"grayLineView": grayLineView}];
    [NSLayoutConstraint activateConstraints:glHArray];
    
    NSArray* cuBtnHArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[curtainBtn]-0-|" options:0 metrics:nil views:@{@"curtainBtn": curtainBtn}];
    [NSLayoutConstraint activateConstraints:cuBtnHArray];
    
    NSNumber *firstMargin = @(HEIGHT * 15);
    NSNumber *imageViewHeigh = @(HEIGHT * 35);
    NSNumber *midMargin = @(HEIGHT * 15);

    NSNumber *labelHeigh = @(HEIGHT * 21);
    NSNumber *secondMargin = @(HEIGHT * 10);
    
    NSString *seVfl = @"V:|-firstMargin-[imageView(imageViewHeigh)]-midMargin-[firstTipLabel(labelHeigh)][secondTipLabel(==firstTipLabel)]-secondMargin-[grayLineView(1)][curtainBtn]|";
    NSDictionary *seVmetrics = NSDictionaryOfVariableBindings(firstMargin,midMargin,imageViewHeigh,labelHeigh,secondMargin);
    NSDictionary *seVView = NSDictionaryOfVariableBindings(imageView,firstTipLabel,secondTipLabel,grayLineView,curtainBtn);
    NSArray *seVconstraints = [NSLayoutConstraint constraintsWithVisualFormat:seVfl options:0 metrics:seVmetrics views:seVView];
    [NSLayoutConstraint activateConstraints:seVconstraints];
}
#pragma mark 支付宝转账提示弹出框自己写死的
- (void)_creatTransAcountTip{

    destView.frame = CGRectMake(0, 0, WIDTH*283, HEIGHT*168);
    destView.center = self.center;

    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.text = @"提示";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:HEIGHT * 15];
    tipLabel.textColor = [self getColor:@"666666"];
    [destView addSubview:tipLabel];

    UIView *firstLineView = [[UIView alloc]init];
    firstLineView.backgroundColor = [self getColor:@"EFEFEF"];
    [destView addSubview:firstLineView];
    
    UIImageView *tipImageView = [[UIImageView alloc]init];
    tipImageView.backgroundColor = [UIColor whiteColor];
    tipImageView.contentMode = UIViewContentModeScaleAspectFit;
    tipImageView.image = [UIImage imageNamed:@"付款提示"];
    [destView addSubview:tipImageView];

    UIView *secondLineView = [[UIView alloc]init];
    secondLineView.backgroundColor = [self getColor:@"EFEFEF"];
    [destView addSubview:secondLineView];

    UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickBtn setTitle:@"确定" forState:UIControlStateNormal];
    [clickBtn setTitleColor:[self getColor:@"333333"] forState:UIControlStateNormal];
    clickBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT*19];
    [clickBtn addTarget:self action:@selector(curtainAction) forControlEvents:UIControlEventTouchUpInside];
    [destView addSubview:clickBtn];

    tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    firstLineView.translatesAutoresizingMaskIntoConstraints = NO;
    
    tipImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    secondLineView.translatesAutoresizingMaskIntoConstraints = NO;
    clickBtn.translatesAutoresizingMaskIntoConstraints = NO;

    NSArray* tipHArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tipLabel]-0-|" options:0 metrics:nil views:@{@"tipLabel": tipLabel}];
    [NSLayoutConstraint activateConstraints:tipHArray];

    NSArray* firLineHArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[firstLineView]-0-|" options:0 metrics:nil views:@{@"firstLineView": firstLineView}];
    [NSLayoutConstraint activateConstraints:firLineHArray];
    
    NSArray *tipImageViewHArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tipImageView]-0-|" options:0 metrics:nil views:@{@"tipImageView":tipImageView}];
    [NSLayoutConstraint activateConstraints:tipImageViewHArray];

    NSArray* secLineHArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[secondLineView]-0-|" options:0 metrics:nil views:@{@"secondLineView": secondLineView}];
    [NSLayoutConstraint activateConstraints:secLineHArray];

    NSArray* cliBtnHArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[clickBtn]-0-|" options:0 metrics:nil views:@{@"clickBtn": clickBtn}];
    [NSLayoutConstraint activateConstraints:cliBtnHArray];

    NSNumber *tipLabelHeigh = @(HEIGHT * 30);
    NSNumber *lineHeigh = @(HEIGHT * 1);
    NSNumber *clickBtnHeigh = @(HEIGHT * 37);
    NSNumber *margin = @(HEIGHT * 9);
    
    NSString *seVfl = @"V:|[tipLabel(tipLabelHeigh)][firstLineView(lineHeigh)][tipImageView][secondLineView(==firstLineView)][clickBtn(clickBtnHeigh)]|";
    NSDictionary *seVmetrics = NSDictionaryOfVariableBindings(tipLabelHeigh,lineHeigh,clickBtnHeigh,margin);
    NSDictionary *seVView = NSDictionaryOfVariableBindings(tipLabel,firstLineView,tipImageView,secondLineView,clickBtn);
    NSArray *seVconstraints = [NSLayoutConstraint constraintsWithVisualFormat:seVfl options:0 metrics:seVmetrics views:seVView];
    [NSLayoutConstraint activateConstraints:seVconstraints];
}
#pragma mark 成功到账
- (void)_creatTransSuccess{
    destView.frame = CGRectMake(0, 0, WIDTH*281, HEIGHT*130);
    destView.center = self.center;
    
//    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    clickBtn setImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
//    [closeBtn setBackgroundColor:[UIColor yellowColor]];
//    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
//    [closeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [closeBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
//    [destView addSubview:closeBtn];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor redColor];
    imageView.image = [UIImage imageNamed:@"success"];
    [destView addSubview:imageView];
    
    UILabel *successTipLabel = [[UILabel alloc]init];
    successTipLabel.textAlignment = NSTextAlignmentCenter;
    successTipLabel.text = @"到账成功";
    successTipLabel.font = [UIFont systemFontOfSize:HEIGHT * 19];
    successTipLabel.textColor = [self getColor:@"333333"];
    [destView addSubview:successTipLabel];
    
    UIView *horizonLineView = [[UIView alloc]init];
    horizonLineView.backgroundColor = [self getColor:@"EFEFEF"];
    [destView addSubview:horizonLineView];
    
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkBtn setTitle:@"查看明细" forState:UIControlStateNormal];
    checkBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT *14];
    [checkBtn setBackgroundColor:[UIColor whiteColor]];
    [checkBtn setTitleColor:[self getColor:@"333333"] forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(checkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [destView addSubview:checkBtn];
    
    UIView *verticalLineView = [[UIView alloc]init];
    verticalLineView.backgroundColor = [self getColor:@"EFEFEF"];
    [destView addSubview:verticalLineView];
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goBackBtn setTitle:@"返回个人中心" forState:UIControlStateNormal];
    goBackBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT*14];
    [goBackBtn setBackgroundColor:[UIColor whiteColor]];
    [goBackBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [goBackBtn addTarget:self action:@selector(goBackBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [destView addSubview:goBackBtn];
    
//    closeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    successTipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    horizonLineView.translatesAutoresizingMaskIntoConstraints = NO;
    checkBtn.translatesAutoresizingMaskIntoConstraints = NO;
    verticalLineView.translatesAutoresizingMaskIntoConstraints = NO;
    goBackBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
//    NSNumber *leftSpacing = @(261*WIDTH);
//    NSNumber *rightSpacing = @(10*WIDTH);
//    
//    NSNumber *topSpacing = @(10*HEIGHT);
//    NSNumber *bottomSpacing = @(120*HEIGHT - 10*WIDTH);
    
//    NSNumber *cloBtnWidth = @(10*WIDTH);
//    NSDictionary *cloBtnHMetrics = NSDictionaryOfVariableBindings(leftSpacing,rightSpacing,cloBtnWidth);
//    NSArray* cloBtnHArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftSpacing-[closeBtn(cloBtnWidth)]-rightSpacing-|" options:0 metrics:cloBtnHMetrics views:@{@"closeBtn": closeBtn}];
//    [NSLayoutConstraint activateConstraints:cloBtnHArray];
//    
//    NSDictionary *cloBtnVMetrics = NSDictionaryOfVariableBindings(topSpacing,cloBtnWidth,bottomSpacing);
//    NSArray* cloBtnVArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topSpacing-[closeBtn(cloBtnWidth)]-bottomSpacing-|" options:0 metrics:cloBtnVMetrics views:@{@"closeBtn": closeBtn}];
//    [NSLayoutConstraint activateConstraints:cloBtnVArray];
    
    NSNumber *Spacing = @((WIDTH * 281 - HEIGHT * 35)/2);
    
    NSDictionary *metrics = NSDictionaryOfVariableBindings(Spacing);
    NSArray* imageViewHArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-Spacing-[imageView]-Spacing-|" options:0 metrics:metrics views:@{@"imageView": imageView}];
    [NSLayoutConstraint activateConstraints:imageViewHArray];
    
    NSArray* suLabelHArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[successTipLabel]-0-|" options:0 metrics:nil views:@{@"successTipLabel": successTipLabel}];
    [NSLayoutConstraint activateConstraints:suLabelHArray];
    
    NSArray* horiLineHArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[horizonLineView]-0-|" options:0 metrics:nil views:@{@"horizonLineView": horizonLineView}];
    [NSLayoutConstraint activateConstraints:horiLineHArray];
    
    NSNumber *checkBtnWidth = @(140*WIDTH);
    NSNumber *lineWidth = @(1*WIDTH);
    // NSNumber *spacing = @(30);
    NSDictionary *views = NSDictionaryOfVariableBindings(checkBtn,verticalLineView,goBackBtn);
    NSDictionary *mertrics = NSDictionaryOfVariableBindings(checkBtnWidth,lineWidth);
    // 添加水平方向的约束1
    NSString *vfl = @"H:|[checkBtn(checkBtnWidth)][verticalLineView(lineWidth)][goBackBtn(==checkBtn)]|";
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:vfl options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:mertrics views:views];
    //    [self.view addConstraints:constraints];
    [NSLayoutConstraint activateConstraints:constraints];
    
    
    NSNumber *margin = @(HEIGHT * 14);
    NSNumber *imageVHeigh = @(HEIGHT * 35);
    NSNumber *secondMargin = @(HEIGHT * 8);
    NSNumber *seccussLabelHeigh = @(HEIGHT * 20);
    NSNumber *lineViewHeigh = @(HEIGHT * 1);
    NSNumber *btnHeigh = @(HEIGHT* 33);
    
    NSString *seVfl = @"V:|-margin-[imageView(imageVHeigh)]-secondMargin-[successTipLabel(seccussLabelHeigh)]-margin-[horizonLineView(lineViewHeigh)][checkBtn]|";
    //(==verticalLineView)(==goBackBtn)
    NSDictionary *seVmetrics = NSDictionaryOfVariableBindings(margin,imageVHeigh,secondMargin,seccussLabelHeigh,lineViewHeigh,btnHeigh);
    NSDictionary *seVView = NSDictionaryOfVariableBindings(imageView,successTipLabel,horizonLineView,checkBtn,verticalLineView,goBackBtn);
    NSArray *seVconstraints = [NSLayoutConstraint constraintsWithVisualFormat:seVfl options:0 metrics:seVmetrics views:seVView];
    [NSLayoutConstraint activateConstraints:seVconstraints];
    
    
}
- (void)showAlert{
    if (self == nil) {
        return;
    }
    UIViewController *top = [self appRootViewController];
    CGPoint p = top.view.center;
    self.center = p;
    [top.view addSubview:self];
}
- (UIViewController *)appRootViewController
{
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC; //获取当前创建alertView的控制器（viewController）
}
//申请到账按钮
- (void)applyBtnAction{
    if (self.applyBlock) {
        self.applyBlock();
    }
    [self _removeSubView];
}
//联系客服按钮
- (void)serviceBtnAction{
    if (self.serviceBlock) {
        self.serviceBlock(QQstring);
    }
    [self _removeSubView];
}
- (void)checkBtnAction{
    if (self.checkBlock) {
        self.checkBlock();
    }
    [self _removeSubView];
}
- (void)goBackBtnAction{
    if (self.goBackBlock) {
        self.goBackBlock();
    }
    [self _removeSubView];
}
- (void)curtainAction{
    if (self.curtainBlock) {
        self.curtainBlock(@"result");
    }
    [self _removeSubView];
}
- (void)_removeSubView{
    [self removeFromSuperview];
}
- (void)clickAction{
    [self removeFromSuperview];
}

#pragma 16进制颜色转换
-(UIColor *)getColor:(NSString *)hexColor {
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

@end
