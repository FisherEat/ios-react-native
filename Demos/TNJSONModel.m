//
//  YCJSONModel.m
//  YC
//
//  Created by Yu Liang on 13-8-13.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import "TNJSONModel.h"
#import <objc/runtime.h>

BOOL x_64()
{
    return sizeof(void *) == 8;
}

@implementation TNJSONModel
- (id)initWithAttributes:(NSDictionary *)attributes
{
    if((self = [self init])) {
        [self setValuesForKeysWithDictionary:attributes];
    }
    return self;
}

- (id)init
{
    if((self = [super init])) {
        
    }
    return self;
}

#pragma mark - NSCoder menthod

- (BOOL)allowsKeyedCoding
{
	return YES;
}

#pragma mark - NSCoding protocl

- (id)initWithCoder:(NSCoder *)decoder
{
    [self initPropertiesWithDecoder:decoder];
	return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [self encodeValues:encoder];
}

#pragma mark - NSCoping protocol

- (id)copyWithZone:(NSZone *)zone
{
    // subclass implementation should do a deep mutable copy
    // this class doesn't have any ivars so this is ok
    id newModel = [[[self class] allocWithZone:zone] init];
    [self copyProperties:newModel];
    return newModel;
}

#pragma mark - NSMutableCoping protocol

- (id)mutableCopyWithZone:(NSZone *)zone
{
    // subclass implementation should do a deep mutable copy
    // this class doesn't have any ivars so this is ok
    id newModel = [[[self class] allocWithZone:zone] init];
    [self copyProperties:newModel];
    return newModel;
}

#pragma mark - KVC menthods

- (id)valueForUndefinedKey:(NSString *)key
{
    // subclass implementation should provide correct key value mappings for custom keys
//    DLog(@"Undefined Key: %@", key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // subclass implementation should set the correct key value mappings for custom keys
//    DLog(@"Undefined Key: %@", key);
}

- (BOOL)isBasicProtertyType:(NSString *)typeAttribute
{
    BOOL isBasicType = NO;
    
    if ([typeAttribute length] >= 1) {
        char tmpAttribut = [typeAttribute characterAtIndex:1];
        
        switch (tmpAttribut) {
            case Bool:
            case UnsignedShort:
            case UnsignedInt:
            case UnsignedLong:
            case UnsignedLongLong:
            case Short:
            case Long:
            case LongLong:
            case Int:
            case Float:
            case Double:
            {
                isBasicType = YES;
            }
                break;
            default:
                break;
        }
    }
    
    return isBasicType;
}

- (Class)getKeyPropertyClass:(NSString *)key
{
    char *getter = strdup([key cStringUsingEncoding:NSUTF8StringEncoding]);
    SEL getterSel = sel_registerName(getter);
    free(getter);
    
    if ([self respondsToSelector:getterSel]) {
        
        const char * type = property_getAttributes(class_getProperty([self class], [key cStringUsingEncoding:NSASCIIStringEncoding]));
        NSString * typeString = [NSString stringWithUTF8String:type];
        NSArray * attributes = [typeString componentsSeparatedByString:@","];
        NSString * typeAttribute = [attributes objectAtIndex:0];
        //        NSString * propertyType = [typeAttribute substringFromIndex:1];
        //        const char * rawPropertyType = [propertyType UTF8String];
        
        if ([typeAttribute hasPrefix:@"T@"] && [typeAttribute length] > 1) {
            NSString * typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length]-4)];  //turns @"NSDate" into NSDate
            Class typeClass = NSClassFromString(typeClassName);
