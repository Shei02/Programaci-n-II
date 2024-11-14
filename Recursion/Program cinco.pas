Program cinco
uses  Sysutils;
Const   
    Inicio = 1;
    MaxFila = 3;
    MaxColum = 3;
    
Type Mat = Array [Inicio..MaxFila,Inicio..MaxColum] of Integer;

Procedure CargaMatriz(var Matriz:Mat);
//Realiza la carga de la matriz
var
    Fi, Co:Integer;
Begin
    For Fi := Inicio to MaxFila do
        For Co := Inicio to MaxColum do
            Begin
                Write('Ingrese valores a la matriz[' + IntToStr(Fi) + ',' + IntToStr(Co) +']: ');
                Readln(Matriz[Fi,Co]);
            End;
End;

Procedure ImprimirMatriz(Matriz:Mat);
//Muestra la matriz final
var
    Fi,Co:Integer;
Begin
    For Fi:= Inicio to MaxFila do
        Begin
            For Co:= Inicio to MaxColum do
                Write(' | ', Matriz[Fi,Co], ' | ');
                Writeln;
        End;
End;

function capi (Matriz:mat ; Fija,Inicio,Final:integer): boolean;
begin
    begin
        writeln('Inicio,Fija', Inicio, Fija);
        writeln('Final,Fija', Final,Fija);
        if (Inicio = Final) or (Inicio > Final) then
            capi:= true
        else
        if Matriz[Inicio,Fija] = Matriz[Final,Fija] then begin
            Inicio:= Inicio + 1;
            Final:= Final - 1;
            capi:= capi(Matriz,Fija,Inicio,Final);
        end
        else
            capi:= false;
    end;
end;

Function capicua (Matriz:mat):boolean;
var
    Co,I,Fi,FilaFinal,FilaInicio,ColumnaInicio,ColumnaFinal:integer;
begin
    FilaInicio:=Inicio;
    FilaFinal:=MaxFila;
    ColumnaInicio:=Inicio;
    ColumnaFinal:=MaxColum;
    
    Co:=inicio;
    Capi(Matriz,Co,FilaInicio,MaxFila);
    
    Fi:=inicio;
    Capi(Matriz,Fi,ColumnaInicio,ColumnaFinal);
    Capicua:=Capi(Matriz,Fi,ColumnaInicio,ColumnaFinal);
end;

Var
    Matriz:Mat;
    Fi,Co:Integer;
Begin
    CargaMatriz(Matriz);
    ImprimirMatriz(Matriz);
    writeln('True:Capicua / False: NoCapicua:');
    writeln('La matriz era:', Capicua(Matriz));
End.