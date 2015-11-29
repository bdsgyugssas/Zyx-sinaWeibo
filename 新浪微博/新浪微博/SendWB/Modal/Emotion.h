//
//  Emotion.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/17.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emotion : NSObject
/**
 *  图片的名字
 */
@property (strong, nonatomic) NSString *png;
/**
 *  图片的汉语名字
 */
@property (strong, nonatomic) NSString *chs;
/**
 *  图片的code
 */
@property (strong, nonatomic) NSString *code;
@end
