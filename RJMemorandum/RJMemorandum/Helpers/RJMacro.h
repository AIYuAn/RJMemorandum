//
//  RJMacro.h
//  RJMemorandum
//
//  Created by RenJiaLiang on 16/4/23.
//  Copyright © 2016年 Renjialiang. All rights reserved.
//

#ifndef RJMacro_h
#define RJMacro_h

#define NSIntegerMax    LONG_MAX
#define NSIntegerMin    LONG_MIN
#define NSUIntegerMax   ULONG_MAX

#pragma mark - Font 
#define RJFont(s)[UIFont fontWithName:@"STHeitiSC-Medium" size:s]

#pragma mark - Color
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


#endif /* RJMacro_h */
