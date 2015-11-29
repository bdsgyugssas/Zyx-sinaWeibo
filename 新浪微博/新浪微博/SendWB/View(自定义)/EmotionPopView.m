//
//  EmotionPopView.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/18.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "EmotionPopView.h"
#import "EmotionButton.h"
@interface EmotionPopView ()

@property (weak, nonatomic) IBOutlet EmotionButton *emotionButton;
@end

@implementation EmotionPopView

+(EmotionPopView *)emotionPopView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"EmotionPopView" owner:nil options:nil] lastObject];
}

-(void)setEmotion:(Emotion *)emotion
{
    _emotion=emotion;
    self.emotionButton.emotion=emotion;
    
}
@end
