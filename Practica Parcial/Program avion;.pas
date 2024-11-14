Program avion;

Type
    PuntAvion= ^TAvion;
    TAvion= record
        patente: integer;
        modelo: string;
        aFabricacion: integer;
        cantMax: integer;
        sig: PuntAvion;
    end;
    
    PVuelo= ^TVuelo;
    TVuelo = record
        nombre_vuelo: string;
        nombre_aerolinea: string;
        fecha_salida: longint;
        hora_salida: longint;
        destino: string;
        punteroAvion: PuntAvion;
        menores,mayores: PVuelo;
    end;
    
    PAerolinea= ^TAerolinea;
    TAerolinea = record
        nombre: string;
        cantAviones: integer;
        aviones: PuntAvion ;
        sig: PAerolinea;
    end;
   
// A  
Function AerolineaPorNombre(PAero: PAerolinea;Nombre_Aero: string): PuntAvion; //Busca aerolinea por nombre
begin
    if PAero <> nil then 
        if PAero^.Nombre = Nombre_Aero then 
            AerolineaPorNombre:= PAero^.Aviones
        else
           AerolineaPorNombre:= AerolineaPorNombre(PAero^.sig,Nombre_Aero)
    else
        AerolineaPorNombre:= nil;
end;

Function AvionPorPatente(AvionAero: PuntAvion;Patente: integer): PuntAvion; //Busca el avion por patente
begin
    if AvionAero <> nil then 
        if AvionAero^.Patente = Patente then 
            AvionPorPatente:= AvionAero
        else
           AerolineaPorNombre:= AerolineaPorNombre(AvionAero^.sig,Patente)
    else
        AvionPorPatente:= nil;
end;

Procedure InsertarVuelo(NuevoVuelo:PVuelo;var Avuelo:PVuelo); //le paso vuelo y inserto en arbol
begin
    if Avuelo <> nil then
        if NuevoVuelo^.Nombre_Vuelo > Avuelo^.Nombre_Vuelo then
            InsertaVuelo(NuevoVuelo^.Mayores,Avuelo)
        else
            InsertarVuelo(NuevoVuelo^.Menores,Avuelo);
    else 
        Avuelo:= NuevoVuelo;
end;

Procedure GenerarNuevoVuelo(var NuevoVuelo:PVuelo); //generar nodo vuelo
begin
    new(NuevoVuelo);
    writeln('nombre vuelo');
    readln(NuevoVuelo^.nombre_vuelo);
    writeln('nombre aerolinea');
    readln(NuevoVuelo^.nombre_aerolinea);
    writeln('fecha salida');
    readln(NuevoVuelo^.fecha_salida);
    writeln('hora salida');
    readln(NuevoVuelo^.hora_salida);
    writeln('destino');
    readln(NuevoVuelo^.destino);
    NuevoVuelo^.punteroavion:= nil;
    NuevoVuelo^.menores:= nil;
    NuevoVuelo^.mayores:= nil;
end;

Procedure AgregarVuelo(var Avuelos: PVuelo;PAero: PAerolinea); // Tipo resolver,modificar
var
    NuevoVuelo: Pvuelo;
    AvionAero, AvionVuelo:PuntAvion;   //puntero a los aviones de la aerolinea
    Patente: integer;
begin
    GenerarNuevoVuelo(NuevoVuelo);
    writeln('Dame patente');
    readln(Patente);
    AvionAero:= AerolineaPorNombre(PAereo,NuevoVuelo^.Nombre_Aerolinea);
    AvionVuelo:= AvionPorPatente(AvionAero,Patente);
    NuevoVuelo^.PunteroAvion:= AvionVuelo;
    InsertaVuelo(NuevoVuelo,AVuelos);
end;

// B
Procedure Desvincular(var AvionEliminar,Aeropostal:PuntAvion;Patente:integer);
begin
    if Aeropostal <> nil then 
        if Aeropostal^.Patente = Patente then begin
            AvionEliminar:= Aeropostal;
            AeroPostal:= Aeropostal^.sig;
            AvionEliminar^.sig:= nil;
        end
        else
            Desvincular(AvionEliminar,Aeropostal^.sig,Patente);
    else
        AvionEliminar:= nil;
end;

Procedure ModificarVuelo(Avuelos:PVuelo;var AvionEliminar:PuntAvion);
begin
    if Avuelos <> nil then begin
        if Avuelo^.PunteroAvion = AvionEliminar then 
            Avuelo^.PunteroAvion:= nil;
        ModificarVuelo(Avuelo^.mayores,AvionEliminar);
        ModificarVuelo(Avuelo^.menores,AvionEliminar);
    end;
end;

Procedure EliminarAvion(PAero:PAerolineas);
var 
    Patente:integer;
    Aerolinea: string;
    AeroPostal,AvionEliminar: PuntAvion;
begin
    Writeln('Dame Patente');
    Readln(Patente);
    Writeln('Dame Aerolinea');
    Readln(Aerolinea);
    AeroPostal:= AerolineaPorNombre(PAreo,Aerolinea)
    if AeroPostal <> nil then begin
        Desvincular(AvionEliminar,Aeropostal,Patente);
        ModificarVuelo(AVuelos,AvionEliminar);
        Dispose(AvionEliminar);
    end;
end;

//C

Function CantVueloxAvion(Avuelos: PVuelos;Avion:PuntAvion):integer;
begin
    if Avuelos <> nil then begin
        if Avuelos^.punteroAvion = avion then
            CantVueloxAvion:= 1 + CantVueloxAvion(Avuelos^.mayores,Avion) + CantVueloxAvion(Avuelos^.menores,Avion);
        CantVueloxAvion:= CantVueloxAvion(Avuelos^.mayores,Avion);
        CantVueloxAvion:= CantVueloxAvion(Avuelos^.menores,Avion);
    end
    else
        CantVueloxAvion:= 0;
end;

Procedure RecorrerPorAvion(Avuelos: PVuelos;Aviones:PuntAvion);
begin
    if Aviones <> nil then begin
        Writeln(Aviones^.nombre,' ',CantVueloxAvion(Avuelos,Aviones));
        RecorrerPorAvion(Avuelos,Aviones^.sig);
    end;
end;

Procedure RecorrerAerolineas(Avuelos: PVuelos;PAero: PAerolineas);
begin
    if PAero <> nil then begin
        RecorrerPorAvion(Avuelos,PAero^.Aviones);
        RecorrerAeroLineas(Avuelos,Paero^.sig);
    end;
end;

// Programa pricipal
var 
    PAero: PAerolinea;
    AVuelos: PVuelo;
    PAvion: PuntAvion;
begin
    AgregarVuelo(Avuelos,PAero);
    EliminarAvion(PAero);
end.