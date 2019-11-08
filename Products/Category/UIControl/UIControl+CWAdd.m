//
//  UIControl+CWAdd.m
//  ZeronerHealthPro
//
//  Created by ChenWu on 2017/5/11.
//  Copyright © 2017年 iwown. All rights reserved.
//
#import <objc/runtime.h>
#import "UIControl+CWAdd.h"

static const int block_key;

@interface CWUIControlBlockTarget : NSObject

@property(nonatomic,copy)void (^block)(id sender);
@property(nonatomic,assign)UIControlEvents  events;

-(id)initWithBlock:(void(^)(id sender))block events:(UIControlEvents)events;
-(void)invoke:(id)sender;

@end

@implementation CWUIControlBlockTarget


-(id)initWithBlock:(void(^)(id sender))block events:(UIControlEvents)events
{
    self=[super init];
    if(self)
    {
        _block=[block copy];
        
        _events=events;
    }
    return self;
}
-(void)invoke:(id)sender
{
    if (_block) {
        _block(sender);
    }
}

@end

@implementation UIControl (CWAdd)


- (void)addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block
{
    CWUIControlBlockTarget* target=[[CWUIControlBlockTarget alloc] initWithBlock:block events:controlEvents];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
    NSMutableArray* targets=[self cw_allUIControlBlockTargets];
    [targets addObject:target];
}

-(NSMutableArray*)cw_allUIControlBlockTargets
{
    NSMutableArray* targets=objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets=[NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}
@end
