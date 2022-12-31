import java.util.*;

PImage[] plw; //left walking animation
PImage pl; //left still
PImage[] prw; //right walking animation
PImage pr; //right still
PImage pf; //front still
String p; //rs: right still, rw: right walk, ls: left still, lw: left walk
int wi = 2;
int scene = 0; //scene
int px = 20; //person x-coord
int transp1 = 305; //transparency variable 1
int transp2 = -305; //transparency variable 2
boolean fadein = true; //fade in
int transition = 1; //0: no transition, 1: fade in, 2: fade out
ArrayList<Integer> choices = new ArrayList<Integer>();

void setup() {
    size(1000,600);
    p = "rs";
    textFont(loadFont("PressStart2P-Regular-100.vlw"));
    plw = new PImage[4];
    for(int i=0;i<4;i++) plw[i] = loadImage("pleftw"+(i+1)+".png");
    pl = loadImage("pleft.png");
    prw = new PImage[4];
    for(int i=0;i<4;i++) prw[i] = loadImage("prightw"+(i+1)+".png");
    pr = loadImage("pright.png");
    pf = loadImage("front.png");
    background(0);
}

void draw() {
    if(scene==0) {
        title();
    } else if(scene==1) {
        intro();
    } else if(scene==2) {
        scene1();
    } else if(scene==3) {
        scene2();
    } else if(scene==4) {
        scene3();
    } else if(scene==5) {
        scene4();
    } else if(scene==6) {
        scene5();
    } else if(scene==7) {
        scene6();
    } else if(scene==8) {
        conclusion();
    } else if(scene==9) {
        theEnd();
    }
    if(transition == 1) {
        fadeIn();
    } else if(transition == 2) {
        fadeOut();
    } 
}

void fadeIn() {
    stroke(0,0,0,0);
    fill(0,transp1);
    rect(0,0,1000,600);
    if(transp1>0) transp1 -= 4;
    else transition = 0;
}

void fadeOut() {
    stroke(0,0,0,0);
    fill(0,transp1);
    rect(0,0,1000,600);
    if(transp1<255) transp1 += 4;
    else {
        transition = 1;
        transp2 = -50;
        scene ++;
        if(scene>=2 && scene<5) {
            px = 20;
            textscene = 0;
        } else if(scene>=5 && scene<7) {
            px = 820;
            p = "ls";
            textscene = 0;
        } else if(scene==7) {
            px = 670;
            p = "ls";
            textscene = 0;
        }
    }
}

void title() {
    textAlign(CENTER);
    background(0);
    if(fadein) transp2 += 3;
    else transp2 -= 3;
    if(transp2 >= 255) fadein = false;
    else if(transp2 <= 100) fadein = true;
    textSize(25);
    fill(255);
    text("GROCERY RUN: COVID-19 EDITION",500,300);
    textSize(15);
    fill(255, transp2);
    text("press any key to continue",500,350);
    if(keyPressed && transition == 0) {
        transp1 = 0;
        transition = 2;
    }
}

void intro() {
    textAlign(CENTER);
    background(0);
    if(fadein) transp2 += 3;
    else transp2 -= 3;
    if(transp2 >= 255) fadein = false;
    else if(transp2 <= 100) fadein = true;
    textSize(25);
    fill(255);
    text("use A and D to move left and right",500,300);
    textSize(15);
    fill(255, transp2);
    text("press any key to continue",500,350);
    if(keyPressed && transition == 0) {
        transp1 = 0;
        transition = 2;
    }
}

