program dosmcd;

function MCDWhile(a, b: integer): integer;
var
    r, q, rf: integer;
begin
    r := -1;
    q := 0;
    
    while r <> 0 do
    begin
        rf := r;
        
        q := a div b;
        r := a - b * q;
        
        if (rf = -1) and (r = 0) then rf := b;

        a := b;
        b := r;
    end;
    
    MCDWhile := rf;
end;

//a) //MCD(X,X)=X
    //X<Y⇒MCD(X,Y)=MCD(Y,X)
    //X>Y⇒MCD(X,Y)=MCD(X−Y,Y)
function MCD (a,b:integer):integer;
begin
    if (a = b) then
    begin
        writeln('igual');
        MCD:=a;
    end;
    if (a < b) then
    begin
        writeln('menor');
        MCD:= MCD(b,a);
    end;
    if (a > b) then
    begin
        writeln('mayor');
        MCD:= MCD(a-b,b);
    end;
end;

//b)//MCD(X,0)=X
    //X<Y⇒MCD(X,Y)=MCD(Y,X)
    //X≥Y⇒MCD(X,Y)=MCD(Y,MOD(X,Y))

function MCDD (a,b:integer):integer;
begin
    writeln('a: ',a);
    writeln('b: ',b);
    if (a <> 0) and (b = 0) then
    begin
        writeln('b igual 0');
        MCDD:= a;
    end;
    if (a < b) then
        begin
            writeln('menor');
            MCDD:= MCDD(b,a);
        end;
    if (a >= b) and (b <> 0) then
        begin
            writeln('mayor =');
            MCDD:= MCDD(b, a mod b);
        end;
end;

var
    a, b: integer;
begin
    readln(a);
    readln(b);
    //writeln('resultado 1');
    //writeln(MCDWhile(a, b));
    //writeln('resultado 2');
    //writeln(MCD(a,b));
    writeln('resultado 3');
    writeln(MCDD(a,b));
end.