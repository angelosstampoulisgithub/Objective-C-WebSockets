//
//  ViewController.h
//  Objective-C-WebSockets
//
//  Created by Angelos Staboulis on 18/11/24.
//

#import <UIKit/UIKit.h>
#import "WebSockets.h"
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) WebSockets *websocket;
@property (nonatomic, strong) NSMutableArray<NSString *> *messages;
@property (weak, nonatomic) IBOutlet UITextField *txtMessage;
- (IBAction)btnConnect:(id)sender;

- (IBAction)btnSendMessage:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)btnClose:(id)sender;

@end

