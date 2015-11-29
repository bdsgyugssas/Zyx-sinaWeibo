//
//  EmetionAttachment.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/18.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Emotion;

@interface EmetionAttachment : NSTextAttachment 

@property (strong, nonatomic) Emotion *emotion;

@end
