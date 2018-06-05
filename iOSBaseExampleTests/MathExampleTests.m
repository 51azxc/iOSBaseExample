//
//  MathExampleTests.m
//  iOSBaseExampleTests
//
//  Created by cascadeMac on 2018/6/5.
//

#import <XCTest/XCTest.h>

@interface MathExampleTests : XCTestCase

@end

@implementation MathExampleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    //
    XCTAssertEqual(pow(3, 2), 9);
    //
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
