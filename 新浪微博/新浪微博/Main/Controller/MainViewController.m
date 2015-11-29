//
//  MainViewController.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/10.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "NavigationController.h"
#import "YXTabBar.h"
#import "NewfeatureController.h"
#import "SendController.h"


@interface MainViewController ()<YXTabBarDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    HomeViewController *control1=[[HomeViewController alloc]init];
    [self addChildViewController:control1 WithTitle:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];

    
    MessageViewController *control2=[[MessageViewController alloc]init];
    [self addChildViewController:control2 WithTitle:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];

    
    DiscoverViewController *control3=[[DiscoverViewController alloc]init];
    [self addChildViewController:control3 WithTitle:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];

    
    ProfileViewController *control4=[[ProfileViewController alloc]init];
    [self addChildViewController:control4 WithTitle:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
 
    YXTabBar *tabbar=[[YXTabBar alloc]init];
    tabbar.delegate=self;
    [self setValue:tabbar forKey:@"tabBar"];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}



-(void)addChildViewController:(UIViewController *)childController WithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    NSMutableDictionary *dict1=[NSMutableDictionary dictionary];
    dict1[NSForegroundColorAttributeName]=[UIColor blackColor];
    NSMutableDictionary *dict2=[NSMutableDictionary dictionary];
    dict2[NSForegroundColorAttributeName]=[UIColor orangeColor];
    
    // childController.view.backgroundColor=RandomColor;
    childController.tabBarItem.title=title;
    childController.navigationItem.title=title;
    childController.tabBarItem.image=[UIImage imageNamed:image];
    childController.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [childController.tabBarItem setTitleTextAttributes:dict1 forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:dict2 forState:UIControlStateSelected];
    
    NavigationController *nav=[[NavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:nav];
}

#pragma mark --YXTabBarDelegate
-(void)tabBardidClickPlusButton:(YXTabBar *)tabBar
{

    SendController *contro=[[SendController alloc]init];
//    contro.view.backgroundColor=RandomColor;
    NavigationController *controller=[[NavigationController alloc]initWithRootViewController:contro];
    [self presentViewController:controller animated:YES completion:nil];
}




@end
