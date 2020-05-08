//021 2321 3946
//  FileOperation.h
//  TLove
//
//  Created by Hou Yong on 12-12-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileOperation : NSObject

+(NSArray*)readOperate:(NSString *)afilename;
+(void)writeOperate:(NSMutableArray *)array filename:(NSString *)afilename;
+(NSString *)readResources:(NSString *)resourcename;
+ (NSString *)stringWithPhoneString:(NSString *)phone;
/**
 isValidatePhone手机号
 */
+ (BOOL)isValidatePhone:(NSString *)phone;
@end
