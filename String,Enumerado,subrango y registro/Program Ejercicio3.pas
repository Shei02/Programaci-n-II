Program Ejercicio3
Const 
    Inicio = 1;
    maxArr = 3;
    maxMes = 6;
    maxDia = 20;
Type
    registro = record
        Dia: 1..31;
        Mes: 1..12;
        cantlluvia: Real;
    End;

    arr = array [Inicio..maxArr] of Registro;
    mat = array [inicio..maxDia,inicio..maxmes] of Real;

Procedure cargaArreglo (var arreglo:arr);
var
    I:Integer;
Begin
    For I:= Inicio to maxArr do 
        Begin
            with arreglo[I] do 
                Begin
                    Writeln('Cargue los datos del arreglo: ');
                    Writeln('Ingrese el dia: ');
                    Readln(dia);
                    Writeln('Ingrese el mes: ');
                    Readln(mes);
                    Writeln('Ingrese precipitacion: ');
                    Readln(cantlluvia);
                End;
        End;
End;

Procedure cargaMatriz (var matriz:mat);
var
    I,J:Integer;
Begin
    Writeln('ingrese los valores de precipitaciones: ');
    For I:= Inicio to maxDia do 
        For J:= Inicio to maxMes do 
            Begin
                Readln(Matriz[I,J]);
            End;
End;

Procedure cargaMatrizaArreglo (var Arreglo:arr; matriz:mat; var frontera:Integer);
var
    I,J:Integer;
Begin
    Frontera:= 1;
    For I:= Inicio to maxDia do
        For J:= Inicio to maxMes do 
            Begin
                If (Matriz[I,J] > 0) then
                    Begin
                        Arreglo[Frontera].dia:= I;
                        Arreglo[Frontera].mes:= J;
                        Arreglo[Frontera].cantlluvia:= Matriz[I,J];
                        Frontera += 1;
                    End;
            End;
End;

Procedure cargaArregloaMatriz (var Matriz:mat; Arreglo:Arr);
var
    I:Integer;
Begin  
    For I:= Inicio to maxArr do 
        Begin
            Matriz[Arreglo[I].dia,Arreglo[I].mes]:= Arreglo[I].cantlluvia;
        End;
End;
    
procedure imprimir (Arreglo:Arr; frontera:Integer);
var 
    I:Integer;
Begin
    Frontera:= maxArr;
    For I:= Inicio to frontera do 
        Begin
            With Arreglo[I] do 
                Begin
                    Writeln('Dia: ',dia);
                    Writeln('Mes: ',mes);
                    Writeln('Precipitacion: ',cantlluvia:0:2);
                End;
        end;
End;
    
Procedure Imprimirmatriz (matriz:mat);
var
    I,J:Integer;
Begin
    For I:= Inicio to maxdia do
        Begin
            For J:= Inicio to maxMes do 
                Begin
                    Write('|');
                    Write(Matriz[I,J]:0:2);
                End;
            Writeln;
        End;
End;
    
//programa principal
var
    Arreglo:Arr;
    Matriz:mat;
    Frontera:Integer;
Begin
    cargaMatriz(Matriz);
    ImprimirMatriz(Matriz);
    cargamatrizaarreglo(Arreglo,matriz,frontera);
    imprimir(arreglo,frontera);
    cargaarreglo(arreglo);
    imprimir(arreglo,frontera);
    cargaarregloamatriz(matriz,arreglo);
    ImprimirMatriz(Matriz);
End.