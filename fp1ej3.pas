program ejercicio3;
type

  str13 = string [13];
  empleado = record
    nom: str13;
    ape: str13;
    cod,edad,dni: integer;
  end;
  archi_empleados = file of empleado;

procedure crear (var archi: archi_empleados);
var
 n: str13;
 e: empleado;
begin

 writeln ('ingrese el nombre del archivo');
 readln (n);
 assign (archi, n);
 rewrite(archi);
 writeln ('ingrese su apellido');
 readln (e.ape);

 while (e.ape <> 'fin') do begin
   writeln ('ingrese nombre');
   readln (e.nom);
   writeln ('ingrese dni');
   readln (e.dni);
   writeln ('ingrese edad');
   readln (e.edad);
   writeln ('ingrese codigo de empleado');
   readln (e.cod);
   write (archi, e);

   writeln ('ingrese su apellido');
   readln (e.ape);
 end;
 close (archi);
end;

procedure mostrar (e: empleado);
begin
  write (e.ape);
  write (e.nom);
  write (e.dni);
  write (e.cod);
  write (e.edad);
end;

procedure ape_nom (var archi: archi_empleados);
var
 e: empleado;
 n: str13;
begin

  writeln ('ingrese un nombre o apelldio a buscar');
  readln (n);

  reset (archi);
  while (not eof(archi)) do begin
   read (archi,e);
   if (e.ape = n) or (e.nom = n) then
     mostrar (e);
  end;
  close (archi)

end;

procedure todos (var archi: archi_empleados);
var
 e: empleado;
begin

 writeln ('a continuacion se muestran todos los empleados');
 
 reset (archi);

 while (not eof(archi)) do begin
   read (archi, e);
   mostrar (e);
   writeln (' ------------------------------------- ');
 end;

 close (archi);

end;

procedure jubilados (var archi: archi_empleados);
var
 e: empleado;
begin

 writeln (' a continuacion se muestran los empleados proximos a jubilarse');
 reset (archi);
 while (not eof(archi)) do begin
   read (archi, e);
   if (e.edad > 70) then
     mostrar (e);
 end;

 close (archi);

end;


var
  archi: archi_empleados;
  op: integer;
  salir: boolean;
begin
 salir:= false;

 while (salir = false) do begin

   writeln (' menu de opciones ');
   writeln (' ------------------------------------------------------ ');
   writeln ('1. crear un archivo');
   writeln ('2. mostrar en pantalla los datos de empleados que tengan un nombre o apellido determinado');
   writeln ('3. mostrar en pantalla los empleados de a uno por línea');
   writeln ('4. mostrar en pantalla los empleados mayores de 70 años, próximos a jubilarse');
   writeln ('5. salir');
   readln (op);

   case op of
   
     1: crear (archi);
     2: ape_nom (archi);
     3: todos (archi);
     4: jubilados (archi);
     5: salir:= true;
   end;   
   
 end;
 
 writeln ('                                                ha salido del menu ');
 
end.
