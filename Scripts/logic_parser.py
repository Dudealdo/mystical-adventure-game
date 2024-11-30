from generated.GameLogicLexer import GameLogicLexer
from generated.GameLogicParser import GameLogicParser
from antlr4 import *

def main():
    data = InputStream(input('Enter game logic: '))
    lexer = GameLogicLexer(data)
    stream = CommonTokenStream(lexer)
    parser = GameLogicParser(stream)
    tree = parser.action()
    print(f"Parsed: {tree.toStringTree(recog=parser)}")

if __name__ == '__main__':
    main()
