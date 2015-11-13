//
//  AccountTool.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/12.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "AccountTool.h"
#import "Account.h"

#define accountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
@implementation AccountTool


+(void)saveAccount:(Account *)account
{

    [NSKeyedArchiver archiveRootObject:account toFile:accountPath];
}

+(Account *)account
{
   
    Account *account=[NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
    
    NSDate *dateNow=[NSDate date];
    
    NSDate *dataFin=[account.created_time dateByAddingTimeInterval:[account.expires_in longLongValue]];
    /**
     *  NSOrderedAscending = -1L, 
     *  NSOrderedSame,
     *  NSOrderedDescending
     */
    NSComparisonResult result=[dateNow compare:dataFin];
    
    if (result==NSOrderedAscending) {
        return account;
    }else{
        return nil;
    }
    
}
@end
