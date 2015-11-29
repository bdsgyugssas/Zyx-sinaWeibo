//
//  NavigationController.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/11.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "NavigationController.h"
#import "UIBarButtonItem+Extension.h"
@interface NavigationController() <UIActionSheetDelegate>

@end

@implementation NavigationController

+(void)initialize
{
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    NSMutableDictionary *normalTextAttributes=[NSMutableDictionary dictionary];
    normalTextAttributes[NSForegroundColorAttributeName]=[UIColor orangeColor];
    normalTextAttributes[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
    
    NSMutableDictionary *disableTextAttributes=[NSMutableDictionary dictionary];
    disableTextAttributes[NSForegroundColorAttributeName]=[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.3];
    disableTextAttributes[NSForegroundColorAttributeName]=[UIColor blackColor];

    disableTextAttributes[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:disableTextAttributes forState:UIControlStateDisabled];

    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {
        
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem itemwithImage:@"navigationbar_back" highlightedImage:@"navigationbar_back_highlighted" action:@selector(back) target:self];
        viewController.navigationItem.rightBarButtonItem=[UIBarButtonItem itemwithImage:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted" action:@selector(more) target:self];
    }
    
     [super pushViewController:viewController animated:YES];
}


#pragma mark --more
-(void)more
{
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"刷新",@"返回主页",nil];
    [sheet showInView:self.view];
}
#pragma mark --back
-(void)back
{
    [self popViewControllerAnimated:YES];
    
}
#pragma mark --UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            NSLog(@"刷新");
            break;
        case 1:
            [self popToRootViewControllerAnimated:YES];
            break;
        default:
            break;
    }

}
@end
