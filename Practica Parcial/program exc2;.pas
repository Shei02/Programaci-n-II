program exc2;

Type
    Arbol = ^PuntArbol;
    PuntArbol = record
        nro_patente, anio: integer; 
        men,may: PuntArbol;
    end;
    
    Lista: ^PuntLista;
    PuntLista = record
        cantpatentes, anio: integer;
        sig,ant: PuntLista;
    end;
////////////////////////////////////////////////////////////////////////////////
function GenesisNodo (Anio: integer): PuntLista;
var
    Nodo: PuntLista;
begin
    new (Nodo);
    Nodo^.CantPatentes:= 1;
    Nodo^.anio:= anio;
    Nodo^.sig:= NIL;
    Nodo^.ant:= NIL;
    GenesisNodo:= Nodo;
end;

procedure InsertarOrdDoblementeVinculada (var Lista: PuntLista; Nodo: PuntLista);
begin
    if (Lista = Nil) then
        Lista := Nodo
    else
        if (Nodo^.anio <= Lista^.anio) then
        begin
            Nodo^.sig := lista;
            Nodo^.ant := Lista^.ant;
            Lista^.ant := Nodo;
            Lista := Nodo;
        end
        else
        InsertarOrdDoblementeVinculada(Lista^.sig,Nodo);
end;

procedure DesvincularLista (var Lista: PuntLista; desvinculador: PuntLista); 
Begin 
    If (desvinculador^.sig = nil) and (desvinculador^.ant = nil) then
    begin
        Lista := Nil
        desvinculador^.sig := nil;
        desvinculador^.ant := nil;
    end
    
    else
        if (desvinculador^.sig <> nil) and (desvinculador^.ant <> nil) then
        begin
            desvinculador^.ant^sig := desvinculador^.sig
            desvinculador^.sig^.ant := desvinculador^.ant
        end
        
        else if (desvinculador^.sig = nil) then
            Lista := Desvinculador^.sig
            
        else  (desvinculador^.ant <> nil)
            desvinculador^.ant^sig := desvinculador^.sig;
    desvinculador^.sig := Nil;
    desvinculador^.ant := Nil;
end;


function BuscaAnioEnLista (Lista: PuntLista; anio: integer): PuntLista;
begin
    if (Lista <> NIL) then 
        if (Lista^.anio = anio) then
            BuscaAnioEnLista:= Lista
        else
            BuscaAnioEnLista:= BuscaAnioEnLista(Lista^.sig, anio);
    else
        BuscaAnioEnLista:= NIL;
end;

Procedure Actualizar(var desvinculador:PuntLista);
begin
    desvinculador^.cantpatentes := desvinculador^.cantpatentes + 1;
end;

procedure ControLaLista (var Lista: PuntLista; Anio: integer);
var
    desvinculador: PuntLista;
begin
    desvinculador:= BuscaAnioEnLista (Lista, anio);
    if (desvinculador <> NIL) then begin
        DesvincularLista(Lista,desvinculador);
        Actualizar(desvinculador);
        InsertarOrdDoblementeVinculada (Lista, desvinculador);
    else
        CrearNodo (Anio);
        InsertarOrdDoblementeVinculada (Lista, CrearNodo (Anio));
end;

procedure ActualizarLista (var Lista: PuntLista; Arbol: PuntArbol; pat_min, pat_max, prof_maxima, profundidad : integer);
begin
    if (Arbol <> nil) then begin
        if (profundidad <= prof_maxima) then begin 
            if (Arbol^.nro_patente > pat_min) and (Arbol^.nro_patente < pat_max) then begin
                ControLaLista (Lista, Arbol^.anio);
                ActualizarLista (Lista ,Arbol^.mayores, pat_min, pat_max, prof_maxima, profundidad + 1);
                ActualizarLista (Lista ,Arbol^.menores, pat_min, pat_max, prof_maxima, profundidad + 1);
            end else if (Arbol^.nro_patente < pat_min) then          
                ActualizarLista (Lista ,Arbol^.mayores, pat_min, pat_max, prof_maxima, profundidad + 1)
            else
                ActualizarLista (Lista ,Arbol^.menores, pat_min, pat_max, prof_maxima, profundidad + 1);
        end;
    end;
end;

///MAIN///
var
    ElArbol: PuntArbol;
    Lista: PuntLista;
    pat_min, pat_max, prof_maxima: integer;
begin
    Lista := nil;
    //SE DA POR TOMADO QUE EL ARBOL FUE CARGADO COMO PAT_MIN, PAT_MAX Y PROF_MAXIMA
    ActualizarLista (Lista, Arbol, pat_min, pat_max, prof_maxima, 0);
    
    
    
end.