//            DLog(@"%@", [typeClass class]);
            //            if (typeClass != nil) {
            //
            //            }
            
            return typeClass;
        }
        else if([self isBasicProtertyType:typeAttribute])
        {
            return [NSNumber class];
        }
        else
        {
            return nil;
        }
        
    }
    
    //key可以不在Model定义里，但是可以不能认为类型不匹配
    return [NSObject class];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    Class keyPropertyClass = [self getKeyPropertyClass:key];
    //判断不出来类型 或者 类型不匹配
    if (!keyPropertyClass || ![value isKindOfClass:keyPropertyClass]) {
//        DLog(@"%@‘s value is not kind of %@", key, keyPropertyClass);
//        return;
        //string int 转换
        if ([value isKindOfClass:[NSNumber class]]) {
            
            [super setValue:[NSString stringWithFormat:@"%@", value] forKeyPath:key];
            return;
        }
        else if ([value isKindOfClass:[NSString class]])
        {
            [super setValue:[NSNumber numberWithInteger:[value integerValue]] forKeyPath:key];
            return;
        }
        else if (!value || [value isKindOfClass:[NSNull class]])
        {
            return;
        }
    }
    
    if (keyPropertyClass) {
        [super setValue:value forKey:key];
    }
}

#pragma mark - NSInvocation method 反射方法.

- (void)copyProperties:(id)theCopy{
    //1.调用get property方法取值(invoke)，如果是object，再调用copy方法
    //2.将获取的值用performSelector设给theCopy
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; ++i) {
        objc_property_t property = properties[i];
        char *readonly = property_copyAttributeValue(property, "R");
        if (readonly)
        {
            free(readonly);
            continue;
        }
        const char *name = property_getName(property);
        const char *attributes = property_getAttributes(property);
        
        char *setter = strstr(attributes, ",S");
        if (setter) {
            //strdup:带malloc的字符串copy
            setter = strdup(setter + 2);
            //strsep:字符串分隔，取第一个","后的字符串
            setter = strsep(&setter, ",");
        } else {
            asprintf(&setter, "set%c%s:", toupper(name[0]), name + 1);
        }
        
        SEL setterSel = sel_registerName(setter);
        free(setter);
        
        char *getter = strstr(attributes, ",G");
        if (getter) {
            //strdup:带malloc的字符串copy
            getter = strdup(getter + 2);
            //strsep:字符串分隔，取第一个","后的字符串
            getter = strsep(&getter, ",");
        } else {
            getter = strdup(name);
        }
        SEL getterSel = sel_registerName(getter);
        free(getter);
        
        //        NSString* ocStringName = [NSString stringWithFormat:@"%s", name];
        id value = [self getObjectValueFromGetter:getterSel];
        
        //这里采用invoke的形式，调用theCopy的setter方法
        NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:setterSel];
        NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:sig];
        [invocation setSelector: setterSel];
        [invocation setTarget:theCopy];
        
        char* type = [self typeOfPropertyFromAttributes:attributes];
        BOOL isValueHandled = NO;
        
        if (1 == strlen(type)){
            isValueHandled = [self copyBaseProperty:type[0] invoke:invocation value:value];
        }else {
            isValueHandled = [self copyPlusProperty:type invoke:invocation value:value];
        }
        
        if (!isValueHandled){
            free(properties);
            [NSException raise:NSInternalInconsistencyException format:@"Unsupported type of property \"%s\" in class %@", name, self];
        }
        
        free(type);

        [invocation retainArguments];
        [invocation invoke];
    }
    
    free(properties);
}

- (BOOL)copyBaseProperty:(char)type invoke:(NSInvocation*)invocation value:(id)value{
    BOOL result = YES;
    switch (type) {
        case Bool:{
            BOOL bValue = [(NSNumber*)value boolValue];
            [invocation setArgument:&bValue atIndex:2];
        }
            break;
        case UnsignedShort:
        case UnsignedInt:
        case UnsignedLong:
        case UnsignedLongLong:
        case Short:
        case Long:
        case LongLong:{
            int64_t longlongvalue = [(NSNumber*)value longLongValue];
            [invocation setArgument:&longlongvalue atIndex:2];
        }
            break;
            
        case Int:{
            int intValue = [(NSNumber*)value intValue];
            [invocation setArgument:&intValue atIndex:2];
        }
            break;
        case Float:{
            float floatValue = [(NSNumber*)value floatValue];
            [invocation setArgument:&floatValue atIndex:2];
        }
            break;
        case Double:{
            double doubleValue = [(NSNumber*)value doubleValue];
            [invocation setArgument:&doubleValue atIndex:2];
        }
            break;
            
        case Object:{
            NSObject* argument = (NSObject*)value;
            [invocation setArgument:&argument atIndex:2];
        }
            break;
            
        default:
            result = NO;
            break;
    }
    
    return result;
}