int cnt = 0;
void drawp() {
    if(p.equals("rw") && transition!=0) {
        p = "rs";
    } else if(p.equals("lw") && transition!=0) {
        p = "ls";
    }
    if(textscene%2==1 || minigame) {
        image(pf,px,270);
        cnt=0;
        wi=2;
    } else if(p.equals("rs")) {
        image(pr,px,270);
        cnt=0;
        wi=2;
    } else if(p.equals("rw")) {
        image(prw[wi],px,270);
        if(cnt==20) {
            wi++; wi%=4; cnt=0;
        }
        cnt++;
    } else if(p.equals("ls")) {
        image(pl,px,270);
        cnt=0;
        wi=2;
    } else if(p.equals("lw")) {
        image(plw[wi],px,270);
        if(cnt==20) {
            wi++; wi%=4; cnt=0;
        }
        cnt++;
    }
    if(choices.size()>0 && choices.get(0)==1) {
        if(textscene%2==1 || minigame) {
            image(loadImage("mask3.png"),px,270);
        }
        else if(p.equals("rs")) image(loadImage("mask1.png"),px,270);
        else if(p.equals("rw")) {
            if(wi%2==0) image(loadImage("mask1.png"),px,274);
            else image(loadImage("mask1.png"),px,270);
        }
        else if(p.equals("ls")) image(loadImage("mask2.png"),px,270);
        else if(p.equals("lw")) {
            if(wi%2==0) image(loadImage("mask2.png"),px,274);
            else image(loadImage("mask2.png"),px,270);
        }
    }
}

int textscene = 0;
void drawbox(int h) {
    fill(255);
    rect(50,30,900,h+25);
    fill(0);
    rect(60,40,880,h+5);
    fill(255);
}

int i=0;
int score = 0;
void scene1() {
    textAlign(LEFT);
    background(loadImage("bg1.png"));
    if(px >= 300 && textscene == 0) {
        textscene = 1;
    } else if(px >= 500 && textscene == 2) {
        textscene = 3;
    } else if(px >= 670 && transition == 0) {
        transp1 = 0;
        transition = 2;
    }
    drawp();
    if(textscene == 1) {
        drawbox(160);
        textSize(15);
        text("You need to go to the supermarket.",75,85);
        text("Will you wear a face mask?",75,115);
        text("1) Yes",75,155);
        text("2) No",75,180);
        if(keyPressed) {
            if(key=='1' || key=='2') {
                choices.add(key-'0');
                textscene = 2;
            }
        }
    } else if(textscene == 3 && i<6) {
        drawbox(140);
        String[] items = {"a reusable tote bag","tissues","a credit card","cash","hand sanitizer","a camera"};
        textSize(15);
        text("Will you bring "+items[i]+" with you?",75,85);
        text("1) Yes",75,125);
        text("2) No",75,150);
        PImage image = loadImage("item"+(i+1)+".png");
        image(image,810,60);
    } else if(i==6) {
        textscene = 4;
    }
}

void scene2() {
    image(loadImage("bg2.png"),0,0);
    if(px >= 300 && textscene == 0) {
        textscene = 1;
    } else if(px>=500 && textscene == 2) {
        textscene = 3;
        timer = 0;
    } else if(px >= 800 && transition == 0) {
        transp1 = 0;
        transition = 2;
    }
    drawp();
    if(textscene == 1) {
        drawbox(190);
        textSize(15);
        text("Which route will you take?",75,85);
        text("1) A direct route that's usually crowded...",75,125);
        text("   (You are lazy).",70,150);
        text("2) A 10 minute detour that has less people...",75,175);
        text("   (Exercise wouldn't hurt).",70,200);
        if(keyPressed) {
            if(key=='1' || key=='2') {
                choices.add(key-'0');
                textscene = 2;
            }
        }
    } else if(textscene == 3) {
        if(timer<120) {
            timer ++;
            drawbox(90);
            textSize(15);
            text("You need to cross the road.",75,85);
            text("Pay attention to the lights!",75,110);
        } else if(timer==120) {
            timer = 500;
        } else {
            scene2_A();
            if(timer==200) {
                transp1 = 0;
                transition = 2;
            }
        }
    }
}

