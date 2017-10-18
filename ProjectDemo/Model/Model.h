//
//  Model.h
//  ProjectDemo
//
//  Created by luckyCoderCai on 2017/9/28.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;

- (id)initWithDic:(NSDictionary*)dic;
+ (id)modelWithDic:(NSDictionary*)dic;

@end
