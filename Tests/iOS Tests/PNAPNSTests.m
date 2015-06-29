//
//  PNAPNSTests.m
//  PubNub Tests
//
//  Created by Vadim Osovets on 6/29/15.
//
//

#import <PubNub/PubNub.h>

#import "PNBasicSubscribeTestCase.h"

#import "NSString+PNTest.h"

@interface PNAPNSTests : PNBasicClientTestCase

@end

@implementation PNAPNSTests

- (void)setUp {
    [super setUp];
    
    // On Account you put there we obligatory need to enable Push Notifications
    // using PubNub Developer Console
    self.configuration = [PNConfiguration configurationWithPublishKey:@"pub-c-12b1444d-4535-4c42-a003-d509cc071e09"
                                                         subscribeKey:@"sub-c-6dc508c0-bff0-11e3-a219-02ee2ddab7fe"];
    self.configuration.uuid = @"322A70B3-F0EA-48CD-9BB0-D3F0F5DE996C";
    self.client = [PubNub clientWithConfiguration:self.configuration];
}

- (BOOL)isRecording{
    return YES;
}

#pragma mark - Tests

- (void)testAddPushOnChannels {
    
    self.testExpectation = [self expectationWithDescription:@"Add Push Expectation."];
    
    NSArray *channels = @[@"1", @"2", @"3"];
    NSString *pushKey = @"6652cff7f17536c86bc353527017741ec07a91699661abaf68c5977a83013091";
    
    NSData *pushToken = [pushKey dataFromHexString:pushKey];
    
    PNWeakify(self);
    
    [self.client addPushNotificationsOnChannels:channels
                            withDevicePushToken:pushToken
                                  andCompletion:^(PNAcknowledgmentStatus *status) {
                                      
                                      PNStrongify(self);
                                      
                                      XCTAssertNotNil(status);
                                      XCTAssertFalse(status.error);
                                      XCTAssertEqual(status.statusCode, 200, @"Response status code is not 200");
                                      
                                      [self.testExpectation fulfill];
                                  }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}

- (void)testAddPushOnNilChannels {
    
    self.testExpectation = [self expectationWithDescription:@"Add Push Expectation."];
    
    NSArray *channels = nil;
    NSString *pushKey = @"6652cff7f17536c86bc353527017741ec07a91699661abaf68c5977a83013091";
    
    NSData *pushToken = [pushKey dataFromHexString:pushKey];
    
    PNWeakify(self);
    
    [self.client addPushNotificationsOnChannels:channels
                            withDevicePushToken:pushToken
                                  andCompletion:^(PNAcknowledgmentStatus *status) {
                                      
                                      PNStrongify(self);
                                      
                                      XCTAssertNotNil(status);
                                      XCTAssertFalse(status.error);
                                      XCTAssertEqual(status.statusCode, 200, @"Response status code is not 200");
                                      
                                      [self.testExpectation fulfill];
                                  }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
    
}

- (void)testAddPushOnChannelsWithNilPushToken {
    self.testExpectation = [self expectationWithDescription:@"Add Push Expectation."];
    
    NSArray *channels = @[@"1", @"2", @"3"];
    NSData *pushToken = nil;
    
    PNWeakify(self);
    
    [self.client addPushNotificationsOnChannels:channels
                            withDevicePushToken:pushToken
                                  andCompletion:^(PNAcknowledgmentStatus *status) {
                                      
                                      PNStrongify(self);
                                      
                                      XCTAssertNotNil(status);
                                      XCTAssertFalse(status.error);
                                      XCTAssertEqual(status.statusCode, 200, @"Response status code is not 200");
                                      
                                      [self.testExpectation fulfill];
                                  }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}

/*

- (void)testAddPushOnChannelsWithNilPushToken {
    
}

- (void)addPushNotificationsOnChannels:(NSArray *)channels withDevicePushToken:(NSData *)pushToken
                         andCompletion:(PNPushNotificationsStateModificationCompletionBlock)block;


- (void)removePushNotificationsFromChannels:(NSArray *)channels
                        withDevicePushToken:(NSData *)pushToken
                              andCompletion:(PNPushNotificationsStateModificationCompletionBlock)block;


- (void)removeAllPushNotificationsFromDeviceWithPushToken:(NSData *)pushToken
                                            andCompletion:(PNPushNotificationsStateModificationCompletionBlock)block;

- (void)pushNotificationEnabledChannelsForDeviceWithPushToken:(NSData *)pushToken
                                                andCompletion:(PNPushNotificationsStateAuditCompletionBlock)block;

*/

@end
