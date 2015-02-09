//
//  Canvas.m
//  List
//
//  Created by Kevin Coleman on 1/26/15.
//  Copyright (c) 2015 Layer. All rights reserved.
//

#import "Canvas.h"

@interface Canvas ()

@property (nonatomic) UIView *superView;
@property (nonatomic) UIView *subView;
@property (nonatomic) UIView *subCanvasView;

@end

@implementation Canvas

+(instancetype)canvasWithSuperView:(UIView *)superView
{
    return [[self alloc] initWithSuperView:superView];
}

- (id)initWithSuperView:(UIView *)superView
{
    self = [super init];
    if (self) {
        _superView = superView;
    }
    return self;
}

- (void)subcanvasWithView:(UIView *)view canvas:(void (^)(Canvas *))canvas
{
    Canvas *subCanvas = [Canvas canvasWithSuperView:self.superView];
    subCanvas.subCanvasView = view;
    canvas(subCanvas);
}

- (void)constrainView:(UIView *)view toCanvas:(void (^)(Canvas *))canvas
{
    self.subView = view;
    canvas(self);
}

- (void)constrainCenter:(CanvasCenter)center constant:(CGFloat)constant
{
    switch (center) {
        case CanvasCenterX:
            [self constrainAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual constant:constant];
            break;
        case CanvasCenterY:
            [self constrainAttribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual constant:constant];
            break;
        case CanvasCenterBoth:
            [self constrainAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual constant:constant];
            [self constrainAttribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual constant:constant];
            break;
        default:
            break;
    }
}

- (void)constrainEdge:(CanvasEdge)canvasEdge constant:(CGFloat)constant
{
    switch (canvasEdge) {
        case CanvasEdgeLeft:
            [self constrainAttribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual constant:constant];
            break;
        case CanvasEdgeRight:
            [self constrainAttribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual constant:constant];            //
            break;
        case CanvasEdgeTop:
            [self constrainAttribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual constant:constant];
            break;
        case CanvasEdgeBottom:
            [self constrainAttribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual constant:constant];
            break;
        case CanvasEdgeAll:
            [self constrainAttribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual constant:constant];
            [self constrainAttribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual constant:constant];
            [self constrainAttribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual constant:constant];
            [self constrainAttribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual constant:constant];
            break;
        default:
            break;
    }
}

- (void)constrainDimension:(CanvasDimension)canvasDimension constant:(CGFloat)constant
{
    switch (canvasDimension) {
        case CanvasDimensionHeight:
            [self simpleConstraintWithAttribute:NSLayoutAttributeHeight constant:constant];
            break;
        case CanvasDimensionWidth:
            [self simpleConstraintWithAttribute:NSLayoutAttributeWidth constant:constant];
            break;
        case CanvasDimensionBoth:
            [self simpleConstraintWithAttribute:NSLayoutAttributeHeight constant:constant];
            [self simpleConstraintWithAttribute:NSLayoutAttributeWidth constant:constant];
            break;
        default:
            break;
    }
}

- (void)setEdgeInsets:(UIEdgeInsets)insets
{
    if (insets.left) [self constrainAttribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual constant:insets.left];
    if (insets.right) [self constrainAttribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual constant:insets.right];
    if (insets.top) [self constrainAttribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual constant:insets.top];
    if (insets.bottom) [self constrainAttribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual constant:insets.bottom];
}

- (void)constrainAttribute:(NSLayoutAttribute)attribute
                 relatedBy:(NSLayoutRelation)relation
                  constant:(CGFloat)constant

{
    if (self.subCanvasView) {
        [self.superView addConstraint:[NSLayoutConstraint constraintWithItem:self.subView
                                                                   attribute:attribute
                                                                   relatedBy:relation
                                                                      toItem:self.subCanvasView
                                                                   attribute:attribute
                                                                  multiplier:1.0
                                                                    constant:constant]];
    } else {
        [self.superView addConstraint:[NSLayoutConstraint constraintWithItem:self.subView
                                                                   attribute:attribute
                                                                   relatedBy:relation
                                                                      toItem:self.superView
                                                                   attribute:attribute
                                                                  multiplier:1.0
                                                                constant:constant]];
    }

}

- (void)simpleConstraintWithAttribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant
{
    [self.superView addConstraint:[NSLayoutConstraint constraintWithItem:self.subView
                                                               attribute:attribute
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:constant]];
}

@end
