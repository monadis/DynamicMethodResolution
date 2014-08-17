//
//  ViewController.m
//  test3
//
//  Created by LYH on 2014. 8. 16..
//  Copyright (c) 2014년 YK. All rights reserved.


//	http://www.field-theory.org/articles/objective-c_dynamic_messages/index.html
//	http://stackoverflow.com/questions/7017281/performselector-may-cause-a-leak-because-its-selector-is-unknown



#import "ViewController.h"
#import "WSEmployee.h"
#import "WSBoss.h"

@interface ViewController ()

@end

@implementation ViewController
            
- (void)viewDidLoad {
	[super viewDidLoad];
	WSEmployee *em=[WSEmployee new];

// WSEmployee클래스에 HAHA라는 이름의 메소드를 동적으로 생성
	SEL sel = NSSelectorFromString(@"HAHA");


	if ([em respondsToSelector:sel]) {   // respondsToSelector:를 실행하면 자동으로 해당객체의 resolveInstanceMethod:가 실행되어 동적으로 메소드가 생성된다.

		/* 동적으로 생성된 메소드를 실행하는 세가지 방법 */


		//	[em performSelector:sel];          // 첫번째 방법은 경고가 뜬다.


		//	IMP imp = [em methodForSelector:sel];          // 두번째 방법은 경고가 뜨지 않지만 너무 길다.
		//	void (*func)(id, SEL) = (void *)imp;
		//	func(em, sel);


		((void (*)(id, SEL))[em methodForSelector:sel])(em, sel);     // 세번째 방법은 한줄로 줄였다.
		

	}


	WSBoss *theBoss = [[WSBoss alloc] init];
	WSEmployee *aWorker = [[WSEmployee alloc] init];
	theBoss.worker = aWorker;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

	[theBoss performSelector:@selector(completeWork)];
	[theBoss performSelector:@selector(completeWorkForMe:) withObject:self];

#pragma clang diagnostic pop
//	[theBoss performSelector:@selector(doMoreStuffWithMe:andMe:)
//				  withObject:self
//				  withObject:self];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
