//
//  UIWindow+Extension.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/13.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "MainViewController.h"
#import "NewfeatureController.h"

@implementation UIWindow (Extension)

+(void)choseRootViewController
{

    NSString *lastVersion=[[NSUserDefaults standardUserDefaults]objectForKey:@"CFBundleVersion"];
    NSString *currentVersion=[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
   
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    if ([lastVersion isEqualToString:currentVersion]) {
        window.rootViewController=[[MainViewController alloc]init];
    }else{
        window.rootViewController=[[NewfeatureController alloc]init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"CFBundleVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
