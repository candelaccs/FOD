program ejercicio7;
type

 str17 = string [17];
 
 novelas = record
   cod: integer;
   nom: str17;
   genero: str17;
   precio: real;
 end;
 
 binario = file of novelas;
 
procedure crear_binario (var bin: binario; var txt: Text);
var
  n: novelas;
  nom: str17;
begin

 writeln (' ingrese el nombre del archivo binario');
 readln (nom);
 assign (bin, nom);
 rewrite (bin);
 reset (txt);
 while (not eof(txt)) do begin
  readln (txt, n.cod,n.precio,n.genero); // siempre se lee bajando una linea cuando se trata de una cadena string?
  readln (txt, n.nom);
  write (bin, n);
 end;
 
 close (txt);
 close(bin);

end;

procedure leer (var n:novelas);
begin
  
  writeln ('ingrese codigo de novela'); 
  readln (n.cod);
  if (n.cod <> 000) then begin
    writeln ('ingrese nombre');
    readln (n.nom);
    writeln ('ingrese genero');
    readln (n.genero);
    writeln ('ingrese precio');
    readln (n.precio);
  end;
 
end;

procedure agregar (var bin: binario);
var
  n:novelas;
begin

 writeln (' ingrese los datos de la nueva novela');
 leer (n);
 reset (bin);
 seek(bin,filesize(bin));
 write(bin,n);
 close (bin);
 
end;

procedure modificar (var bin: binario);
var
 n,n1: novelas;
begin

 writeln ('ingrese los datos de la novela que quiere modificar');
 leer (n);
 reset (bin);
 read (bin, n1);
 while (not eof(bin) and (n.cod <> n1.cod)) do
   read(bin,n1);
 if (n.cod = n1.cod) then begin
   writeln ('ingrese los nuevos datos');
   leer (n);
   seek(bin, filepos(bin)-1);
   write(bin,n);
 end
 else
   writeln ('no se pudo encontrar la novela ');
 
 close (bin);
 
end;
   
var

 bin: binario;
 texto: Text;

begin

 crear_binario (bin, texto);
 agregar(bin);
 modificar(bin);
 
 // no se crea menu porque no se especifica
 
end. 
   
   
