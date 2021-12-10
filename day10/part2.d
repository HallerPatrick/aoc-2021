import std.stdio;
import std.string;
import std.file;
import std.conv;
import std.algorithm;
import std.math;


void main() {
    string content = readText("input2.txt");
    string[] lines = splitLines(content);


    ulong[] scores = [];

    foreach (line; lines) {
        ulong score = 0;
        char[] characters = parseIncomplete(line);
        
        writeln(characters);

        if (characters.length == 0) {
            continue;
        }


        foreach(l; characters) {
            score = (score * 5) + charToPoint(l);
        }


        scores ~= score;
    }
        
    writeln(scores);
    scores.sort();
    writeln(scores[to!ulong(round(scores.length / 2))]);
    /* writeln(scores[to!ulong(round(scores.length / 2))]); */

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

int charToPoint(char c) {

    if (c == ')') {
        return 1;
    }

    if (c == '}') {
        return 3;

    }

    if (c == ']') {
        return 2;
    }

    if (c == '>') {
        return 4; 
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


char getMatchinBracket(char bracket) {
    if (bracket == '(') return ')';
    if (bracket == '[') return ']';
    if (bracket == '{') return '}';
    if (bracket == '<') return '>';
    return 'e';
}



// Returns either the error bracket or empty string if all correct
char[] parseIncomplete(string line) {

    char[] completeChars = [];
    
    char[] stack = [];


    foreach (c; line) {

        if (isClosingBracket(c)) {

            char top = stack[stack.length -1];
                
            if (matchBracket(top, c)) {
                int head = to!int(stack.length - 1 );
                stack = stack[0 .. head];
            } else {
                // If corrupt, empty 
                return [];
            }
        } else {
            stack ~= c;
        }
    }
    
    for (int i=to!int(stack.length- 1); i >= 0; i--) {
        completeChars ~= getMatchinBracket(stack[i]);
    } 

    return completeChars;
}
