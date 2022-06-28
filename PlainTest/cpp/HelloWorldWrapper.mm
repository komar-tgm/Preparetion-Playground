//
//  HelloWorldWrapper.m
//  PlainTest
//
//  Created by Karim Omar on 14.06.22.
//

#import <Foundation/Foundation.h>
#import "HelloWorldWrapper.h"
#import "HelloWorld.hpp"
@implementation HelloWorldWrapper
- (NSString *) sayHello {
    HelloWorld helloWorld;
    std::string helloWorldMessage = helloWorld.sayHello();
    return [NSString
            stringWithCString:helloWorldMessage.c_str()
            encoding:NSUTF8StringEncoding];
}
- (NSNumber *) testNumber:(NSNumber *)nr {
    int intValue = [nr intValue];
    HelloWorld helloWorld;
    int testNumberMessage = helloWorld.testNumber(intValue);
    NSNumber *yourNumber = [NSNumber numberWithInt:testNumberMessage];
    return yourNumber;
}
@end
