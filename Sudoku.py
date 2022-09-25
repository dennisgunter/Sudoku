#The Sudoku Game
#Version 1.0
#Last Update: 20.03.2020

#Imports
import sys,pygame,random,time

#Pygame Init
pygame.init()

#all for pygame and the window
clock = pygame.time.Clock()
size = width, height = 900, 900         #size of the window
screen = pygame.display.set_mode(size)  #screen
surface = pygame.display.get_surface()


#definition of color variables
black = (0, 0, 0)                   
blue = (0,0, 255)                   
red = (255,0,0)                     
white = (255,255,255)
green = (0,255,0)






while True:
    mouse_X = pygame.mouse.get_pos()[0]
    mouse_Y = pygame.mouse.get_pos()[1]

    
    #handles the shutting down of the programm
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            sys.exit()

    keys = pygame.key.get_pressed() #gets the pressed keys



    #updating the screen
    screen.fill(white)
    for i in range()
    pygame.draw.rect(surface, black, (300,0,2,900), 0)
   
    


    clock.tick(30) #new frame
    pygame.display.flip()    
