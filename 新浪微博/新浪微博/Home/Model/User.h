//
//  User.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/13.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
/**
 *  微博用户 姓名
 */
@property (copy,nonatomic) NSString *name;
/**
 *  微博用户 头像
 */
@property (copy,nonatomic) NSString *profile_image_url;


@end
