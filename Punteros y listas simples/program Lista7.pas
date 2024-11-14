program Lista7
type
    PuntJugador= ^tipoJugador;
        tipoJugador = record
            Alias:string;
            Puntaje:longint;
            sig:PuntJugador;
        end;
        
procedure CargarDatos(var dato:Tipojugador);
begin
    with dato do
        begin
            writeln('Ingrese un Alias: '); readln(alias);
            Writeln('ingrese un puntaje: '); readln(Puntaje);
            while (puntaje < 0) or (puntaje > 100000) do
                begin
                    writeln('puntaje incorrecto ingrese un valor correcto: ');
                    readln(puntaje);
                end;
        end;
end;

procedure CrearNodo(var nodo:PuntJugador; dato:Tipojugador);
begin
    new(nodo);
    nodo^.sig:=nil;
    nodo^.alias:= dato.alias;
    nodo^.puntaje:= dato.puntaje;
end;

procedure CrearLista(var Lista:puntjugador);
var
    cursor:puntjugador;
    dato:tipojugador;
    corte:integer;
begin
    cargardatos(dato);
    crearnodo(lista,dato);
    cursor:= lista;
    readln(corte);
    while (corte <> -1) do
        begin
            cargardatos(dato);
            crearnodo(cursor^.sig,dato);
            cursor:= cursor^.sig;
            readln(corte);
        end;
end;
Procedure InsertarOrdenado(var Lista:puntJugador);
var
    cursor,JAgregar:puntJugador;
    dato:tipojugador;
begin
    CargarDatos(dato);
    CrearNodo(JAgregar,dato);
    if (lista = nil) or (lista^.alias > JAgregar^.alias) then
        begin
            JAgregar^.sig:= lista;
            Lista:= JAgregar;
        end
    else
        begin
            cursor:= lista;
                while (cursor^.sig <> nil) and (Cursor^.sig^.alias < JAgregar^.alias) do
                    begin
                        cursor:= cursor^.sig;
                    end;
                    Jagregar^.sig := cursor^.sig;
                    Cursor^.sig:= JAgregar;
        end;
end;
procedure imprimirlista(lista:puntJugador);
var
    cursor:puntJugador;
begin
    cursor:= lista;
    while (cursor <> nil) do 
        begin
            write('El Alias es: '); writeln(cursor^.alias);
            write('El Puntaje es: '); writeln(cursor^.puntaje);
            cursor:= cursor^.sig;
        end;
end;
function EstaJugador(lista:puntJugador; dato:tipojugador):boolean;
var
    cursor:puntJugador;
begin
    cursor:= lista;
    while (cursor <> nil) and (cursor^.alias <> dato.alias) do
        begin
            cursor:=cursor^.sig;
        end;
    if (cursor <> nil) then
        EstaJugador:= true
    else
        EstaJugador:= false;
end;
procedure EliminarJugador(var Lista:PuntJugador);
var
    cursor,JEliminar:puntJugador;
    dato:tipojugador;
begin
    writeln('Ingrese el alias que desea eliminar: ');
    readln(dato.alias);
    Crearnodo(JEliminar,dato);
    cursor:= lista;
    if (Estajugador(cursor,dato)) then
        begin
            if (Cursor^.alias = JEliminar^.alias) then
                begin
                    JEliminar:= cursor;
                    Cursor:= Cursor^.sig;
                    dispose(JEliminar);
                    JEliminar:= nil;
                    lista:= cursor;
                end
            else
                begin
                    cursor:=Lista;
                    while (cursor^.sig <> nil) and (cursor^.sig^.alias <> JEliminar^.alias) do
                        begin
                            cursor:= cursor^.sig;
                        end;
                    if (cursor <> nil) then
                        begin
                            JEliminar:=cursor^.sig;
                            cursor^.sig:= cursor^.sig^.sig;
                            dispose(JEliminar);
                            JEliminar:=Nil;
                        end;
                end;
        end
    else
        writeln('no se encuentra');
end;

procedure mayorpuntaje (dato:puntjugador);
var
    cursor, maxpuntaje:puntJugador;
begin
    maxpuntaje:=dato;
    cursor:=dato;
    while (cursor <> nil) do 
        begin
            if (cursor^.puntaje > maxpuntaje^.puntaje) then
                maxpuntaje:= cursor;
            cursor:= cursor^.sig;
        end;
    writeln('El jugador con mayor puntaje es: ', maxpuntaje^.alias); 
    writeln('Puntaje: ', maxpuntaje^.puntaje);
end;

var
    Lista:PuntJugador;
begin
    CrearLista(Lista);
    Writeln('La lista es: ');
    ImprimirLista(lista);
    writeln();
    InsertarOrdenado(lista);
    Writeln('La lista ordenada es: ');
    ImprimirLista(lista);
    writeln();
    EliminarJugador(lista);
    Writeln('La lista es: ');
    ImprimirLista(lista);
    writeln();
    mayorpuntaje(lista);
end.