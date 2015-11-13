//
//  MenuView.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/11.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuView;

@protocol MenuViewDelegate <NSObject>

-(void)menuViewDidMiss:(MenuView *)menuView;

@end

@interface MenuView : UIView

+(instancetype)menu;

@property (strong, nonatomic) UIViewController *ContentController;

@property (weak, nonatomic) id <MenuViewDelegate> delegate;

-(void)showfrom:(UIButton *)from;

@end
