//
//  EmotionTabBar.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/17.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionTabBar;

typedef enum {
    EmotionTabBarButtonRecent,
    EmotionTabBarButtonDefault,
    EmotionTabBarButtonEmoji,
    EmotionTabBarButtonLXH,
} EmotionTabBarButtonType ;

@protocol EmotionTabBarDelegate <NSObject>

-(void)emotionTabBar:(EmotionTabBar *)emotionTabBar selectedButtonOfType:(EmotionTabBarButtonType)type;

@end

@interface EmotionTabBar : UIView

@property (weak, nonatomic) id <EmotionTabBarDelegate> delegate;

@end
