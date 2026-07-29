table 70000 "Plantilla Queen Mat. Comerc."
{

    fields
    {
        field(1; "ID MAT QUEEN"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'ID MAT QUEEN';
            Description = 'Codigo de material.';
        }
        field(2; "TIPO MATERIAL"; Code[1])
        {
            DataClassification = CustomerContent;
            Caption = 'TIPO MATERIAL';

            /*
            Description = 'M:Manuscrito (no aplica)\'
                          'ico\'
                          '\'
                          'arketing\'
                          '\'
                          'plica si es combo (pack, kit)\'
                          '';
                          */
        }
        field(3; ISBN; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'ISBN';
            Description = 'En materiales Marketing NO aplica.';
        }
        field(4; "Id manuscrito"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Id manuscrito';
            Description = 'Codigo que agrupa isbn de la misma obra\';
        }
        field(5; "Codigo producto de grupo"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo producto de grupo';
            Description = 'Codigo que identifica un producto a nivel de grupo\';
        }
        field(6; "Codigo manuscrito grupo"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo manuscrito grupo';
            Description = 'Codigo que identifica un manuscrito a nivel de grupo\';
        }
        field(7; "Sociedad propietaria"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Sociedad propietaria';
            Description = 'Sociedad propietaria de los derechos\';
        }
        field(8; "Fecha prevista Publicacion"; Code[8])
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha prevista Publicacion';
            Description = '(NO obligatoriopara TIPO MATERIAL: K  )';
        }
        field(9; "T tulo definitivo"; Code[120])
        {
            DataClassification = CustomerContent;
            Caption = 'T tulo definitivo';
        }
        field(10; "Subt tulo"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Subt tulo';
        }
        field(11; "NIF Autor Comercial"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'NIF Autor Comercial';
            Description = 'Debe venir de tabla GL024';
        }
        field(12; Sello; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Sello';
            Description = 'Debe venir de tabla GL003, Recibimos lookup\';
        }
        field(13; Linea; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Linea';
            Description = 'Debe venir de tabla GL004, Recibimos lookup\';
        }
        field(14; "Colecci n"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Colecci n';
            Description = 'Texto del nivel 7 de la jerarqu a de productos. Se agrupa en PRHGE';
        }
        field(15; "N  p ginas del art culo"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'N  p ginas del art culo';
        }
        field(16; Ancho; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ancho';
            Description = '13 (3 decimales)';
        }
        field(17; Alto; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Alto';
            Description = '13 (3 decimales)';
        }
        field(18; Grueso; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Grueso';
            Description = '13 (3 decimales)';
        }
        field(19; Peso; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Peso';
            Description = '13 (3 decimales) En KG';
        }
        field(20; "Tipo Encuadernacion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Encuadernacion';
            Description = 'Debe venir de tabla GL23';
        }
        field(21; "Precio con IVA"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio con IVA';
            Description = '15 (3 decimales) Precio con impuestos incluidos.';
        }
        field(22; Moneda; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Moneda';
        }
        field(23; "Valido desde"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Valido desde';
            Description = 'Fecha de precio vigente. En el formato AAAAMMDD';
        }
        field(24; "Valido hasta"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Valido hasta';
            Description = 'No Aplica';
        }
        field(25; "Clasificaci n Fiscal"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Clasificaci n Fiscal';
            Description = 'Porcentaje del impuesto.';
        }
        field(26; "Idioma Original"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Idioma Original';
            Description = 'Codigo ISO Idioma\';
        }
        field(27; "Idioma de publicaci n"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Idioma de publicaci n';
            Description = 'Codigo ISO Idioma\';
        }
        field(29; "Estado Cat logo"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Estado Cat logo';
            Description = 'Estado\';
        }
        field(30; "N  ultima Edicion"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'N  ultima Edicion';
        }
        field(31; "Editor Original"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Editor Original';
            Description = 'No aplica';
        }
        field(32; "Editor de Gesti n"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Editor de Gesti n';
            Description = 'GL022, Nombre Editor gestion\ e mandar los usuarios\';
        }
        field(33; "T tulo Original"; Text[110])
        {
            DataClassification = CustomerContent;
            Caption = 'T tulo Original';
        }
        field(34; "Idioma de la traducci n"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Idioma de la traducci n';
            Description = 'No aplica';
        }
        field(35; Personaje; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Personaje';
            Description = 'No aplica';
        }
        field(36; "N  de art culo en Colecci n"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'N  de art culo en Colecci n';
        }
        field(37; "No. Art. en Biblioteca Autor"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Art. en Biblioteca Autor';
            Description = 'No aplica';
        }
        field(38; "Fecha puesta en venta"; Code[8])
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha puesta en venta';
            Description = 'Fecha primera salida almacen';
        }
        field(39; "Articulo Embalado"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Articulo Embalado';
            Description = 'No aplica. Mandar vacio.';
        }
        field(40; Componente; Code[1])
        {
            DataClassification = CustomerContent;
            Caption = 'Componente';
            Description = ' ''X'' Indicador de componente de combo';
        }
        field(41; Compuesto; Code[1])
        {
            DataClassification = CustomerContent;
            Caption = 'Compuesto';
            Description = ' ''X'' Indicador de combo';
        }
        field(42; "Fecha  ltima Edicion"; Code[8])
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha  ltima Edicion';
            Description = 'La fecha de  ltima entrada en almac n';
        }
        field(43; "Fecha primera fact."; Code[8])
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha primera fact.';
            Description = 'Fecha primera salida de almac n.';
        }
        field(44; "Fecha primera venta"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha primera venta';
            Description = 'Fecha primera salida de almac n';
        }
        field(45; "Categoria Editorial"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Categoria Editorial';
            Description = 'No aplica.';
        }
        field(46; "Target Edad desde"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Target Edad desde';
            Description = 'Lectura recomendada para esta edad';
        }
        field(47; "Descripcion breve"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion breve';
            Description = 'No aplica';
        }
        field(48; Sinopsis; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Sinopsis';
            Description = 'Texto Contraportada';
        }
        field(49; "Biograf a"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Biograf a';
            Description = 'Biograf a Autor';
        }
        field(50; "Dep sito Legal"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Dep sito Legal';
        }
        field(51; "Fecha publicaci n"; Code[8])
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha publicaci n';
            Description = 'Poner la misma que fecha puesta en venta';
        }
        field(52; "TEMATICA WEB 1"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'TEMATICA WEB 1';
            Description = 'Bolsillo.\';
        }
        field(53; "TEMATICA WEB 2"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'TEMATICA WEB 2';
            Description = 'Rom ntica\';
        }
        field(54; "TEMATICA WEB 3"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'TEMATICA WEB 3';
            Description = 'Juvenil\';
        }
        field(55; "TEMATICA WEB 4"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'TEMATICA WEB 4';
            Description = 'Infantil\';
        }
        field(56; "TEMATICA WEB 5"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'TEMATICA WEB 5';
            Description = 'Ebook\';
        }
        field(57; "TEMATICA WEB 6"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'TEMATICA WEB 6';
            Description = 'App\';
        }
        field(58; "FECHA PUBL 1"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'FECHA PUBL 1';
            Description = 'Lo mismo que en fecha primera fact.';
        }
        field(59; "ISBN LIBRO FISICO"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'ISBN LIBRO FISICO';
            Description = 'S (Obligatorio para digital), En libros digitales, informar el ISBN del libro f sico, convertido a digital';
        }
        field(60; INEDITO; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'INEDITO';
            Description = 'In dito Digital. No aplica. Vacio.';
        }
        field(61; "Classificaci n comercial"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Classificaci n comercial';
            Description = 'AR.';
        }
        field(62; "Tipo de producci n"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de producci n';
            Description = 'AR.';
        }
        field(63; "Posici n Arancelaria"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Posici n Arancelaria';
            Description = 'AR.';
        }
        field(64; "Pais Ult. Impresi n"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Pais Ult. Impresi n';
            Description = 'AR.';
        }
        field(65; "% dederchos de autor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = '% dederchos de autor';
            Description = 'AR.';
        }
        field(66; "CAtegoria editor"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'CAtegoria editor';
            Description = 'AR.';
        }
        field(67; "Target Edad hasta"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Target Edad hasta';
        }
    }

    keys
    {
        key(Key1; "ID MAT QUEEN")
        {
        }
    }

    fieldgroups
    {
    }
}

