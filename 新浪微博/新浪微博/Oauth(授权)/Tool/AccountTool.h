//
//  AccountTool.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/12.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Account;
@interface AccountTool : NSObject
/**
 *  存储账号
 */
+(void)saveAccount:(Account *)account;
/**
 *  获得账号
 *
 *  @return 账号（如果账号过期，返回nil）
 */
+(Account *)account;
@end
