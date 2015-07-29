//
//  WLServerClient.m
//  WorldList
//
//  Created by Artem Podustov on 7/29/15.
//  Copyright (c) 2015 OLEArt. All rights reserved.
//

#import "WLServerClient.h"
#import <UIKit/UIKit.h>
#import "WLWorld.h"

static NSString *serverPath = @"http://backend1.lordsandknights.com/XYRALITY/WebObjects/BKLoginServer.woa/wa/worlds";

@implementation WLServerClient

+ (instancetype)sharedInstance {
    static WLServerClient *client = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        client = [WLServerClient new];
    });
    
    return client;
}

- (void)loginWith:(NSString *)login andPassword:(NSString *)password callback:(void (^)(NSArray *, NSError *))callback {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *deviceType = [NSString stringWithFormat:@"%@ - %@ %@", [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
    NSString *deviceID = [[NSUUID UUID] UUIDString];
    NSString *postBody = [NSString stringWithFormat:@"login=%@&password=%@&deviceType=%@&deviceId=%@", login, password, deviceType, deviceID];
    
    NSData *postData = [postBody dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:serverPath]];
    urlRequest.HTTPMethod = @"POST";
    urlRequest.HTTPBody = postData;
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    NSOperationQueue *q = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:q completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSError *error = nil;
        NSPropertyListFormat plistFormat;
        
        NSDictionary *responseDictionary = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:&plistFormat error:&error];

        NSMutableArray *worlds = [NSMutableArray array];
        
        if (responseDictionary[@"clientCommand"]) {
            
            connectionError = [NSError errorWithDomain:@"WL.connection" code:1000 userInfo:@{@"info": responseDictionary[@"clientCommand"][@"message"]}];
        }
        else {
        
        
            for (NSDictionary *worldD in responseDictionary[@"allAvailableWorlds"]) {
                WLWorld *world = [WLWorld new];
                world.name = worldD[@"name"];
                world.itemId = [worldD[@"id"] integerValue];
                world.language = worldD[@"language"];
                world.country = worldD[@"country"];
                world.mapURL = worldD[@"mapURL"];
                world.URL = worldD[@"url"];
                world.worldStatus = worldD[@"worldStatus"][@"description"];
                world.worldStatusId = [worldD[@"worldStatus"][@"id"] integerValue];
                
                [worlds addObject:world];
            }

        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callback([worlds copy], connectionError);
        });
    }];
}

@end
