uses crt;
  Type Vector=Array [1..50] of integer;
   Player=record
    nick:string[12];
    point:byte;
    end;
  //լուսավորվող թվերի դիրքը որոշող կոորդինատներ;
  const
  x=5;y=2;
Var 
  f : file of integer; 
  i,j,n,pn,a,d1,d2,v1 : integer; 
  //խաղացողների անունները և միավորները պարունակող աղյուսակ;
  T:Player;
  p : file of Player;

//սկզբնական մատրիցի ստեղծում (որտեղ արտածվում են 1-25 թվերը);
procedure Readmat();
var 
  i,j,q:integer;
begin
  q:=1;
  For i:=1 to 5 do 
    begin
    For j:=1 to 5 do
      begin 
         gotoxy((j*x),(i*y));
        delay(100);
        Write(q);
        q:=q+1;
      end;     
    writeln; 
    end;
end;

// պրոցեդուրա որը ստեղծում է միաչափ զանգված (պատահական վերցնելով 1-25 թվերը ըստ նշված քանակի);
procedure Createmat(var g: file of integer);
var 
  i,n,z,k:integer;
begin
  randomize;
  writeln;
  gotoxy(2,12);
  write('  Number of points: ');Readln(n);
  
  Assign(g,'Vector.int');
  rewrite(g);
   k:=random(1,25);
   write(g,k);
  repeat
    begin
      k:=random(1,25);
      i:=0;
      seek(g,i);
      while not eof(g) do
       begin  
      read(g,z);
      //այս պայմանը նախատեսված է թվերի եզակիությունը ապահովելու համար(չկրկնվելու համար);
      if(k<>z)then
      i:=i+1;
      if(i=filesize(g)) then
        begin
        seek(g,i);
        write(g,k);
        end;
    end;
    end;
  until i=n-1;
  close(g);
end;

//այս պրոցեդուրան ապահովում է թվերի լուսավորումը;
procedure lus(var g: file of integer);
 var 
  i,j,q,z:integer;
 begin
  Assign(g,'Vector.int');
  reset(g); 
 while not (Eof(g)) do
   begin
      gotoxy(0,0);
   q:=1;
   read(g,z);
   
  For i:=1 to 5 do 
  begin
    For j:=1 to 5 do
      begin 
        //գնալով նշված կոորդինատը տպում է կանաչ գույնը հետո վերադարձնում հին տեսքը;
        if (z=q)then
        begin
          delay(1000);
        textcolor(10);
        gotoxy(j*x,i*y);
        write(z);
        delay(1000);
        textcolor(14);
        gotoxy(j*x,i*y);
        write(z);
        end;
         q:=q+1;
      end;  
    writeln; 
    end;      
   end;
    gotoxy(2,14);
    close(g);
    end;
 //այս պրոցեդուրան նախատեսված է տարրերի շարժման անիմացիայի համար; 
procedure animation(n,m,i,c:integer);
var d:integer;
begin
    if(i>11)then
      begin
    d:=14;
    d1:=12;
    end else
      d:=9;
  while(d<=35)do
  begin
    delay(10);
    gotoxy(d,d1);
    write(c);
    //դանդաղեցնում է մատրիցի տարրերի շարժումը նկատելի դարձնելու համար;
    delay(100);
    gotoxy(d,d1);
    write('  ');
    gotoxy(d,d1);
    d:=d+2;
    
  end;
  
  d:=d1;
  while (d>=n) do
  begin
    delay(10);gotoxy(35,d);write(c);
    delay(100);gotoxy(35,d);write('  ');
    gotoxy(35,d);
    d:=d-1;
    end;
    
    d:=35;
  while (d>=m) do
  begin
    delay(10);gotoxy(d,n); write(c);
    delay(100);gotoxy(d,n);write('  ');
    gotoxy(d,n);
    d:=d-2;
    end;
    d1:=d1+1;
end;

