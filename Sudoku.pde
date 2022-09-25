class Field {
  String entry;
  int x;
  int y;
  int h;
  int w;
  int row;
  int column;
  color col;
  color bg;
  boolean first = false;
  int number;
 
 
  
  Field(int new_x,int new_y,int new_w,int new_h,color new_col,int new_row,int new_column,String new_entry,int new_number){
    x = new_x;
    y = new_y;
    w = new_w;
    h = new_h;
    row = new_row;
    column = new_column;
    col = new_col;
    bg = white;
    number = new_number;
    
    entry = new_entry;
    
    
  }
  

  
   void update(){
     strokeWeight(1);
     fill(bg);
     rect(x,y,w,h);
     
      
     textFont(font,60);
     if(first == true){ textFont(f2,60);}
     fill(col);
     textAlign(CENTER);
     text(entry,x+w/2,y+h*0.7);
   }
     
   void changeNumber(String new_entry){
     entry = new_entry;
   }
   
  void changeColor(color new_col){
    col = new_col; }
    
   void changeBG(color new_bg){
    bg = new_bg;
   }
   
   void changeN(int new_n){
    number = new_n;
   }
}

int counter;
int countsec;
Field time;
Field ok;

PFont font;
PFont f2;
Field[] fields = new Field[81];
int actrow = -1;
int actcolumn = -1;
boolean block;
int gamemode = 0;

Field easy;
Field medium;
Field hard;

String diffi;

Field backbox;
Field backyes;
Field backno;


boolean setupbool = true;
boolean isSolved;

color white = color(255);
color black = color(0);
color red = color(255,0,0);
color grey = color(222);

String[] lines;

String sodukostring = "000000000000000000000000000000000000000000000000000000000000000000000000000000000";
String[] ss;
int [] sudoku = new int[81];


/*  
int[] sudoku = {0,0,0 , 0,0,0 , 0,0,0 ,
                0,2,0 , 0,0,0 , 0,0,0 ,
                0,0,0 , 0,0,0 , 0,0,0 ,
                
                0,0,0 , 0,0,0 , 0,0,0 ,
                0,0,0 , 0,0,0 , 0,0,3 ,
                0,0,0 , 0,0,1 , 0,0,0 ,
                
                0,0,0 , 0,0,0 , 0,0,0 ,
                0,0,0 , 0,0,0 , 0,0,0 ,
                0,0,0 , 0,0,0 , 0,0,0  };   */


void changeNumbers(int[] sudokulist){
  for (int i=0;i<81;i++){
    if (sudokulist[i] != 0){
      fields[i].first = false;
      fields[i].changeNumber(Integer.toString(sudokulist[i]));
      fields[i].changeN(sudokulist[i]);
    } else{fields[i].first = true;}
  }
}



void gameSetup(String data){
  counter  = 0;
  countsec = 0;
  
  //String to Sudoku Array
  lines = loadStrings(data);
  sodukostring = lines[(int)random(0,lines.length)]; 
  ss = sodukostring.split("");
  
  for(int i =0;i<81;i++){
    sudoku[i] = Integer.parseInt(ss[i]);
  }
  
   
  //creating Fields
  for (int index=0;index<81;index++){
        fields[index] = new Field(100*(index%9),100*(index/9),100,100,black,index/9,index%9,"",0);
        
    }
    
  //creates sudokulist
  changeNumbers(sudoku);
  
  setupbool = false;

}



void menuSetup(){
  fill(255);
  rect(0,0,width,height);
  easy = new Field(200,150,500,100,black,0,0,"Easy",0);
  medium = new Field(200,300,500,100,black,0,0,"Medium",0);
  hard = new Field(200,450,500,100,black,0,0,"Hard",0);
  setupbool = false;
}

void menu(){
  easy.update();
  medium.update();
  hard.update();
}

void solvedSetup(){
  background(255);
  time = new Field(150,250,600,100,black,0,0,Integer.toString(countsec) + " Sekunden",0);
  ok = new Field(300,700,300,100,black,0,0,"OK",0);
}

void solved(){
  time.update();
  ok.update();
}

void backSetup(){
  backbox = new Field(150,250,600,100,black,0,0,"Back to Menu?",0);
  backyes = new Field(150,350,300,100,black,0,0,"Yes",0);
  backno = new Field(450,350,300,100,black,0,0,"No",0);
  
  setupbool = false;
}

void backtom(){
  backbox.update();
  backyes.update();
  backno.update();

}


