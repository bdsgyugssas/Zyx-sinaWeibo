//
//  StatusTool.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/16.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusTool : NSObject

+(NSArray *)statusWithParameter:(NSDictionary *)parameter;
+(void)saveStatus:(NSArray *)status;

@end
