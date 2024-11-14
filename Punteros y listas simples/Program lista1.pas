Program lista1
const
    corte = '*';
    
Type puntnodo = ^tiponodo;
     tiponodo = record
        caracter:char;
        sig:puntnodo;
     end;
     
procedure crearnodo(var nodo:puntnodo; dato:char);
begin
    new(nodo);
    nodo^.sig:= nil;
    nodo^.caracter:= dato;
end;
     
procedure carga (var lalista:puntnodo);
var
    cursor:puntnodo;
    dato:char;
begin
    lalista:= nil;
    writeln('ingrese el caracter: ');
    readln(dato);
    If (dato <> corte) then
        Crearnodo(lalista,dato);
    cursor:= lalista;
    readln(dato);
    while (dato <> corte) do
        begin
            crearnodo(cursor^.sig,dato);
            cursor:= cursor^.sig;
            readln(dato);
        end;
end;

procedure mostrarlista (lalista:puntnodo);
var
    cursor:puntnodo;
    dato:char;
begin
    cursor:=lalista;
    writeln('la lista es: ');
    while (cursor <> nil) do
        begin
            writeln(cursor^.caracter);
            cursor:= cursor^.sig;
        end;
    if (dato <> corte) then
        readln(dato);
end;

var
    lalista:puntnodo;
begin
    carga(lalista);
    mostrarlista(lalista);
end.