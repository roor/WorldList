//
//  WLLoginViewController.h
//  WorldList
//
//  Created by Artem Podustov on 7/28/15.
//  Copyright (c) 2015 OLEArt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLLoginViewController;

@protocol WLLoginViewControllerDelegate <NSObject>

- (void)loginDidClicked:(WLLoginViewController *)loginViewController withLogin:(NSString *)login andPassword:(NSString *)password;

@end

@interface WLLoginViewController : UIViewController

@property (weak, nonatomic) id <WLLoginViewControllerDelegate> delegate;

@end