void game(){
  counter ++;
  if(counter >= 60){
    counter = 0;
    countsec++;
  }
  
  for (Field obj:fields){
    obj.update();
    obj.changeBG(white);
    if(obj.row == actrow && obj.column == actcolumn && obj.first){obj.changeBG(grey);}  else if(obj.row == actrow && obj.column == actcolumn){obj.changeBG(245); }
  }
  
  for (int i=0;i<4;i++){
      strokeWeight(4);
      line(300*i,0,300*i,height);
      line(0,300*i,width,300*i);
   }
   
   isSolved = true;
   for(Field ff:fields){
     if (ff.col == red || ff.number == 0){
       isSolved = false;
       break;
     }
   }
   
   if(isSolved){setupbool = true; gamemode=3;}



}

void setup(){
  //all for the window
  size(900,900);
  background(255);
  frameRate(60);

  //creating font
  font = createFont("Arial Black",48,true);
  f2 = createFont("Lucida Handwriting",48,true);
  



}


void draw(){
  if (gamemode == 1){
   if(setupbool){gameSetup(diffi);}
   game();}
  else if (gamemode == 0){
    if(setupbool){menuSetup();}
    menu(); 
   }
   else if(gamemode == 2){
      if (setupbool == true){backSetup();}
      backtom();
   }
   else if(gamemode == 3){
     if (setupbool == true){solvedSetup();}
      solved();
   }


}


void mousePressed(){
  if (gamemode ==1){
  actrow = mouseY / 100;
  actcolumn = mouseX / 100;
  }
  else if(gamemode == 0) {
    if (mouseX <= 700 && mouseX >= 200 && mouseY >= 150 && mouseY <= 250){
      diffi = "easy.txt";
      setupbool = true;
      gamemode = 1;
    }
    else if (mouseX <= 700 && mouseX >= 200 && mouseY >= 300 && mouseY <= 400){
      diffi = "medium.txt";
      setupbool = true;
      gamemode = 1;
    }
    else if(mouseX <= 700 && mouseX >= 200 && mouseY >= 450 && mouseY <= 550){
      diffi = "hard.txt";
      setupbool = true;
      gamemode = 1;
    }
  }
  else if(gamemode == 2) {
    if (mouseX < 450 && mouseX >= 150 && mouseY >= 350 && mouseY <= 450){
      setupbool = true;
      gamemode = 0;
    }
    else if (mouseX <= 750 && mouseX >= 450 && mouseY >= 350 && mouseY <= 450){
      gamemode = 1;
    }
  }
  else if(gamemode == 3){
    if (mouseX <= 600 && mouseX >= 300 && mouseY >= 700 && mouseY <= 800){
      setupbool = true;
      gamemode = 0;
    }
    
  }
    
}

void keyPressed(){
  if(gamemode == 1){
    if(keyCode==ENTER){
      setupbool = true;
      gamemode = 2;
    }
    
    if (keyCode==UP && actrow > 0 ){actrow--;}
    if (keyCode==DOWN && actrow < 8){actrow++;}
    if (keyCode==LEFT && actcolumn > 0 ){actcolumn--;}
    if (keyCode==RIGHT &&  actcolumn < 8){actcolumn++;}
  
    for(Field obj:fields){if (key=='-'){
         if (obj.row == actrow && obj.column == actcolumn && obj.first){
           obj.changeNumber("");
           obj.changeN(0);
       }}}
  
  
    for (int i=1;i<=9;i++){
      if (key == i +'0'){    
        for(Field obj:fields){
          if (obj.row == actrow && obj.column == actcolumn && obj.first){
            obj.changeNumber(Integer.toString(i));
            obj.changeN(i);
      
            obj.changeColor(black);
            block = false;
            for(Field p:fields){
            
              if((p.column != obj.column) && (p.row == obj.row) && (p.number == obj.number)){
                obj.changeColor(red);
              }
              else if ((p.column == obj.column) && (p.row != obj.row)  && (p.number == obj.number)){
                obj.changeColor(red);
              }
               
              else{
                int rr = (actrow/3);
                int cc = (actcolumn/3);
                int ur = rr*3;
                int uc = cc*3;
                for (int r=ur;r<ur+3;r++){
                  for(int c=uc;c<uc+3;c++){
                    if(p.number == obj.number && p.row == r && p.column == c && p != obj){block=true;}
                  }
                }
                
                
                if(block){
                  obj.changeColor(red);
                }
              } 
              
            
            }
            
      }
        }
      
      
      }}
    }
    else if(gamemode == 3){
      if(keyCode==ENTER){
        setupbool = true;
        gamemode = 0;
      }
    }
              
  
}