int count = 0;
int light = 0; //color
int dist = 500; //distance traveled
void scene2_A() {
    background(0);
    if(timer==500) {
      textAlign(LEFT);
      fill(255);
      textSize(15);
      text("Press the UP key during a green light.",20,60);
      text("Press the DOWN key during a yellow light.",20,85);
      text("Press the SPACE key during a red light.",20,110);
      stroke(235, 59, 47);
      strokeWeight(5);
      line(650,510,810,510);
      line(650,90,810,90);
      PImage red, green, yellow;
      red = loadImage("red.png");
      red.resize(120,200);
      green = loadImage("green.png");
      green.resize(120,200);
      yellow = loadImage("yellow.png");
      yellow.resize(120,200);
      count++;
      if (dist <= 100) {
        timer = 320;
      }
      if (light == 0) {
        image(red, 100, 300);
        if (!keyPressed && dist<350)
          dist++;
      } else if (light == 1) {
        image(green, 100, 300);
        if (!keyPressed && dist<450) {
          dist++;
        }
      } else if (light == 2) {
        image(yellow, 100, 300);
        if (!keyPressed && dist<450) {
          dist++;
        }
      }
      PImage head = loadImage("ptop1.png");
      head.resize(60,60);
      image(head, 700, dist);
      if (count >= 120 && count % 120 == 0) {
        light = (int)(3*Math.random());
        if (light == 0) {
          image(red, 100, 300);
          if (!keyPressed && dist<450) {
            dist++;
          }
        } else if (light == 1) {
          image(green, 100, 300);
          if (!keyPressed && dist<450) {
            dist++;
          }
        } else {
          image(yellow, 100, 300);
          if (!keyPressed && dist<450) {
            dist++;
          }
        }
        image(head, 700, dist);
      }
    } else {
        textAlign(CENTER);
        text("You successfully crossed the road.",500,300);
        textAlign(LEFT);
        timer--;
    }
}

boolean minigame = false;
void scene3() {
    image(loadImage("bg3.png"),0,0);
    if(px >= 100 && textscene == 0) {
        textscene = 1;
        timer = 0;
    } else if(px >= 300 && textscene == 2) {
        textscene = 3;
    } else if(px >= 580 && textscene == 4) {
        textscene = 5;
    } else if((px >= 800 && transition == 0) || (px<=100 && textscene == 6 && transition == 0)) {
        transp1 = 0;
        transition = 2;
    }
    drawp();
    if(textscene == 1) {
        drawbox(155);
        textSize(15);
        text("Should I sanitize my hands before beginning to shop?",75,85);
        text("1) Yes, it can reduce the amount of germs and bacteria",75,125);
        text("   on your hands.",70,150);
        text("2) No, it wont make a difference and it's such a hassle.",75,175);
        if(keyPressed) {
            if(key=='1' || key=='2') {
                choices.add(key-'0');
                textscene = 2;
            }
        }
    } else if(textscene == 3) {
        drawbox(155);
        textSize(15);
        text("Oh, your phone is ringing! Should you pick it up?",75,85);
        text("1) Yes, it could be urgent!",75,125);
        text("2) No, you should avoid touching my phone to prevent",75,150);
        text("   the virus from getting on it.",70,175);
        if(keyPressed) {
            if(key=='1' || key=='2') {
                choices.add(key-'0');
                textscene = 4;
            }
        }
    } else if(textscene == 5) {
        drawbox(205);
        textSize(15);
        text("You consider sorting through all the apples to pick",75,85);
        text("the ripest reddest, and juiciest ones?",75,110);
        text("1) Yes, you came all the way to the grocery store,",75,150);
        text("   might as well.",70,175);
        text("2) No, you should only touch items you will be buying.",75,200);
        text("   Be considerate!",70,225);
        if(keyPressed) {
            if(key=='1' || key=='2') {
                choices.add(key-'0');
                textscene = 6;
                minigame = true;
            }
        }
    } else if(minigame) {
        if(timer<120) {
            timer ++;
            drawbox(65);
            textSize(15);
            text("You accidentally knocked over the apples!",75,85);
        } else if(timer==120) {
            timer = 920;
            for(int i=0; i<12; i++) {
                ax[i] = (int)random(200,770);
                ay[i] = -30+i*(-120);
            }
        }
        if(timer > 200) {
            timer--;
            scene3_A();
        } else if(timer==200) {
            textscene = 6;
            minigame = false;
        }
    } 
}

