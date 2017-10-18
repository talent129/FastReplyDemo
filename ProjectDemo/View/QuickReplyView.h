//
//  QuickReplyView.h
//  ProjectDemo
//
//  Created by luckyCoderCai on 2017/9/27.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuickReplyViewDelegate <NSObject>

- (void)clickReplyViewCancle;
- (void)clickReplyViewCustom;

@end

@interface QuickReplyView : UIView

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak) id<QuickReplyViewDelegate> replyDelegate;

@end
