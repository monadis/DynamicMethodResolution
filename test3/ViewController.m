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
