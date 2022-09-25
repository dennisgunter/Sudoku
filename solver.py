import random


sudoku = [[0,1,0 , 0,3,4 , 0,0,0],
          [0,0,0 , 0,7,0 , 0,2,0],
          [3,4,2 , 0,0,0 , 0,0,0],
          
          [4,3,8 , 0,0,0 , 0,0,0],
          [0,0,0 , 0,0,0 , 5,6,0],
          [0,0,0 , 0,4,9 , 0,0,0],
          
          [8,0,0 , 7,0,0 , 0,0,9],
          [0,0,0 , 9,0,5 , 1,0,7],
          [9,0,3 , 0,0,0 , 0,0,0],
 ]





def findNextCellToFill(grid, i, j):
        for x in range(i,9):
                for y in range(j,9):
                        if grid[x][y] == 0:
                                return x,y
        for x in range(0,9):
                for y in range(0,9):
                        if grid[x][y] == 0:
                                return x,y
        return -1,-1

def isValid(grid, i, j, e):
        rowOk = all([e != grid[i][x] for x in range(9)])
        if rowOk:
                columnOk = all([e != grid[x][j] for x in range(9)])
                if columnOk:
                        # finding the top left x,y co-ordinates of the section containing the i,j cell
                        secTopX, secTopY = 3 *(i//3), 3 *(j//3) #floored quotient should be used here. 
                        for x in range(secTopX, secTopX+3):
                                for y in range(secTopY, secTopY+3):
                                        if grid[x][y] == e:
                                                return False
                        return True
        return False

def solveSudoku(grid, i=0, j=0):
        i,j = findNextCellToFill(grid, i, j)
        if i == -1:
                return True
        for e in range(1,10):
                if isValid(grid,i,j,e):
                        grid[i][j] = e
                        if solveSudoku(grid, i, j):
                                return True
                        # Undo the current cell for backtracking
                        grid[i][j] = 0
        return False


solveSudoku(sudoku)



counter = 0
test = sudoku.copy()
ab = sudoku.copy()


while counter < 30:

    a = random.randint(0,8)
    b = random.randint(0,8)
    
 
    if test[a][b] != 0:        
        save = test[a][b]
        test[a][b] = 0
                
        if solveSudoku(test):
            counter += 1
            ab[a][b] = 0

        else:
            test[a][b] = save


                    
            




print(ab)
















