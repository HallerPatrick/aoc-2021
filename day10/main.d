import std.stdio;
import std.string;
import std.file;
import std.conv;


void main() {
    string content = readText("input2.txt");
    string[] lines = splitLines(content);

    
    uint sum = 0;

    foreach (line; lines) {
        char c = parseLine(line);
        sum += matchCharValue(c);
    }

    writeln(sum);
}

int matchCharValue(char c) {
    if (c == ')') {
        return 3;
    }

    if (c == '}') {
        return 1197;

    }

    if (c == ']') {
        return 57;
    }

    if (c == '>') {
        return 25137;
    }

    return 0;
}


// If matching bracket found return true
bool matchBracket(char bracket, char bracket2) {
    if (bracket == '(') {
        if (bracket2 == ')') {
            return true;
        }
    }

    if (bracket == '[') {
        if (bracket2 == ']') {
            return true;
        }
    }

    if (bracket == '{') {
        if (bracket2 == '}') {
            return true;
        }
    }

    if (bracket == '<') {
        if (bracket2 == '>') {
            return true;
        }
    }

    return false;
}

bool isClosingBracket(char bracket) {
    return bracket == ')' || bracket == ']' || bracket == '}' || bracket == '>';
}



// Returns either the error bracket or empty string if all correct
char parseLine(string line) {
    
    char[] stack = [];


    foreach (c; line) {

        if (isClosingBracket(c)) {

            /* if (stack.length == 0) { */
            /*     return c; */
            /* } */

            char top = stack[stack.length -1];
                
            if (matchBracket(top, c)) {
                write("Found matching: ");
                writeln(c);
                int head = to!int(stack.length - 1 );
                writeln(stack);
                stack = stack[0 .. head];
                writeln(stack);
            } else {
                write("CORRUPT WITH: ");
                writeln(c);
                    
                return c;
            }
        } else {
            stack ~= c;
        }


    }

    return 'e';
}
