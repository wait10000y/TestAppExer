//
//  LPHTTPClient.m
//  Anagram-Solver
//
//  Created by Leonardo Parro Jr on 4/21/13.
//  Copyright (c) 2013 Leonardo Parro Jr. All rights reserved.
//

#import "LPHTTPClient.h"
#import "AFHTTPRequestOperation.h"

@implementation LPHTTPClient

+ (LPHTTPClient *)sharedClient {
    static LPHTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[LPHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setParameterEncoding:AFJSONParameterEncoding];
    
    return self;
}

@end

