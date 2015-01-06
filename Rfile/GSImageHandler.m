//
// GSImageHandler.m
//
// Copyright (c) 2012 Gil Shapira
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "GSImageHandler.h"


@interface GSImageHandler ()

@property (nonatomic,strong) NSMutableSet *inserted;

@end


@implementation GSImageHandler

- (NSMutableSet *)inserted {
    if (!_inserted) {
        _inserted = [NSMutableSet new];
    }
    return _inserted;
}

- (NSString *)type {
    return @"image";
}

- (NSDictionary *)commonEntries {
    return nil;
}

- (NSDictionary *)entriesForResourceAtPath:(NSString *)path {
    NSString *ext = [[path pathExtension] lowercaseString];
    if ([ext isEqualToString:@"png"] || [ext isEqualToString:@"jpg"]) {
        NSString *filename = [[path lastPathComponent] stringByDeletingPathExtension];
        NSString *key = [self cleanKeyFromKey:filename];
        
        if ([self.inserted containsObject:key]) {
            return nil;
        }
        filename = [key stringByAppendingPathExtension:ext];
        [self.inserted addObject:key];
        
        if (key.length && filename.length) {
            return @{key : filename};
        }
    }
    
    return nil;
}

- (NSString *)cleanKeyFromKey:(NSString *)string {
    NSString *prefix2x = @"@2x";
    NSString *prefix3x = @"@3x";
    if ([string hasSuffix:prefix2x]) {
        string = [string substringToIndex:string.length - prefix2x.length];
    } else if ([string hasSuffix:prefix3x]) {
        string = [string substringToIndex:string.length - prefix3x.length];
    }
    return string;
}

@end
