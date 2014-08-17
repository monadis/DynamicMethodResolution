//
//  WSEmployee.m
//  test3
//
//  Created by LYH on 2014. 8. 16..
//  Copyright (c) 2014년 YK. All rights reserved.
//

#import "WSEmployee.h"
#import <objc/runtime.h>

// 이 클래스는 동적 메소드 결정 (dynamic method resolution)의 예를 보여준다.
@implementation WSEmployee


//This method is called before the Objective-C forwarding mechanism is invoked. If respondsToSelector: or instancesRespondToSelector: is invoked, the dynamic method resolver is given the opportunity to provide an IMP for the given selector first.
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

	if (sel == @selector(completeWork)) {
		class_addMethod([self class], sel, (IMP)doWorkIMP, "v@:");
		return YES;
	} else if (sel == @selector(completeWorkForMe:)) {
		class_addMethod([self class], sel, (IMP)doWorkForBossIMP, "v@:@");
		return YES;
	}

#pragma clang diagnostic pop

	return [super resolveInstanceMethod:sel];
}

void doWorkIMP(id self, SEL _cmd)
{
	NSLog((@"%s (Line:%d)"), __PRETTY_FUNCTION__, __LINE__);
}

void doWorkForBossIMP(id self, SEL _cmd, id value)
{
	NSLog((@"%s (Line:%d)"), __PRETTY_FUNCTION__, __LINE__);
}

@end