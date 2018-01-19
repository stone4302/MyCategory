//
//  NSString+XGString.m
//  WeRentCar
//
//  Created by 彭丙向 on 16/3/17.
//  Copyright © 2016年 weizuche. All rights reserved.
//

#import "NSString+XGString.h"
#import <UIKit/UIKit.h>

@implementation NSString (XGString)

+ (NSString *)xgString{
    return @"xgString";
}
#pragma mark - 判断手机号码是否合法
+ (BOOL)XGStringPhoneNum:(NSString *)phoneNum {
    /*
     移动号段：
     134 135 136 137 138 139 147 150 151 152 157 158 159 172 178 182 183 184 187 188
     联通号段：
     130 131 132 145 155 156 171 175 176 185 186
     电信号段：
     133 149 153 173 177 180 181 189
     虚拟运营商:
     170
     */
    NSArray *phoneNumFix = @[@"134",@"135",@"136",@"137",@"138",@"139",@"147",@"150",@"151",@"152",@"157",@"158",@"159",@"172",@"178",@"182",@"183",@"184",@"187",@"188",@"130",@"131",@"132",@"145",@"155",@"156",@"171",@"175",@"176",@"185",@"186",@"133",@"149",@"153",@"173",@"177",@"180",@"181",@"189",@"170"];
    BOOL isPhone = NO;
    if (phoneNum.length == 11) {
        for (NSString *str in phoneNumFix) {
            if ([phoneNum hasPrefix:str]) {
                isPhone = YES;
                break;
            }
        }
        if (isPhone) {
            for (int i = 3; i<phoneNum.length; i++) {
                char character = [phoneNum characterAtIndex:i];
                if (character < 48 || character > 57) {
                    isPhone = NO;
                    break;
                }
            }
        }
    } else {
        isPhone = NO;
    }
    return isPhone;
}
#pragma mark - 汉字转拼音
+ (NSString *)XGStringTransform:(NSString *)chinese{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //返回最近结果
    return pinyin;
}
#pragma mark - unicode编码转译
+ (NSString *)XGStringReplaceUnicode:(NSString *)unicodeStr
{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

#pragma mark - 判断string中是否只有数字和字母
+ (BOOL)XGStringIsNumberOrChar:(NSString*)string {
    NSString *PASSWORD = @"^[A-Za-z0-9]+$";
    
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PASSWORD];
    
    return [regextest evaluateWithObject:string];
}
#pragma mark - 判断string中是否只有数字
+ (BOOL)XGStringIsNumber:(NSString*)string {
    NSString *PASSWORD = @"^[0-9]+$";
    
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PASSWORD];
    
    return [regextest evaluateWithObject:string];
}
#pragma mark - 身份证验证
+ (BOOL)XGStringIDCard:(NSString*)string {
    NSString *PASSWORD = @"([0-9]{17}([0-9]|[xX]))|([0-9]{15})";
    
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PASSWORD];
    
    return [regextest evaluateWithObject:string];
}
#pragma mark - 验证车牌号是否正确
+ (BOOL)XGStringVerifyLicense:(NSString*)licenseStr {
    // ^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$
    NSString *PASSWORD = @"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{1}[A-Z]{1}[A-Z0-9]{5}$";
    
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PASSWORD];
    
    return [regextest evaluateWithObject:licenseStr];
}
#pragma mark - 根据系统当前时间获取一个随机值(12位)
+ (NSString*)getCurrentTimeRandomString {
    NSString *randomStr = [NSString XGStringPhoneCurrentTimeWithFormatter:@"yy-MM-dd HH:mm:ss"];
    randomStr = [[[randomStr stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@":" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    return randomStr;
}
#pragma mark - 获取系统当前时间,WithFormatter:@"yy-MM-dd HH:mm:ss"
+ (NSString*)XGStringPhoneCurrentTimeWithFormatter:(NSString*)format {
    // 时间显示的格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    formatter.dateFormat = format;
    // 当前手机系统时间
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate date]];
    return nowTimeStr;
}

#pragma mark - 判断字符串是否不为空,不为空返回YES
+ (BOOL)XGStringIsNotEmptyString:(NSString*)string{
    if ([string isKindOfClass:[NSNull class]] || [string isEqualToString:@""] || [string isEqual:[NSNull null]] || string == nil || [string isEqualToString:@"null"] || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"]) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - 将毫秒数转换为年月日时分秒的时间
+ (NSString *)ConvertStrToTime:(NSString *)timeStr
{
    long long time=[timeStr longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString*timeString=[formatter stringFromDate:d];
    return timeString;
}
#pragma mark - 10进制转16进制
+ (NSString *)hexStringFromDecString:(NSString*)decString
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    long long int tmpid = [decString longLongValue];
    for (int i =0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    NSLog(@"str(1) = %@",str);
    if (str.length >= 8) {
        str = [str substringWithRange:NSMakeRange(0, 8)];
    } else {
        int num = (int)str.length;
        for (int i=0; i<8 - num; i++) {
            str = [NSString stringWithFormat:@"0%@",str];
        }
    }
    NSLog(@"str(2) = %@",str);
    return str;
}
#pragma mark - 16进制字符串转2进制字符串
+ (NSString*)binStringFromHexString:(NSString*)hexStr {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0;i<hexStr.length;i++) {
        NSString* str = [hexStr substringWithRange:NSMakeRange(i, 1)];
        [arr addObject:[self binString:str]];;
    }
    NSString *binStr = [arr componentsJoinedByString:@""];
    NSLog(@"binStr = %@",binStr);
    return binStr;
}
+ (NSString*)binString:(NSString*)str {
    if ([str isEqualToString:@"0"]) {
        return @"0000";
    } else if ([str isEqualToString:@"1"]) {
        return @"0001";
    } else if ([str isEqualToString:@"2"]) {
        return @"0010";
    } else if ([str isEqualToString:@"3"]) {
        return @"0011";
    } else if ([str isEqualToString:@"4"]) {
        return @"0100";
    } else if ([str isEqualToString:@"5"]) {
        return @"0101";
    } else if ([str isEqualToString:@"6"]) {
        return @"0110";
    } else if ([str isEqualToString:@"7"]) {
        return @"0111";
    } else if ([str isEqualToString:@"8"]) {
        return @"1000";
    } else if ([str isEqualToString:@"9"]) {
        return @"1001";
    } else if ([str isEqualToString:@"a"]) {
        return @"1010";
    } else if ([str isEqualToString:@"b"]) {
        return @"1011";
    } else if ([str isEqualToString:@"c"]) {
        return @"1100";
    } else if ([str isEqualToString:@"d"]) {
        return @"1101";
    } else if ([str isEqualToString:@"e"]) {
        return @"1110";
    } else if ([str isEqualToString:@"f"]) {
        return @"1111";
    } else {
        return nil;
    }
}
#pragma mark - 16进制字符串转data
+ (NSData *)stringToHexData:(NSString *)hexStr
{
    unsigned long len = [hexStr length] / 2;    // Target length
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    for (i=0; i < [hexStr length] / 2; i++) {
        byte_chars[0] = [hexStr characterAtIndex:i*2];
        byte_chars[1] = [hexStr characterAtIndex:i*2+1];
        *whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    NSData *data = [NSData dataWithBytes:buf length:len];
    free( buf );
    return data;
}

#pragma mark - data转换为十六进制的string
+ (NSString *)hexStringFromData:(NSData *)myData{
    
    Byte *bytes = (Byte *)[myData bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myData length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    NSLog(@"hex = %@",hexStr);
    
    return hexStr;
}
#pragma mark - 16进制字符串转换成data后按位异或
+ (NSString*)xorWithHexString:(NSString*)hexString range:(NSRange)range {
    if (!hexString | (range.length == 0) ) {
        return nil;
    }
    NSData *hexData = [NSString stringToHexData:[hexString substringWithRange:range]];
    NSLog(@"hexData = %@",hexData);
    Byte *byte = (Byte*)hexData.bytes;
    for (int i=0; i<hexData.length - 1; i++) {
        byte[0] ^= byte[i + 1];
    }
    NSData *resultData = [NSData dataWithBytes:byte length:1];
    return [NSString hexStringFromData:resultData];
}
@end
