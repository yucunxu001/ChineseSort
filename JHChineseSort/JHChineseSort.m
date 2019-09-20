//
//  JHChineseSort.m
//  ChineseSortDemo
//
//  Created by lijinhai on 12/24/14.
//  Copyright (c) 2014 gaussli. All rights reserved.
//

#import "JHChineseSort.h"
#import "JHChineseInfo.h"

@implementation JHChineseSort

// 中文字符串转换成拼音
- (NSString*) chineseStringTransformPinyin: (NSString*)chineseString {
    if (chineseString == nil) {
        return nil;
    }
    // 拼音字段
    NSMutableString *tempNamePinyin = [chineseString mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)tempNamePinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)tempNamePinyin, NULL, kCFStringTransformStripDiacritics, NO);
    return tempNamePinyin.uppercaseString;
}

// 对中文字符串数组进行排序
- (NSArray*) chineseSortWithStringArray: (NSArray*)stringArray {
    if (stringArray == nil) {
        return nil;
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [stringArray count] ; i++) {
        if (![[stringArray objectAtIndex:i] isKindOfClass:[NSString class]]) {
            return nil;
        }
        NSDictionary *tempDic = [[NSDictionary alloc] initWithObjectsAndKeys:[stringArray objectAtIndex:i], @"chinese", [self chineseStringTransformPinyin:[stringArray objectAtIndex:i]], @"pinyin", nil];
        [tempArray addObject:tempDic];
    }
    // 排序
    [tempArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj1 objectForKey:@"pinyin"] compare:[obj2 objectForKey:@"pinyin"]];
    }];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (NSDictionary *tempDic in tempArray) {
        [resultArray addObject:[tempDic objectForKey:@"chinese"]];
    }
    return resultArray;
}

// 对包含中文字符串字段的字典数组进行排序
- (NSArray*) chineseSortWithDictionaryArray: (NSArray*)dictionaryArray andFieldKey: (NSString*)fieldKey {
    if (dictionaryArray == nil) {
        return nil;
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [dictionaryArray count] ; i++) {
        if (![[dictionaryArray objectAtIndex:i] isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        NSDictionary *tempDic = [[NSDictionary alloc] initWithObjectsAndKeys:[dictionaryArray objectAtIndex:i], @"info", [self chineseStringTransformPinyin:[[dictionaryArray objectAtIndex:i] objectForKey:fieldKey]], @"pinyin", nil];
        [tempArray addObject:tempDic];
    }
    // 排序
    [tempArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj1 objectForKey:@"pinyin"] compare:[obj2 objectForKey:@"pinyin"]];
    }];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (NSDictionary *tempDic in tempArray) {
        [resultArray addObject:[tempDic objectForKey:@"info"]];
    }
    return resultArray;
}
//判断是否为A-Z
- (BOOL)isLetter:(NSString *)text{
    NSString *regex =@"[A-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:text]) {
        return YES;
    }
    return NO;
}

// 对包含中文字符串字段的字典数组进行排序并分组
- (NSMutableArray*) chineseSortWithDictionaryArray: (NSArray*)dictionaryArray andPinYinKey: (NSString*)pinyinKey {
    if (dictionaryArray == nil) {
        return nil;
    }
    if (dictionaryArray.count == 0) {
        return [NSMutableArray new];
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [dictionaryArray count] ; i++) {
        if (![[dictionaryArray objectAtIndex:i] isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        NSDictionary *tempDic = [[NSDictionary alloc] initWithObjectsAndKeys:[dictionaryArray objectAtIndex:i], @"info", [self chineseStringTransformPinyin:[[dictionaryArray objectAtIndex:i] objectForKey:pinyinKey]], @"pinyin", nil];
        [tempArray addObject:tempDic];
    }
    // 排序
    [tempArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj1 objectForKey:@"pinyin"] compare:[obj2 objectForKey:@"pinyin"]];
    }];
    
    //取拼音首字母分组
    NSMutableArray *letterArr = [NSMutableArray array];
    for (NSDictionary *item in tempArray) {
        //获取拼音
        NSString *pinyin = [NSString stringWithFormat:@"%@",item[@"pinyin"]];
        //获取拼音首字母
        NSString *firstLetter = [pinyin substringToIndex:1];
        if ([self isLetter:firstLetter]) {
            if (letterArr.count == 0) {
                [letterArr addObject:firstLetter];
            } else {
                BOOL bl = [letterArr containsObject:firstLetter];
                if (!bl) {
                    [letterArr addObject:firstLetter];
                }
            }
        } else {
            if (![letterArr containsObject:@"#"]) {
                [letterArr addObject:@"#"];//添加#号，代表除A-Z之外的
            }
        }
    }
    if ([letterArr containsObject:@"#"]) {
        [letterArr removeObject:@"#"];
        [letterArr addObject:@"#"];//添加#号，代表除A-Z之外的
    }

    //根据首字母分组
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (NSString *title in letterArr) {
        
        NSMutableArray *cateArr = [[NSMutableArray alloc] init];
        NSMutableArray *removeArr = [[NSMutableArray alloc] init];
        for (NSDictionary *tempDic in tempArray) {
            NSString *pinyin = tempDic[@"pinyin"];
            NSString *first = [pinyin substringToIndex:1];
            if ([title isEqualToString:first]) {
                [cateArr addObject:[tempDic objectForKey:@"info"]];
                [removeArr addObject:tempDic];
            } else if ([title isEqualToString:@"#"]) {
                [cateArr addObject:[tempDic objectForKey:@"info"]];
                [removeArr addObject:tempDic];
            }
        }
        [tempArray removeObjectsInArray:removeArr];
        NSDictionary *newDict = @{@"title":title,@"info":cateArr};
        [resultArray addObject:newDict];
    }
    return resultArray;
}


// 对JHChineseInfo子类对象的数组进行排序
- (NSArray*) chineseSortWithObjectArray: (NSArray*)objectArray {
    if (objectArray == nil) {
        return nil;
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [objectArray count] ; i++) {
        if (![[objectArray objectAtIndex:i] isKindOfClass:[JHChineseInfo class]]) {
            return nil;
        }
        NSDictionary *tempDic = [[NSDictionary alloc] initWithObjectsAndKeys:[objectArray objectAtIndex:i], @"info", [self chineseStringTransformPinyin:((JHChineseInfo*)[objectArray objectAtIndex:i]).JHChineseString], @"pinyin", nil];
        [tempArray addObject:tempDic];
    }
    // 排序
    [tempArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj1 objectForKey:@"pinyin"] compare:[obj2 objectForKey:@"pinyin"]];
    }];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (NSDictionary *tempDic in tempArray) {
        [resultArray addObject:[tempDic objectForKey:@"info"]];
    }
    return resultArray;
}

@end
