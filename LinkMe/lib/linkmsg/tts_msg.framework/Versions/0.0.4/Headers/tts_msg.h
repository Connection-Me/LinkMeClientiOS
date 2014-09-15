//
//  tts_msg.h
//  tts_msg
//
//  Created by phoenix on 5/30/13.
//  Copyright (c) 2013 phoenix. All rights reserved.
//

///\file

#import <Foundation/Foundation.h>
#import "tts_exception.h"

/**
 \mainpage
 
 There are two main functionalities provided by the tts_msg framework:
 - Provides log functions, which adding [Header], [Function], and [Line number] information to the log messages
 - Extention to NSException so that the reason of the exception include information about the line number, the function invoked the execption and the call stack.
 
 \b Messages \n
 There are three types of messages you could print by using \ref TLOG, \ref TDEBUG or \ref TWARN this framework:
 
 - Example of nromal message:
 \code
 [TTS]-[tts_msgTests testLog]|Line:42: Here test TLOG
 \endcode
 
 - Example of debug message:
 \code
 [TTS][DEBUG]-[tts_msgTests testDebug]|Line:38: Here test TDEBUG
 \endcode
 
 - Example of warning message:
 \code
 [TTS][WARN]-[tts_msgTests testWran]|Line:34: Here test TWARN
 \endcode
 
 \b Exceptions \n
 You could also use the \ref tts_exception or \ref tts_exceptionA function to construct an NSException or other exception instance inherits from NSException, whose 'reasoning' holds valuable information. Or, you may directly raise such exception by \ref tts_raise.\n
 Example of extended exception message:
 \code
 2013-06-10 09:44:30.956 otest[1208:303]
 [NSException]
 [cause: -[tts_msgTests testException]|46]
 [reason: exception]
 (
     "1   tts_msgTests                        0x01872fae -[tts_msgTests testException] + 78",
     "2   CoreFoundation                      0x003f04ed __invoking___ + 29",
     "3   CoreFoundation                      0x003f0407 -[NSInvocation invoke] + 167",
     "4   SenTestingKit                       0x201039c4 -[SenTestCase invokeTest] + 184",
     "5   SenTestingKit                       0x20103868 -[SenTestCase performTest:] + 183",
     "6   SenTestingKit                       0x201034a9 -[SenTest run] + 82",
     "7   SenTestingKit                       0x20106db2 -[SenTestSuite performTest:] + 106",
     "8   SenTestingKit                       0x201034a9 -[SenTest run] + 82",
     "9   SenTestingKit                       0x20106db2 -[SenTestSuite performTest:] + 106",
     "10  SenTestingKit                       0x201034a9 -[SenTest run] + 82",
     "11  SenTestingKit                       0x20105e97 +[SenTestProbe runTests:] + 174",
     "12  CoreFoundation                      0x0048bd51 +[NSObject performSelector:withObject:] + 65",
     "13  otest                               0x0000231c otest + 4892",
     "14  otest                               0x000025be otest + 5566",
     "15  otest                               0x00002203 otest + 4611",
     "16  otest                               0x00001f8d otest + 3981",
     "17  otest                               0x00001f31 otest + 3889"
 )
 \endcode
 
 However, \ref tts_exception, \ref tts_exceptionA and \ref tts_aise require user to use certain macros to fill up their corresponding parameters. This constrain makes coding with this functions become difficult and therefore tts_msg also provide following macros to help users on writing such code: \ref TTSException \ref TTSExceptionA, \ref TTSExceptionE, \ref TTSThrow, \ref TTSThrowA and \ref TTSThrowE
 
 <b> Exception Inheritance </b>\n
 Normally, we could just throw NSException and handle it by just one exception handling. However, functions may throw exceptions with different reasoning and require different handling. In such case, it is better to throw different classes of exception and handle them differently. To do this user could just simply inherit from NSException without any new mthod:
 \code
 @interface MyException : NSException
 @end
 
 @implementation MyException
 @end
 \endcode
 
 and then constrct an exception by \ref TTSExceptionA
 \code
 @throw TTSExceptionA(MyException, @"My Exception Message");
 \endcode
 or directly raise an exception by \ref TTSThrowA
 \code
 TTSThrowA(MyException, @"My Exception Message");
 \endcode
 
 This exception will be caught by the FIRST catch block which with the MOST appropriate exception type (just behave like JAVA).
 \code
 @try {
     @throw TTSExceptionA(MyException, @"My Exception Message");
 }@catch (AException *exception) {
     NSLog(@"%@", exception);
 }@catch (TestException *exception) {
     NSLog(@"%@", exception);   //catch 
 }@catch (NSException *exception) {
     NSLog(@"%@", exception);
 }
 \endcode
 
 <b> Version History </b>\n
 version 0.0.1
 - Initial version
 
 version 0.0.2
 - Document the framework
 - Change the log functions.
 The original declarations of \ref tts_log, \ref tts_debug and \ref tts_warn used NSString * type as the type of their "msg" argument. In this version, the declaration changed to a c-style formatting as the type their "msg" argument.
 Since the framework suggests use \ref TLOG \ref TDEBUG and \ref TWARN rather to use the c functions directly, and the framework dose not applied widly, I design to change the dclaration directly.
 - Change the TTSMsgExtend.
 Similar to the changes maked to log functions. Makes the mssage use c-style formatting. Change does not affect the Macros \ref TTSException and \ref TTSExceptionA, which are the suggested way of constructing the extended exception.
 - Used release script "ufw_release_0_0_1.sh"
 - \b Deprecated
 Version 0.0.2 defined a category with class function exceptionWithFunction:line:reason: for NSException to automatically create valuable exception reasoning. However, this is not going to work! This because of Objective-C libraries are not able to hole category definitions! Therefore, the class function defined in the library will not work in practice.
 
 version 0.0.3
 - Fix the Category problem presented in version 0.0.2. Use c functions \ref tts_exception, \ref tts_exceptionA instead
 - New function \ref tts_raise.
 - New macro \ref TTSExceptionE, \ref TTSThrow, \ref TTSThrowA and \ref TTSThrowE
 
 version 0.0.4 
 - New common Exception classes \ref InvalidTypeCastException \ref InvalidParameterException and \ref NilPointerException
 - New convenient macro \ref TTSNilPointerCheck and \ref TTSNilParamCheck for checking nil pointer and nil parameters
 - New convenient macro \ref TTSTypeCheck for checking invalid type cast
 
 \version 0.0.4
 \author Jiaming HUANG
 */


