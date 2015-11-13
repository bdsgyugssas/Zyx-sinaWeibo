//
//  Account.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/12.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "Account.h"

@implementation Account

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
    [aCoder encodeObject:self.name forKey:@"name"];

}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
    self.uid=[aDecoder decodeObjectForKey:@"uid"];
    self.access_token=[aDecoder decodeObjectForKey:@"access_token"];
    self.expires_in=[aDecoder decodeObjectForKey:@"expires_in"];
    self.created_time=[aDecoder decodeObjectForKey:@"created_time"];
    self.name=[aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

+(Account *)accountWithDictionary:(NSDictionary *)dictionary
{
    Account *account=[[Account alloc]init];
    account.uid=dictionary[@"uid"];
    account.access_token=dictionary[@"access_token"];
    account.expires_in=dictionary[@"expires_in"];
    
    NSDate *date=[NSDate date];
    account.created_time=date;
    return account;
}
@end
