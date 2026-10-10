
local black = '#121212'

local lexers = vis.lexers

lexers.STYLE_DEFAULT = 'back:'..black..',fore:#b4b4b4'
lexers.STYLE_NOTHING = 'back:'..black
lexers.STYLE_COMMENT = 'fore:#737373'
lexers.STYLE_CONSTANT = 'fore:#c4693d'
lexers.STYLE_ERROR = 'back:#c53030,fore:#e5e5e5'
lexers.STYLE_FUNCTION = 'fore:#e5e5e5'
lexers.STYLE_KEYWORD = 'fore:#e5e5e5'
lexers.STYLE_LABEL = 'fore:#e5e5e5'
lexers.STYLE_NUMBER = 'fore:#c4693d'
lexers.STYLE_OPERATOR = 'fore:#e0e2ea'
lexers.STYLE_STRING = 'fore:#df6464'
lexers.STYLE_PREPROCESSOR = 'fore:#b14242'
lexers.STYLE_TAG = 'fore:#949494'
lexers.STYLE_TYPE = 'fore:#c4693d'
lexers.STYLE_WHITESPACE = 'fore:#535353'
lexers.STYLE_IDENTIFIER = 'fore:#e5e5e5'
lexers.STYLE_CODE = 'fore:#df6464'

lexers.STYLE_LINENUMBER = 'back:'..black..',fore:#323232'
lexers.STYLE_LINENUMBER_CURSOR =  'back:#212121,fore:#737373'
lexers.STYLE_CURSOR = 'back:#212121,fore:#737373'
lexers.STYLE_CURSOR_PRIMARY = 'back:#949494,bold,fore:#121212'
lexers.STYLE_CURSOR_LINE = 'back:#212121'
lexers.STYLE_COLOR_COLUMN = 'back:#323232'
lexers.STYLE_SELECTION = 'back:#323232'
lexers.STYLE_STATUS = 'back:#2c2e33,fore:#c4c6cd'
lexers.STYLE_STATUS_FOCUSED = 'back:#323232,fore:#949494'
lexers.STYLE_EOF = 'back:'..black..',fore:#323232'