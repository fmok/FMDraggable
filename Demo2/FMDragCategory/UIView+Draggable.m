//
//  UIView+Draggable.m
//  Demo2
//
//  Created by fm on 2017/5/26.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "UIView+Draggable.h"
#import <objc/runtime.h>

@implementation UIView (Draggable)

- (void)makeDraggable
{
    [self makeDraggableInView:self.superview damping:0.4];
}

- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping
{
    if (!view) return;
    [self removeDraggable];
    
    self.fm_playground = view;
    self.fm_damping = damping;
    
    [self fm_creatAnimator];
    [self fm_addPanGesture];
}

- (void)removeDraggable
{
    [self removeGestureRecognizer:self.fm_panGesture];
    self.fm_panGesture = nil;
    self.fm_playground = nil;
    self.fm_animator = nil;
    self.fm_snapBehavior = nil;
    self.fm_attachmentBehavior = nil;
    self.fm_centerPoint = CGPointZero;
}

- (void)updateSnapPoint
{
    self.fm_centerPoint = [self convertPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) toView:self.fm_playground];
    self.fm_snapBehavior = [[UISnapBehavior alloc] initWithItem:self snapToPoint:self.fm_centerPoint];
    self.fm_snapBehavior.damping = self.fm_damping;
}

- (void)fm_creatAnimator
{
    self.fm_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.fm_playground];
    [self updateSnapPoint];
}

- (void)fm_addPanGesture
{
    self.fm_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(fm_panGesture:)];
    [self addGestureRecognizer:self.fm_panGesture];
}

#pragma mark - Gesture

- (void)fm_panGesture:(UIPanGestureRecognizer *)pan
{
    CGPoint panLocation = [pan locationInView:self.fm_playground];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        UIOffset offset = UIOffsetMake(panLocation.x - self.fm_centerPoint.x, panLocation.y - self.fm_centerPoint.y);
        [self.fm_animator removeAllBehaviors];
        self.fm_attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self
                                                               offsetFromCenter:offset
                                                               attachedToAnchor:panLocation];
        [self.fm_animator addBehavior:self.fm_attachmentBehavior];
        
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        
        [self.fm_attachmentBehavior setAnchorPoint:panLocation];
        
    } else if (pan.state == UIGestureRecognizerStateEnded ||
             pan.state == UIGestureRecognizerStateCancelled ||
             pan.state == UIGestureRecognizerStateFailed) {
        
        [self.fm_animator removeAllBehaviors];
        [self.fm_animator addBehavior:self.fm_snapBehavior];
        
    }
}

#pragma mark - Associated Object

- (void)setFm_playground:(id)object {
    objc_setAssociatedObject(self, @selector(fm_playground), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)fm_playground {
    return objc_getAssociatedObject(self, @selector(fm_playground));
}

- (void)setFm_animator:(id)object {
    objc_setAssociatedObject(self, @selector(fm_animator), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIDynamicAnimator *)fm_animator {
    return objc_getAssociatedObject(self, @selector(fm_animator));
}

- (void)setFm_snapBehavior:(id)object {
    objc_setAssociatedObject(self, @selector(fm_snapBehavior), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UISnapBehavior *)fm_snapBehavior {
    return objc_getAssociatedObject(self, @selector(fm_snapBehavior));
}

- (void)setFm_attachmentBehavior:(id)object {
    objc_setAssociatedObject(self, @selector(fm_attachmentBehavior), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIAttachmentBehavior *)fm_attachmentBehavior {
    return objc_getAssociatedObject(self, @selector(fm_attachmentBehavior));
}

- (void)setFm_panGesture:(id)object {
    objc_setAssociatedObject(self, @selector(fm_panGesture), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIPanGestureRecognizer *)fm_panGesture {
    return objc_getAssociatedObject(self, @selector(fm_panGesture));
}

- (void)setFm_centerPoint:(CGPoint)point {
    objc_setAssociatedObject(self, @selector(fm_centerPoint), [NSValue valueWithCGPoint:point], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGPoint)fm_centerPoint {
    return [objc_getAssociatedObject(self, @selector(fm_centerPoint)) CGPointValue];
}

- (void)setFm_damping:(CGFloat)damping {
    objc_setAssociatedObject(self, @selector(fm_damping), @(damping), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)fm_damping {
    return [objc_getAssociatedObject(self, @selector(fm_damping)) floatValue];
}


@end
