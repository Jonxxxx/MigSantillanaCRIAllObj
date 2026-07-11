table 70020 "Plantilla Queen Mat. Comerc.1"
{

    fields
    {
        field(1; "ID MAT QUEEN"; Code[30])
        {
            Description = 'C digo de material.';
        }
        field(2; "TIPO MATERIAL"; Code[1])
        {
            Description = 'M:Manuscrito (no aplica)\'
                          'ico\'
                          '\'
                          'arketing\'
                          '\'
                          'plica si es combo (pack, kit)\'
                          '';
        }
        field(3;ISBN;Code[30])
        {
            Description = 'En materiales Marketing NO aplica.';
        }
        field(4;"Id manuscrito";Code[10])
        {
            Description = 'Codigo que agrupa isbn de la misma obra\'
                          '\'
                          '';
        }
        field(5;"Codigo producto de grupo";Code[10])
        {
            Description = 'Codigo que identifica un producto a nivel de grupo\'
                          '\'
                          '';
        }
        field(6;"Codigo manuscrito grupo";Code[10])
        {
            Description = 'Codigo que identifica un manuscrito a nivel de grupo\'
                          '\'
                          '';
        }
        field(7;"Sociedad propietaria";Code[10])
        {
            Description = 'Sociedad propietaria de los derechos\'
                          'o informa PRH\'
                          '';
        }
        field(8;"Fecha prevista Publicacion";Code[8])
        {
            Description = '(NO obligatoriopara TIPO MATERIAL: K  )';
        }
        field(9;"T tulo definitivo";Code[120])
        {
        }
        field(10;"Subt tulo";Text[80])
        {
        }
        field(11;"NIF Autor Comercial";Code[30])
        {
            Description = 'Debe venir de tabla GL024';
        }
        field(12;Sello;Text[80])
        {
            Description = 'Debe venir de tabla GL003, Recibimos lookup\'
                          '\'
                          '';
        }
        field(13;Linea;Text[80])
        {
            Description = 'Debe venir de tabla GL004, Recibimos lookup\'
                          '\'
                          '';
        }
        field(14;"Colecci n";Text[30])
        {
            Description = 'Texto del nivel 7 de la jerarqu a de productos. Se agrupa en PRHGE';
        }
        field(15;"N  p ginas del art culo";Integer)
        {
        }
        field(16;Ancho;Integer)
        {
            Description = '13 (3 decimales)';
        }
        field(17;Alto;Integer)
        {
            Description = '13 (3 decimales)';
        }
        field(18;Grueso;Integer)
        {
            Description = '13 (3 decimales)';
        }
        field(19;Peso;Integer)
        {
            Description = '13 (3 decimales) En KG';
        }
        field(20;"Tipo Encuadernaci n";Code[10])
        {
            Description = 'Debe venir de tabla GL23';
        }
        field(21;"Precio con IVA";Decimal)
        {
            Description = '15 (3 decimales) Precio con impuestos incluidos.';
        }
        field(22;Moneda;Code[10])
        {
        }
        field(23;"Valido desde";Code[20])
        {
            Description = 'Fecha de precio vigente. En el formato AAAAMMDD';
        }
        field(24;"Valido hasta";Code[20])
        {
            Description = 'No Aplica';
        }
        field(25;"Clasificaci n Fiscal";Code[10])
        {
            Description = 'Porcentaje del impuesto.';
        }
        field(26;"Idioma Original";Code[10])
        {
            Description = 'C digo ISO Idioma\'
                          '\'
                          '';
        }
        field(27;"Idioma de publicaci n";Code[10])
        {
            Description = 'C digo ISO Idioma\'
                          '\'
                          '';
        }
        field(29;"Estado Cat logo";Code[10])
        {
            Description = 'Estado\'
                          '\'
                          '';
        }
        field(30;"N  Ultima Edicion";Code[30])
        {
        }
        field(31;"Editor Original";Code[10])
        {
            Description = 'No aplica';
        }
        field(32;"Editor de Gesti n";Text[30])
        {
            Description = 'GL022, Nombre Editor gesti n\'
                          'e mandar los usuarios\'
                          '';
        }
        field(33;"T tulo Original";Text[110])
        {
        }
        field(34;"Idioma de la traducci n";Code[10])
        {
            Description = 'No aplica';
        }
        field(35;Personaje;Code[10])
        {
            Description = 'No aplica';
        }
        field(36;"N  de art culo en Colecci n";Code[20])
        {
        }
        field(37;"No. Art. en Biblioteca Autor";Code[10])
        {
            Description = 'No aplica';
        }
        field(38;"Fecha puesta en venta";Code[8])
        {
            Description = 'Fecha primera salida almacen';
        }
        field(39;"Articulo Embalado";Code[10])
        {
            Description = 'No aplica. Mandar vacio.';
        }
        field(40;Componente;Code[1])
        {
            Description = ' ''X'' Indicador de componente de combo';
        }
        field(41;Compuesto;Code[1])
        {
            Description = ' ''X'' Indicador de combo';
        }
        field(42;"Fecha  ltima edici n";Code[8])
        {
            Description = 'La fecha de  ltima entrada en almac n';
        }
        field(43;"Fecha primera fact.";Code[8])
        {
            Description = 'Fecha primera salida de almac n.';
        }
        field(44;"Fecha primera venta";Code[10])
        {
            Description = 'Fecha primera salida de almac n';
        }
        field(45;"Categor a Editorial";Code[10])
        {
            Description = 'No aplica.';
        }
        field(46;"Target Edad desde";Code[20])
        {
            Description = 'Lectura recomendada para esta edad';
        }
        field(47;"Descripci n breve";Text[30])
        {
            Description = 'No aplica';
        }
        field(48;Sinopsis;Text[250])
        {
            Description = 'Texto Contraportada';
        }
        field(49;"Biograf a";Text[250])
        {
            Description = 'Biograf a Autor';
        }
        field(50;"Dep sito Legal";Text[30])
        {
        }
        field(51;"Fecha publicaci n";Code[8])
        {
            Description = 'Poner la misma que fecha puesta en venta';
        }
        field(52;"TEMATICA WEB 1"; Text[30])
        {
            Description = 'Bolsillo.\'
                          'acio.\'
                          '';
        }
        field(53;"TEMATICA WEB 2"; Text[30])
        {
            Description = 'Rom ntica\'
                          'acio.\'
                          '';
        }
        field(54;"TEMATICA WEB 3"; Text[30])
        {
            Description = 'Juvenil\'
                          'acio.\'
                          '';
        }
        field(55;"TEMATICA WEB 4"; Text[30])
        {
            Description = 'Infantil\'
                          'acio.\'
                          '';
        }
        field(56;"TEMATICA WEB 5"; Text[30])
        {
            Description = 'Ebook\'
                          'acio.\'
                          '';
        }
        field(57;"TEMATICA WEB 6"; Text[30])
        {
            Description = 'App\'
                          'acio.\'
                          '';
        }
        field(58;"FECHA PUBL 1"; Code[10])
        {
            Description = 'Lo mismo que en fecha primera fact.';
        }
        field(59;"ISBN LIBRO FISICO";Text[30])
        {
            Description = 'S (Obligatorio para digital), En libros digitales, informar el ISBN del libro f sico, convertido a digital';
        }
        field(60;INEDITO;Text[30])
        {
            Description = 'In dito Digital. No aplica. Vacio.';
        }
        field(61;"Classificaci n comercial";Text[30])
        {
            Description = 'AR.';
        }
        field(62;"Tipo de producci n";Text[30])
        {
            Description = 'AR.';
        }
        field(63;"Posici n Arancelaria";Text[30])
        {
            Description = 'AR.';
        }
        field(64;"Pa s Ult. Impresi n";Text[30])
        {
            Description = 'AR.';
        }
        field(65;"% dederchos de autor";Code[20])
        {
            Description = 'AR.';
        }
        field(66;"CAtegoria editor";Text[30])
        {
            Description = 'AR.';
        }
        field(67;"Target Edad hasta";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"ID MAT QUEEN")
        {
        }
    }

    fieldgroups
    {
    }
}

