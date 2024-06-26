program ejercicio4;
type

  str13 = string [13];
  empleado = record
    nom: str13;
    ape: str13;
    cod,edad,dni: integer;
  end;
  archi_empleados = file of empleado;
  
procedure leer (var e: empleado);
begin

  writeln ('ingrese su apellido');
  readln (e.ape);
  if (e.ape <> 'fin') then begin
   writeln ('ingrese nombre');
   readln (e.nom);
   writeln ('ingrese dni');
   readln (e.dni);
   writeln ('ingrese edad');
   readln (e.edad);
   writeln ('ingrese codigo de empleado');
   readln (e.cod);
  end;
end; 
  

procedure crear (var archi: archi_empleados);
var
 n: str13;
 e: empleado;
begin

 writeln ('ingrese el nombre del archivo');
 readln (n);
 assign (archi, n);
 rewrite(archi);
 leer (e);

 while (e.ape <> 'fin') do begin
   write (archi, e);
   leer (e);
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

procedure agregarEmp (var archi: archi_empleados);
var
 e, f: empleado;
begin
 
  leer (e); // lee el nuevo //
  reset (archi);
  while (e.ape <> 'fin') do begin
    read (archi, f); // lee el primero para poder comparar codigos
    while ((not eof(archi)) and (e.cod <> f.cod))  do // busca en el archivo si ya existe el empleado //
      read (archi, f); // sigue leyendo
    if (e.cod = f.cod) then // se fija por que salio
      writeln (' ese empleado ya existe')
    else begin
      seek (archi, filesize(archi)); // va a la ultima pos //
      write (archi, e); // añade nuevo empleado //
    end; 
    leer (e);
  end;
  close (archi);
end;

procedure modificar_edad (var archi: archi_empleados);
  
var
 e, f: empleado;
 nueva_edad: integer;
begin

   writeln (' ingrese los datos del empleado que desea modificar' );
   leer (e);
   reset (archi);
   read (archi, f); // se busca por codigo de empleado
   while ((not eof(archi)) and (e.cod <> f.cod))  do
      read (archi, f);
   if (e.cod = f.cod) then begin
      writeln (' ingrese la nueva edad ');
      readln (nueva_edad);
      e.edad:= nueva_edad;
      seek(archi,filepos(archi)-1);
      write (archi, e)
   end
   else 
      writeln ( ' no se encontro el empleado ');
  close (archi);
end;

procedure exportar_txt (var archi: archi_empleados; var architxt: Text);
var
 e: empleado;
begin
  assign (architxt, 'todos_empleados.txt');
  reset (archi);
  rewrite (architxt);
  
  while (not eof(archi)) do begin
    read (archi, e);
    writeln (architxt, e.nom);
    writeln (architxt, e.cod, ' ', e.edad, ' ', e.dni, ' ', e.ape);
  end;
  close (archi);
  close (architxt);
  
  writeln (' archivo binario exportado a texto');
end;

procedure no_dnis  (var archi: archi_empleados; var txtdnis: Text);

  function encero (dni:integer): boolean;
  begin
    encero:= (dni =00);
  end;
var
  e: empleado;
begin

  assign (txtdnis, 'faltaDNIEmpleado.txt');
  reset (archi);
  rewrite (txtdnis);
  
  while (not eof(archi)) do begin
    read (archi, e);
    if (encero(e.dni))then begin
      writeln (txtdnis, e.nom);
      writeln (txtdnis, e.cod, ' ', e.edad, ' ', e.dni, ' ', e.ape);
    end;
  end;
  close (archi);
  close (txtdnis);
end; 
var
  archi: archi_empleados;
  architxt: Text;
  txtdnis: Text;
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
   writeln ('5. agregar empleados/s ');
   writeln ('6. exportar archivo a texto ');
   writeln ('7. exportar los empleados que no tengan dni');
   writeln ('8. salir');
   readln (op);

   case op of
   
     1: crear (archi);
     2: ape_nom (archi);
     3: todos (archi);
     4: jubilados (archi);
     5: agregarEmp (archi);
     6: exportar_txt (archi, architxt);
     7: no_dnis (archi, txtdnis); 
     8: salir:= true;
   end;   
   
 end;
 
 writeln ('                                                ha salido del menu ');
 
end.
