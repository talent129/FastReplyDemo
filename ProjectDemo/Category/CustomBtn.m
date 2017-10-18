//
//  CustomBtn.m
//  ProjectDemo
//
//  Created by luckyCoderCai on 2017/9/27.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import "CustomBtn.h"
#import "Define.h"

@implementation CustomBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width * 0.5 - contentRect.size.height * 0.5 - 5, contentRect.size.height/4.0, contentRect.size.height * 0.5, contentRect.size.height * 0.5);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width * 0.5 + 5, contentRect.size.height/4.0 + 2, contentRect.size.width * 0.5, contentRect.size.height * 0.5);
}

@end
