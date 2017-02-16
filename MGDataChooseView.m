//
//  MGDataChooseView.m
//  CheDaiBao
//
//  Created by zzw on 17/2/13.
//  Copyright © 2017年 MG. All rights reserved.
//

#import "MGDataChooseView.h"

@interface MGDataChooseView()

@end

@implementation MGDataChooseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self creatViewWithFrame:frame];
    
    return self;
}

- (void)creatViewWithFrame:(CGRect)frame {
    
    float height = frame.size.height;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, kScreenW/3, height);
    leftButton.tag = 100;
    [leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"date_arrow_left_ic"] forState:UIControlStateNormal];
    [self addSubview:leftButton];
    
    _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _centerButton.frame = CGRectMake(kScreenW/3, 0, kScreenW/3, height);
    _centerButton.tag = 102;
    [_centerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_centerButton setTitle:[MGItemTool getCurrentYear] forState:UIControlStateNormal];
    _centerButton.titleLabel.font = Font_Bold_16;
    [_centerButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_centerButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(kScreenW/3*2, 0, kScreenW/3, height);
    rightButton.tag = 101;
    [rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"date_arrow_right_ic"] forState:UIControlStateNormal];
    [self addSubview:rightButton];
    
}

- (void)buttonClick:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(dataButtonClick:)])
    {
        [self.delegate dataButtonClick:button.tag];
    }

    if (button.tag != 102) {
        
        //获取当前显示的时间
        NSString *showTime = _centerButton.titleLabel.text;
        //将字符串时间转换为data类型
        NSDate *dateNow =[MGItemTool convertDateFromString:showTime];
        NSString *strTemp = @"";
        
        switch (button.tag) {
            case 100:{
                
                //减一天
                NSDate *dateLastDay = [NSDate dateWithTimeInterval:-24*3600 sinceDate:dateNow];
                
                strTemp =[[NSString stringWithFormat:@"%@",dateLastDay] substringToIndex:10];
                
            }
                break;
            case 101:{
                
                //加一天前先判断是否显示的是今天的日期，是则不能切换到明天
                NSInteger tag = [MGItemTool compareOneDay:dateNow withAnotherDay:[MGItemTool convertDateFromString:[MGItemTool getCurrentYear]]];
                if (tag == 0) {
                    [KeyWindow makeToast:@"无法查看明天的数据" duration:2 position:@"center"];
                    return;
                }
                
                //加一天
                NSDate *dateFutureDay = [NSDate dateWithTimeInterval:24*3600 sinceDate:dateNow];
                
                strTemp =[[NSString stringWithFormat:@"%@",dateFutureDay] substringToIndex:10];
                
            }
                break;
                
            default:
                break;
        }
        
        //设置加减之后的值
        [_centerButton setTitle:strTemp forState:UIControlStateNormal];
    }
}

@end
