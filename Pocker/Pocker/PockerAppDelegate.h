//
//  PockerAppDelegate.h
//  Pocker
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PockerAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic,retain) UITabBarController *tabbarController;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
