//
//  MMConstants.h
//  Mikoto
//
//  Created by 丁帅 on 15/3/24.
//  Copyright (c) 2015年 m_mikoto. All rights reserved.
//
//****************************************************************************************
//  Constants. Some typedef , enum and constants value for MMLib
//****************************************************************************************
//

#ifndef MMConstants_h
#define MMConstants_h

#import <Foundation/Foundation.h>

// block type define
typedef void (^MMBaseBlock)(void);
typedef void(^MMResultBlock)(BOOL);
typedef void(^MMDelegateBlock)(id);
typedef BOOL(^MMConditionBlock)(BOOL);
typedef BOOL(^MMConditionObjectBlock)(id);

/**
    Method result for doing something. 
 */
typedef enum : NSUInteger {
    MMResultSuccess,
    MMResultNotFound,
    MMResultOutOfRange,
    MMResultInvalidValue,
    MMResultAssignError,
    MMResultAssignTypeError,
    MMResultAuthorityError,
    MMResultUnknownError,
} MMResult;

#endif