int timer = 0;
int bx = 20;
int caught = 0;
int[] ax = new int[12];
int[] ay = new int[12];
void scene3_A() { //apple catching - "minigame"
    background(0);
    textSize(15);
    if(timer > 320) {
        textAlign(LEFT);
        text("Quick! Catch the apples in your bag!",20,40);
        text("Time left: "+((timer-320)/60)+" seconds",20,65);
        text("Apples caught: "+caught+"",20,90);
        PImage bag = loadImage("item1.png");
        PImage apple = loadImage("apple.png");
        image(bag,bx,400);
        for(int i=0; i<12; i++) {
            image(apple,ax[i],ay[i]);
            if(ax[i] >= bx && ax[i] <= bx+70 && ay[i] >= 400 && ay[i] <= 460) {
                ay[i] = 600;
                caught++;
            }
            ay[i]+=3;
        }
        if(keyPressed) {
            if((key=='d' || key=='D') && bx <= 840) {
                bx+=15;
            } else if((key=='a' || key=='A') && bx >= 20) {
                bx-=15;
            } 
        }
    } else {
        textAlign(CENTER);
        text("You caught "+caught+" out of 12 apples.",500,300);
    }
}

void scene4() { //discover flyer
    textAlign(LEFT);
    image(loadImage("bg2.png"),0,0);
    image(loadImage("paper.png"),330,500);
    if(px <= 700 && textscene == 0) {
        textscene = 1;
        timer = 0;
    } else if(px <= 500 && textscene == 2) {
        textscene = 3;
    }
    drawp();
    if(textscene == 1) {
        drawbox(155);
        textSize(15);
        text("Argh, your eye is very itchy. You consider rubbing it.",75,85);
        text("1) Yes, go take care of that itch!",75,125);
        text("2) No, there could be bacteria on your fingers.",75,150);
        text("   wait until you wash your hands first.",70,175);
    } else if(textscene == 3) {
        if(timer<120 && !minigame) {
            timer++;
            if(timer==120) {
                timer = 121;
                minigame = true;
            }
            drawbox(65);
            textSize(15);
            text("What is this? A flyer?",75,85);
        } 
        if((minigame && timer==121) || transition==2) {
            scene4_A();
        }
    } 
}

void scene4_A() { //flyer reading - "minigame"
    textAlign(LEFT);
    background(0);
    textSize(15);
    fill(255);
    text("You read the flyer as you walk home.",20,40);
    text("Press SPACE to continue.",20,65);
    PImage flyer = loadImage("flyer.png");
    flyer.resize(340,480);
    image(flyer,330,100);
    if(keyPressed && key==' ') {
        minigame = false;
        transp1 = 0;
        transition = 2;
    }
}

int tx = 760;
int ty = 304;
PImage pt;
void scene5() { //maze
    image(loadImage("bg4.png"),0,0);
    if(tx==760 && ty==304 && textscene==0) {
        timer = 0;
        textscene=1;
        pt = loadImage("ptop.png");
    }
    image(pt,tx,ty);
    if(textscene==1) {
        if(timer<180) {
            timer++;
            drawbox(65);
            textSize(15);
            text("You find yourself rather lost. Find your way home.",75,85);
        } else {
            textscene=2;
        }
    } else if(textscene==2) {
        if(keyPressed) {
            if((key=='w' || key=='W') && canMove(tx,ty-5)) {
                ty-=5;
            } else if((key=='a' || key=='A') && canMove(tx-5,ty)) {
                tx-=5;
            } else if((key=='s' || key=='S') && canMove(tx,ty+5)) {
                ty+=5;
            } else if((key=='d' || key=='D') && canMove(tx+5,ty)) {
                tx+=5;
            }
        }
        if(tx>=161&&tx<=208&&ty>=100&&ty<=110) {
            textscene=3;
            transp1 = 0;
            transition = 2;
        }
    }
}

boolean canMove(int x, int y) {
    int[] x1 = {0,17,257,753,17,17,161,257,481,657,833};
    int[] y1 = {129,289,321,289,479,129,100,129,0,0,9};
    int[] x2 = {1000,100,528,1000,879,64,208,304,528,704,879};
    int[] y2 = {176,336,368,335,528,600,176,600,600,256,528};
    for(int i=0; i<x1.length; i++) {
        if(x>x1[i] && y>y1[i] && x+23<x2[i] && y+23<y2[i]) {
            return true;
        }
    }
    return false;
}

