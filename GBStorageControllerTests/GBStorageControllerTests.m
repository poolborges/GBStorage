//
//  GBStorageControllerTests.m
//  GBStorageControllerTests
//
//  Created by Luka Mirosevic on 02/12/2012.
//  Copyright (c) 2012 Goonbee. All rights reserved.
//

#import "GBStorageControllerTests.h"

#import "GBStorageController.h"

#if TARGET_OS_IPHONE
    #import "GBToolbox.h"
#else
    #import <GBToolbox/GBToolbox.h>
#endif

@implementation GBStorageControllerTests

- (void)setUp
{
    [super setUp];
    
    //make sure documents directory exists
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] withIntermediateDirectories:YES attributes:nil error:NULL];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testLibrary
{
    [_sc deletePermanently:@"dogs"];
    
    STAssertNil(_sc[@"dogs"], @"");
    
    _sc[@"dogs"] = [@[@"GSD", @"collie"] mutableCopy];
    
    STAssertEquals((NSUInteger)2, ((NSArray *)_sc[@"dogs"]).count, @"");
    STAssertEqualObjects(@"collie", _sc[@"dogs"][1], @"");
    
    [_sc[@"dogs"] addObject:@"pug"];
    
    [_sc save:@"dogs"];
    [_sc clearCacheForKey:@"dogs"];
    
    STAssertNotNil(_sc[@"dogs"], @"should reload from disk");
    STAssertEqualObjects(@"pug", _sc[@"dogs"][2], @"");
}

@end
