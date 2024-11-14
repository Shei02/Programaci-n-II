program pruebaquick; //recurcion

const
    maximo = 100;
type
    arregloEnteros = array[1..maximo] of integer;

procedure swap(var valor1, valor2:integer);
var
aux:integer;
begin
    aux:= valor1;
    valor1:= valor2;
    valor2:= aux;
end;

procedure QuickSort(var datos:arregloEnteros; l, r: Integer);
 { Ordena según Quicksort }
procedure Sort(var datos:arregloEnteros; l, r: Integer);
 { Esta es la parte recursiva }
var
    i, j, x, y: integer;
begin
    i := l; j := r;                                  { Límites por los lados }
    x := datos[(l+r) DIV 2];                         { Centro de la comparaciones }
    repeat
        while datos[i] < x do 
        begin
            i := i + 1;
        end;                                        { Salta los ya colocados }
        while x < datos[j] do j := j - 1;               {en ambos lados }
        if i <= j then                           { Si queda alguno sin colocar}
        begin
            swap(datos[i], datos[j]);   { Los cambia de lado }
            i := i + 1; j := j - 1;     { Y sigue acercándose al centro }
        end;
    until i > j;
    //writeln;
    //writeln;
    //for y:= 1 to maximo do
        //write(datos[y], ', ');  { Hasta que lo pasemos }
        
    if l < j then Sort(datos, l, j);
    if i < r then Sort(datos, i, r);   { Llamadas recursivas por cada lado}
end;
begin
 { Esto llama a la parte recursiva}
    writeln;
    writeln('Ordenando mediante QuickSort...');
    Sort(datos, l, r);
end;

var
    arreglo:arregloEnteros;
    i:integer;
begin
    for i:= 1 to maximo do
    begin
        arreglo[i]:= random(100);
    end;
    for i:= 1 to maximo do
        write(arreglo[i], ', ');
    quickSort(arreglo, 1, maximo);
    for i:= 1 to maximo do
        write(arreglo[i], ', ');
end.