//
//  Model.m
//  ProjectDemo
//
//  Created by luckyCoderCai on 2017/9/28.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import "Model.h"

@implementation Model

- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.icon = [dic objectForKey:@"icon"];
        self.name = [dic objectForKey:@"name"];
    }
    return self;
}

+ (id)modelWithDic:(NSDictionary *)dic
{
    Model *model = [[Model alloc] initWithDic:dic];
    return model;
}

@end
