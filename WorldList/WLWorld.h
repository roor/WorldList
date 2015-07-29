//
//  WLWorld.h
//  WorldList
//
//  Created by Artem Podustov on 7/28/15.
//  Copyright (c) 2015 OLEArt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLWorld : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *mapURL;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *language;
@property (nonatomic) NSInteger itemId;
@property (strong, nonatomic) NSString *URL;
@property (nonatomic) NSInteger worldStatusId;
@property (strong, nonatomic) NSString *worldStatus;

@end
