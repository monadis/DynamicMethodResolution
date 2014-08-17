//
//  WSBoss.m
//  MessageHandling
//
//  Created by Wolfram Schroers on 4/6/12.
//  Copyright (c) 2012 Numerik & Analyse Schroers. All rights reserved.
//

#import "WSBoss.h"
#import "WSEmployee.h"


// 이 클래스에서는 method forwarding 의 예를 보여준다.

@implementation WSBoss

@synthesize worker = _worker;


// forwardInvocation:에게 인자로 넘겨줄 NSInvocation을 생성하기 위해 필요한 메소드시그너쳐를 리턴
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [[WSEmployee class] instanceMethodSignatureForSelector:aSelector];
}

// 이 객체에 메시지를 실행시킬 메소드가 없을경우 forwardInvocation:이 실행되어 메시지를 포워딩함.
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"%@ says: I don't do '%@' myself.",
          NSStringFromClass([self class]),
          [anInvocation description]);
	if ([self.worker respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:self.worker];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

@end