- (BOOL)copyPlusProperty:(char*)type invoke:(NSInvocation*)invocation value:(id)value{
    BOOL result = YES;
    if (!strcmp(type, @encode(CGPoint))){
        CGPoint pointValue = [(NSValue*)value CGPointValue];
        [invocation setArgument:&pointValue atIndex:2];
    }else if (!strcmp(type, @encode(CGSize))){
        CGSize sizeValue = [(NSValue*)value CGSizeValue];
        [invocation setArgument:&sizeValue atIndex:2];
    }else if (!strcmp(type, @encode(CGRect))){
        CGRect rectValue = [(NSValue*)value CGRectValue];
        [invocation setArgument:&rectValue atIndex:2];
    }else if (!strcmp(type, @encode(CGAffineTransform))){
        CGAffineTransform affineValue = [(NSValue*)value CGAffineTransformValue];
        [invocation setArgument:&affineValue atIndex:2];
    }else if (!strcmp(type, @encode(UIEdgeInsets))){
        UIEdgeInsets edgeInsetsValue = [(NSValue*)value UIEdgeInsetsValue];
        [invocation setArgument:&edgeInsetsValue atIndex:2];
    }else if (!strcmp(type, @encode(UIOffset))){
        UIOffset offset = [(NSValue*)value UIOffsetValue];
        [invocation setArgument:&offset atIndex:2];
    }
    else{
        result = NO;
    }
    
    return result;
}

//将Decoder中的数据赋给property中的方法
- (void)initPropertiesWithDecoder:(NSCoder *)decoder
{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; ++i) {
        objc_property_t property = properties[i];
        char *readonly = property_copyAttributeValue(property, "R");
        if (readonly)
        {
            free(readonly);
            continue;
        }

        const char *name = property_getName(property);
        const char *attributes = property_getAttributes(property);
        
        char *setter = strstr(attributes, ",S");
        if (setter) {
            setter = strdup(setter + 2);
            setter = strsep(&setter, ",");
        } else {
            asprintf(&setter, "set%c%s:", toupper(name[0]), name + 1);
        }
        SEL setterSel = sel_registerName(setter);
        free(setter);
        
        NSString* ocStringName = [NSString stringWithFormat:@"%s", name];
        
        NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:setterSel];
        NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:sig];
        [invocation setSelector:setterSel];
        [invocation setTarget:self];
        
        char* type = [self typeOfPropertyFromAttributes:attributes];
        
        BOOL isValueHandled = NO;
        
        if (1 == strlen(type)){
            isValueHandled = [self decodeBaseValues:decoder type:type[0] nameString:ocStringName invoke:invocation];
        }else{
            isValueHandled = [self decodePlusValues:decoder type:type nameString:ocStringName invoke:invocation];
        }
        
        if (!isValueHandled){
            free(properties);
            [NSException raise:NSInternalInconsistencyException format:@"Unsupported type of property \"%s\" in class %@", name, self];
        }
        
        [invocation retainArguments];
        [invocation invoke];
        free(type);
        //        NSLog(@"fill key = %s value = %@", name, argument);

    }
    
    free(properties);
}

