//
//  MessageInterceptor.m
//  HNCF
//
//  Created by Apple on 15/11/18.
//  Copyright © 2015年 hsy. All rights reserved.
//

//  From http://stackoverflow.com/questions/3498158/intercept-obj-c-delegate-messages-within-a-subclass

#import "MessageInterceptor.h"

@implementation MessageInterceptor
@synthesize receiver;
@synthesize middleMan;

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([middleMan respondsToSelector:aSelector]) { return middleMan; }
    if ([receiver respondsToSelector:aSelector]) { return receiver; }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([middleMan respondsToSelector:aSelector]) { return YES; }
    if ([receiver respondsToSelector:aSelector]) { return YES; }
    return [super respondsToSelector:aSelector];
}

@end

