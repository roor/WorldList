//
//  WLServerClient.h
//  WorldList
//
//  Created by Artem Podustov on 7/29/15.
//  Copyright (c) 2015 OLEArt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLServerClient : NSObject

+ (instancetype)sharedInstance;

- (void)loginWith:(NSString *)login andPassword:(NSString *)password callback:(void(^)(NSArray *data, NSError *error))collback;

@end
