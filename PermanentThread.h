//
//  PermanentThread.h
//  PermanentThread
//
//  Created by wangwei on 2019/4/2.
//  Copyright © 2019 zhixl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PermanentThread : NSObject


/**
 do task in runloop

 @param task taskBlock
 */
- (void)doTask:(void(^)(void))task;

/**
 stop runloop
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
