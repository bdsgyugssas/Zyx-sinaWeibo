//
//  Account.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/12.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>

@property (copy,nonatomic) NSString *access_token;

@property (copy,nonatomic) NSString *expires_in;

@property (copy,nonatomic) NSString *uid;
/**
 *  账号获得access时间
 */
@property (strong, nonatomic) NSDate *created_time;

/** 当前账号的昵称 */
@property (strong, nonatomic) NSString *name;



+(Account *)accountWithDictionary:(NSDictionary *)dictionary;

@end
