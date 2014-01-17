##TASTaggedAttributedString

###A category on NSString for quickly generated attributed strings from HTML-style tags.

####Basics:

 Opening Tags: <>
 
 Closing Tags: &lt;/&gt;
 
 Multiple commands can be used in a single tag. For example: &lt;b, i, u&gt;.
 These should be comma seperated. Commands are closed by listing them in a
 closing tag: &lt;/b, i, u&gt;
 
 For commands that take an arguement, an equals sign with no quotes are required. For example:
 &lt;c=red, font=Georgia&gt;
 
 Commands are parsed linearly, and not nested. Each new command will override 
 previous commands. For exmaple, "&lt;c=red&gt;Hello &lt;c=blue&gt;World&lt;/c&gt;!" will result
 in a red "Hello", blue "World", and a black (uncolored) "!".
 
 Fonts and colors can be described in a nil terminated list using
 attributedStringFromTaggedStringWithFontsAndColors. They should be of type
 UIFont and UIcolor. The fonts and colors can be referenced by their position
 by type in the list using @1, @2, etc. For example, if you pass (in order) 
 myFont1, myColor1, myFont2, myFont3, myColor2, then those can be accessed by 
 font=@1, c=@1, font=@2, font=@3, color=@2 respectively. For example: [@"&lt;font=@1&gt;Hello World&lt;/font&gt;" attributedStringFromTaggedStringWithFontsAndColors:myFont]; 
 
####Color Commands:

 - c=, cf= - Foreground Text Color
 - cb= - Background Text Color
 - tc= - Strikethrough Color

 
####Font Color:

 - family= - Set the family name for a font. Use family= to set a font that can
    be bolded, italicized, or bold ital. Bold, italic, and bold italic are only
    availiable if a family has been set. The default family is HelveticaNeue.
    This must match a family name in the project.
 - face= - Set Font Face. This must match a font name in the project.
 - b - Bold (must have set a family).
 - i - Italic (must have set a family).
 - s= - Size (float value).
 
#### Alignment:

 - a= - Options: left, right, center, justified, natural.
 
#### Underline:

 - u - Underlines text
 
#### Strikethrough:
 
 - t - Strikethrough text. The line will be the same color as the current text
    color, unless the strikethrough color has been specified (see above). 