void scene6() {
    image(loadImage("bg1.png"),0,0);
    if(px<=700 && textscene==0) {
        timer = 0;
        textscene=1;
    } else if(px<=500 && textscene==2) {
        textscene=3;
    } else if(px<=300 && textscene==4) {
        timer = 0;
        textscene=5;
    } else if(px <= 300 && transition == 0 && textscene==6) {
        transp1 = 0;
        transition = 2;
        timer = 0;
    }
    drawp();
    if(textscene==1) {
        drawbox(155);
        textSize(15);
        text("Home sweet home! You think about washing your hands.",75,85);
        text("1) Yes, washing your hands is one of the best defenses",75,125);
        text("   against contracting COVID-19!.",70,150);
        text("2) No, you barely touched anything. Don't bother.",75,175);
        if(keyPressed) {
            if(key=='1' || key=='2') {
                choices.add(key-'0');
                textscene = 2;
            }
        }
    } else if(textscene == 3) {
        if(timer<120) {
            timer++;
            drawbox(65);
            textSize(15);
            text("You start organising your groceries.",75,85); 
        } else if(timer==120) { 
            minigame = true;
            timer = 320;
            for(int i=0; i<4; i++) {
                for(int j=0; j<4; j++) {
                    flipped[j][i] = true;
                }
            }
            for(int i=0; i<8; i++) {
                for(int j=0; j<2; j++) {
                    int x = (int)(Math.random()*4);
                    int y = (int)(Math.random()*4);
                    while(!flipped[x][y]) {
                        x = (int)(Math.random()*4);
                        y = (int)(Math.random()*4);
                    }
                    flipped[x][y] = false;
                    grid[x][y] = i;
                }
                cards[i] = loadImage("card"+(i+1)+".png");
                cards[i].resize(78,104);
            }
            border = loadImage("border.png");
            border.resize(82,108);
            card = loadImage("card.png");
            card.resize(78,104);
        }
        if(matched < 8 && timer==320) {
            scene6_A();
        } else if(timer>200) {
            scene6_A();
            timer--;
        } else if(timer==200) {
            textscene = 4;
            minigame = false;
        }
    } else if(textscene == 5) {
        if(timer==1) {
            int[] answers = {1,2,1,2,2,2,1};
            int cnt = 0;
            for(int i=0; i<choices.size(); i++) {
                if(answers[i]!=choices.get(i)) cnt++;
            }
            chance = (int)(Math.round(((double)cnt+score/3.0)/(answers.length+2)*100));
        }
        if(timer<600) {
            timer++;
            drawbox(140);
            textAlign(LEFT);
            textSize(15);
            text("Whew, you got home with the milk! You hope you didn't",75,85);
            text("get anything else too...",75,110);
            text("The choices you made resulted in a "+chance+"% of",75,135);
            text("contracting COVID-19 from the grocery store.",75,160);
        } else if(timer==600) {
            textscene = 6;
        }
    }
}

