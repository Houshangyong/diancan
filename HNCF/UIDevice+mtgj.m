//
//  UIDevice+mtgj.m
//  MTGJ
//
//  Created by zhouxz on 14/11/18.
//  Copyright (c) 2014年 MallTang. All rights reserved.
//

#import "UIDevice+mtgj.h"
#import <sys/utsname.h>
#import <sys/types.h>
#import <sys/sysctl.h>
#import <mach/machine.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "MJCommonHeader.h"

#define IFPGA_NAMESTRING                @"iFPGA"
#define IPHONE_1G_NAMESTRING            @"iPhone 1G"
#define IPHONE_3G_NAMESTRING            @"iPhone 3G"
#define IPHONE_3GS_NAMESTRING           @"iPhone 3GS"
#define IPHONE_4_NAMESTRING             @"iPhone 4"
#define IPHONE_4S_NAMESTRING            @"iPhone 4S"
#define IPHONE_5_NAMESTRING             @"iPhone 5"
#define IPHONE_5S_NAMESTRING            @"iPhone 5S"
#define IPHONE_6_NAMESTRING             @"iPhone 6"
#define IPHONE_6P_NAMESTRING            @"iPhone 6 Plus"

#define IPHONE_UNKNOWN_NAMESTRING       @"Unknown iPhone"

#define IPOD_1G_NAMESTRING              @"iPod touch 1G"
#define IPOD_2G_NAMESTRING              @"iPod touch 2G"
#define IPOD_3G_NAMESTRING              @"iPod touch 3G"
#define IPOD_4G_NAMESTRING              @"iPod touch 4G"
#define IPOD_5G_NAMESTRING              @"iPod touch 5G"
#define IPOD_UNKNOWN_NAMESTRING         @"Unknown iPod"

#define IPAD_1G_NAMESTRING              @"iPad 1G"
#define IPAD_2G_NAMESTRING              @"iPad 2G"
#define IPAD_3G_NAMESTRING              @"iPad 3G"
#define IPAD_4G_NAMESTRING              @"iPad 4G"
#define IPAD_UNKNOWN_NAMESTRING         @"Unknown iPad"

#define APPLETV_2G_NAMESTRING           @"Apple TV 2G"
#define APPLETV_3G_NAMESTRING           @"Apple TV 3G"
#define APPLETV_4G_NAMESTRING           @"Apple TV 4G"
#define APPLETV_UNKNOWN_NAMESTRING      @"Unknown Apple TV"

#define IOS_FAMILY_UNKNOWN_DEVICE       @"Unknown iOS device"

#define SIMULATOR_NAMESTRING            @"iPhone Simulator"
#define SIMULATOR_IPHONE_NAMESTRING     @"iPhone Simulator"
#define SIMULATOR_IPAD_NAMESTRING       @"iPad Simulator"
#define SIMULATOR_APPLETV_NAMESTRING    @"Apple TV Simulator" // :)

#define DEVICE_IDENTIFIER               @"CREATE_DEVICE_IDENTIFIER"

typedef enum {
    UIDeviceUnknown,
    
    UIDeviceSimulator,
    UIDeviceSimulatoriPhone,
    UIDeviceSimulatoriPad,
    UIDeviceSimulatorAppleTV,
    
    UIDevice1GiPhone,
    UIDevice3GiPhone,
    UIDevice3GSiPhone,
    UIDevice4iPhone,
    UIDevice4SiPhone,
    UIDevice5iPhone,
    UIDevice5SiPhone,
    UIDevice6iPhone,
    UIDevice6PiPhone,
    
    UIDevice1GiPod,
    UIDevice2GiPod,
    UIDevice3GiPod,
    UIDevice4GiPod,
    UIDevice5GiPod,
    
    UIDevice1GiPad,
    UIDevice2GiPad,
    UIDevice3GiPad,
    UIDevice4GiPad,
    
    UIDeviceAppleTV2,
    UIDeviceAppleTV3,
    UIDeviceAppleTV4,
    
    UIDeviceUnknowniPhone,
    UIDeviceUnknowniPod,
    UIDeviceUnknowniPad,
    UIDeviceUnknownAppleTV,
    UIDeviceIFPGA,
    
} UIDevicePlatform;

@implementation UIDevice (mtgj)