- (BOOL)decodeBaseValues:(NSCoder *)decoder type:(char)cType nameString:(NSString*)ocStringName invoke:(NSInvocation*)invocation{
    BOOL result = YES;
    
    switch (cType) {
        case Bool:{
            BOOL bValue = [decoder decodeBoolForKey:ocStringName];
            [invocation setArgument:&bValue atIndex:2];
        }
            break;
            
        case UnsignedShort:
        case UnsignedInt:
        case UnsignedLong:
        case UnsignedLongLong:
        case Short:
        case Long:
        case LongLong:{
            int64_t longlongValue = [decoder decodeInt64ForKey:ocStringName];
            [invocation setArgument:&longlongValue atIndex:2];
        }
            break;
            
        case Int:{
            NSInteger intValue = [decoder decodeIntegerForKey:ocStringName];
            [invocation setArgument:&intValue atIndex:2];
        }
            break;
            
        case Float:{
            float floatValue = [decoder decodeFloatForKey:ocStringName];
            [invocation setArgument:&floatValue atIndex:2];
        }
            break;
            
        case Double:{
            double doubleValue = [decoder decodeDoubleForKey:ocStringName];
            [invocation setArgument:&doubleValue atIndex:2];
        }
            break;
            
        case Object:{
            NSObject* argument = [decoder decodeObjectForKey:ocStringName];
            [invocation setArgument:&argument atIndex:2];
        }
            break;
            
        default:
            result = NO;
            break;
    }
    
    return result;
}

- (BOOL)decodePlusValues:(NSCoder *)decoder type:(char*)type nameString:(NSString*)ocStringName invoke:(NSInvocation*)invocation{
    BOOL result = YES;
    if (!strcmp(type, @encode(CGPoint))){
        CGPoint pointValue = [decoder decodeCGPointForKey:ocStringName];
        [invocation setArgument:&pointValue atIndex:2];
    }else if (!strcmp(type, @encode(CGSize))){
        CGSize sizeValue = [decoder decodeCGSizeForKey:ocStringName];
        [invocation setArgument:&sizeValue atIndex:2];
    }else if (!strcmp(type, @encode(CGRect))){
        CGRect rectValue = [decoder decodeCGRectForKey:ocStringName];
        [invocation setArgument:&rectValue atIndex:2];
    }else if (!strcmp(type, @encode(CGAffineTransform))){
        CGAffineTransform affineValue = [decoder decodeCGAffineTransformForKey:ocStringName];
        [invocation setArgument:&affineValue atIndex:2];
    }else if (!strcmp(type, @encode(UIEdgeInsets))){
        UIEdgeInsets edgeInsetsValue = [decoder decodeUIEdgeInsetsForKey:ocStringName];
        [invocation setArgument:&edgeInsetsValue atIndex:2];
    }else if (!strcmp(type, @encode(UIOffset))){
        UIOffset offset = [decoder decodeUIOffsetForKey:ocStringName];
        [invocation setArgument:&offset atIndex:2];
    }
    else{
        result = NO;
    }
    
    return result;
}

- (char*)typeOfPropertyFromAttributes:(const char*)attributes{
    if (!attributes || strlen(attributes) <= 1)
        return 0x00;
    
    char* result = NULL;
    if (!(attributes[1] == '{')){
        result = malloc(sizeof(char) * 2);
        memset(result, 0, 2);
        strncpy(result, attributes + 1, 1);
        return result;
    }
    
    //"{"和"}"之间即为type
    char* start = strstr(attributes, "{");
    
    //找到最后一个"}"
    char* end = start;
    while (true) {
        char* tmp = strstr(end + 1, "}");
        if (!tmp)
            break;
        end = tmp;
    }
    
    NSInteger len = end - start + 1;
    result = malloc(sizeof(char) * (len + 1));
    memset(result, 0, len + 1);
    strncpy(result, start, len);
    return result;
}

