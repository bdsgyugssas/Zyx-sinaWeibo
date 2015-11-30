//
//  SendToolBar.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/17.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "SendToolBar.h"

@interface SendToolBar ()

@property (weak, nonatomic) UIButton *emotionButton;

@end

@implementation SendToolBar

-(void)setShowEmotionButton:(BOOL)showEmotionButton
{
    _showEmotionButton=showEmotionButton;
    
    if (showEmotionButton) {
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }else{
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }

}

-(instancetype)initWithFrame:(CGRect)frame
{

    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self setbtnWithimage:@"compose_camerabutton_background" highlightimage:@"compose_camerabutton_background_highlighted" type:sendToolBarButtonItemCamera];
        
        [self setbtnWithimage:@"compose_toolbar_picture" highlightimage:@"compose_toolbar_picture_highlighted"type:sendToolBarButtonItemPicture];
        
        [self setbtnWithimage:@"compose_mentionbutton_background" highlightimage:@"compose_mentionbutton_background_highlighted"type:sendToolBarButtonItemMention];
        
        [self setbtnWithimage:@"compose_keyboardbutton_background" highlightimage:@"compose_keyboardbutton_background_highlighted"type:sendToolBarButtonItemKeyboard];
        
        self.emotionButton=[self setbtnWithimage:@"compose_emoticonbutton_background" highlightimage:@"compose_emoticonbutton_background_highlighted"type:sendToolBarButtonItemEmoticon];
        
    }
    return self;
    
}

-(UIButton *)setbtnWithimage:(NSString *)image highlightimage:(NSString *)highlightimage type:(sendToolBarButtonItemType) type
{
    UIButton *btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightimage] forState:UIControlStateHighlighted];
    btn.tag=type;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
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

-(void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(buttonClickOfSendToolBar:withButtonType:)]) {
        [self.delegate buttonClickOfSendToolBar:self withButtonType:(sendToolBarButtonItemType)button.tag];
    }
    
}
@end
