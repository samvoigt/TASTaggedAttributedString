/*
 NSString+TaggedAttributedString.h

 Created by Samuel Voigt on 10/16/13.
 Copyright (c) 2013 Sam Voigt. All rights reserved.

 Opening Tags: <>
 Closing Tags:</>
 
 Multiple commands can be used in a single tag. For example: <b, i, u>.
 These should be comma seperated. Commands are closed by listing them in a
 closing tag: </b, i, u>
 
 For commands that take an arguement, no quotes are required. For example:
 <c=red, font=Georgia>
 
 Commands are parsed linearly, and not nested. Each new command will override 
 previous commands. For exmaple, "<c=red>Hello <c=blue>World</c>!" will result
 in a red "Hello", blue "World", and a black (uncolored) "!".
 
 Fonts and colors can be described in a nil terminated list using
 attributedStringFromTaggedStringWithFontsAndColors. They should be of type
 UIFont and UIcolor. The fonts and colors can be referenced by their position
 by type in the list using @1, @2, etc. For example, if you pass (in order) 
 myFont1, myColor1, myFont2, myFont3, myColor2, then those can be accessed by 
 font=@1, c=@1, font=@2, font=@3, color=@2 respectively.
 
 Color Commands:
 c=, cf= - Foreground Text Color
 cb= - Background Text Color
 tc= - Strikethrough Color
 
 Font Color:
 family= - Set the family name for a font. Use family= to set a font that can
    be bolded, italicized, or bold ital. Bold, italic, and bold italic are only
    availiable if a family has been set. The default family is HelveticaNeue.
    This must match a family name in the project.
 face= - Set Font Face. This must match a font name in the project.
 b - Bold (must have set a family).
 i - Italic (must have set a family).
 s= - Size (float value).
 
 Alignment:
 a= - Options: left, right, center, justified, natural.
 
 Underline:
 u - Underlines text
 
 Strikethrough:
 t - Strikethrough text. The line will be the same color as the current text
    color, unless the strikethrough color has been specified (see above).
 
*/

#import <Foundation/Foundation.h>

@interface NSString (TaggedAttributedString)

- (NSAttributedString *)attributedStringFromTaggedString;
- (NSAttributedString *)attributedStringFromTaggedStringWithFontsAndColors:(id)firstParameter,... NS_REQUIRES_NIL_TERMINATION;

@end
