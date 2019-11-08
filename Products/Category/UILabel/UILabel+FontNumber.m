//
//  UILabel+FontNumber.m
//  Kawayi
//
//  Created by CY on 2018/2/5.
//  Copyright © 2018年 A$CE. All rights reserved.
//

#import "UILabel+FontNumber.h"

#define LAB_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define FONT_LAB_SCALE(Num) (Num*(LAB_SCREEN_WIDTH/375.0))

@implementation UILabel (FontNumber)

- (void)updateLabelStyleWithSmallFont:(NSInteger)samll bigFont:(NSInteger)big {
    if (self.text == nil) {
        return;
    }
    NSDictionary*  defaultLb= @{NSFontAttributeName:[UIFont systemFontOfSize:FONT_LAB_SCALE(samll)],
                                };
    
    NSAttributedString* defaultAtt=[[NSAttributedString alloc]initWithString:self.text attributes:defaultLb];
    self.attributedText=defaultAtt;
    
    NSError *error;
    // 创建NSRegularExpression对象并指定正则表达式:数字
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"\\d+|(\\.\\d+)|:|'|''"
                                  options:0
                                  error:&error];
    if (!error) { // 如果没有错误
        // 获取特特定字符串的范围
        
        NSArray *matchs = [regex matchesInString:self.text options: NSMatchingReportProgress  range:NSMakeRange(0, [self.text length])];
        
        if (matchs.count > 0) {
            NSMutableAttributedString* mutableAttrStr=[[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
            for (NSTextCheckingResult *match in matchs) {
                NSRange range = match.range;
                [mutableAttrStr addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"DINPro-Medium" size:FONT_LAB_SCALE(big)]} range:range];
            }
            self.attributedText=mutableAttrStr;
        }
    }
}


- (void)updateLabelStyleWithSmallFont:(NSInteger)samll bigFont:(NSInteger)big smallFontName:(NSString *)smallFontName bigFontName:(NSString *)bigFontName;
{
    if (self.text == nil) {
        return;
    }
    NSDictionary*  defaultLb= @{NSFontAttributeName:[UIFont systemFontOfSize:FONT_LAB_SCALE(samll)],
                                };
    if (![smallFontName isEqualToString:@"sys"]) {
        defaultLb= @{NSFontAttributeName:[UIFont  fontWithName:smallFontName size:FONT_LAB_SCALE(samll)],
                                    };
    }

    
    NSAttributedString* defaultAtt=[[NSAttributedString alloc]initWithString:self.text attributes:defaultLb];
    self.attributedText=defaultAtt;
    
    NSError *error;
    // 创建NSRegularExpression对象并指定正则表达式:数字
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"\\d+|(\\.\\d+)|:|'|''"
                                  options:0
                                  error:&error];
    if (!error) { // 如果没有错误
        // 获取特特定字符串的范围
        
        NSArray *matchs = [regex matchesInString:self.text options: NSMatchingReportProgress  range:NSMakeRange(0, [self.text length])];
        
        if (matchs.count > 0) {
            NSMutableAttributedString* mutableAttrStr=[[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
            for (NSTextCheckingResult *match in matchs) {
                NSRange range = match.range;
                [mutableAttrStr addAttributes:@{NSFontAttributeName:[UIFont fontWithName:bigFontName size:FONT_LAB_SCALE(big)]} range:range];
            }
            self.attributedText=mutableAttrStr;
        }
    }
}

- (void)updateLabelStyleWithSmallFont:(NSInteger)samll bigFont:(NSInteger)big smallFontName:(NSString *)smallFontName bigFontName:(NSString *)bigFontName smallColor:(UIColor *)smallColor bigColor:(UIColor *)bigColor {
    if (self.text == nil) {
        return;
    }
    
    NSDictionary *defaultLb= @{NSFontAttributeName:[UIFont systemFontOfSize:FONT_LAB_SCALE(samll)],NSForegroundColorAttributeName:smallColor
                                };
    if (![smallFontName isEqualToString:@"sys"]) {
        defaultLb= @{NSFontAttributeName:[UIFont  fontWithName:smallFontName size:FONT_LAB_SCALE(samll)],NSForegroundColorAttributeName:smallColor
                     };
    }
    
    NSAttributedString* defaultAtt=[[NSAttributedString alloc]initWithString:self.text attributes:defaultLb];
    self.attributedText=defaultAtt;
    
    NSError *error;
    // 创建NSRegularExpression对象并指定正则表达式:数字
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"\\d+|(\\.\\d+)|:|'|''"
                                  options:0
                                  error:&error];
    if (!error) { // 如果没有错误
        // 获取特特定字符串的范围
        
        NSArray *matchs = [regex matchesInString:self.text options: NSMatchingReportProgress  range:NSMakeRange(0, [self.text length])];
        
        if (matchs.count > 0) {
            NSMutableAttributedString* mutableAttrStr=[[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
            for (NSTextCheckingResult *match in matchs) {
                NSRange range = match.range;
                [mutableAttrStr addAttributes:@{NSFontAttributeName:[UIFont fontWithName:bigFontName size:FONT_LAB_SCALE(big)],NSForegroundColorAttributeName:bigColor} range:range];
            }
            self.attributedText=mutableAttrStr;
        }
    }
}

@end
