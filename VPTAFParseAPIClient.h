//
//  VTPAFParseAPIClient.h
//  VirtualPT
//
//  Created by Jason Zhao on 5/9/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPClient.h"

// Singleton class for AF connection
@interface VPTAFParseAPIClient : AFHTTPClient
+ (VPTAFParseAPIClient *)sharedClient;

- (NSMutableURLRequest *)GETRequestForClass:(NSString *)className parameters:(NSDictionary *)parameters;
- (NSMutableURLRequest *)GETRequestForAllRecordsOfClass:(NSString *)className updatedAfterDate:(NSDate *)updatedDate;
@end
