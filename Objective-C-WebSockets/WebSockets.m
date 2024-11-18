//
//  WebSockets.m
//  Objective-C-WebSockets
//
//  Created by Angelos Staboulis on 18/11/24.
//

#import "WebSockets.h"

@implementation WebSockets
- (void)connect {
    NSURL *url = [NSURL URLWithString:@"wss://echo.websocket.org"];
    if (!url) return;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 5;
    self.webSocketTask = [[NSURLSession sharedSession] webSocketTaskWithRequest:request];
    [self.webSocketTask resume];
}

- (void)close {
    NSData *reason = [@"Closing connection" dataUsingEncoding:NSUTF8StringEncoding];
    [self.webSocketTask cancelWithCloseCode:NSURLSessionWebSocketCloseCodeGoingAway reason:reason];
}

- (void)readMessageWithCompletion:(void (^)(NSString *webSocketMessage))completion {
  
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webSocketTask receiveMessageWithCompletionHandler:^(NSURLSessionWebSocketMessage * _Nullable message, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Failed to receive message: %@", error);
                completion(nil);
                return;
            }
            switch (message.type) {
                case NSURLSessionWebSocketMessageTypeString: {
                    NSString *text = [NSString stringWithFormat:@"%@",message.string];
                    NSLog(@"Received text message: %@", text);
                    completion(text);
                    break;
                }
                case NSURLSessionWebSocketMessageTypeData: {
                    NSData *data = message.data;
                    NSLog(@"Received binary message: %@", data);
                    completion(nil);
                    break;
                }
                default:
                    break;
            }
        }];
    });

}

- (void)sendMessage:(NSString *)message {
    NSURLSessionWebSocketMessage * webMessage = [[NSURLSessionWebSocketMessage alloc] initWithString:[NSString stringWithString:message]];
    [self.webSocketTask sendMessage:webMessage completionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"WebSocket sending error: %@", error);
        } else {
            NSLog(@"Completed successfully");
        }
    }];
}

@end
