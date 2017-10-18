//
//  ReplyDetailController.h
//  ProjectDemo
//
//  Created by luckyCoderCai on 2017/9/28.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Model;

typedef void(^RefreshPageBlock)(Model *newModel);

@interface ReplyDetailController : UIViewController

@property (nonatomic, strong) Model *model;

@property (nonatomic, assign) BOOL isNewFlag;//YES: 新建

@property (nonatomic, copy) RefreshPageBlock refreshBlock;

@end
