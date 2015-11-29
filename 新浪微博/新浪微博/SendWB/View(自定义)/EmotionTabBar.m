//
//  EmotionTabBar.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/17.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "EmotionTabBar.h"

@interface EmotionTabBar ()

@property (strong, nonatomic) UIButton *selectButton;


@end

@implementation EmotionTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self setButtonWithTitle:@"最近"type:EmotionTabBarButtonRecent];
        [self setButtonWithTitle:@"默认"type:EmotionTabBarButtonDefault];
        [self setButtonWithTitle:@"emoji"type:EmotionTabBarButtonEmoji];
        [self setButtonWithTitle:@"浪小花"type:EmotionTabBarButtonLXH];

    }
    return self;
    
}
-(void)setButtonWithTitle:(NSString *)title type:(EmotionTabBarButtonType)type
{
    UIButton *button=[[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    button.tag=type;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];

}

-(void)setDelegate:(id<EmotionTabBarDelegate>)delegate
{
    _delegate=delegate;
    
    [self buttonClick:(UIButton *)[self viewWithTag:EmotionTabBarButtonDefault]];
}

-(void)buttonClick:(UIButton *)button
{
    self.selectButton.selected=NO;
    button.selected=YES;
    self.selectButton=button;
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:selectedButtonOfType:)]) {
        [self.delegate emotionTabBar:self selectedButtonOfType:button.tag];
    }
    

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    int count=self.subviews.count;
    CGFloat btnW=self.bounds.size.width/count;
    
    for (int i=0; i<count; i++) {
        UIButton *button=self.subviews[i];
        CGFloat x=i*btnW;
        CGFloat y=0;
        CGFloat w=btnW;
        CGFloat h=self.height;
        button.frame=CGRectMake(x, y, w, h);
    }
}
@end
