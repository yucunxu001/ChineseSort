//
//  MainViewController.m
//  ChineseSortDemo
//
//  Created by lijinhai on 12/24/14.
//  Copyright (c) 2014 gaussli. All rights reserved.
//

#import "MainViewController.h"
#import "JHChineseSort.h"
#import "JHChineseInfo.h"
#import "SubChineseInfo.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    JHChineseSort *chineseSort = [[JHChineseSort alloc] init];
    
    // 测试对中文字符串数组排序
//    NSArray *a1 = @[@"密码1",@"密码2",@"高由坤",@"甘传普",@"密码3",@"高磊"];
//    NSArray *newData = [chineseSort chineseSortWithStringArray:a1];
//    for (NSString *item in newData) {
//        NSLog(@"item==%@",item);
//    }
    
    
//    NSArray *letterArr = @[@"B",@"A",@"C",@"H",@"D",@"G",@"F",@"E"];
//    NSLog(@"letterArr==%@",letterArr);
//    NSArray *newFirst = [letterArr sortedArrayUsingSelector:@selector(compare:)];
//    NSLog(@"newFirst==%@",newFirst);
    
    
    // 测试对包含中文字符串字段的字典数组排序
    NSArray *a2 = @[
      @{@"name":@"密码", @"num":@"2"},
      @{@"name":@"安按", @"num":@"3"},
      @{@"name":@"搜索", @"num":@"4"},
      @{@"name":@"对对对", @"num":@"5"},
      @{@"name":@"方法", @"num":@"6"},
      @{@"name":@"刚刚", @"num":@"7"},
      
      @{@"name":@"换行", @"num":@"2"},
      @{@"name":@"解决", @"num":@"3"},
      @{@"name":@"看看", @"num":@"4"},
      @{@"name":@"流量", @"num":@"5"},
      @{@"name":@"请求", @"num":@"6"},
      @{@"name":@"问问", @"num":@"7"},
      
      @{@"name":@"嗯嗯", @"num":@"2"},
      @{@"name":@"让人", @"num":@"3"},
      @{@"name":@"天天", @"num":@"4"},
      @{@"name":@"一样", @"num":@"5"},
      @{@"name":@"uu", @"num":@"6"},
      @{@"name":@"ii", @"num":@"7"},
      
      @{@"name":@"哦哦", @"num":@"2"},
      @{@"name":@"品牌", @"num":@"3"},
      @{@"name":@"正在", @"num":@"4"},
      @{@"name":@"学习", @"num":@"5"},
      @{@"name":@"尺寸", @"num":@"6"},
      @{@"name":@"vv", @"num":@"7"},
      @{@"name":@"版本", @"num":@"2"},
      @{@"name":@"那你", @"num":@"3"},
      @{@"name":@"密码2", @"num":@"4"},
      @{@"name":@"111", @"num":@"5"},
      @{@"name":@"222", @"num":@"6"},
      @{@"name":@"333", @"num":@"7"},
      ];
//    NSLog(@"排序结果2: %@", [chineseSort chineseSortWithDictionaryArray:a2 andFieldKey:@"name"]);
    
    NSMutableArray *datas = [chineseSort chineseSortWithDictionaryArray:a2 andPinYinKey:@"name"];
    for (NSDictionary *dict in datas) {
        NSLog(@"%@",dict[@"title"]);
        for (NSDictionary *item in dict[@"info"]) {
            NSLog(@"name==%@",item[@"name"]);
        }
    }
//    NSLog(@"排序结果2: %@", );
    
    // 测试对JHChineseInfo为元素的数组排序
//    JHChineseInfo *ci1 = [[JHChineseInfo alloc] init];
//    JHChineseInfo *ci2 = [[JHChineseInfo alloc] init];
//    JHChineseInfo *ci3 = [[JHChineseInfo alloc] init];
//    JHChineseInfo *ci4 = [[JHChineseInfo alloc] init];
//    JHChineseInfo *ci5 = [[JHChineseInfo alloc] init];
//    JHChineseInfo *ci6 = [[JHChineseInfo alloc] init];
//    JHChineseInfo *ci7 = [[JHChineseInfo alloc] init];
//    JHChineseInfo *ci8 = [[JHChineseInfo alloc] init];
//    JHChineseInfo *ci9 = [[JHChineseInfo alloc] init];
//    JHChineseInfo *ci10 = [[JHChineseInfo alloc] init];
//    JHChineseInfo *ci11 = [[JHChineseInfo alloc] init];
//    ci1.JHChineseString = @"张三";
//    ci2.JHChineseString = @"李三";
//    ci3.JHChineseString = @"li三";
//    ci4.JHChineseString = @"qeri三";
//    ci5.JHChineseString = @"rei三";
//    ci6.JHChineseString = @"lbcx三";
//    ci7.JHChineseString = @"kjh三";
//    ci8.JHChineseString = @"照三";
//    ci9.JHChineseString = @"于三";
//    ci10.JHChineseString = @"破三";
//    ci11.JHChineseString = @"梁三";
//    NSArray *a3 = @[ci1, ci2, ci3, ci4, ci5, ci6, ci7, ci8, ci9, ci10, ci11];
//    NSLog(@"排序结果:");
//    a3 = [chineseSort chineseSortWithObjectArray:a3];
//    for (JHChineseInfo *temp in a3) {
//        NSLog(@"%@", temp.JHChineseString);
//    }
    
    // 测试对JHChineseInfo的子类为元素的数组排序
//    SubChineseInfo *sci1 = [[SubChineseInfo alloc] init];
//    SubChineseInfo *sci2 = [[SubChineseInfo alloc] init];
//    SubChineseInfo *sci3 = [[SubChineseInfo alloc] init];
//    SubChineseInfo *sci4 = [[SubChineseInfo alloc] init];
//    SubChineseInfo *sci5 = [[SubChineseInfo alloc] init];
//    SubChineseInfo *sci6 = [[SubChineseInfo alloc] init];
//    SubChineseInfo *sci7 = [[SubChineseInfo alloc] init];
//    SubChineseInfo *sci8 = [[SubChineseInfo alloc] init];
//    SubChineseInfo *sci9 = [[SubChineseInfo alloc] init];
//    SubChineseInfo *sci10 = [[SubChineseInfo alloc] init];
//    SubChineseInfo *sci11 = [[SubChineseInfo alloc] init];
//    sci1.JHChineseString = @"张三";
//    sci1.num = @"1";
//    sci2.JHChineseString = @"李三";
//    sci2.num = @"2";
//    sci3.JHChineseString = @"li三";
//    sci3.num = @"3";
//    sci4.JHChineseString = @"qeri三";
//    sci4.num = @"4";
//    sci5.JHChineseString = @"rei三";
//    sci5.num = @"5";
//    sci6.JHChineseString = @"lbcx三";
//    sci6.num = @"6";
//    sci7.JHChineseString = @"kjh三";
//    sci7.num = @"7";
//    sci8.JHChineseString = @"照三";
//    sci8.num = @"8";
//    sci9.JHChineseString = @"于三";
//    sci9.num = @"9";
//    sci10.JHChineseString = @"破三";
//    sci10.num = @"10";
//    sci11.JHChineseString = @"梁三";
//    sci11.num = @"11";
//    NSArray *a4 = @[sci1, sci2, sci3, sci4, sci5, sci6, sci7, sci8, sci9, sci10, sci11];
//    NSLog(@"排序结果:");
//    a4 = [chineseSort chineseSortWithObjectArray:a4];
//    for (SubChineseInfo *temp in a4) {
//        NSLog(@"%@, %@", temp.JHChineseString, temp.num);
//    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
