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
#import <objc/runtime.h>

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
+(NSDictionary*)getObjectData:(id)obj

{
    
    NSMutableDictionary
    *dic = [NSMutableDictionary dictionary];
    
    unsigned
    int propsCount;
    
    objc_property_t
    *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int
        i = 0;i < propsCount; i++)
        
    {
        
        objc_property_t
        prop = props[i];
        
        
        
        NSString
        *propName = [NSString stringWithUTF8String:property_getName(prop)];
        
        id
        value = [obj valueForKey:propName];
        
        if(value
           == nil)
            
        {
            
            value
            = [NSNull null];
            
        }
        
        else
            
        {
            
            value
            = [self getObjectInternal:value];
            
        }
        
        [dic
         setObject:value forKey:propName];
        
    }
    
    return
    
    dic;
    
}

+(id)getObjectInternal:(id)obj

{
    
    if([obj
        isKindOfClass:[NSString class]]
       
       ||
       [obj isKindOfClass:[NSNumber class]]
       
       ||
       [obj isKindOfClass:[NSNull class]])
        
    {
        
        return
        
        obj;
        
    }
    
    
    
    if([obj
        isKindOfClass:[NSArray class]])
        
    {
        
        NSArray
        *objarr = obj;
        
        NSMutableArray
        *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int
            i = 0;i < objarr.count; i++)
            
        {
            
            [arr
             setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
            
        }
        
        return
        
        arr;
        
    }
    
    
    
    if([obj
        isKindOfClass:[NSDictionary class]])
        
    {
        
        NSDictionary
        *objdic = obj;
        
        NSMutableDictionary
        *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString
            *key in
            
            objdic.allKeys)
            
        {
            
            [dic
             setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
            
        }
        
        return
        
        dic;
        
    }
    
    return
    
    [self getObjectData:obj];
    
}
@end
