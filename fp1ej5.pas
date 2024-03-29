program ejercicio5;
type 

  str21 = string [21];
  
  celulares = record
  
    cod: integer;  
    nom: str21;
    marca: str21;
    precio: real;
    smin: integer;
    sdis: integer;
    desc: string;
  end;
  
  bin_celus = file of celulares;
 
procedure crear (var archibin: bin_celus; var architxt: Text);
var
 nom: str21;
 c: celulares;
begin

 writeln (' ingrese el nombre que desea ponerle al nuevo archivo ');
 readln (nom);
 
 assign (archibin, nom); // conecta el nombre
 rewrite (archibin); // inicia el archivo
 
 reset (architxt); // abre el archivo txt
 
 while (not eof(architxt)) do begin
   readln (architxt, c.cod, c.precio, c.marca);
   readln (architxt, c.sdis, c.smin, c.desc);
   readln (architxt, c.nom);
   write (archibin, c);
 end;
 
 close (architxt);
 close (archibin);
 
end;

procedure mostrar (c: celulares);
begin
  writeln ( 'codigo: ', c.cod);
  writeln (' nombre: ', c.nom);
  writeln (' marca: ', c.marca);
  writeln (' precio: ', c.precio);
  writeln (' stock minimo: ', c.smin);
  writeln (' stock disponible: ', c.sdis);
  writeln (' descripcion: ', c.desc);
end;

procedure stock (var archi: bin_celus);
var
  c: celulares;
begin

   reset(archi);
   
  while (not eof(archi)) do begin
    read (archi, c);
    if (c.sdis < c.smin) then
      mostrar(c)
    else
      writeln (' el stock disponible es mayor al minimo');
  end;
  
  close (archi);
  
end;
  
procedure descripcion (var archi: bin_celus);
var
  c:celulares;
  des: string;
begin

 writeln (' ingrese la descripcion a buscar');
 readln (des);
 
 reset (archi);
 
 while (not eof(archi) ) do begin
   read (archi, c);
   if (c.desc = des) then
     mostrar(c)
   else
     writeln (' este celular no tiene la descripcion buscada');
 end;
 
 close (archi);
 
end;

procedure exportar (var archibin:bin_celus; var architxt: Text);
var
  c: celulares;
begin
 
  assign (architxt, 'celulares.txt');
  rewrite (architxt);
  reset (archibin);
  
  while (not eof(archibin)) do begin
    read (archibin, c);
    writeln (architxt,c.cod, c.precio, c.marca); // no quedan desordenados los datos?
    writeln (architxt, c.sdis, c.smin, c.desc);
    writeln (architxt, c.nom);
  end;
  
  close (archibin);
  close (architxt);
  
end;

procedure menu (var archibin: bin_celus; var archtxt_disponible: Text; var archtxt_nuevo: Text; op: integer);
begin

  case op of 
  
    1: crear (archibin, archtxt_disponible);
    2: stock (archibin);
    3: descripcion (archibin);
    4: exportar (archibin, archtxt_nuevo);
    0: writeln (' menu finalizado ');
  end;
end;

var
  archibin: bin_celus;
  architxt_disponible: Text;
  architxt_nuevo: Text;
  op: integer;
begin

  repeat

   writeln (' Menu de opciones ');
   writeln (' ---------------------------------------------------------------------------------------- ');
   writeln ('1. crear archivo binario');
   writeln ('2. mostrar en pantalla los celulares con stock menor al minimo');
   writeln ('3. mostrar en pantalla los celulares con la descripcion ingresada');
   writeln ('4. crear archivo de texto con archivo binario');
   writeln ('0. salir del menu de opciones'); 
   readln (op);
   menu (archibin, architxt_disponible, architxt_nuevo,op);
   
  until ( op = 0)
  
end.
 