- (NSString *)mtgj_UUID {
    
    NSString *uuid;
    if (MT_SYSTEM_VERSION_LESS_THAN(@"6") || ![[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
        uuid = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidObject));
        CFRelease(uuidObject);
    } else {
        uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    
    return uuid;
}

- (NSString *)mtgj_platform {
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    return [self platformString:platform];
}

- (NSString*)platformString:(NSString *)oriPlatforString
{
    switch ([self platformType:oriPlatforString]) {
        case UIDevice1GiPhone: return IPHONE_1G_NAMESTRING;
        case UIDevice3GiPhone: return IPHONE_3G_NAMESTRING;
        case UIDevice3GSiPhone: return IPHONE_3GS_NAMESTRING;
        case UIDevice4iPhone: return IPHONE_4_NAMESTRING;
        case UIDevice4SiPhone: return IPHONE_4S_NAMESTRING;
        case UIDevice5iPhone: return IPHONE_5_NAMESTRING;
        case UIDevice5SiPhone: return IPHONE_5S_NAMESTRING;
        case UIDevice6iPhone: return IPHONE_6_NAMESTRING;
        case UIDevice6PiPhone: return IPHONE_6P_NAMESTRING;
        case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
            
        case UIDevice1GiPod: return IPOD_1G_NAMESTRING;
        case UIDevice2GiPod: return IPOD_2G_NAMESTRING;
        case UIDevice3GiPod: return IPOD_3G_NAMESTRING;
        case UIDevice4GiPod: return IPOD_4G_NAMESTRING;
        case UIDevice5GiPod : return IPOD_5G_NAMESTRING;
        case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
            
        case UIDevice1GiPad : return IPAD_1G_NAMESTRING;
        case UIDevice2GiPad : return IPAD_2G_NAMESTRING;
        case UIDevice3GiPad : return IPAD_3G_NAMESTRING;
        case UIDevice4GiPad : return IPAD_4G_NAMESTRING;
        case UIDeviceUnknowniPad : return IPAD_UNKNOWN_NAMESTRING;
            
        case UIDeviceAppleTV2 : return APPLETV_2G_NAMESTRING;
        case UIDeviceAppleTV3 : return APPLETV_3G_NAMESTRING;
        case UIDeviceAppleTV4 : return APPLETV_4G_NAMESTRING;
        case UIDeviceUnknownAppleTV: return APPLETV_UNKNOWN_NAMESTRING;
            
        case UIDeviceSimulator: return SIMULATOR_NAMESTRING;
        case UIDeviceSimulatoriPhone: return SIMULATOR_IPHONE_NAMESTRING;
        case UIDeviceSimulatoriPad: return SIMULATOR_IPAD_NAMESTRING;
        case UIDeviceSimulatorAppleTV: return SIMULATOR_APPLETV_NAMESTRING;
            
        case UIDeviceIFPGA: return IFPGA_NAMESTRING;
            
        default: return IOS_FAMILY_UNKNOWN_DEVICE;
    }
}

- (NSUInteger)platformType:(NSString *)oriPlatforString
{
    // The ever mysterious iFPGA
    if ([oriPlatforString isEqualToString:@"iFPGA"])        return UIDeviceIFPGA;
    
    // iPhone
    if ([oriPlatforString isEqualToString:@"iPhone1,1"])    return UIDevice1GiPhone;
    if ([oriPlatforString isEqualToString:@"iPhone1,2"])    return UIDevice3GiPhone;
    if ([oriPlatforString hasPrefix:@"iPhone2"])            return UIDevice3GSiPhone;
    if ([oriPlatforString hasPrefix:@"iPhone3"])            return UIDevice4iPhone;
    if ([oriPlatforString hasPrefix:@"iPhone4"])            return UIDevice4SiPhone;
    if ([oriPlatforString hasPrefix:@"iPhone5"])            return UIDevice5iPhone;
    if ([oriPlatforString hasPrefix:@"iPhone6,2"])          return UIDevice5SiPhone;
    if ([oriPlatforString isEqualToString:@"iPhone7,1"])    return
         UIDevice6iPhone;
    if ([oriPlatforString isEqualToString:@"iPhone7,2"])    return
         UIDevice6PiPhone;
    
    // iPod
    if ([oriPlatforString hasPrefix:@"iPod1"])              return UIDevice1GiPod;
    if ([oriPlatforString hasPrefix:@"iPod2"])              return UIDevice2GiPod;
    if ([oriPlatforString hasPrefix:@"iPod3"])              return UIDevice3GiPod;
    if ([oriPlatforString hasPrefix:@"iPod4"])              return UIDevice4GiPod;
    if ([oriPlatforString hasPrefix:@"iPod5"])              return UIDevice5GiPod;
    
    // iPad
    if ([oriPlatforString hasPrefix:@"iPad1"])              return UIDevice1GiPad;
    if ([oriPlatforString hasPrefix:@"iPad2"])              return UIDevice2GiPad;
    if ([oriPlatforString hasPrefix:@"iPad3"])              return UIDevice3GiPad;
    if ([oriPlatforString hasPrefix:@"iPad4"])              return UIDevice4GiPad;
    
    // Apple TV
    if ([oriPlatforString hasPrefix:@"AppleTV2"])           return UIDeviceAppleTV2;
    if ([oriPlatforString hasPrefix:@"AppleTV3"])           return UIDeviceAppleTV3;
    
    if ([oriPlatforString hasPrefix:@"iPhone"])             return UIDeviceUnknowniPhone;
    if ([oriPlatforString hasPrefix:@"iPod"])               return UIDeviceUnknowniPod;
    if ([oriPlatforString hasPrefix:@"iPad"])               return UIDeviceUnknowniPad;
    if ([oriPlatforString hasPrefix:@"AppleTV"])            return UIDeviceUnknownAppleTV;
    
    // Simulator thanks Jordan Breeding
    if ([oriPlatforString hasSuffix:@"86"] || [oriPlatforString isEqual:@"x86_64"]) {
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 768;
        return smallerScreen ? UIDeviceSimulatoriPhone : UIDeviceSimulatoriPad;
    }
    
    return UIDeviceUnknown;
}

@end
