//
//  IndexController.m
//  ProjectDemo
//
//  Created by luckyCoderCai on 2017/9/27.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import "IndexController.h"
#import "CustomBtn.h"
#import "Define.h"
#import "QuickReplyView.h"
#import "QuickReplyController.h"
#import "Model.h"

@interface IndexController ()<QuickReplyViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UILabel *quickReplyLabel;
@property (nonatomic, strong) UIView *btnView;
@property (nonatomic, strong) UIView *shadeView;
@property (nonatomic, strong) CustomBtn *praiseBtn;
@property (nonatomic, strong) CustomBtn *thankBtn;
@property (nonatomic, strong) CustomBtn *moreBtn;

@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UIView *rightLine;

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *scrollColorView;

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) QuickReplyView *replyView;

@end

@implementation IndexController

#pragma mark -lazy load
- (UILabel *)quickReplyLabel
{
    if (!_quickReplyLabel) {
        _quickReplyLabel = [[UILabel alloc] init];
        _quickReplyLabel.textColor = [UIColor lightGrayColor];
        _quickReplyLabel.font = [UIFont systemFontOfSize:13];
        _quickReplyLabel.text = @"快速回复";
    }
    return _quickReplyLabel;
}

- (UIView *)btnView
{
    if (!_btnView) {
        _btnView = [UIView new];
        _btnView.layer.borderColor = [UIColor grayColor].CGColor;
        _btnView.layer.borderWidth = 0.5;
        _btnView.layer.cornerRadius = 8;
        _btnView.layer.masksToBounds = YES;
    }
    return _btnView;
}

- (UIView *)shadeView
{
    if (!_shadeView) {
        _shadeView = [UIView new];
        _shadeView.backgroundColor = [UIColor lightGrayColor];
    }
    return _shadeView;
}

- (CustomBtn *)praiseBtn
{
    if (!_praiseBtn) {
        _praiseBtn = [CustomBtn buttonWithType:UIButtonTypeCustom];
//        [_praiseBtn setImage:Image(@"email-zan") forState:UIControlStateNormal];
//        [_praiseBtn setImage:Image(@"email-zan") forState:UIControlStateHighlighted];
//        [_praiseBtn setTitle:@"赞" forState:UIControlStateNormal];
        [_praiseBtn addTarget:self action:@selector(praiseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseBtn;
}

- (CustomBtn *)thankBtn
{
    if (!_thankBtn) {
        _thankBtn = [CustomBtn buttonWithType:UIButtonTypeCustom];
//        [_thankBtn setImage:Image(@"email-zan") forState:UIControlStateNormal];
//        [_thankBtn setImage:Image(@"email-zan") forState:UIControlStateHighlighted];
//        [_thankBtn setTitle:@"谢谢" forState:UIControlStateNormal];
        [_thankBtn addTarget:self action:@selector(thankBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thankBtn;
}

- (CustomBtn *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [CustomBtn buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:Image(@"email-zan") forState:UIControlStateNormal];
        [_moreBtn setImage:Image(@"email-zan") forState:UIControlStateHighlighted];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"撤销" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.alpha = 0;
    }
    return _cancelBtn;
}

- (UIView *)scrollColorView
{
    if (!_scrollColorView) {
        _scrollColorView = [[UIView alloc] initWithFrame:CGRectMake(-SCREEN_Width + 10, 0, (SCREEN_Width - 20)/3.0 * 2, 60)];
        _scrollColorView.backgroundColor = [UIColor cyanColor];
    }
    return _scrollColorView;
}

- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    return _coverView;
}

- (QuickReplyView *)replyView
{
    if (!_replyView) {
        _replyView = [[QuickReplyView alloc] initWithFrame:CGRectMake(20, SCREEN_Height, SCREEN_Width - 40, SCREEN_Height / 3.0 * 2)];
        _replyView.layer.cornerRadius = 8;
        _replyView.layer.masksToBounds = YES;
        _replyView.replyDelegate = self;
    }
    return _replyView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化
//    self.dataArray = [NSMutableArray arrayWithObjects:@{@"email-agree": @"同意"}, @{@"email-zan": @"赞"}, @{@"email-call": @"致电给我"}, @{@"email-good": @"不错"}, @{@"email-like": @"喜欢"}, @{@"email-thanks": @"谢谢"}, @{@"email-zanner": @"很赞"}, nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ModelList" ofType:@"plist"]];
    
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        Model *model = [Model modelWithDic:array[i]];
        [self.dataArray addObject:model];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.dataArray.count > 0) {
        
        Model *model = [self.dataArray firstObject];
        [self.praiseBtn setImage:Image(model.icon) forState:UIControlStateNormal];
        [self.praiseBtn setImage:Image(model.icon) forState:UIControlStateHighlighted];
        [self.praiseBtn setTitle:model.name forState:UIControlStateNormal];
    } else {
        self.praiseBtn.alpha = 0;
    }
    
    if (self.dataArray.count > 1) {
        
        Model *model = [self.dataArray objectAtIndex:1];
        
        [self.thankBtn setImage:Image(model.icon) forState:UIControlStateNormal];
        [self.thankBtn setImage:Image(model.icon) forState:UIControlStateHighlighted];
        [self.thankBtn setTitle:model.name forState:UIControlStateNormal];
    } else {
        self.thankBtn.alpha = 0;
    }
}

#pragma mark -createUI
- (void)createUI
{
    [self.view addSubview:self.quickReplyLabel];
    [self.view addSubview:self.btnView];
    [self.btnView addSubview:self.shadeView];
    [self.btnView addSubview:self.praiseBtn];
    [self.btnView addSubview:self.thankBtn];
    [self.btnView addSubview:self.moreBtn];
    [self.btnView addSubview:self.cancelBtn];
    
    [self.btnView insertSubview:self.scrollColorView belowSubview:self.praiseBtn];
    
    [self.scrollColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.btnView.mas_leading);
        make.top.and.bottom.and.width.equalTo(self.shadeView);
    }];
    
    [self.quickReplyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@10);
        make.top.equalTo(self.mas_topLayoutGuideBottom).mas_offset(100);
    }];
    
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@10);
        make.trailing.equalTo(@-10);
        make.top.equalTo(self.quickReplyLabel.mas_bottom).mas_offset(5);
        make.height.equalTo(@60);
    }];
    
    [self.shadeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.top.and.bottom.equalTo(@0);
        make.width.mas_equalTo((SCREEN_Width - 20)/3.0 * 2);
    }];
    
    [self.praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.top.and.bottom.equalTo(@0);
        make.width.mas_equalTo((SCREEN_Width - 20)/3.0);
    }];
    
    [self.thankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo((SCREEN_Width - 20)/3.0);
        make.top.and.bottom.equalTo(@0);
        make.width.equalTo(self.praiseBtn);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.thankBtn.mas_trailing);
        make.top.and.bottom.equalTo(@0);
        make.width.equalTo(self.praiseBtn);
    }];
    
    UIView *leftLine = [[UIView alloc] init];
    leftLine.backgroundColor = [UIColor redColor];
    [self.btnView addSubview:leftLine];
    self.leftLine = leftLine;
    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = [UIColor redColor];
    [self.btnView addSubview:rightLine];
    self.rightLine = rightLine;
    
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.praiseBtn);
        make.width.equalTo(@0.5);
        make.top.equalTo(@15);
        make.bottom.equalTo(@-15);
    }];
    
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.moreBtn);
        make.width.equalTo(@0.5);
        make.top.and.bottom.mas_equalTo(0);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@-20);
        make.centerY.equalTo(self.btnView);
    }];
}

