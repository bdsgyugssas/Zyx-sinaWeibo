//
//  EmotionButton.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/18.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "EmotionButton.h"
#import "Emotion.h"

@implementation EmotionButton

-(void)setEmotion:(Emotion *)emotion
{
    _emotion=emotion;
    
    if (emotion.chs) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }else {
        NSString *str=[emotion.code emoji];
        [self setTitle:str forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont systemFontOfSize:32];
    }

}

@end
