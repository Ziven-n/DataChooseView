//
//  MGDataChooseView.h
//  CheDaiBao
//
//  Created by zzw on 17/2/13.
//  Copyright © 2017年 MG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGDataChooseViewDelegate <NSObject>

- (void)dataButtonClick:(NSInteger)tag;

@end

@interface MGDataChooseView : UIView

@property (nonatomic,strong)UIButton *centerButton;

@property (nonatomic,weak)id<MGDataChooseViewDelegate>delegate;

@end
