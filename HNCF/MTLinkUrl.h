//
//  MTLinkUrl.h
//  MTGJ
//
//  Created by Apple on 15/3/24.
//  Copyright (c) 2015年 MallTang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTLinkUrl : NSObject
//
+ (NSMutableArray*)arrayWithLinkUrlString:(NSString*)linkUrl;
+(BOOL) connectedToNetwork;

@end