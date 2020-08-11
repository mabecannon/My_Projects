import copy
#Let's start by defining 
# import only system from os 
from os import system, name 
  
# import sleep to show output for some time period 
from time import sleep 
  
# define our clear function 
def clear(): 
  
    # for windows 
    if name == 'nt': 
        _ = system('cls') 
class piece:
        def __init__(self, name, posx, posy, col):
            self.name = name
            self.posx = posx
            self.posy = posy
            self.col = col
        def getPiece(self):
            return self.name
        def getColor(self):
            return self.col
        def getPosX(self):
            return self.posx
        def getPosY(self):
            return self.posy
        def setPiece(self, p):
            self.name = p
        def setPosX(self, x):
            self.posx = x
        def setPosY(self, y):
            self.posy = y
        def ToString(self):
            print(name)

master_Game_Board = [
[ piece('r', 'a', '1', 'w'),  piece('p', 'a', '2', 'w'), '',  '',  '', '', piece('p', 'a', '7', 'b'), piece('r', 'a', '8', 'b')],
[ piece('n', 'b', '1', 'w'),  piece('p', 'b', '2', 'w'), '',  '',  '', '', piece('p', 'b', '7', 'b'), piece('n', 'b', '8', 'b')], 
[ piece('b', 'c', '1', 'w'),  piece('p', 'c', '2', 'w'), '',  '',  '', '', piece('p', 'c', '7', 'b'), piece('b', 'c', '8', 'b')], 
[ piece('q', 'd', '1', 'w'),  piece('p', 'd', '2', 'w'), '',  '',  '', '', piece('p', 'd', '7', 'b'), piece('k', 'd', '8', 'b')],
[ piece('k', 'e', '1', 'w'),  piece('p', 'e', '2', 'w'), '',  '',  '', '', piece('p', 'e', '7', 'b'), piece('q', 'e', '8', 'b')],
[ piece('b', 'f', '1', 'w'),  piece('p', 'f', '2', 'w'), '',  '',  '', '', piece('p', 'f', '7', 'b'), piece('b', 'f', '8', 'b')],
[ piece('n', 'g', '1', 'w'),  piece('p', 'g', '2', 'w'), '',  '',  '', '', piece('p', 'g', '7', 'b'), piece('n', 'g', '8', 'b')],
[ piece('r', 'h', '1', 'w'),  piece('p', 'h', '2', 'w'), '',  '',  '', '', piece('p', 'h', '7', 'b'), piece('r', 'h', '8', 'b')]]
#This is a standard board tilted 90deg to the right from the perspective of black (or 90deg left for white)
                                                                                                                                                                          #[x = letter][y = number]  

for x in range(len(master_Game_Board)):
    for y in range(len(master_Game_Board[x])): 
        if master_Game_Board[x][y] == '':
            master_Game_Board[x][y] = piece('', x, y, '')# Fill the game board with empty pieces, will be useful for determining move legality


new_Game = copy.deepcopy(master_Game_Board)# start a new game from the master template

    #With a completed game board, let's define how these pieces can move around the board
    #The board (array) contains info about where the pieces are and so do the pieces themselves
    #A decoder function will make it easier to check the validity of user or AI inputs on pieces of the board
    #Let's do the decoder next!    
def decode_Piece_X(x):
     if x == 'a':
        return 1
     else: 
        if x == 'b':
            return 2
        else:
            if x == 'c':
               return 3
            else:
                if x == 'd':
                   return 4
                else:
                    if x == 'e':
                       return 5
                    else:
                        if x == 'f':
                            return 6
                        else:
                            if x == 'g':
                               return 7
                            else:
                                if x == 'h':
                                   return 8
        
def decode_Piece_Y(y):
    y = int(y)
    print(type(y))
    return y




#Ok let's make a basic move function so that we can use it test some basic validity, thus testing the fundamental structure of the game thus far
def Move(oldX, oldY, newX, newY):
    if new_Game[newX][newY].getPiece() != '':
        if new_Game[newX][newY].getColor() == new_Game[oldX][oldY].getColor(): # return false since you can't have two pieces of the same color on the same square
            return False
        else:
            print("Wow, you took a " + new_Game[newX][newY].getPiece())
    #every move creates an empty space in the old position, regardless of if a piece is captured or not, and the board must be updated    
    new_Game[oldX][oldY].setPosX(newX)
    new_Game[oldX][oldY].setPosY(newY)
    new_Game[newX][newY] = new_Game[oldX][oldY]
    new_Game[oldX][oldY] = piece('', oldX, oldY, '')
    return True





#Let's see what it looks like! What a headache to just try to remember and find where all the pieces are!
def PrintBoard():
  
        for y in range(len(new_Game)):
            print(new_Game[0][y].getPiece(), ' ', new_Game[1][y].getPiece(), ' ', new_Game[2][y].getPiece(), ' ', new_Game[3][y].getPiece(), ' ', new_Game[4][y].getPiece(), ' ', new_Game[5][y].getPiece(), ' ', new_Game[6][y].getPiece(), ' ', new_Game[7][y].getPiece(), ' ' )
        




#Let's just test a pawn since they have a rather complex moveset which can be representative of other sophisticated moves like castling 
def ValidMove(x, y, xNew, yNew):
   if new_Game[x][y].getPiece() == 'p' and new_Game[x][y].getColor() == 'w': # valid moves for white pawns
            if int(yNew) - int(y) == 1: #white pawns can only move in the positive y direction 1 at a time 
                if (xNew - x == 0 and new_Game[xNew][yNew].getPiece() == '') or (abs(xNew - x) == 1 and new_Game[xNew][yNew].getPiece() != ''): #pawns can only have an x value iff they are attacking a piece
                                                                                                                                    #if they aren't attacking, they cannot have an x value
                                                                                                                                    #thus a pawn cannot move forward if there is a piece in the way
                                                                                                                #It can however if there is a piece on either side of its foward path    
                    if yNew == 8:
                        new_Game[x][y].setPiece('q')
                    return Move(x, y, xNew, yNew)
                else: 
                    return False
            else: 
                if yNew - y == 2 and y == 2 and kNew - k == 0 and new_Game[xNew][yNew].getPiece() == '' and new_Game[xNew][yNew - 1].getPiece() == '':
                    return Move(x, y, xNew, yNew)
                else:
                    return False



PrintBoard()
print(ValidMove(0, 1, 0, 2))
clear()
PrintBoard()
#print(master_Game_Board['a']['2'].getPiece())
#print(master_Game_Board['a']['2'].getPosX())
#print(master_Game_Board['a']['2'].getPosY())
#print(master_Game_Board['a']['7'].getPiece())
#print(master_Game_Board['a']['7'].getPosX())
#print(master_Game_Board['a']['7'].getPosY())
  
