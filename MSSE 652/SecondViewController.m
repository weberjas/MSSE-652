//
//  SecondViewController.m
//  MSSE 652
//
//  Created by Jason Weber on 3/2/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import "SecondViewController.h"
#import "SRWebSocket.h"

@interface SecondViewController () <SRWebSocketDelegate>

@end

@implementation SecondViewController

SRWebSocket *_webSocket = nil;

/**
 * Run when the view loads
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //_webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://localhost:9000/chat"]]];
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://www.regisscis.net:80/WebSocketServer/chat"]]];
    _webSocket.delegate = self;
    
    [_webSocket open];
    NSLog(@"Socket should be open");
}

/**
 *  Run when memory warning recieved
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendMessageBtn:(id)sender {
    
    [_webSocket send:self.chatMessageText.text];
    

}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSString *incomingMessage = (NSString *)message;
    
    NSString *chatMessages = [[self.chatMessages.text stringByAppendingString:@"\n"] stringByAppendingString:incomingMessage];
    
    self.chatMessages.text = chatMessages;
}

- (void) webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"Opening Failed! : %@", error);
}

- (void) webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"Web Socket Opened!");

}

- (IBAction)sendPing:(id)sender {
    
    [_webSocket send:@"Testing"];
}
@end
