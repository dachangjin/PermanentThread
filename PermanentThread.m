//
//  PermanentThread.m
//  PermanentThread
//
//  Created by wangwei on 2019/4/2.
//  Copyright © 2019 zhixl. All rights reserved.
//

#import "PermanentThread.h"

@interface PermanentThread ()

@property(nonatomic,strong)NSThread *thread;

@end

@implementation PermanentThread

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.thread = [[NSThread alloc] initWithBlock:^{
            CFRunLoopSourceContext context = {0};
            CFRunLoopSourceRef ref = CFRunLoopSourceCreate(CFAllocatorGetDefault(), 0, &context);
            CFRunLoopAddSource(CFRunLoopGetCurrent(), ref, kCFRunLoopDefaultMode);
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10e10, false);
            CFRelease(ref);
        }];
        [self.thread start];
    }
    return self;
}

- (void)doTask:(nonnull void (^)(void))task {
    if(self && !self.thread) return;
    [self performSelector:@selector(doTaskOnThread:) onThread:self.thread withObject:task waitUntilDone:NO];
}

- (void)doTaskOnThread:(void(^)(void))task
{
    task();
}

- (void)stopRunLoop
{
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)stop
{
    if(!self.thread) return;
    [self performSelector:@selector(stopRunLoop) onThread:self.thread withObject:nil waitUntilDone:YES];
    self.thread = nil;
}

- (void)dealloc
{
    [self stop];
}
@end
