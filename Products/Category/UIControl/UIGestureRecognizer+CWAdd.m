//
//  UIGestureRecognizer+CWAdd.m
//  ZeronerHealthPro
//
//  Created by ChenWu on 2017/5/11.
//  Copyright © 2017年 iwown. All rights reserved.
//
#import <objc/runtime.h>
#import "UIGestureRecognizer+CWAdd.h"


static const int block_key;

@interface CWUIGestureRecognizerBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation CWUIGestureRecognizerBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) _block(sender);
}
@end


@implementation UIGestureRecognizer (CWAdd)

- (instancetype)initWithActionBlock:(void (^)(id sender))block {
    self = [self init];
    [self addActionBlock:block];
    return self;
}

-(void)addActionBlock:(void (^)(id sender))block {
    CWUIGestureRecognizerBlockTarget *target = [[CWUIGestureRecognizerBlockTarget alloc] initWithBlock:block];
    [self addTarget:target action:@selector(invoke:)];
    NSMutableArray *targets = [self cw_allUIGestureRecognizerBlockTargets];
    [targets addObject:target];
}

- (NSMutableArray *)cw_allUIGestureRecognizerBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}
@end
