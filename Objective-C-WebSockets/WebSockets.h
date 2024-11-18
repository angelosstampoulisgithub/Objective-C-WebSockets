//
//  WebSockets.h
//  Objective-C-WebSockets
//
//  Created by Angelos Staboulis on 18/11/24.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
NS_ASSUME_NONNULL_BEGIN

@interface WebSockets : NSObject
@property (nonatomic, strong) NSURLSessionWebSocketTask *webSocketTask;

- (void)connect;
- (void)close;
- (void)readMessageWithCompletion:(void (^)(NSString *webSocketMessage))completion;
- (void)sendMessage:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
