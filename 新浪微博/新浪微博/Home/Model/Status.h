//
//  Status.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/13.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface Status : NSObject

/**  用户发的微博内容  */
@property (copy,nonatomic) NSString *text;
/**  发微博的用户  */
@property (strong, nonatomic) User *user;
/**  微博的id  */
@property (copy,nonatomic) NSString *idstr;
/**  微博的创作时间  */
@property (copy,nonatomic) NSString *created_at;
/**  微博的来源  */
@property (copy,nonatomic) NSString *source;
/**  转发数  */
@property (assign, nonatomic) int reposts_count;
/**  评论数  */
@property (assign, nonatomic) int comments_count;
/**  表态数  */
@property (assign, nonatomic) int attitudes_count;
/**  微博的配图  */
@property (strong,nonatomic) NSArray *pic_urls;
/**  转发的微博  */
@property (strong,nonatomic) Status *retweeted_status;
@end
