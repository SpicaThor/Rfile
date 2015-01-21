//
//  GSStringsXmlHandler.m
//  Rfile
//
//  Created by Ariel Tkachenko on 1/21/15.
//  Copyright (c) 2015 Gil Shapira. All rights reserved.
//

#import "GSStringsXmlHandler.h"
#import "XMLReader.h"
#import "NSString+Rfile.h"



@implementation GSStringsXmlHandler

- (NSString *)type {
    return @"string";
}

- (NSDictionary *)commonEntries {
    NSLog(@"Will try to get data from file: %@",self.xmlFilePath);
    NSString *ext = [[self.xmlFilePath pathExtension] lowercaseString];
    if ([ext isEqualToString:@"xml"]) {
        NSData *xmlData = [NSData dataWithContentsOfFile:self.xmlFilePath];
        NSError *error = nil;
        NSDictionary *strings = [XMLReader dictionaryForXMLData:xmlData error:&error];
        if (error) {
            NSLog(@"Error parsing data from: %@\n%@",self.xmlFilePath,error);
            return nil;
        }
        NSLog(@"Got following dictionary: %@",strings);
        NSMutableDictionary *entries = [NSMutableDictionary dictionary];
        for (NSString *key in strings) {
            NSString *lKey = [key lowercaseString];
            if ([lKey isEqualToString:@"resources"]) {
                NSDictionary *inner = strings[key];
                for (NSString *innerKey in inner) {
                    NSString *lInnerKey = [innerKey lowercaseString];
                    if ([lInnerKey isEqualToString:@"string"]) {
                        NSArray *strings = inner[innerKey];
                        for (NSDictionary *stringValuePair in strings) {
                            NSString *actualKey = stringValuePair[@"name"];
                            if ([actualKey length]) {
                                entries[actualKey] = [actualKey stringByAddingBackslashes];
                            }
                        }
                    }
                }
            }
        }
        
        return entries;
    }
    NSLog(@"File with wrong extention: %@",self.xmlFilePath);
    return nil;
}

- (NSDictionary *)entriesForResourceAtPath:(NSString *)path {
    return nil;
}

@end
