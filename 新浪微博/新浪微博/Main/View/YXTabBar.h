//
//  YXTabBar.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/11.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXTabBar;

@protocol YXTabBarDelegate <UITabBarDelegate>

-(void)tabBardidClickPlusButton:(YXTabBar *)tabBar;

@end

@interface YXTabBar : UITabBar
@property (weak, nonatomic) id <YXTabBarDelegate> delegate;
@end
