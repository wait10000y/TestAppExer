//
//  LPHTTPClient.h
//  Anagram-Solver
//
//  Created by Leonardo Parro Jr on 4/21/13.
//  Copyright (c) 2013 Leonardo Parro Jr. All rights reserved.
//

#import "AFHTTPClient.h"

@interface LPHTTPClient : AFHTTPClient

+ (LPHTTPClient *)sharedClient;
@end
