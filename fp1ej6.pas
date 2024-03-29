program ejercicio6;
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
    writeln (architxt,c.cod, ' ', c.precio, ' ', c.marca); // no quedan desordenados los datos?
    writeln (architxt, c.sdis, ' ', c.smin, ' ', c.desc);
    writeln (architxt, c.nom);
  end;
  
  close (archibin);
  close (architxt);
  
end;

procedure leer (var c: celulares);
begin
  
  writeln ('ingrese nombre');
  readln (c.nom);
  if (c.nom <> 'xxx') then begin
    writeln ('ingrese codigo de celular');
    readln (c.cod);
    writeln ('ingrese marca ');
    readln (c.marca);
    writeln (' ingrese precio ');
    readln (c.precio);
    writeln (' ingrese stock minimo ');
    readln (c.smin);
    writeln (' ingrese stock disponible');
    readln (c.sdis);
    writeln (' ingrese descripcion ');
    readln (c.desc);
  end;
end;
procedure agregarCelus (var archibin: bin_celus);
var
  c:celulares;
begin

  reset (archibin);
  
  writeln ('ingrese los datos del celular que quiere añadir al archivo');
  leer (c);
  while (c.nom <> 'xxx') do begin
    seek (archibin,filesize(archibin)); // MUY IMPORTANTE !!
    write (archibin, c);
    leer (c);
  end;
  
  close (archibin);
  
end;  

procedure modificar (var archibin: bin_celus);
var
  c,d: celulares;
begin

 writeln ('ingrese los datos del celular que desea modificar');
 leer(c);
 
 reset (archibin);
 read (archibin, d);
 while (not eof(archibin) and (d.nom <> c.nom)) do // lo busco por nombre
   read (archibin, d);
 if (d.nom = c.nom) then begin
   writeln (' ingrese el stock minimo');
   readln (c.smin);
   writeln ('ingrese stock disponible');
   readln (c.sdis);
   seek(archibin,filepos(archibin)-1); // RECORDAR
   write (archibin,c)
 end
 else
   writeln (' no se encontro el celular');
  
 close (archibin);
 
end;

procedure sin_stock (var archibin: bin_celus; var architxt_sinstock: Text);
var
  c:celulares;
begin
 
 assign (architxt_sinstock, 'SinStock.txt');
 rewrite (architxt_sinstock);
 
 reset(archibin);
 
 while (not(eof)) do begin
   read (archibin, c);
   if (c.sdis = 0) then begin
    writeln (architxt_sinstock, c.cod, ' ',  c.precio, ' ',  c.marca); // no quedan desordenados los datos? se sigue manteniendo el orden?
    writeln (architxt_sinstock, c.sdis, ' ', c.smin, ' ', c.desc);
    writeln (architxt_sinstock, c.nom);
   end;
 end;
 
 close (archibin);
 close(architxt_sinstock);    

end;   

procedure menu (var archibin: bin_celus; var archtxt_disponible: Text; var archtxt_nuevo: Text; op: integer; var architxt_sinstock: Text);
begin

  case op of 
  
    1: crear (archibin, archtxt_disponible);
    2: stock (archibin);
    3: descripcion (archibin);
    4: exportar (archibin, archtxt_nuevo);
    5: agregarCelus (archibin);
    6: modificar (archibin);
    7: sin_stock (archibin, architxt_sinstock);
    0: writeln (' menu finalizado ');
  end;
end;

var
  archibin: bin_celus;
  architxt_disponible: Text;
  architxt_nuevo: Text;
  architxt_sinstock: Text;
  op: integer;
begin

  repeat

   writeln (' Menu de opciones ');
   writeln (' ---------------------------------------------------------------------------------------- ');
   writeln ('1. crear archivo binario');
   writeln ('2. mostrar en pantalla los celulares con stock menor al minimo');
   writeln ('3. mostrar en pantalla los celulares con la descripcion ingresada');
   writeln ('4. crear archivo de texto con archivo binario');
   writeln ('5. agregar celular/es');
   writeln ('6. modificar stock');
   writeln ('7. exportar a archivo de texto los celulares sin stock');
   writeln ('0. salir del menu de opciones'); 
   readln (op);
   menu (archibin, architxt_disponible, architxt_nuevo,op, architxt_sinstock);
   
  until ( op = 0)
  
end.