#pragma mark -按钮点击响应事件
- (void)praiseBtnAction
{
    NSLog(@"===click praise");
    [self clickActionWith:NO];
}

- (void)thankBtnAction
{
    NSLog(@"===click thank");
    
    [self clickActionWith:YES];
}

- (void)moreBtnAction
{
    NSLog(@"===click more");
    [[UIApplication sharedApplication].keyWindow addSubview:self.coverView];
    [self.coverView addSubview:self.replyView];
    self.replyView.dataArray = self.dataArray;//数据
    
    WEAKSELF
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.replyView.frame = CGRectMake(20, SCREEN_Height - SCREEN_Height / 3.0 * 2 - 20, SCREEN_Width - 40, SCREEN_Height / 3.0 * 2);
    }];
    
}

- (void)cancelBtnAction
{
    NSLog(@"===click cancel");
    [self.scrollColorView.layer removeAllAnimations];
    
    WEAKSELF
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.thankBtn.frame = CGRectMake((SCREEN_Width - 20)/3.0, 0, (SCREEN_Width - 20)/3.0, 60);
    }];
    self.leftLine.alpha = 1;
    self.rightLine.alpha = 1;
    self.shadeView.alpha = 1;
    self.praiseBtn.alpha = 1;
    self.thankBtn.alpha = 1;
    self.moreBtn.alpha = 1;
    self.cancelBtn.alpha = 0;
    
    if (self.scrollColorView != nil) {
        [self.scrollColorView removeFromSuperview];
        self.scrollColorView = nil;
    }
    
    [self.btnView insertSubview:self.scrollColorView belowSubview:self.praiseBtn];
    [self.scrollColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.btnView.mas_leading);
        make.top.and.bottom.and.width.equalTo(self.shadeView);
    }];
}

#pragma mark -reply 代理
- (void)clickReplyViewCancle
{
    [self removeCoverView];
}

- (void)clickReplyViewCustom
{
    [self removeCoverView];
    
    QuickReplyController *vc = [[QuickReplyController alloc] init];
    vc.dataArray = self.dataArray;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)removeCoverView
{
    WEAKSELF
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.replyView.frame = CGRectMake(20, SCREEN_Height, SCREEN_Width - 40, SCREEN_Height / 3.0 * 2);
    } completion:^(BOOL finished) {
        if (weakSelf.coverView) {
            [weakSelf.coverView removeFromSuperview];
            weakSelf.coverView = nil;
        }
        
        if (weakSelf.replyView) {
            [weakSelf.replyView removeFromSuperview];
            weakSelf.replyView = nil;
        }
    }];
}

#pragma mark -点击按钮动画效果
- (void)clickActionWith:(BOOL)thank
{
    WEAKSELF
    [UIView animateWithDuration:0.8 animations:^{
        
        if (thank) {
            weakSelf.praiseBtn.alpha = 0;
        } else {
            weakSelf.thankBtn.alpha = 0;
        }
        weakSelf.leftLine.alpha = 0;
        weakSelf.rightLine.alpha = 0;
        weakSelf.moreBtn.alpha = 0;
        weakSelf.shadeView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.8 animations:^{
            
            if (thank) {
                weakSelf.thankBtn.frame = CGRectMake(0, 0, (SCREEN_Width - 20)/3.0, 60);
            } else {
                weakSelf.praiseBtn.frame = CGRectMake(0, 0, (SCREEN_Width - 20)/3.0, 60);
            }
            
            weakSelf.cancelBtn.alpha = 1;
            
        } completion:^(BOOL finished) {
            [weakSelf leftToRightAnimation];
        }];
        
    }];
}

- (void)leftToRightAnimation
{
    WEAKSELF
    [UIView animateWithDuration:5 animations:^{
        weakSelf.scrollColorView.frame = CGRectMake(0, 0, (SCREEN_Width - 20)/3.0 * 2, 60);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
