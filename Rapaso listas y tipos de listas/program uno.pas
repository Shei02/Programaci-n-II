program uno
type
    puntfila = ^tipofila;
        tipofila = record
            nro:integer;
            sig:puntfila;
        end;

procedure inicfila (var fila:puntfila; dato:integer);
begin
    new(fila);
    fila^.sig:= nil;
    fila^.nro:=dato;
end;

procedure agregar (var fila:puntfila);
var
    cursor,aAgregar:puntfila;
    valor:integer;
begin
    writeln('ingrese el valor: ');
    readln(valor);
    inicfila(aAgregar,valor);
    if (fila = nil) then
        begin
            fila:= aAgregar;
        end
    else
        begin
            cursor:= fila;
            while (cursor^.sig <> nil) do 
                begin
                    cursor:= cursor^.sig;
                end;
            cursor^.sig:= aAgregar;
        end;
end;

procedure extraer (var fila:puntfila);
var
    cursor,aeliminar:puntfila;
begin
    cursor:= fila;
    while (cursor^.sig <> nil) do 
        begin
            cursor:= cursor^.sig;
        end;
    if (cursor <> nil) then
        begin
            aeliminar:= cursor^.sig;
            dispose(aeliminar);
            aeliminar:= nil;
        end;
end;

function pilavacia (fila:puntfila):boolean;
var
    valor:boolean;
begin
    if (fila = nil) then
        valor:=true
    else
        valor:= false;
    pilavacia:=valor;
end;

function primero (fila:puntfila):integer;
begin
    if (fila <> nil) then
        primero:= fila^.nro;
end;

procedure mostrarfila (fila:puntfila);
var
    cursor:puntfila;
begin
    cursor:= fila;
    while (cursor <> nil) do 
        begin
            writeln(cursor^.nro);
            cursor:= cursor^.sig;
        end;
end;

procedure leerfila (var fila:puntfila);
var
    cursor:puntfila;
    dato:integer;
begin
    writeln('ingrese datos a la fila: ');
    readln(dato);
    if (dato <> -1) then
        begin
            inicfila(fila,dato);
            cursor:= fila;
            readln(dato);
            while (dato <> -1) do 
                begin
                    inicfila(cursor^.sig,dato);
                    cursor:= cursor^.sig;
                    readln(dato);
                end;
        end;
end;

//programa principal
var
    fila:puntfila;
begin
    leerfila(fila);
    mostrarfila(fila);
    extraer(fila);
    writeln('la lista es: ');
    mostrarfila(fila);
    agregar(fila);
    writeln('la lista es: ');
    mostrarfila(fila);
end.