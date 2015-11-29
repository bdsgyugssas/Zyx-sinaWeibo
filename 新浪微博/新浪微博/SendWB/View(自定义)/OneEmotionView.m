//
//  OneEmotionView.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/18.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "OneEmotionView.h"
#import "Emotion.h"
#import "EmotionPopView.h"
#import "EmotionButton.h"

#define Margin 10
#define CountOfRow 7

@interface OneEmotionView ()

@property (strong, nonatomic) EmotionPopView *emotionPopView;


@end

@implementation OneEmotionView

-(EmotionPopView *)emotionPopView
{
    if (_emotionPopView==nil) {
        _emotionPopView=[EmotionPopView emotionPopView];
    }
    return _emotionPopView;

}

-(void)setEmotions:(NSArray *)emotions
{
    _emotions=emotions;
    for (Emotion *emotion in emotions) {
        EmotionButton *button=[[EmotionButton alloc]init];
        button.emotion=emotion;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];

    }
    EmotionButton *button=[[EmotionButton alloc]init];
    [button setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:button];

}

-(void)buttonClick:(EmotionButton *)button
{

    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"selectEmotion"]=button.emotion;
    [NotificationCenter postNotificationName:@"EmotionDidSelect" object:nil userInfo:dict];
    
    if (button.emotion==nil) return;
     UIWindow *window=[[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.emotionPopView];
    
    
    CGRect frame=[button convertRect:button.bounds toView:nil];
    CGFloat centerX=button.centerX;
    CGFloat y=frame.origin.y+frame.size.height/2-self.emotionPopView.height;
    self.emotionPopView.centerX=centerX;
    self.emotionPopView.y=y;
    self.emotionPopView.emotion=button.emotion;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.emotionPopView removeFromSuperview];
    });
  
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int count=self.subviews.count;
    int rows=(count+CountOfRow-1)/CountOfRow;
    CGFloat buttonW=(self.width-2*Margin)/CountOfRow;
    CGFloat buttonH=(self.height-Margin)/rows;
    
    for (int i=0; i<count; i++) {
        UIButton *button=self.subviews[i];
        button.x=i%CountOfRow*buttonW+Margin;
        button.y=i/CountOfRow*buttonH;
        button.width=buttonW;
        button.height=buttonH;
    }

}

@end
