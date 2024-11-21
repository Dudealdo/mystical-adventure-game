# Generated from /home/dude/mystical_adventure_game/Scripts/game_logic.g4 by ANTLR 4.11.1
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .game_logicParser import game_logicParser
else:
    from game_logicParser import game_logicParser

# This class defines a complete listener for a parse tree produced by game_logicParser.
class game_logicListener(ParseTreeListener):

    # Enter a parse tree produced by game_logicParser#action.
    def enterAction(self, ctx:game_logicParser.ActionContext):
        pass

    # Exit a parse tree produced by game_logicParser#action.
    def exitAction(self, ctx:game_logicParser.ActionContext):
        pass


    # Enter a parse tree produced by game_logicParser#event.
    def enterEvent(self, ctx:game_logicParser.EventContext):
        pass

    # Exit a parse tree produced by game_logicParser#event.
    def exitEvent(self, ctx:game_logicParser.EventContext):
        pass


    # Enter a parse tree produced by game_logicParser#object.
    def enterObject(self, ctx:game_logicParser.ObjectContext):
        pass

    # Exit a parse tree produced by game_logicParser#object.
    def exitObject(self, ctx:game_logicParser.ObjectContext):
        pass


    # Enter a parse tree produced by game_logicParser#command.
    def enterCommand(self, ctx:game_logicParser.CommandContext):
        pass

    # Exit a parse tree produced by game_logicParser#command.
    def exitCommand(self, ctx:game_logicParser.CommandContext):
        pass



del game_logicParser