//将Property中的值encode.
- (void)encodeValues:(NSCoder *)encoder{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; ++i) {
        objc_property_t property = properties[i];
        
        char *readonly = property_copyAttributeValue(property, "R");
        if (readonly)
        {
            free(readonly);
            continue;
        }
        
        const char *name = property_getName(property);
        const char *attributes = property_getAttributes(property);
        
        char *getter = strstr(attributes, ",G");
        if (getter) {
            getter = strdup(getter + 2);
            getter = strsep(&getter, ",");
        } else {
            getter = strdup(name);
        }
        SEL getterSel = sel_registerName(getter);
        free(getter);
        
        NSString* ocStringName = [NSString stringWithFormat:@"%s", name];
        
        //调用反射的方法，从get接口获取返回值
        id value = [self getObjectValueFromGetter:getterSel];
        
        //        NSLog(@"save key = %s value = %@", name, value);
        char* type = [self typeOfPropertyFromAttributes:attributes];
        
        BOOL isValueHandled = NO;
        
        if (1 == strlen(type)){
            char cType = type[0];
            isValueHandled = [self encodeBaseValues:encoder type:cType value:value nameString:ocStringName];
        }else{
            isValueHandled = [self encodePlusValues:encoder type:type value:value nameString:ocStringName];
        }

        if (!isValueHandled){
            free(properties);
            [NSException raise:NSInternalInconsistencyException format:@"Unsupported type of property \"%s\" type \"%s\" in class %@", name, type, self];
        }
        free(type);
    }
    free(properties);
}

- (BOOL)encodeBaseValues:(NSCoder *)encoder type:(char)cType value:(id)value nameString:(NSString*)ocStringName{
    BOOL result = YES;
    switch (cType) {
        case Bool:
            [encoder encodeBool:[(NSNumber*)value boolValue] forKey:ocStringName];
            break;
            
        case UnsignedShort:
        case UnsignedInt:
        case UnsignedLong:
        case UnsignedLongLong:
        case Short:
        case Long:
        case LongLong:
            [encoder encodeInt64:[(NSNumber*)value longLongValue] forKey:ocStringName];
            break;
            
        case Int:
        {
            // This block with crash run on x64
//            int intValue = 0;
//            if (x_64())
//            {
//                [value getValue:&intValue];
//            }
//            else
//            {
//                intValue = [(NSNumber*)value intValue];
//            }
//            
//            [encoder encodeInt:intValue forKey:ocStringName];
            [encoder encodeInt:[(NSNumber*)value intValue] forKey:ocStringName];
        }
            break;
            
        case Float:
            [encoder encodeFloat:[(NSNumber*)value floatValue] forKey:ocStringName];
            break;
            
        case Double:
            [encoder encodeDouble:[(NSNumber*)value doubleValue] forKey:ocStringName];
            break;
            
        case Object:
            [encoder encodeObject:value forKey:ocStringName];
            break;
            
        default:
            result = NO;
            break;
    }
    
    return result;
}

/*
Encode values like:
                    CGPoint
                    CGSize
                    CGRect
                    CGAffineTransform
                    UIEdgeInsets
                    UIOffset
*/
- (BOOL)encodePlusValues:(NSCoder *)encoder type:(char*)type value:(id)value nameString:(NSString*)ocStringName{
    BOOL result = YES;
    if (!strcmp(type, @encode(CGPoint))){
        [encoder encodeCGPoint:[(NSValue*)value CGPointValue] forKey:ocStringName];
    }else if (!strcmp(type, @encode(CGSize))){
        [encoder encodeCGSize:[(NSValue*)value CGSizeValue] forKey:ocStringName];
    }else if (!strcmp(type, @encode(CGRect))){
        [encoder encodeCGRect:[(NSValue*)value CGRectValue] forKey:ocStringName];
    }else if (!strcmp(type, @encode(CGAffineTransform))){
        [encoder encodeCGAffineTransform:[(NSValue*)value CGAffineTransformValue] forKey:ocStringName];
    }else if (!strcmp(type, @encode(UIEdgeInsets))){
        [encoder encodeUIEdgeInsets:[(NSValue*)value UIEdgeInsetsValue] forKey:ocStringName];
    }else if (!strcmp(type, @encode(UIOffset))){
        [encoder encodeUIOffset:[(NSValue*)value UIOffsetValue] forKey:ocStringName];
    }
    else{
        result = NO;
    }
    return result;
}

