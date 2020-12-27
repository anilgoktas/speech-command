//
//  KeyCodeConverter.swift
//  Speech Command
//
//  Created by Anil Goktas on 12/27/20.
//

import Foundation

/// - Note: [Source](https://stackoverflow.com/a/14529841)
struct KeyCodeConverter {
    
    func keyCode(with string: String) -> CGKeyCode? {
        if string == "a" { return 0 }
        if string == "s" { return 1 }
        if string == "d" { return 2 }
        if string == "f" { return 3 }
        if string == "h" { return 4 }
        if string == "g" { return 5 }
        if string == "z" { return 6 }
        if string == "x" { return 7 }
        if string == "c" { return 8 }
        if string == "v" { return 9 }
        if string == "b" { return 11 }
        if string == "q" { return 12 }
        if string == "w" { return 13 }
        if string == "e" { return 14 }
        if string == "r" { return 15 }
        if string == "y" { return 16 }
        if string == "t" { return 17 }
        if string == "1" { return 18 }
        if string == "2" { return 19 }
        if string == "3" { return 20 }
        if string == "4" { return 21 }
        if string == "6" { return 22 }
        if string == "5" { return 23 }
        if string == "=" { return 24 }
        if string == "9" { return 25 }
        if string == "7" { return 26 }
        if string == "-" { return 27 }
        if string == "8" { return 28 }
        if string == "0" { return 29 }
        if string == "]" { return 30 }
        if string == "o" { return 31 }
        if string == "u" { return 32 }
        if string == "[" { return 33 }
        if string == "i" { return 34 }
        if string == "p" { return 35 }
        if string == "RETURN" { return 36 }
        if string == "l" { return 37 }
        if string == "j" { return 38 }
        if string == "'" { return 39 }
        if string == "k" { return 40 }
        if string == " }" { return 41 }
        if string == "\\" { return 42 }
        if string == "," { return 43 }
        if string == "/" { return 44 }
        if string == "n" { return 45 }
        if string == "m" { return 46 }
        if string == "." { return 47 }
        if string == "TAB" { return 48 }
        if string == "SPACE" { return 49 }
        if string == "`" { return 50 }
        if string == "DELETE" { return 51 }
        if string == "ENTER" { return 52 }
        if string == "ESCAPE" { return 53 }
        if string == "." { return 65 }
        if string == "*" { return 67 }
        if string == "+" { return 69 }
        if string == "CLEAR" { return 71 }
        if string == "/" { return 75 }
        if string == "ENTER" { return 76 }
        if string == "=" { return 78 }
        if string == "=" { return 81 }
        if string == "0" { return 82 }
        if string == "1" { return 83 }
        if string == "2" { return 84 }
        if string == "3" { return 85 }
        if string == "4" { return 86 }
        if string == "5" { return 87 }
        if string == "6" { return 88 }
        if string == "7" { return 89 }
        if string == "8" { return 91 }
        if string == "9" { return 92 }
        if string == "F5" { return 96 }
        if string == "F6" { return 97 }
        if string == "F7" { return 98 }
        if string == "F3" { return 99 }
        if string == "F8" { return 100 }
        if string == "F9" { return 101 }
        if string == "F11" { return 103 }
        if string == "F13" { return 105 }
        if string == "F14" { return 107 }
        if string == "F10" { return 109 }
        if string == "F12" { return 111 }
        if string == "F15" { return 113 }
        if string == "HELP" { return 114 }
        if string == "HOME" { return 115 }
        if string == "PGUP" { return 116 }
        if string == "DELETE" { return 117 }
        if string == "F4" { return 118 }
        if string == "END" { return 119 }
        if string == "F2" { return 120 }
        if string == "PGDN" { return 121 }
        if string == "F1" { return 122 }
        if string == "LEFT" { return 123 }
        if string == "RIGHT" { return 124 }
        if string == "DOWN" { return 125 }
        if string == "UP" { return 126 }
        
        return nil
    }
    
    func string(of keyCode: CGKeyCode) -> String? {
        switch keyCode {
        case 0: return "a"
        case 1: return "s"
        case 2: return "d"
        case 3: return "f"
        case 4: return "h"
        case 5: return "g"
        case 6: return "z"
        case 7: return "x"
        case 8: return "c"
        case 9: return "v"
        case 11: return "b"
        case 12: return "q"
        case 13: return "w"
        case 14: return "e"
        case 15: return "r"
        case 16: return "y"
        case 17: return "t"
        case 18: return "1"
        case 19: return "2"
        case 20: return "3"
        case 21: return "4"
        case 22: return "6"
        case 23: return "5"
        case 24: return "="
        case 25: return "9"
        case 26: return "7"
        case 27: return "-"
        case 28: return "8"
        case 29: return "0"
        case 30: return "]"
        case 31: return "o"
        case 32: return "u"
        case 33: return "["
        case 34: return "i"
        case 35: return "p"
        case 36: return "RETURN"
        case 37: return "l"
        case 38: return "j"
        case 39: return "'"
        case 40: return "k"
        case 41: return ""
        case 42: return "\\"
        case 43: return ","
        case 44: return "/"
        case 45: return "n"
        case 46: return "m"
        case 47: return "."
        case 48: return "TAB"
        case 49: return "SPACE"
        case 50: return "`"
        case 51: return "DELETE"
        case 52: return "ENTER"
        case 53: return "ESCAPE"
        case 65: return "."
        case 67: return "*"
        case 69: return "+"
        case 71: return "CLEAR"
        case 75: return "/"
        case 76: return "ENTER"   // numberpad on full kbd
        case 78: return "-"
        case 81: return "="
        case 82: return "0"
        case 83: return "1"
        case 84: return "2"
        case 85: return "3"
        case 86: return "4"
        case 87: return "5"
        case 88: return "6"
        case 89: return "7"
        case 91: return "8"
        case 92: return "9"
        case 96: return "F5"
        case 97: return "F6"
        case 98: return "F7"
        case 99: return "F3"
        case 100: return "F8"
        case 101: return "F9"
        case 103: return "F11"
        case 105: return "F13"
        case 107: return "F14"
        case 109: return "F10"
        case 111: return "F12"
        case 113: return "F15"
        case 114: return "HELP"
        case 115: return "HOME"
        case 116: return "PGUP"
        case 117: return "DELETE"  // full keyboard right side numberpad
        case 118: return "F4"
        case 119: return "END"
        case 120: return "F2"
        case 121: return "PGDN"
        case 122: return "F1"
        case 123: return "LEFT"
        case 124: return "RIGHT"
        case 125: return "DOWN"
        case 126: return "UP"
        default: return nil
        }
    }
    
}
