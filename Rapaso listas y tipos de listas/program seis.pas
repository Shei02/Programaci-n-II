program seis
const
    maximoPuntaje = 32000;

type puntJugador = ^ jugador;
    jugador = Record
        Alias: String;
        Puntaje:0..maximoPuntaje;
        Sig:puntJugador;
        Sig_Puntaje:PuntJugador;
    End;
    
procedure crearNodo(var Nodo:puntJugador);
var
    Alias:string;
    puntaje:integer;
begin
    new(Nodo);
    
    writeln('ingrese un alias al jugador:');
    readln(Alias);
    nodo^.alias:=Alias;
    
    writeln('ingrese un puntaje');
    readln(puntaje);
    if (puntaje<maximoPuntaje) then
        Nodo^.puntaje:=puntaje
    else
        Nodo^.puntaje:=maximoPuntaje;
        
    Nodo^.sig:=nil;
    Nodo^.sig_Puntaje:=nil;
end;

procedure crearLista(var Lista:puntJugador);
var
    i:integer;
    cursor:puntJugador;
begin
    i:=1;
    crearNodo(Lista);
    cursor:=lista;
    
    while (i<>-1) do
    begin
        crearNodo(cursor^.sig);
        cursor:=cursor^.sig;
        writeln('Si desea no cargar mas valores ingrese un -1');
        readln(i);
    end;
end;

procedure imprimirNodo(Nodo:puntJugador);
begin
    writeln('---------------------');
    writeln('el alias es:', Nodo^.Alias);
    writeln('el puntaje es:', Nodo^.Puntaje);
    writeln('---------------------');
end;

procedure imprimirLista(Lista:puntJugador);
begin
    while (lista<>nil) do
    begin
        imprimirNodo(lista);
        lista:=lista^.sig;
    end;
end;

procedure insertarJugador(var Lista,NewPlayer:puntJugador);
var
    cursor,anteriorDef:puntJugador;
begin
    cursor:=lista;
    If (cursor^.alias>NewPlayer^.alias) then
    begin
        Lista:=NewPlayer;
        Lista^.sig:=Cursor;
    end;
    
    while (cursor<>nil) and (cursor^.Alias<newplayer^.alias) do
    begin
        anteriorDef:=cursor;
        cursor:=cursor^.sig;
        if (cursor=nil) then
            anteriorDef^.sig:=NewPlayer;
    end;
    
    
    anteriorDef^.sig:=NewPlayer;
    NewPlayer^.sig:=Cursor;
end;

procedure eliminarAlias(var Lista:puntJugador; AliasBuscado:string);
var
    cursor,anterior:puntJugador;
begin
    cursor:=lista;
    anterior:=lista;
    while (Cursor<>nil) do
    begin
        if (cursor^.alias = AliasBuscado) then
        begin
            anterior^.sig:=cursor^.sig;
            dispose(cursor);
        end;
        anterior:=cursor;
        cursor:=cursor^.sig;
    end;
end;

Procedure InsertarOrdPorPuntj(Nodo:PuntJugador; var puntajes:PuntJugador);
var
    cursor, anterior: PuntJugador;
    laza:boolean;
begin
    laza:=false;
    if (puntajes = nil) then
    begin
        //writeln('Primer If');
        puntajes := nodo;
    end
    else if (nodo^.puntaje < puntajes^.puntaje) then
    begin
        //writeln('Segundo If');
        nodo^.sig_Puntaje := puntajes;
        puntajes := nodo;
    end
    else 
    begin
        cursor := puntajes;
        anterior := cursor;
        While (cursor<>nil) and (laza=false) do
        begin
            //writeln('While');
            if (cursor^.puntaje > nodo^.puntaje) then
            begin
                nodo^.Sig_Puntaje:=cursor;
                anterior^.Sig_Puntaje:=nodo;
                laza:=true;
                //writeln('While if primero');
            end
            else if (cursor^.Sig_Puntaje = nil) then
            begin
                Cursor^.Sig_Puntaje := nodo;
                laza:=true;
                //writeln('While else if');
            end;
            anterior:=cursor;
            cursor := cursor^.Sig_Puntaje;
            //writeln('Final');
        end;
    end;
end;

procedure actualizarPuntaje(Lista:PuntJugador; var puntajes:PuntJugador);
begin
    while (Lista<>nil) do
    begin
        //writeln('Rip1');
        InsertarOrdPorPuntj(Lista,puntajes);
        Lista:=Lista^.sig;
    end;
end;

procedure imprimirListaPuntaje(puntajes:puntJugador);
begin
    while (puntajes<>nil) do
    begin
        writeln('--------------------------');
        writeln(puntajes^.puntaje);
        puntajes:=puntajes^.sig_Puntaje;
        write('----------------------------');
    end;
end;
// programa principal // 
var
    Lista:puntJugador;
    Jugador_Puntaje:PuntJugador;
begin
    crearLista(Lista);
    imprimirLista(Lista);
    Jugador_Puntaje:=Nil;
    actualizarPuntaje(Lista,Jugador_Puntaje);
    imprimirListaPuntaje(Jugador_Puntaje);
end.