#define __TTS_MSG__

/**
 Used while injecting message with message [Header]. The default velue of this macro is "TTS". In case you want to use other header, you may use the following code to change your header:
 \code
 #define __TTS_MSG_HEAD_TITLE "YOUR_HEADER_NAME"
 \endcode
 
 Settings take effect when use \ref TLOG, \ref TWARN and \ref TDEBUG
 */
#define __TTS_MSG_HEAD_TITLE "TTS"

/**
 \brief Logs a normal message.
 
 \param headTitle the title, which invoked in the log message.
 \param function the function name, which invoking log. Should fill up with "__FUNCTION__" macro.
 \param line the line number that invoke this log. Should fill up with "__LINE__" macro.
 \param msg the message to be print out. The massage is in c-style formatting.
 */
void tts_log(const char *headTitle, const char *function, int line, NSString *msg, ...) NS_FORMAT_FUNCTION(4,5);

/**
 \brief Logs a debug message.
 
 \param headTitle the title, which invoked in the log message.
 \param function the function name, which invoking log. Should fill up with "__FUNCTION__" macro.
 \param line the line number that invoke this log. Should fill up with "__LINE__" macro.
 \param msg the message to be print out. The massage is in c-style formatting.
 */
void tts_debug(const char *headTitle, const char *function, int line, NSString *msg, ...) NS_FORMAT_FUNCTION(4,5);

/**
 \brief Logs a warning message.
 
 \param headTitle the title, which invoked in the log message.
 \param function the function name, which invoking log. Should fill up with "__FUNCTION__" macro.
 \param line the line number that invoke this log. Should fill up with "__LINE__" macro.
 \param msg the message to be print out. The massage is in c-style formatting.
 */
void tts_warn(const char *headTitle, const char *function, int line, NSString *msg, ...) NS_FORMAT_FUNCTION(4,5);

/**
 \brief Convenient macro fill up the regular arguments for tts_log, that are the header, the function, and the line number arguments.
 */
#define TLOG(theMessage ...) tts_log(__TTS_MSG_HEAD_TITLE, __FUNCTION__, __LINE__, theMessage)

/**
 \brief Convenient macro fill up the regular arguments for tts_warn, that are the header, the function, and the line number arguments.
 */
#define TWARN(theMessage ...) tts_warn(__TTS_MSG_HEAD_TITLE, __FUNCTION__, __LINE__, theMessage)


/**
 \def TDEBUG 
 \brief Convenient macro fill up the regular arguments for tts_debug, that are the header, the function, and the line number arguments.
 
 TDEBUG would be turn off, if the macro "DEBUG" is undefine.
 */
#ifdef DEBUG
#define TDEBUG(theMessage ...) tts_debug(__TTS_MSG_HEAD_TITLE, __FUNCTION__, __LINE__, theMessage)
#else
#define TDEBUG(theMessage ...)
#endif