int matched = 0;
int[][] grid = new int[4][4];
boolean[][] flipped = new boolean[4][4];
int c1x = -1, c1y = -1;
int c2x = -1, c2y = -1;
PImage cards[] = new PImage[8];
PImage border;
PImage card;
int pause = 0;
int chance;
void scene6_A() {
    background(0);
    textSize(15);
    if(matched < 8) {
        textAlign(LEFT);
        text("Select two cards to flip. Press SPACE to flip.",20,40);
        text("Pairs matched: "+matched,20,65);
        if(c1x!=-1 && c1y!=-1 && pause==0) {
            image(border, 336.5+c1x*83-2, 82.5+c1y*109-2);
        } 
        if(c2x != -1 && c2y != -1 && pause==0) {
            image(border, 336.5+c2x*83-2, 82.5+c2y*109-2);
        }
        for(int i=0; i<4; i++) {
            for(int j=0; j<4; j++) {
                if(flipped[j][i]) {
                    image(cards[grid[j][i]], 336.5+j*83, 82.5+i*109);
                } else {
                    image(card, 336.5+j*83, 82.5+i*109);
                }
            }
        }
        if(pause > 1) {
            pause --;
        } else if(pause==1) {
            if(grid[c1x][c1y] != grid[c2x][c2y]) {
                flipped[c1x][c1y]=false;
                flipped[c2x][c2y]=false;
            }
            c1x = -1;
            c1y = -1;
            c2x = -1;
            c2y = -1;
            pause --;
        }
        if(keyPressed && key==' ' && c1x!=-1 && c2x!=-1 && pause==0) {
            pause = 61;
            flipped[c1x][c1y]=true;
            flipped[c2x][c2y]=true;
            if(grid[c1x][c1y] == grid[c2x][c2y]) {
                matched++;
            } 
        }
    } else {
        textAlign(CENTER);
        text("You have finished organizing your groceries.",500,300);
    }
}

void mouseReleased() {
    if(scene == 7 && minigame && matched < 8) {
        for(int i=0; i<4; i++) {
            for(int j=0; j<4; j++) {
                if(mouseX >= 336.5+j*83 && mouseX <= 336.5+j*83+78 && mouseY >= 82.5+i*109 && mouseY <= 82.5+i*109+104 && !flipped[j][i]) {
                    if(c1x==-1) {
                        c1x=j; c1y=i;
                        return;
                    } else if(c2x==-1) {
                        c2x=j; c2y=i;
                        return;
                    }
                }
            }
        }
    }
}

void conclusion() {
    timer++;
    if(timer==300) {
        transp1 = 0;
        transition = 2;
    }
    textAlign(LEFT);
    textscene=1;
    px=430;
    choices = new ArrayList<Integer>();
    if(chance > 50) {
        image(loadImage("bg5.png"),0,0);
        drawp();
        drawbox(115);
        text("You don't feel so well, so you are waiting to ", 75,85);
        text("get tested. You should be more careful and cautious", 75,110);
        text("when going out in public.", 75,135);
    } else {
        image(loadImage("bg6.png"),0,0);
        drawp();
        drawbox(115);
        text("Life has finally returned to normal, and you", 75,85);
        text("did not contract the virus. Your carefulness", 75,110);
        text("and consideration has paid off.", 75,135);
    }
}

void theEnd() {
    background(0);
    textAlign(CENTER);
    fill(255);
    textSize(25);
    text("THE END",500,300);
    textSize(15);
    if(fadein) transp2 += 3;
    else transp2 -= 3;
    if(transp2 >= 255) fadein = false;
    else if(transp2 <= 100) fadein = true;
    fill(255,transp2);
    text("press any key to exit",500,350);
    if(keyPressed) {
        exit();
    }
}

void keyPressed() {
    if(scene==3 && textscene==3) {
      if (keyCode == DOWN && light == 2) {
        dist-=2;
      } else if (key != ' ' && light == 0 && dist <450) {
        dist ++;
      } else if (keyCode == UP && light == 1) {
        dist-=5;
      } else if (key == ' ' && light == 0) {
      } else if (dist<350) {
        dist++;
      }
    }
    if((key=='d' || key=='D') && px < 840 && textscene%2 != 1 && !minigame && transition==0) {
        px+=15;
        p = "rw";
    } else if((key=='a' || key=='A') && px > 20 && textscene%2 != 1 && !minigame && transition==0) {
        px-=15;
        p = "lw";
    } 
}

void keyReleased() {
    if(p.equals("rw")) { p = "rs"; cnt = 0; }
    else if(p.equals("lw")) { p = "ls"; cnt = 0; }
    if(scene==2 && textscene==3) {
        int[] correct = {2,1,1,2,1,2};
        if(key=='1'||key=='2') {
            if(key-'0'!=correct[i]) score++;
            i++;
        }
    } else if(scene==5 && textscene==1) {
        if(key=='1' || key=='2') {
            choices.add(key-'0');
            textscene = 2;
        }
    }
}
