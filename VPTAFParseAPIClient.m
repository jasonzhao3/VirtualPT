//
//  VPTAFParseAPIClient.m
//  VirtualPT
//
//  Created by Jason Zhao on 5/9/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "VPTAFParseAPIClient.h"
#import "AFJSONRequestOperation.h"


static NSString * const VPTParseAPIBaseURLString = @"https://api.parse.com/1/";

static NSString * const VPTParseAPIApplicationId = @"L6SLBxrQtNVjvdO8TCaYH7rpMHStR832rJoTloW0";
static NSString * const VPTParseAPIKey = @"NosuwaRbR1wFhGdK4jpptTEcJTjbDMaFfDIpoGNO";

@implementation VPTAFParseAPIClient
+ (VPTAFParseAPIClient *)sharedClient {
    static VPTAFParseAPIClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[VPTAFParseAPIClient alloc] initWithBaseURL:[NSURL URLWithString:VPTParseAPIBaseURLString]];
    });
    
    return sharedClient;
}


- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setParameterEncoding:AFJSONParameterEncoding];
        [self setDefaultHeader:@"X-Parse-Application-Id" value:VPTParseAPIApplicationId];
        [self setDefaultHeader:@"X-Parse-REST-API-Key" value:VPTParseAPIKey];
    }
    
    return self;
    
}

- (NSMutableURLRequest *)GETRequestForClass:(NSString *)className parameters:(NSDictionary *)parameters {
    NSMutableURLRequest *request = nil;
    request = [self requestWithMethod:@"GET" path:[NSString stringWithFormat:@"classes/%@", className] parameters:parameters];
    return request;
}

- (NSMutableURLRequest *)GETRequestForAllRecordsOfClass:(NSString *)className updatedAfterDate:(NSDate *)updatedDate {
    NSMutableURLRequest *request = nil;
    NSDictionary *parameters = nil;
    if (updatedDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.'999Z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        
        NSString *jsonString = [NSString
                                stringWithFormat:@"{\"updatedAt\":{\"$gte\":{\"__type\":\"Date\",\"iso\":\"%@\"}}}",
                                [dateFormatter stringFromDate:updatedDate]];
        
        parameters = [NSDictionary dictionaryWithObject:jsonString forKey:@"where"];
    }
    
    request = [self GETRequestForClass:className parameters:parameters];
    return request;
}

@end
