//
//  RGSingletonTemplate.h
//  Tomatos
//
//  Created by Zero on 13-6-7.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#ifndef Tomatos_RGSingletonTemplate_h
#define Tomatos_RGSingletonTemplate_h

#define SYNTHESIZE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SYNTHESIZE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#endif
