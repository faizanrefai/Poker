//
//  PockerAppDelegate.m
//  Pocker
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import "PockerAppDelegate.h"
#import "News.h"
#import "onIphone.h"
#import "Hint.h"
#import "Config.h"
#import "AffilateProgramme.h"
#import "Tournaments.h"
#import "PlyerState.h"

@implementation PockerAppDelegate


@synthesize window=_window;
@synthesize tabbarController;
@synthesize navigationController=_navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    
    
    
    
    UIViewController *viewController1 = [[[News alloc] initWithNibName:@"News" bundle:nil] autorelease];
    UIViewController *viewController2 = [[[Hint alloc] initWithNibName:@"Hint" bundle:nil] autorelease];
    UIViewController *viewController3 = [[[onIphone alloc] initWithNibName:@"onIphone" bundle:nil] autorelease];
    UIViewController *viewController4 = [[[AffilateProgramme alloc] initWithNibName:@"AffilateProgramme" bundle:nil] autorelease];
    UIViewController *viewController5 = [[[Config alloc] initWithNibName:@"Config" bundle:nil] autorelease];
 //   UIViewController *viewController6 = [[[PlyerState alloc] initWithNibName:@"PlyerState" bundle:nil] autorelease];
 //   UIViewController *viewController7 = [[[Tournaments alloc] initWithNibName:@"Tournaments" bundle:nil] autorelease];
    
    
    UINavigationController *navi1=[[UINavigationController alloc]initWithRootViewController:viewController1];
    navi1.navigationBar.tintColor = [UIColor colorWithRed:11.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1];
    
    UINavigationController *navi2=[[UINavigationController alloc]initWithRootViewController:viewController2];
    navi2.navigationBar.tintColor = [UIColor colorWithRed:11.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1];

    UINavigationController *navi3=[[UINavigationController alloc]initWithRootViewController:viewController3];
    navi3.navigationBar.tintColor = [UIColor colorWithRed:11.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1];

    UINavigationController *navi4=[[UINavigationController alloc]initWithRootViewController:viewController4];
    navi4.navigationBar.tintColor = [UIColor colorWithRed:11.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1];

    UINavigationController *navi5=[[UINavigationController alloc]initWithRootViewController:viewController5];
    navi5.navigationBar.tintColor = [UIColor colorWithRed:11.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1];

 //   UINavigationController *navi6=[[UINavigationController alloc]initWithRootViewController:viewController6];
//    navi6.navigationBar.tintColor = [UIColor colorWithRed:11.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1];
//
//    UINavigationController *navi7=[[UINavigationController alloc]initWithRootViewController:viewController7];
//    navi7.navigationBar.tintColor = [UIColor colorWithRed:11.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1];

    
    
    
    navi1.tabBarItem.title = @"Noticias";
    navi1.tabBarItem.image = [UIImage imageNamed:@"news_icon.png"];
     
    navi2.tabBarItem.title = @"Dica do Dia";
    navi2.tabBarItem.image = [UIImage imageNamed:@"hint_icon.png"];
    
    navi3.tabBarItem.title = @"Pergunte ao Pro";
    navi3.tabBarItem.image = [UIImage imageNamed:@"ask_icon.png"];
  
    navi4.tabBarItem.title = @"Jogu Online";
    navi4.tabBarItem.image = [UIImage imageNamed:@"affilited_icon.png"];
   
    navi5.tabBarItem.title = @"Configuracoes";
    navi5.tabBarItem.image = [UIImage imageNamed:@"configuration_icon.png"];
   
    
//     navi6.tabBarItem.title = @"PlyerState";
//
//    navi6.tabBarItem.image = [UIImage imageNamed:@"configuration_icon.png"];
//    
//    navi7.tabBarItem.title = @"Tournaments";
//  navi7.tabBarItem.image = [UIImage imageNamed:@"configuration_icon.png"];
//    
    
    
    //   self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    
    //    self.tabBarController.tabBar 
    
    
    if ([self.tabbarController.tabBar respondsToSelector:@selector(setBackgroundImage:)])
    {
        // set it just for this instance
        //[self.tabbarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar.png"]];
        
        
        // set for all
        // [[UITabBar appearance] setBackgroundImage: ...
    }
    
    self.tabbarController = [[UITabBarController alloc]init];
    
    self.tabbarController.viewControllers = [NSArray arrayWithObjects:navi1,navi2,navi3,navi4,navi5, nil];

    if ([self.tabbarController.tabBar respondsToSelector:@selector(setTintColor:)]){
        [self.tabbarController.tabBar setTintColor: [UIColor colorWithRed:11.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1]];}

    self.tabbarController.moreNavigationController.navigationBar.tintColor = [UIColor colorWithRed:11.0/255.0 green:148.0/255.0 blue:214.0/255.0 alpha:1];
    
    UITableView *table = (UITableView*) self.tabbarController.moreNavigationController.visibleViewController.view;
    
    [table setBackgroundColor:[UIColor clearColor]];
    
    UITableView *view = (UITableView *)self.tabbarController.moreNavigationController.topViewController.view;
    
    if ([[view subviews] count]) {
        for (UITableViewCell *cell in [view visibleCells]) {
            cell.textLabel.textColor = [UIColor whiteColor];

        }
    }
    

    
    
    self.window.rootViewController = self.tabbarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
