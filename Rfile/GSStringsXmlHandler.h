//
//  GSStringsXmlHandler.h
//  Rfile
//
//  Created by Ariel Tkachenko on 1/21/15.
//  Copyright (c) 2015 Gil Shapira. All rights reserved.
//

#import "GSResourceHandler.h"


@interface GSStringsXmlHandler : NSObject <GSResourceHandler>

@property (nonatomic,copy) NSString *xmlFilePath;

@end
