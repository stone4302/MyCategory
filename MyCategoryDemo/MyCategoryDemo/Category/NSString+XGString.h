//
//  NSString+XGString.h
//  WeRentCar
//
//  Created by 彭丙向 on 16/3/17.
//  Copyright © 2016年 weizuche. All rights reserved.
//

//NSString的类别

#import <Foundation/Foundation.h>

@interface NSString (XGString)

+ (NSString*)xgString;

/** 判断手机号码是否合法 */
+ (BOOL)XGStringPhoneNum:(NSString *)phoneNum;

/** 汉字转拼音 */
+ (NSString *)XGStringTransform:(NSString *)chinese;

/** unicode编码转译 */
+ (NSString *)XGStringReplaceUnicode:(NSString *)unicodeStr;

/** 判断string中是否只有数字和字母 */
+ (BOOL)XGStringIsNumberOrChar:(NSString*)string;

/** 判断string中是否只有数字 */
+ (BOOL)XGStringIsNumber:(NSString*)string;

/** 身份证验证 */
+ (BOOL)XGStringIDCard:(NSString*)string;

/** 验证车牌号是否正确 */
+ (BOOL)XGStringVerifyLicense:(NSString*)licenseStr;

/** 根据系统当前时间获取一个随机值(12位) */
+ (NSString*)getCurrentTimeRandomString;

/** 获取系统当前时间,format:时间格式 */
+ (NSString*)XGStringPhoneCurrentTimeWithFormatter:(NSString*)format;

/** 判断字符串是否不为空 */
+ (BOOL)XGStringIsNotEmptyString:(NSString*)string;

/** 将毫秒数转换为年月日时分秒的时间 */
+ (NSString *)ConvertStrToTime:(NSString *)timeStr;

/** 10进制转16进制 */
+ (NSString *)hexStringFromDecString:(NSString*)decString;

/** 16进制字符串转2进制字符串 */
+ (NSString*)binStringFromHexString:(NSString*)hexStr;

/** 16进制字符串转data **/
+ (NSData *)stringToHexData:(NSString *)hexStr;

/** data转换为十六进制的string **/
+ (NSString *)hexStringFromData:(NSData *)myData;

/** 16进制字符串转换成data后按位异或 */
+ (NSString*)xorWithHexString:(NSString*)hexString range:(NSRange)range;

@end





