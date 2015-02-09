//
//  Canvas.h
//  List
//
//  Created by Kevin Coleman on 1/26/15.
//  Copyright (c) 2015 Layer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, CanvasCenter) {
    CanvasCenterX,
    CanvasCenterY,
    CanvasCenterBoth
};

typedef NS_ENUM(NSInteger, CanvasEdge) {
    CanvasEdgeLeft,
    CanvasEdgeRight,
    CanvasEdgeTop,
    CanvasEdgeBottom,
    CanvasEdgeAll
};

typedef NS_ENUM(NSInteger, CanvasDimension) {
    CanvasDimensionHeight,
    CanvasDimensionWidth,
    CanvasDimensionBoth
};

@interface Canvas : NSObject

+ (instancetype)canvasWithSuperView:(UIView *)superView;

- (void)subcanvasWithView:(UIView *)view canvas:(void(^)(Canvas *canvas))canvas;

- (void)constrainView:(UIView *)view toCanvas:(void(^)(Canvas *canvas))canvas;

- (void)constrainCenter:(CanvasCenter)center constant:(CGFloat)constant;

- (void)constrainEdge:(CanvasEdge)canvasEdge constant:(CGFloat)constant;

- (void)constrainDimension:(CanvasDimension)canvasDimension constant:(CGFloat)constant;

@end
