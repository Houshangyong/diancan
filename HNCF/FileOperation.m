//
//  FileOperation.m
//  TLove
//
//  Created by Hou Yong on 12-12-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FileOperation.h"
#import "MJProgressHUD.h"

@implementation FileOperation
//读document文件
+(NSArray*)readOperate:(NSString *)afilename//侯尚勇
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:afilename];
    
    NSMutableArray *tmparray=[[NSMutableArray alloc] initWithContentsOfFile:filename];
    return tmparray;
}
//写document文件
+(void)writeOperate:(NSMutableArray *)array filename:(NSString *)afilename//侯尚勇
{
    NSMutableArray *tmparray=[NSMutableArray arrayWithArray:array];
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:afilename];    
    [tmparray writeToFile:filename  atomically:YES];
}
//读取resource文件
+(NSString *)readResources:(NSString *)resourcename//侯尚勇
{
    NSBundle *bundel=[NSBundle mainBundle];
    NSString *filePath=[bundel pathForResource:resourcename ofType:nil];
    NSString *fileContent=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return fileContent;
}
//写入文件例子
// NSArray *temparray = [NSArray arrayWithObjects:app.accessibilityValue,app.accessibilityLabel,app.password,app.userEmail,app.pcontact, nil];
//userinfo = (NSMutableArray *)temparray;
//    [userinfo removeAllObjects];
//userinfo = nil;
//NSLog(@"userinfo%@",userinfo);
//[FileOperation writeOperate:userinfo filename:@"user.plist"];
//读取文件里子
//userinfo = (NSMutableArray *)[FileOperation readOperate:@"user.plist"];
#pragma mark
#pragma mark -手机号中间加*
+ (NSString *)stringWithPhoneString:(NSString *)phone;
{
    NSMutableString *String1 = [[NSMutableString alloc] initWithString:phone];
    [String1 replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return String1;
}
#pragma mark
#pragma mark - 利用正则表达式验证手机号合法性
+ (BOOL)isValidatePhone:(NSString *)phone
{
    if ([phone length] == 0) {
        
        
        [MJProgressHUD showHUDWithText:@"手机号码不能为空" duration:1.0];
        
        return NO;
        
    }
    
    else if ([phone length] < 11 )
    {
        
        [MJProgressHUD showHUDWithText:@"请输入11位手机号" duration:1.0];
        
        return NO;
    }else{
        
        //1[0-9]{10}
        
        //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
        
        //    NSString *regex = @"[0-9]{11}";
        
        NSString * phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
        
        BOOL isMatch = [pred evaluateWithObject:phone];
        
        
        
        if (!isMatch) {
            
            
            [MJProgressHUD showHUDWithText:@"请输入正确的手机号码" duration:1.0];
            
            return NO;
        }else{
            return YES;
            
        }
    }


}

@end
