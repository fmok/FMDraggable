//
//  UIView+Draggable.h
//  Demo2
//
//  Created by fm on 2017/5/26.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Draggable)

- (void)makeDraggable;  // damping default 0.4
- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping;
- (void)removeDraggable;
- (void)updateSnapPoint;

@end