//ստուգում է ներմուծված թիվը,թե արդյոք համապատասխանում է լուսավորված թվին;   
procedure hisharj(var g:file of integer; var pr:file of Player);
var  i,k,r,e,a,b,x,y,pn:integer; pt:boolean; q:byte;s:string[12];
  begin
    //հարցնում է խաղացողի անունը;
    write(' write your name: ');
    Assign(pr,'Tabel.rec');
      readln(s);
      gotoxy(2,12);
      write('                             ');
      gotoxy(2,12);
    writeln('Insert the number in order: ');  
     Assign(g,'Vector.int');
    reset(g);
    i:=1;
    while not (Eof(g)) do
    begin
      if(i>11)then
      begin
      v1:=10;
      d2:=13;
    end else
      v1:=2;
      gotoxy(v1,d2);
      write(' ',i,'. ':1);read(r);
      d2:=d2+1;
      read(g,k);
      gotoxy(2,12);
      write('                                                        ');
      //եթե ներմուժվաժ թիվը համապատասխանում է լուսավորված թվին կանաչեցնում է
      if(k = r) then
        begin
           delay(300);e:=1;a:=1;
           while (a<=5) do
              begin
                b:=1;
               while(b<=5) do
                  begin 
                    if (r=e)then
                    begin
                      animation(a*2-1,b*5,i,r);
                      gotoxy(b*5,a*2);
                      textcolor(10);
                      write(e,' ');
                    end;
                     e:=e+1;b:=b+1;
                  end;
                  a:=a+1;
                end;  
              
           gotoxy(2,13);
           q:=q+1;
           textcolor(14);
        end
        //հակառակ  դեպքում կարմրեցնում է
        else
        begin
           delay(300);
           e:=1;
           For a:=1 to 5 do 
              begin
                For b:=1 to 5 do
                  begin 
                    if (r=e)then
                    begin
                    animation(a*2-1,b*5,i,r);
                    gotoxy(b*5,a*2);
                    textcolor(12);
                    write(e,' ');
                    end;
                     e:=e+1;
                  end;
                end;  
           gotoxy(2,13);
           textcolor(14);
        end;
        i:=i+1;
       end;  
       close(g);
       i:=1;
       pt:=true;
       //տպում է աղյուսակում գրանված անունները և իրանց միավորները և հետո համեմատում խաղացողի միավորների հետ և տպում համապատասխան մեկնաբանությունը;
    while not Eof(pr)and pt do
       begin
         read(p,T);
         if(pt)then
           begin
         if(q>=T.point)then
         begin
         if(i=1)then
          begin
            gotoxy(50,10);
            write('Congratulations you took first place!!!                                              ');
            pt:=false;
            end
            else if(i=2)then
          begin
            gotoxy(50,10);
            write('Congratulations you took second place!!!                                            ');
           pt:=false;
            end
            else if(i=3)then
          begin
            gotoxy(50,10);
            write('Congratulations you took third place!!!                                             ');
             pt:=false;
            end ;
            end
            else
              begin 
                gotoxy(50,10);
                write('Sorry, but you didn`t earn enough points to be ranked');
              end;
             end;
              i:=i+1;
          end;
       gotoxy(50,8);
       textcolor(14);
       write(s,' ');
       //տպում է մեր անունը և ներմուծած ճիշտ պատասխանների քանակը(միավորները);
       write(' you scored ',q,' points');    
  end;
  
 //ջնջում է արտածված թվերը(հետագայում անիմացիայի միջոցով իր դիրքում դնելու համար);
procedure jnjel();
var 
  i,j,q:integer;
begin
  For i:=1 to 5 do 
    begin
    For j:=1 to 5 do
      begin 
         gotoxy((j*5),(i*2));
        Write('  ');
        q:=q+1;
      end;     
    writeln; 
    end;
end;

//հիմնական ծրագիր;
begin {main}
  d1:=13;d2:=13;
  Assign(p,'table.rec');
  reset(p);
   textcolor(14);
   //արտածում է սկզբնական մատրիցը
   Readmat();
      gotoxy(2,12);
      //լուսավորում է թվերը
      Createmat(f);
      lus(f);
      gotoxy(2,12);
      write('                              ');
      jnjel();
      gotoxy(2,12);
      textcolor(14); 
      hisharj(f,p);
      a:=2;
      reset(p);
      while not Eof(p) do
      begin
        
        read(p,T);
        
      gotoxy(50,a);
 
      Writeln(T.nick,' ',T.point);
  
      a:=a+1;
      end;
      close(p);
      gotoxy(2,25);
      
      textcolor(3);
end.