//
//  tts_exception.h
//  tts_msg
//
//  Created by Jerry on 22/6/13.
//  Copyright (c) 2013 phoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

///\file


/**
 \brief Constructs a NSException or exception of inherit from NSException with the given function name, line number, userInfo and reasoning.
 
 The 'reason' of the exception constructed is in a formal format, which has the following information:
 - The name of the function invokes the constuction of the exception.
 - The line number this construction happen.
 - The call stack at the time the exception is constructing.
 - A description of the reason of making this execption
 
 
 Most of this information is not automatically fill up but provided by the user. For example the function name could be obtained by using the "__FUNCTION__" macro, and line number could be obtained by "__LINE__" macro.
 For convenience issues, the \ref TTSException, \ref TTSExceptionA and \ref TTSExceptionE macros will automatically fill up these information for the user.
 
 \param clazz the class of exception that going to construct. If clazz is not given, then NSException will be used. If clazz is not inherited from NSException, then construction will be fail and unexpected exception will be thrown.
 \param function the name of the function invokes the construction
 \param line the line number this construction happen
 \param userInfo custom information attach with the exception
 \param reason the reason cause this exception.
 \param args the arguments that going to fill into the reasoning.
 
 \see TTSException
 \see TTSExceptionA
 \see TTSExceptionE
 */
NSException *tts_exceptionA(Class clazz, const char *function, int line, NSDictionary *userInfo, NSString *reason, va_list args);


/**
 \brief Constructs a NSException or exception of inherit from NSException with the given function name, line number, userInfo and reasoning.
 
 The 'reason' of the exception constructed is in a formal format, which has the following information:
 - The name of the function invokes the constuction of the exception.
 - The line number this construction happen.
 - The call stack at the time the exception is constructing.
 - A description of the reason of making this execption
 
 
 Most of this information is not automatically fill up but provided by the user. For example the function name could be obtained by using the "__FUNCTION__" macro, and line number could be obtained by "__LINE__" macro.
 For convenience issues, the \ref TTSException, \ref TTSExceptionA and \ref TTSExceptionE macros will automatically fill up these information for the user.
 
 \param clazz the class of exception that going to construct. If clazz is not given, then NSException will be used. If clazz is not inherited from NSException, then construction will be fail and unexpected exception will be thrown.
 \param function the name of the function invokes the construction
 \param line the line number this construction happen
 \param userInfo custom information attach with the exception
 \param reason the c-formatted reasoning that cause this exception.
 
 \see TTSException
 \see TTSExceptionA
 \see TTSExceptionE
 */
NSException *tts_exception(Class clazz, const char *function, int line, NSDictionary *userInfo, NSString *reason, ...) NS_FORMAT_FUNCTION(5, 6);

/**
 \brief Throw a tts-formatted exception with the given function name, line number, userInfo and reasoning.
 
 Most of this information is not automatically fill up but provided by the user. For example the function name could be obtained by using the "__FUNCTION__" macro, and line number could be obtained by "__LINE__" macro.
 For convenience issues, the \ref TTSthrow, \ref TTSthrowA and \ref TTSthrowE macros will automatically fill up these information for the user.
 
 This function used as a convenient when needs to throw exception. It also help you on coverage test. That is because coverage test will not covers statements with @@throw. Therefore, this function prevent your from using @@throw directly, and coverage test will then take effect on the statements where error occurs.
 
 \param clazz the class of exception that going to construct. If clazz is not given, then NSException will be used. If clazz is not inherited from NSException, then construction will be fail and unexpected exception will be thrown.
 \param function the name of the function invokes the construction
 \param line the line number this construction happen
 \param userInfo custom information attach with the exception
 \param reason the c-formatted reasoning that cause this exception.
 
 \see TTSThrow
 \see TTSThrowA
 \see TTSThrowE
 */
void tts_raise(Class clazz, const char *function, int line, NSDictionary *userInfo, NSString *reason, ...) NS_FORMAT_FUNCTION(5, 6);



/**
 Thrown to indicate invalid cast of object
 \since 0.0.4
 */
@interface InvalidTypeCastException : NSException
@end

/**
 Thrown to indicate caller invokes a function by providing invalid argument.
 \since 0.0.4
 */
@interface InvalidParameterException : NSException
@end

/**
 Thrown to indicate attempts to use nil pointer
 \since 0.0.4
 */
@interface NilPointerException : NSException
@end




/**
 A convenient approach for calling \ref tts_exception.
 */
#define TTSException(theReason...) tts_exception(nil, __FUNCTION__, __LINE__, nil, theReason)

/**
 A convenient approach for calling \ref tts_exception. You could specify which NSException sub-class to call by this macro
 */
#define TTSExceptionA(type, theReason...) tts_exception([type class], __FUNCTION__, __LINE__, nil, theReason)

/**
 Similar to \ref TTSExceptionA, and attach the custom userInfo the the exception additionally
 */
#define TTSExceptionE(type, theUserInfo, theReason...) tts_exception([type class], __FUNCTION__, __LINE__, (theUserInfo), theReason)



/**
 A convenient approach for throwing an tts-formatted exception.
 */
#define TTSThrow(theReason...) tts_raise(nil, __FUNCTION__, __LINE__, nil, theReason)

/**
 A convenient approach for throwing an tts-formatted exception. You could specify which NSException sub-class to call by this macro
 */
#define TTSThrowA(type, theReason...) tts_raise([type class], __FUNCTION__, __LINE__, nil, theReason)

/**
 Similar to \ref TTSthrowA, and attach the custom userInfo the the exception additionally
 */
#define TTSThrowE(type, theUserInfo, theReason...) tts_raise([type class], __FUNCTION__, __LINE__, (theUserInfo), theReason)


/**
 A convenient macro on checking if a parameter is nil. Throws InvalidParameterException on failure
 \since 0.0.4
 */
#define TTSNilParamCheck(param) if(!(param)){@throw TTSExceptionA(InvalidParameterException, @"Param '%s' MUST NOT nil", #param);}


/**
 A convenient macro on checking if a pointer is nil. Throws NilPointerException on failure
 \since 0.0.4
 */
#define TTSNilPointerCheck(var) if(!(var)){@throw TTSExceptionA(NilPointerException, @"Var '%s' MUST NOT nil", #var);}


/**
 A convenient macro on checking if an object belongs to subclass of the given class. Throws InvalidTypeCastException on failure
 \since 0.0.4
 */
#define TTSTypeCheck(param, type) if(!([[param class] isSubclassOfClass:(type)])){@throw TTSExceptionA(InvalidTypeCastException, @"Param '%s' MUST from subclass of %s", #param, NSStringFromClass((type)).UTF8String);}
