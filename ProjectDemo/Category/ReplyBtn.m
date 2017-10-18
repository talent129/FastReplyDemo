//
//  ReplyBtn.m
//  ProjectDemo
//
//  Created by luckyCoderCai on 2017/9/27.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import "ReplyBtn.h"
#import "Define.h"
#import "Model.h"

@interface ReplyBtn ()

@property (nonatomic, strong) UIImageView *btnImgView;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *btnTitleLabel;

@end

@implementation ReplyBtn

- (UIImageView *)btnImgView
{
    if (!_btnImgView) {
        _btnImgView = [[UIImageView alloc] init];
        _btnImgView.image = Image(@"emoji-solid-grey");
    }
    return _btnImgView;
}

- (UIImageView *)iconImgView
{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
    }
    return _iconImgView;
}

- (UILabel *)btnTitleLabel
{
    if (!_btnTitleLabel) {
        _btnTitleLabel = [[UILabel alloc] init];
        _btnTitleLabel.textColor = [UIColor blackColor];
        _btnTitleLabel.font = Sys_Font(16);
        _btnTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _btnTitleLabel;
}

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
    [self addSubview:self.btnImgView];
    [self.btnImgView addSubview:self.iconImgView];
    [self addSubview:self.btnTitleLabel];
    [self.btnImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.top.equalTo(self);
        make.height.and.width.mas_equalTo(60);
    }];
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.btnImgView);
    }];
    
    [self.btnTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnImgView.mas_bottom).mas_offset(4);
        make.centerX.equalTo(self);
    }];
}

- (void)setModel:(Model *)model
{
    _model = model;
    
    self.iconImgView.image = Image(model.icon);
    self.btnTitleLabel.text = model.name;
}

@end
