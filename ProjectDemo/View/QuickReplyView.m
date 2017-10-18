//
//  QuickReplyView.m
//  ProjectDemo
//
//  Created by luckyCoderCai on 2017/9/27.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import "QuickReplyView.h"
#import "Define.h"
#import "ReplyBtn.h"

@interface QuickReplyView ()

@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation QuickReplyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)_initView
{
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 50)];
    contentView.showsVerticalScrollIndicator = NO;
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    self.contentView = contentView;
    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50)];
    btnView.backgroundColor = [UIColor cyanColor];
    [self addSubview:btnView];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(0, 0, self.frame.size.width/2.0, 50);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = Bold_Font(16);
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:cancleBtn];
    
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.frame = CGRectMake(self.frame.size.width/2.0, 0, self.frame.size.width/2.0, 50);
    [customBtn setTitle:@"自定义" forState:UIControlStateNormal];
    [customBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    customBtn.titleLabel.font = Bold_Font(16);
    [customBtn addTarget:self action:@selector(customBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:customBtn];
    
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    CGFloat pointX = 20;
    CGFloat pointY = 50;
    CGFloat btnWidth = 60;
    CGFloat btnHeight = 80;
    CGFloat paddingX = (SCREEN_Width - 40 - 40 - 60 * 3)/2.0;
    CGFloat paddingY = 20;
    
    NSInteger line;
    if (dataArray.count % 3 == 0) {
        line = dataArray.count/3;
    } else {
        line = dataArray.count/3 + 1;
    }
    CGFloat contentHeight = pointY + line * (btnHeight + paddingY);
    self.contentView.contentSize = CGSizeMake(self.frame.size.width, contentHeight);
    
    for (int i = 0; i < dataArray.count; i++) {
        
        NSLog(@"===%d===%d", i, i % 3);
        
        if (i % 3 == 0 && i != 0) {
            pointX = 20;//恢复
            pointY += (btnHeight + paddingY);
        }
        
        ReplyBtn *btn = [ReplyBtn buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        btn.model = dataArray[i];
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(pointX);
            make.top.mas_equalTo(pointY);
            make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
        }];
        
        pointX += (btnWidth + paddingX);
    }
    
}

- (void)btnClick:(ReplyBtn *)btn
{
    NSLog(@"--click btn tag: %ld", btn.tag);
}

- (void)cancleBtnAction
{
    if (self.replyDelegate && [self.replyDelegate respondsToSelector:@selector(clickReplyViewCancle)]) {
        [self.replyDelegate clickReplyViewCancle];
    }
}

- (void)customBtnAction
{
    if (self.replyDelegate && [self.replyDelegate respondsToSelector:@selector(clickReplyViewCustom)]) {
        [self.replyDelegate clickReplyViewCustom];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
