import copy
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

master_Game_Board = {
'a':{ '1': piece('r', 'a', '1', 'w'),  '2':piece('p', 'a', '2', 'w'), '3': '', '4': '', '5': '', '6': '', '7': piece('p', 'a', '7', 'b'), '8': piece('r', 'a', '8', 'b')},
'b':{ '1': piece('n', 'b', '1', 'w'),  '2':piece('p', 'b', '2', 'w'), '3': '', '4': '', '5': '', '6': '', '7': piece('p', 'b', '7', 'b'), '8': piece('n', 'b', '8', 'b')}, 
'c':{ '1': piece('b', 'c', '1', 'w'),  '2':piece('p', 'c', '2', 'w'), '3': '', '4': '', '5': '', '6': '', '7': piece('p', 'c', '7', 'b'), '8': piece('b', 'c', '8', 'b')}, 
'd':{ '1': piece('q', 'd', '1', 'w'),  '2':piece('p', 'd', '2', 'w'), '3': '', '4': '', '5': '', '6': '', '7': piece('p', 'd', '7', 'b'), '8': piece('k', 'd', '8', 'b')},
'e':{ '1': piece('k', 'e', '1', 'w'),  '2':piece('p', 'e', '2', 'w'), '3': '', '4': '', '5': '', '6': '', '7': piece('p', 'e', '7', 'b'), '8': piece('q', 'e', '8', 'b')},
'f':{ '1': piece('b', 'f', '1', 'w'),  '2':piece('p', 'f', '2', 'w'), '3': '', '4': '', '5': '', '6': '', '7': piece('p', 'f', '7', 'b'), '8': piece('b', 'f', '8', 'b')},
'g':{ '1': piece('n', 'g', '1', 'w'),  '2':piece('p', 'g', '2', 'w'), '3': '', '4': '', '5': '', '6': '', '7': piece('p', 'g', '7', 'b'), '8': piece('n', 'g', '8', 'b')},
'h':{ '1': piece('r', 'h', '1', 'w'),  '2':piece('p', 'h', '2', 'w'), '3': '', '4': '', '5': '', '6': '', '7': piece('p', 'h', '7', 'b'), '8': piece('r', 'h', '8', 'b')}}

for x in master_Game_Board:
    for y in x: 
        if y == '':
            y = piece('', x, y, '')# Fill the game board with empty pieces, will be useful for determining move legality


new_Game = copy.deepcopy(master_Game_Board)# start a new game from the master template

def Move(oldX, oldY, newX, newY):
    if new_Game[newX][newY].getPiece() != '':
        if new_Game[newX][newY].getColor() == new_Game[oldX][oldY].getColor(): # return false since you can't have two pieces of the same color on the same square
            return False
        else:
            print("Wow, you took a " + new_Game[newX][newY].getPiece())
    del new_Game[newX][newY]
    new_Game[oldX][oldY].setPosX(newX)
    new_Game[oldX][oldY].setPosY(newY)
    new_Game[newX][newY] = new_Game[oldX][oldY]
    new_Game[oldX][oldY] = piece('', oldX, oldY, '')
    return True

def ValidMove(piece, x, y, xP, yP):
    if x == 'a':
        k = 1
    else: 
        if x == 'b':
            k = 2
        else:
            if x == 'c':
                k = 3
            else:
                if x == 'd':
                    k = 4
                else:
                    if x == 'e':
                        k = 5
                    else:
                        if x == 'f':
                            k = 6
                        else:
                            if x == 'g':
                                k = 7
                            else:
                                if x == 'h':
                                    k = 8
    
                                    
    if xP == 'a':
        kP = 1
    else: 
        if xP == 'b':
            kP = 2
        else:
            if xP == 'c':
                kP = 3
            else:
                if xP == 'd':
                    kP = 4
                else:
                    if xP == 'e':
                        kP = 5
                    else:
                        if xP == 'f':
                            kP = 6
                        else:
                            if xP == 'g':
                                kP = 7
                            else:
                                if xP == 'h':
                                    kP = 8
    #add decoder for y values; strings are no good for comparing
    if new_Game[x][y].getPiece() == 'p' and  new_Game[x][y].getColor() == 'w': # valid moves for pawns
            if yP - y == 1:
                if (kP - k == 0 and new_Game[xP][yP].getPiece() == '') or (abs(kP - k) == 1 and new_Game[xP][yP].getPiece() != ''):
                    if yP == 8:
                        new_Game[x][y].setPiece('q')
                    return Move(x, y, xP, yP)
                else: 
                    return False
            else: 
                if yP - y == 2 and y == 2 and kP - k == 0 and new_Game[xP][yP].getPiece() == '' and new_Game[xP][yP - 1].getPiece() == '':
                    return Move(x, y, xP, yP)
                else:
                    return False





print(ValidMove('p', 'a', '2', 'a', '3'))
print(master_Game_Board['a']['2'].getPiece())
print(master_Game_Board['a']['2'].getPosX())
print(master_Game_Board['a']['2'].getPosY())
print(master_Game_Board['a']['7'].getPiece())
print(master_Game_Board['a']['7'].getPosX())
print(master_Game_Board['a']['7'].getPosY())
  