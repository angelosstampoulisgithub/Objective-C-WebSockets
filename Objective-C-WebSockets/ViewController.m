//
//  ViewController.m
//  Objective-C-WebSockets
//
//  Created by Angelos Staboulis on 18/11/24.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"WebSocket Test"];
    _message = @"";
    _websocket = [[WebSockets alloc] init];
    _messages = [NSMutableArray array];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

}


- (IBAction)btnSendMessage:(id)sender {
    [self.websocket sendMessage:[_txtMessage text]];
       // Assuming readMessage is a synchronous call for simplicity
    [_websocket readMessageWithCompletion:^(NSString * _Nonnull message) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.messages addObject:message];
            [self.tableView reloadData];
        });
            
    }];
  
}

- (IBAction)btnConnect:(id)sender {
    [self.websocket connect];
    [_websocket readMessageWithCompletion:^(NSString * _Nonnull message) {
        NSLog(@"connect message=%@",message);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.messages[indexPath.row];
    return cell;
}

- (IBAction)btnClose:(id)sender {
    [self.websocket close];
}
@end