- (id)getObjectValueFromGetter:(SEL)getterSel{
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:getterSel];
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:sig];
    [invocation setSelector: getterSel];
    [invocation setTarget:self];
    [invocation retainArguments];
    [invocation invoke];
    //声明返回值变量
    const char* returnType = sig.methodReturnType;
    
    //The problem is that result is __strong by default, so when it goes out of scope, the compiler generates a release for it. But getReturnValue: didn't give you ownership of the returned object, so your method shouldn't be releasing it.
    //From http://stackoverflow.com/questions/11874056/nsinvocation-getreturnvalue-called-inside-forwardinvocation-makes-the-returned
    __unsafe_unretained id returnValue;
    //如果没有返回值，也就是消息声明为void，那么returnValue=nil
    if(!strcmp(returnType, @encode(void)) ){
        returnValue =  nil;
    }
    //如果返回值为对象，那么为变量赋值
    else if(!strcmp(returnType, @encode(id)) ){
        [invocation getReturnValue:&returnValue];
    }
    else{
        //如果返回值为普通类型NSInteger  BOOL
        //返回值长度
        NSUInteger length = [sig methodReturnLength];
        //根据长度申请内存
        void *buffer = (void *)malloc(length);
        //为变量赋值
        [invocation getReturnValue:buffer];

        id result = nil;
        if(!strcmp(returnType, @encode(BOOL)) ) {
            result = [NSNumber numberWithBool:*((BOOL*)buffer)];
        }else if(!strcmp(returnType, @encode(NSInteger)) ){
            result = [NSNumber numberWithInteger:*((NSInteger*)buffer)];
        }else if (!strcmp(returnType, @encode(unsigned short)) ||
                  !strcmp(returnType, @encode(unsigned int)) ||
                  !strcmp(returnType, @encode(unsigned long)) ||
                  !strcmp(returnType, @encode(unsigned long long)) ||
                  !strcmp(returnType, @encode(short)) ||
                  !strcmp(returnType, @encode(long)) ||
                  !strcmp(returnType, @encode(long long))){
            result = [NSNumber numberWithLongLong:*(long long*)buffer];
        }
        else if (!strcmp(returnType, @encode(float)) ){
            result = [NSNumber numberWithFloat:*((float*)buffer)];
        }else if (!strcmp(returnType, @encode(double)) ){
            result = [NSNumber numberWithDouble:*((double*)buffer)];
        }else if (!strcmp(returnType, @encode(CGPoint))){
            result = [NSValue valueWithCGPoint:*(CGPoint*)buffer];
        }else if (!strcmp(returnType, @encode(CGSize))){
            result = [NSValue valueWithCGSize:*(CGSize*)buffer];
        }else if (!strcmp(returnType, @encode(CGRect))){
            result = [NSValue valueWithCGRect:*(CGRect*)buffer];
        }else if (!strcmp(returnType, @encode(CGAffineTransform))){
            result = [NSValue valueWithCGAffineTransform:*(CGAffineTransform*)buffer];
        }else if (!strcmp(returnType, @encode(UIEdgeInsets))){
            result = [NSValue valueWithUIEdgeInsets:*(UIEdgeInsets*)buffer];
        }else if (!strcmp(returnType, @encode(UIOffset))){
            result = [NSValue valueWithUIOffset:*(UIOffset*)buffer];
        }else if (!strcmp(returnType, @encode(NSData))){
            result = [NSData dataWithBytes:buffer length:length];
        }else{
            result =[NSValue valueWithBytes:buffer objCType:returnType];
        }

        free(buffer);
        return result;
    }
    
    return returnValue;
}

@end
