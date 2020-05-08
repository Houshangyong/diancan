//
//  MTLinkUrl.m
//  MTGJ
//
//  Created by Apple on 15/3/24.
//  Copyright (c) 2015年 MallTang. All rights reserved.
//

#import "MTLinkUrl.h"
#import <CommonCrypto/CommonHMAC.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import <arpa/inet.h>
@implementation MTLinkUrl
/**
 * 处理点击链接
 *
 * @param linkUrl
 */
+ (NSMutableArray*)arrayWithLinkUrlString:(NSString*)linkUrl;
{
    //app://
    NSArray *components;
    if ([linkUrl hasPrefix:@"tel://"])
    {
        NSString *infoString = [[linkUrl mutableCopy] substringFromIndex:[@"getmagazinepoint://" length]];
        NSArray *array = [infoString componentsSeparatedByString:@"?"];
        components = [[array objectAtIndex:1] componentsSeparatedByString:@"="];
    }else if ([linkUrl hasPrefix:@"toast://"])
    {
        NSString *infoString = [[linkUrl mutableCopy] substringFromIndex:[@"toast://" length]];
        NSArray *array = [infoString componentsSeparatedByString:@"?"];
        components = [[array objectAtIndex:1] componentsSeparatedByString:@"="];    }
    else if ([linkUrl hasPrefix:@"activity://"])
    {
        NSString *infoString = [[linkUrl mutableCopy] substringFromIndex:[@"activity://" length]];
        NSArray *array = [infoString componentsSeparatedByString:@"?"];
        components = [[array objectAtIndex:1] componentsSeparatedByString:@"="];
        
    }else if ([linkUrl hasPrefix:@"http://"])
    {
      components =  [NSArray arrayWithObject:linkUrl];
    }
    else
    {
        NSString *infoString = [[linkUrl mutableCopy] substringFromIndex:[@"app://" length]];
        NSArray *array = [infoString componentsSeparatedByString:@"?"];
        components = [[array objectAtIndex:1] componentsSeparatedByString:@"="];    }

   return [NSMutableArray arrayWithArray:components];
}
+(BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}
@end
