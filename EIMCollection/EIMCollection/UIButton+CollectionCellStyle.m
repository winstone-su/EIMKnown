//
//  UIButton+CollectionCellStyle.m
//  CollectionViewClassifyMenu
//
//  Created by https://github.com/ChenYilong on 15/4 / 2.
//  Copyright (c)  http://weibo.com/luohanchenyilong/ . All rights reserved.
//

#import "UIButton+CollectionCellStyle.h"
//#import "CYLParameterConfiguration.h"

#define CYLAppTintColor [UIColor colorWithRed:42 / 255.0 green:185 / 255.0 blue:160 / 255.0 alpha:1]
#define  CYLTagTitleFont [UIFont systemFontOfSize:16]

@implementation UIButton (CollectionCellStyle)

- (void)cyl_generalStyle {
    self.layer.cornerRadius = 5.0;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
}

- (void)cyl_homeStyle {
    self.titleLabel.font = CYLTagTitleFont;
    [self setTitleColor:[UIColor colorWithRed:18 / 255.0 green:133 / 255.0 blue:117 / 255.0 alpha:1] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:18 / 255.0 green:133 / 255.0 blue:117 / 255.0 alpha:0.7] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    UIImage *imageHighlighted = [[self class] cyl_imageWithColor:[UIColor colorWithRed:18 / 255.0 green:133 / 255.0 blue:117 / 255.0 alpha:1]];
    [self setBackgroundImage:imageHighlighted forState:UIControlStateHighlighted];
    self.layer.borderColor = [UIColor colorWithRed:18 / 255.0 green:133 / 255.0 blue:117 / 255.0 alpha:1].CGColor;
}

- (void)cyl_redStyle {
    self.titleLabel.font = CYLTagTitleFont;
    [self setTitleColor:[UIColor colorWithRed:160 / 255.0 green:15 / 255.0 blue:85 / 255.0 alpha:1] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    UIImage *imageHighlighted  = [[self class] cyl_imageWithColor:[UIColor colorWithRed:18 / 255.0 green:133 / 255.0 blue:117 / 255.0 alpha:1]];
    [self setBackgroundImage:imageHighlighted forState:UIControlStateHighlighted];
    self.layer.borderColor = [UIColor colorWithRed:160 / 255.0 green:15 / 255.0 blue:85 / 255.0 alpha:1].CGColor ;
}

- (void)cyl_chengNiStyle {
    self.layer.cornerRadius = 13.0;
    self.layer.masksToBounds = YES;
    UIImage *imageNormal = [[self class] cyl_imageWithColor:[UIColor colorWithRed:230 / 255.0 green:255 / 255.0 blue:244 / 255.0 alpha:1]];
    [self setBackgroundImage:imageNormal forState:UIControlStateNormal];
    self.titleLabel.font = CYLTagTitleFont;
    [self setTitleColor:CYLAppTintColor forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    UIImage *imageHighlighted  = [UIImage imageNamed:@"tag_btn_background_highlighted"];
    [self setBackgroundImage:imageHighlighted forState:UIControlStateHighlighted];
}

- (void)eim_greenStyle
{
    self.layer.masksToBounds = YES;
    self.titleLabel.font = CYLTagTitleFont;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self setTitleColor:[self getColor:@"333333"] forState:UIControlStateNormal];
    [self setTitleColor:[self getColor:@"2fc762"] forState:UIControlStateSelected];
    [self setTitleColor:[self getColor:@"2fc762"] forState:UIControlStateHighlighted];
    
    
    
    [self setBackgroundImage:[self stretchableImageNamed:@"eim_known_btn_normal"] forState:UIControlStateNormal];
    [self setBackgroundImage:[self stretchableImageNamed:@"eim_known_btn_selected"] forState:UIControlStateSelected];
    [self setBackgroundImage:[self stretchableImageNamed:@"eim_known_btn_selected"] forState:UIControlStateHighlighted];

}

-(UIColor *)getColor: (NSString *)hexColor
{
    hexColor = [hexColor lowercaseString];
    unsigned int red, green, blue;
    
    NSRange range;
    
    range.length = 2;
    
    range.location = 0;
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

- (UIImage *)stretchableImageNamed:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:8 topCapHeight:13];
//    [image stretchableImageWithLeftCapWidth:(NSUInteger)(image.size.width / 2)
//                               topCapHeight:(NSUInteger)(image.size.height / 2)];
//    return image;
}

+ (UIImage *)cyl_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
