//
//  AppDelegate.m
//  CosChat
//
//  Created by Mark on 15/4/21.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "AppDelegate.h"
#import "WKRolePickController.h"
#import "WKWelcomeController.h"
#import "WKNavigationController.h"
#import <AVOSCloud/AVOSCloud.h>
#define kAVOSAppId  @"idi55wuv2gfgvayujmujeiwar3abv1diszmip6efzcu18go1"
#define kAVOSAppKey @"idi55wuv2gfgvayujmujeiwar3abv1diszmip6efzcu18go1"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AVOSCloud setApplicationId:kAVOSAppId clientKey:kAVOSAppKey];
    // 状态栏样式
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        WKWelcomeController *welcomeController = [[WKWelcomeController alloc] init];
        self.window.rootViewController = welcomeController;
    }else{
        WKRolePickController *rolePick = [[WKRolePickController alloc] init];
        WKNavigationController *nav = [[WKNavigationController alloc] initWithRootViewController:rolePick];
        self.window.rootViewController = nav;
    }
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
