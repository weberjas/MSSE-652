//
//  SocketSvc.m
//  MSSE 652
//
//  Created by Jason Weber on 4/16/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import "SocketSvc.h"

@implementation SocketSvc

NSInputStream *inputStream;
NSOutputStream *outputStream;


- (void) connect: (NSString *) msg {
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    //CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"www.regisscis.net", 8080, &readStream, &writeStream);
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"localhost", 80, &readStream, &writeStream);
    
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream open];
    [outputStream open];
    
    NSData *data = [[NSData alloc] initWithData:[msg dataUsingEncoding:NSASCIIStringEncoding]];
    
    [outputStream write:[data bytes] maxLength:[data length]];
    
    
}


- (void) send: (NSString *)msg {
    
    NSData *data = [[NSData alloc] initWithData:[msg dataUsingEncoding:NSASCIIStringEncoding]];
    
    [outputStream write:[data bytes] maxLength:[data length]];
}

- (NSString *) retrieve {
    
    uint8_t buffer[1024];
    int len=0;
    NSString *outputMessage;
    
    while ([inputStream hasBytesAvailable]) {
        len = (int)[inputStream read:buffer maxLength:sizeof(buffer)];
        if (len > 0) {
            NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
            if (output != nil) {
                outputMessage = output;
            }
        }
    }
    return outputMessage;
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
    switch (streamEvent) {
            
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
            
        case NSStreamEventHasBytesAvailable:
            
            if (theStream == inputStream) {
                
                uint8_t buffer[1024];
                int len;
                
                while ([inputStream hasBytesAvailable]) {
                    len = (int)[inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        
                        if (nil != output) {
                            self.outputTextView.text = [self.outputTextView.text stringByAppendingString:output];
                            NSLog(@"server said: %@", output);
                        }
                    }
                }
            }
            break;
            
        case NSStreamEventErrorOccurred:
            NSLog(@"Can not connect to the host!");
            break;
            
        case NSStreamEventEndEncountered:
            break;
            
        default:
            NSLog(@"Unknown event");
    }
    
}

- (void) disconnect {
    
    [inputStream close];
    [outputStream close];
    
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream setDelegate:nil];
    [outputStream setDelegate:nil];
    
    inputStream = nil;
    outputStream = nil;
    
}

@end
