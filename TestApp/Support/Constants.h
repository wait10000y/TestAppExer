//
//  Constants.h
//  Anagram-Solver
//
//  Created by Leonardo Parro Jr on 4/21/13.
//  Copyright (c) 2013 Leonardo Parro Jr. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define kAPIBaseURLString   @"http://guarded-basin-2383.herokuapp.com"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Helpers
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define IS_IPAD     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)

#endif
