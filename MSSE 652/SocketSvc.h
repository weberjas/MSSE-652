//
//  SocketSvc.h
//  MSSE 652
//
//  Created by Jason Weber on 4/16/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SocketSvc : NSObject <NSStreamDelegate>

@property UITextView *outputTextView;

- (void) connect: (NSString *) msg;
- (void) send: (NSString *)msg;
- (NSString *) retrieve;
- (void) disconnect;

@end
