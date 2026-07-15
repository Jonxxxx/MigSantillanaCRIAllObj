xmlport 75004 "MDM-Migracion Inicial Art."
{
    // --------------------------------------------------------------------------------
    // -- XMLport automatically created with Dynamics NAV XMLport Generator 1.3.0.2
    // -- Copyright ® 2007-2012 Carsten Scholling
    // --------------------------------------------------------------------------------
    // wSopPapel Indica el valor Sorte = "Papel" lo que implique se se comuniquen o no determinados campos
    // wTipSLIC wTipSDIG Son tipologias de tipo SLIC o SDIC. Implica que determinados campos se consideren obligatorios y deban de comunicarse o no

    DefaultFieldsValidation = false;
    Direction = Export;
    Encoding = UTF16;
    Format = Xml;
    FormatEvaluate = Xml;
    /*
    TODO: Ver
    schema
    {
        textelement(mensaje)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            XmlName = 'mensaje';
            textelement(body)
            {
                MaxOccurs = Once;
                MinOccurs = Once;
                XmlName = 'body';
                textelement(articulos)
                {
                    MaxOccurs = Once;
                    MinOccurs = Once;
                    XmlName = 'Articulos';
                    tableelement(Item; Item)
                    {
                        MaxOccurs = Unbounded;
                        MinOccurs = Once;
                        RequestFilterFields = Field1;
                        XmlName = 'Articulo';
                        SourceTableView = SORTING(Field1);
                        textelement(articulo_general)
                        {
                            MaxOccurs = Once;
                            MinOccurs = Once;
                            XmlName = 'Articulo_GENERAL';
                            fieldelement(Clave; Item."No.")
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                            }
                            fieldelement(Tipologia; Item."Item Category Code")
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;

                                trigger OnBeforePassField()
                                begin
                                    AsegDato(Item."Item Category Code");
                                end;
                            }
                            textelement(titulo_corto)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                TextType = Text;
                                XmlName = 'Titulo_Corto';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Titulo_Corto);
                                end;
                            }
                            textelement(titulo)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Titulo_Catalogo';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Titulo);
                                end;
                            }
                            textelement(ISBN)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(ISBN);
                                end;
                            }
                            textelement(isbn_tramitado)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'ISBN_Tramitado';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato('');
                                end;
                            }
                            textelement(ean)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'EAN';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(EAN);
                                end;
                            }
                            fieldelement(Tipo_Producto; Item."Tipo Producto")
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;

                                trigger OnBeforePassField()
                                begin
                                    AsegDato(Item."Tipo Producto");
                                end;
                            }
                            fieldelement(Soporte_del_Producto; Item.Soporte)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;

                                trigger OnBeforePassField()
                                begin
                                    AsegDato(Item.Soporte);
                                end;
                            }
                            textelement(alto)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Alto';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Alto);
                                end;
                            }
                            textelement(ancho)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Ancho';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Ancho);
                                end;
                            }
                            textelement(encuadernacion)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Encuadernacion';

                                trigger OnBeforePassVariable()
                                begin
                                    IF NOT EsPapel THEN
                                        currXMLport.SKIP;
                                    AsegDato(Encuadernacion);
                                end;
                            }
                            textelement(con_solapas)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Con_Solapas';

                                trigger OnBeforePassVariable()
                                begin
                                    IF NOT EsPapel THEN
                                        currXMLport.SKIP;
                                    AsegDato(Con_Solapas);
                                end;
                            }
                            textelement(datos_tecnicos)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Datos_Tecnicos';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Datos_Tecnicos);
                                end;
                            }
                            textelement(paginas)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Paginas';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Paginas);
                                end;
                            }
                            textelement(peso)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Peso';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Peso);
                                end;
                            }
                            fieldelement(Empresa_Editora; Item."Empresa Editora")
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;

                                trigger OnBeforePassField()
                                begin
                                    AsegDato(Item."Empresa Editora");
                                end;
                            }
                            fieldelement(Linea; Item.Linea)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;

                                trigger OnBeforePassField()
                                begin
                                    AsegDato(Item.Linea);
                                end;
                            }
                            textelement(sello)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                XmlName = 'Sello';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Sello);
                                end;
                            }
                            textelement(fecha_alta)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                TextType = Text;
                                XmlName = 'Fecha_Alta';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Fecha_Alta);
                                end;
                            }
                            textelement(idioma)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                XmlName = 'Idioma';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Idioma);
                                end;
                            }
                            textelement(idioma_original)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Idioma_Original';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Idioma_Original);
                                end;
                            }
                            textelement(titulo_original)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Titulo_Original';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Titulo_Original);
                                end;
                            }
                            textelement(idioma_resumen)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Idioma_Resumen';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Idioma_Resumen);
                                end;
                            }
                            textelement(resumen)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Resumen';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Resumen);
                                end;
                            }
                            textelement(obra_proyecto)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Obra_Proyecto';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Obra_Proyecto);
                                end;
                            }
                            textelement(serie_metodo)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Serie_Metodo';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Serie_Metodo);
                                end;
                            }
                            textelement(orden_serie_metodo)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Orden_Serie_Metodo';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Orden_Serie_Metodo);
                                end;
                            }
                            textelement(clasificaciones_ibic)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Clasificaciones_IBIC';
                                textelement(clasificacion_ibic)
                                {
                                    MaxOccurs = Unbounded;
                                    MinOccurs = Once;
                                    XmlName = 'Clasificacion_IBIC';
                                    textelement(ibic)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'IBIC';
                                    }
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    currXMLport.SKIP;
                                end;
                            }
                            textelement(ficheros_digitales_asociado)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Ficheros_Digitales_Asociados';
                                textelement(fichero_digital_asociado)
                                {
                                    MaxOccurs = Unbounded;
                                    MinOccurs = Once;
                                    XmlName = 'Fichero_Digital_Asociado';
                                    textelement(tipo_fichero_digital_asocia)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'Tipo_Fichero_Digital_Asociado';
                                    }
                                    textelement(ficherodigitalasociado)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'FicheroDigitalAsociado';
                                    }
                                    textelement(ficherodigitalprincipal)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'FicheroDigitalPrincipal';
                                    }
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    currXMLport.SKIP;
                                end;
                            }
                            textelement(asignacion_autores)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Asignacion_Autores';
                                textelement(asignacion_autor)
                                {
                                    MaxOccurs = Unbounded;
                                    MinOccurs = Once;
                                    XmlName = 'Asignacion_Autor';
                                    textelement(autor)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        XmlName = 'Autor';

                                        trigger OnBeforePassVariable()
                                        begin
                                            AsegDato(Autor);
                                        end;
                                    }
                                    textelement(tipo_autoria)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        XmlName = 'Tipo_Autoria';

                                        trigger OnBeforePassVariable()
                                        begin
                                            AsegDato(Tipo_Autoria);
                                        end;
                                    }
                                    textelement(autor_catalogo)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        XmlName = 'Autor_Catalogo';

                                        trigger OnBeforePassVariable()
                                        begin
                                            AsegDato(Autor_Catalogo);
                                        end;
                                    }

                                    trigger OnBeforePassVariable()
                                    begin
                                        AsegDato(Autor);
                                    end;
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Autor);
                                end;
                            }
                            textelement(articulos_digitales)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Articulos_Digitales';
                                textelement(articulo_digital)
                                {
                                    MaxOccurs = Unbounded;
                                    MinOccurs = Once;
                                    XmlName = 'Articulo_Digital';
                                    textelement(formatodigital)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'FormatoDigital';

                                        trigger OnBeforePassVariable()
                                        begin
                                            AsegDato(FormatoDigital);
                                        end;
                                    }
                                    textelement(pesodigitalunidad)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'PesoDigitalUnidad';

                                        trigger OnBeforePassVariable()
                                        begin
                                            AsegDato(PesoDigitalUnidad);
                                        end;
                                    }
                                    textelement(pesodigitalvalor)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'PesoDigitalValor';

                                        trigger OnBeforePassVariable()
                                        begin
                                            AsegDato(PesoDigitalValor);
                                        end;
                                    }
                                    textelement(tipoproteccion)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'TipoProteccion';

                                        trigger OnBeforePassVariable()
                                        begin
                                            AsegDato(TipoProteccion);
                                        end;
                                    }
                                    textelement(versiondigital)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'VersionDigital';

                                        trigger OnBeforePassVariable()
                                        begin
                                            AsegDato(VersionDigital);
                                        end;
                                    }

                                    trigger OnBeforePassVariable()
                                    begin

                                        IF EsTipSlicSdig THEN BEGIN
                                            FormatoDigital := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::"Formato Digital", '', wObligaCampos);
                                            PesoDigitalUnidad := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::"Peso Digital Unidad", '', wObligaCampos);
                                            PesoDigitalValor := '0';
                                            TipoProteccion := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::"Tipo Proteccion", '', wObligaCampos);
                                        END
                                        ELSE BEGIN
                                            FormatoDigital := '';
                                            PesoDigitalUnidad := '';
                                            PesoDigitalValor := '';
                                            TipoProteccion := '';
                                        END;

                                        IF (FormatoDigital = '') AND (PesoDigitalUnidad = '') AND (PesoDigitalValor = '') AND (TipoProteccion = '') THEN
                                            currXMLport.SKIP;
                                    end;
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    IF NOT EsTipSlicSdig THEN
                                        currXMLport.SKIP;
                                end;
                            }
                            textelement(direcciones_url)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Direcciones_URL';
                                textelement(direccion_url)
                                {
                                    MaxOccurs = Unbounded;
                                    MinOccurs = Once;
                                    XmlName = 'Direccion_URL';
                                    textelement(direccion_url_direccion_url)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'Direccion_URL';
                                    }
                                    textelement(principal)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'Principal';
                                    }
                                    textelement(tipo_url)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'Tipo_URL';
                                    }
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    currXMLport.SKIP;
                                end;
                            }
                            textelement(premios)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Premios';
                                textelement(premio)
                                {
                                    MaxOccurs = Unbounded;
                                    MinOccurs = Once;
                                    XmlName = 'Premio';
                                    textelement(nombre_premio)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'Nombre_Premio';
                                    }
                                    textelement(pais_premio)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'Pais_Premio';
                                    }
                                    textelement(posicion_premio)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'Posicion_Premio';
                                    }
                                    textelement(anio_premio)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'Anio_Premio';
                                    }
                                    textelement(jurado_premio)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'Jurado_Premio';
                                    }
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    currXMLport.SKIP;
                                end;
                            }
                        }
                        textelement(articulo_espec)
                        {
                            MaxOccurs = Unbounded;
                            MinOccurs = Once;
                            XmlName = 'Articulo_ESPEC';
                            fieldelement(Clave; Item."No.")
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                            }
                            fieldelement(Sociedad; Item.Sociedad)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;

                                trigger OnBeforePassField()
                                begin
                                    AsegDato(Item.Sociedad);
                                end;
                            }
                            textelement(pais)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                XmlName = 'Pais';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Pais);
                                end;
                            }
                            textelement(idioma_resenia)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Idioma_Resenia';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Idioma_Resenia);
                                end;
                            }
                            textelement(resenia)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Resenia';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Resenia);
                                end;
                            }
                            textelement(idioma_titular_promocional)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Idioma_Titular_Promocional';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Idioma_Titular_Promocional);
                                end;
                            }
                            textelement(titular_promocional)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Titular_Promocional';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Titular_Promocional);
                                end;
                            }
                            fieldelement(Plan_Editorial; Item."Plan Editorial")
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;

                                trigger OnBeforePassField()
                                begin
                                    AsegDato(Item."Plan Editorial");
                                end;
                            }
                            textelement(campania)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Campania';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Campania);
                                end;
                            }
                            textelement(edicion)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Edicion';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Edicion);
                                end;
                            }
                            textelement(derechos_de_autor)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                TextType = Text;
                                XmlName = 'Derechos_de_Autor';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Derechos_de_Autor);
                                end;
                            }
                            textelement(destino)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                TextType = Text;
                                XmlName = 'Destino';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Destino);
                                end;
                            }
                            textelement(cuenta)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                TextType = Text;
                                XmlName = 'Cuenta';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Cuenta);
                                end;
                            }
                            fieldelement(Estructura_Analitica; Item."Estructura Analitica")
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;

                                trigger OnBeforePassField()
                                begin
                                    AsegDato(Item."Estructura Analitica");
                                end;
                            }
                            textelement(estado)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                XmlName = 'Estado';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Estado);
                                end;
                            }
                            textelement(fecha_estado)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                TextType = Text;
                                XmlName = 'Fecha_Estado';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Fecha_Estado);
                                end;
                            }
                            textelement(fecha_almacen)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Fecha_Almacen';
                            }
                            textelement(fecha_prevista_almacen)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Fecha_Prevista_Almacen';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Fecha_Prevista_Almacen);
                                end;
                            }
                            textelement(fecha_comercializacion)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Fecha_Comercializacion';
                            }
                            textelement(tipo_texto)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Tipo_Texto';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Tipo_Texto);
                                end;
                            }
                            fieldelement(Asignatura; Item.Asignatura)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;

                                trigger OnBeforePassField()
                                begin
                                    AsegDato(Item.Asignatura);
                                end;
                            }
                            textelement(materia)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Materia';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Materia);
                                end;
                            }
                            textelement(nivel_escolar)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Nivel_Escolar';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Nivel_Escolar);
                                end;
                            }
                            textelement(bimestre_trimestre)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Bimestre_Trimestre';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Bimestre_Trimestre);
                                end;
                            }
                            textelement(carga_horaria)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Carga_Horaria';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Carga_Horaria);
                                end;
                            }
                            textelement(common_european_framework)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Common_European_Framework';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Common_European_Framework);
                                end;
                            }
                            textelement(observaciones)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Observaciones';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Observaciones);
                                end;
                            }
                            textelement(origen)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                TextType = Text;
                                XmlName = 'Origen';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Origen);
                                end;
                            }
                            textelement(vendible)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                TextType = Text;
                                XmlName = 'Vendible';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Vendible);
                                end;
                            }
                            textelement(precio)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Precio';
                                textelement(precio_sin_impuestos)
                                {
                                    MaxOccurs = Once;
                                    MinOccurs = Once;
                                    TextType = Text;
                                    XmlName = 'Precio_sin_Impuestos';

                                    trigger OnBeforePassVariable()
                                    begin
                                        AsegDato(Precio_sin_Impuestos);
                                    end;
                                }
                                textelement(precio_con_impuestos)
                                {
                                    MaxOccurs = Once;
                                    MinOccurs = Once;
                                    TextType = Text;
                                    XmlName = 'Precio_con_Impuestos';

                                    trigger OnBeforePassVariable()
                                    begin
                                        AsegDato(Precio_con_Impuestos);
                                    end;
                                }
                                textelement(moneda)
                                {
                                    MaxOccurs = Once;
                                    MinOccurs = Once;
                                    TextType = Text;
                                    XmlName = 'Moneda';

                                    trigger OnBeforePassVariable()
                                    begin
                                        AsegDato(Moneda);
                                    end;
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Precio_sin_Impuestos);
                                end;
                            }
                            textelement(edad_interes_desde)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Edad_Interes_Desde';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Edad_Interes_Desde);
                                end;
                            }
                            textelement(edad_interes_hasta)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Edad_Interes_Hasta';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Edad_Interes_Hasta);
                                end;
                            }
                            textelement(vida_util)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Vida_Util';

                                trigger OnBeforePassVariable()
                                begin
                                    AsegDato(Vida_Util);
                                end;
                            }
                            textelement(packs)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Packs';
                                tableelement(bomline; Table90)
                                {
                                    LinkFields = Field1 = FIELD("Field1");
                                    LinkTable = Item;
                                    MaxOccurs = Unbounded;
                                    MinOccurs = Zero;
                                    XmlName = 'Pack';
                                    SourceTableView = WHERE(Field3 = CONST(1));
                                    textelement(articulo_pack)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        XmlName = 'Articulo_Pack';
                                    }
                                    fieldelement(Unidades; BOMLine."Quantity per")
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                    }
                                    fieldelement(Orden; BOMLine."Line No.")
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                    }

                                    trigger OnAfterGetRecord()
                                    begin
                                        IF BOMLine.COUNT = 0 THEN
                                            currXMLport.SKIP;

                                        Articulo_Pack := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::"Artículo Pack", BOMLine."No.", FALSE);
                                        //Articulo_Pack  := GetTexMaxErr(Articulo_Pack,10, Text003);
                                    end;
                                }
                                textelement(componentes)
                                {
                                    MaxOccurs = Once;
                                    MinOccurs = Zero;
                                    TextType = Text;
                                    XmlName = 'Componentes';

                                    trigger OnBeforePassVariable()
                                    begin
                                        AsegDato(Componentes);
                                    end;
                                }

                                trigger OnBeforePassVariable()
                                var
                                    lrLinBom: Record 90;
                                begin
                                    CLEAR(lrLinBom);
                                    lrLinBom.SETRANGE("Parent Item No.", Item."No.");
                                    IF lrLinBom.ISEMPTY THEN
                                        currXMLport.SKIP;
                                end;
                            }
                            textelement(asignacion_articulos_relaci)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Asignacion_Articulos_Relacionados';
                                textelement(asignacion_articulo_relacio)
                                {
                                    MaxOccurs = Unbounded;
                                    MinOccurs = Once;
                                    XmlName = 'Asignacion_Articulo_Relaciodado';
                                    textelement(articulo_relacionado)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'Articulo_Relacionado';
                                    }
                                    textelement(tipo_relacion)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'Tipo_Relacion';
                                    }
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    currXMLport.SKIP;
                                end;
                            }
                            textelement(asignacion_fechas_conmemora)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Asignacion_Fechas_Conmemorativas';
                                textelement(asignacion_fecha_conmemorat)
                                {
                                    MaxOccurs = Unbounded;
                                    MinOccurs = Once;
                                    XmlName = 'Asignacion_Fecha_Conmemorativa';
                                    textelement(fecha_conmemorativa)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'Fecha_Conmemorativa';
                                    }
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    currXMLport.SKIP;
                                end;
                            }
                            textelement(asignacion_temas_tranversal)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Asignacion_Temas_Tranversales';
                                textelement(asignacion_tema_tranversal)
                                {
                                    MaxOccurs = Unbounded;
                                    MinOccurs = Once;
                                    XmlName = 'Asignacion_Tema_Tranversal';
                                    textelement(tema_tranversal)
                                    {
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                        TextType = Text;
                                        XmlName = 'Tema_Tranversal';
                                    }
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    currXMLport.SKIP;
                                end;
                            }

                            trigger OnBeforePassVariable()
                            var
                                lrCommentLine: Record 97;
                            begin


                                Derechos_de_Autor := FORMAT(Item."Derecho de autor", 0, 9);
                                Pais := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::País, Item."Country/Region of Origin Code", FALSE);

                                Edicion := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::Edicion, Item.Edicion, FALSE);
                                Edicion := GetTexMaxErr(Edicion, 10, Item.FIELDCAPTION(Edicion));

                                Estado := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::Estado, Item.Estado, FALSE);
                                Estado := GetTexMaxErr(Estado, 10, Item.FIELDCAPTION(Estado));

                                Nivel_Escolar := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::"Nivel Escolar", Item."Nivel Escolar (Grado)", FALSE);
                                Nivel_Escolar := GetTexMaxErr(Nivel_Escolar, 10, Item.FIELDCAPTION("Nivel Escolar (Grado)"));

                                SePrecioVta(TODAY);

                                Observaciones := '';
                                CLEAR(lrCommentLine);
                                lrCommentLine.SETRANGE("Table Name", lrCommentLine."Table Name"::Item);
                                lrCommentLine.SETRANGE("No.", Item."No.");
                                IF lrCommentLine.FINDLAST THEN
                                    Observaciones := GettTextSnt(lrCommentLine.Comment);


                                Fecha_Almacen := DateFormatXML(Item."Fecha Almacen");
                                Fecha_Comercializacion := DateFormatXML(Item."Fecha Comercializacion");
                            end;
                        }
                        textelement(locales)
                        {
                            MaxOccurs = Unbounded;
                            MinOccurs = Zero;
                            XmlName = 'Locales';
                            textelement(locales_clave)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                TextType = Text;
                                XmlName = 'Clave';
                            }
                            textelement(locales_pais)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                TextType = Text;
                                XmlName = 'Pais';
                            }
                            textelement(entrega_biblioteca_nacional)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Entrega_Biblioteca_Nacional';
                            }

                            trigger OnBeforePassVariable()
                            begin
                                currXMLport.SKIP;
                            end;
                        }
                        textelement(locales_espec)
                        {
                            MaxOccurs = Unbounded;
                            MinOccurs = Zero;
                            XmlName = 'Locales_ESPEC';
                            textelement(locales_espec_clave)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                TextType = Text;
                                XmlName = 'Clave';
                            }
                            textelement(locales_espec_pais)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                TextType = Text;
                                XmlName = 'Pais';
                            }
                            textelement(locales_espec_sociedad)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                TextType = Text;
                                XmlName = 'Sociedad';
                            }
                            textelement(fecha_limite_comercializaci)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Fecha_Limite_Comercializacion';
                            }
                            textelement(prefijo_volumen)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                                XmlName = 'Prefijo_Volumen';
                            }
                            textelement(prefijo_libro)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                XmlName = 'Prefijo_Libro';
                            }

                            trigger OnBeforePassVariable()
                            begin
                                currXMLport.SKIP;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            lwValor: Code[20];
                        begin

                            Titulo := GettTextSnt(Item.Description);
                            Titulo_Corto := GettTextSnt(GetTexMax(Item."Description 2", 40));
                            ISBN := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::ISBN, Item.ISBN, FALSE);
                            ISBN := GetTexMaxErr(ISBN, 13, Item.FIELDCAPTION(ISBN));

                            // Este valor no está incluido en Navision por lo que ha de estar configurados por defecto
                            IF ISBN = '' THEN
                                lwValor := 'NO'
                            ELSE
                                lwValor := 'SI';
                            ISBN_Tramitado := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::"ISBN Tramitado", lwValor, wObligaCampos); // Es obligado

                            EAN := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::EAN, cFunMdM.GetEAN(Item), FALSE);
                            EAN := GetTexMaxErr(EAN, 13, Text002);

                            Sello := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::Sello, Item.Sello, FALSE);
                            Sello := GetTexMaxErr(Sello, 10, Item.FIELDCAPTION(Sello));

                            Idioma := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::Idioma, Item.Idioma, FALSE);
                            Idioma := GetTexMaxErr(Idioma, 10, Item.FIELDCAPTION(Idioma));

                            Autor := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::Autor, Item.Autor, FALSE);
                            Autor := GetTexMaxErr(Autor, 10, Item.FIELDCAPTION(Autor));
                            IF Autor <> '' THEN BEGIN
                                Autor_Catalogo := FORMAT(TRUE);
                                Tipo_Autoria := '000002'; // A piñon
                            END
                            ELSE BEGIN
                                Autor_Catalogo := '';
                                Tipo_Autoria := '';
                            END;

                            IF Item."No. Paginas" = 0 THEN BEGIN
                                IF EsPapel THEN // Si es Papel se convierte en obligatorio, devolvemos 1
                                    Paginas := DecFormatXMLDef(1);
                            END
                            ELSE
                                Paginas := DecFormatXMLDef(Item."No. Paginas");

                            SetUnid(Item."No.", Item."Base Unit of Measure");

                            // Dimensiones
                            Serie_Metodo := GetDim(0);
                            Destino := GetDim(1);
                            Cuenta := GetDim(2);
                            Tipo_Texto := GetDim(3);
                            Materia := GetDim(4);
                            Carga_Horaria := GetDim(5);
                            Origen := GetDim(6);
                        end;
                    }
                }
            }
        }
        
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(wSopPapel; wSopPapel)
                {
                    Caption = 'Soporte Papel';
                    TableRelation = "Datos MDM".Codigo WHERE(Tipo = CONST(Soporte),
                                                              Bloqueado = CONST(false));
                    ToolTip = 'Codigo Soporte que corresponde a "Papel" para discriminar la informacion de ciertos campos';
                }
                field(wTipSLIC; wTipSLIC)
                {
                    Caption = 'Tipología SLIC';
                    TableRelation = "Item Category" WHERE(Bloqueado = CONST(false));
                    ToolTip = 'Codigo de Tipologia que corresponde a SLIC para discriminar la informacion de determinados campos';
                }
                field(wTipSDIG; wTipSDIG)
                {
                    Caption = 'Tipología SDIG';
                    TableRelation = "Item Category" WHERE(Bloqueado = CONST(false));
                    ToolTip = 'Codigo de Tipologia que corresponde a SDIG para discriminar la informacion de determinados campos';
                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        wObligaCampos := FALSE; // Refiere a si obliga o no a que campos no requeridos estén debidamente configurados en la tabla de conversion
    end;

    trigger OnPreXmlPort()
    begin

        rConfMdM.GET;
        rConfMdM.TESTFIELD("VAT Bus. Posting Group");
        rConfMdM.TESTFIELD("Divisa Local MdM");

        // Valores no incluidos en Navision que han de estar configurados por defecto
        Encuadernacion := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::Encuadernacion, '', wObligaCampos);
        Con_Solapas := BolFormatXML(FALSE); //Booleano sin marcar
                                            // La fecha de alta con el que se van a cargar en el MdM los productos que se migren de NAV, será a uno del mes en el que se lance el proceso de migracion
                                            // Fecha_Alta        := FORMAT(CALCDATE('<CM>', TODAY));

        
        Vendible := BolFormatXML(TRUE); // Este valor siempre será True.

        // Se reporta 01/01/2016 a piñon
        // Fecha_Estado      := FORMAT(010116D);
        // Se reporta 1/12/2017 a piñon
        Fecha_Estado := DateFormatXML(120117D);
        Fecha_Alta := DateFormatXML(120117D);

        // Moneda
        Vida_Util := rConvNavMdM.GetNav2MdM(rConvNavMdM."Tipo Registro"::"Vida util", '', wObligaCampos);
        Moneda := rConfMdM."Divisa Local MdM";

    end;

    var
        rConfMdM: Record 75000;
        rConvNavMdM: Record 75007;
        VatSetup: Record 325;
        cFunMdM: Codeunit 75000;
        Text001: Label 'La longitud de %1 No puede ser superior a %2 en Producto %3';
        Text002: Label 'EAN';
        Text003: Label 'Articulo Pack';
        cGestMdm: Codeunit 75001;
        wObligaCampos: Boolean;
        wSopPapel: Code[10];
        wTipSLIC: Code[10];
        wTipSDIG: Code[10];

    procedure DateFormatXML(plval: Date): Text
    begin
        // DateFormatXML

        EXIT(FORMAT(plval, 0, 9));
    end;

    procedure DecFormatXML(plval: Decimal): Text
    begin
        // DecFormatXML

        EXIT(FORMAT(plval, 0, 9));
    end;

    procedure DecFormatXMLDef(plval: Decimal) wResult: Text
    begin
        // DecFormatXMLDef

        IF plval = 0 THEN
            plval := 99; // Valor por defecto

        EXIT(DecFormatXML(plval));
    end;

    procedure BolFormatXML(pwBol: Boolean) wVal: Text
    begin
        // BolFormatXML

        //EXIT(FORMAT(pwBol,0,9));
        EXIT(FORMAT(pwBol));
    end;

    procedure GetTexMax(pwText: Text; pwMax: Integer) wResult: Text
    begin
        // GetTexMax

        IF STRLEN(pwText) > pwMax THEN
            wResult := COPYSTR(pwText, 1, pwMax)
        ELSE
            wResult := pwText;
    end;

    procedure GetTexMaxErr(pwText: Text; pwMax: Integer; pwFieldName: Text) wResult: Text
    begin
        // GetTexMaxErr


        IF STRLEN(pwText) > pwMax THEN
            ERROR(Text001, pwFieldName, pwMax, Item."No.")
        ELSE
            wResult := pwText;
    end;

    procedure GetDim(pwId: Integer) wValue: Text
    var
        lwId2: Integer;
    begin
        // GetDim

        lwId2 := 0;
        CASE pwId OF // Id del tipo de conversion
            0:
                lwId2 := 7;
            1:
                lwId2 := 14;
            2:
                lwId2 := 15;
            3:
                lwId2 := 17;
            4:
                lwId2 := 18;
            5:
                lwId2 := 20;
            6:
                lwId2 := 21;
        END;

        wValue := cFunMdM.GetDimValueT(Item."No.", pwId); // Devuelve el valor de la dimension
        wValue := rConvNavMdM.GetNav2MdM(lwId2, wValue, FALSE); // Mira si hay alguna conversion a MdM
        wValue := GetTexMaxErr(wValue, 10, cFunMdM.GetDimNameField(pwId)); // Limita la longitud máxima
    end;

    procedure SetUnid(pwItemNo: Code[20]; pwCodUnidadBase: Code[10])
    var
        lrUnid: Record 5404;
    begin
        // SetUnid

        Ancho := '';
        Alto := '';
        Peso := '';

        IF pwItemNo = '' THEN
            EXIT;

        CLEAR(lrUnid);
        IF NOT lrUnid.GET(pwItemNo, pwCodUnidadBase) THEN
            lrUnid.INIT;

        Ancho := DecFormatXMLDef(lrUnid.Width);
        Alto := DecFormatXMLDef(lrUnid.Height);
        Peso := DecFormatXMLDef(lrUnid.Weight);

        // Valores por defecto Que ha de informar si es Papel
        IF EsPapel THEN BEGIN
            IF lrUnid.Width = 0 THEN
                Ancho := DecFormatXMLDef(1);
            IF lrUnid.Height = 0 THEN
                Alto := DecFormatXMLDef(1);
        END;
    end;

    procedure SePrecioVta(pwFecha: Date) wEnc: Boolean
    var
        lrPrec: Record 7002;
        lwPrecioConImp: Decimal;
        lwPrecioSinImp: Decimal;
        lwDivisa: Code[10];
    begin
        // SePrecioVta

        CLEAR(lwPrecioConImp);
        CLEAR(lwPrecioSinImp);

        

        wEnc := cGestMdm.GetPrecioVta(Item, pwFecha, lwPrecioConImp, lwPrecioSinImp, lwDivisa);

        IF lwPrecioSinImp <> 0 THEN BEGIN
            Precio_con_Impuestos := DecFormatXML(ROUND(lwPrecioConImp));
            Precio_sin_Impuestos := DecFormatXML(ROUND(lwPrecioSinImp));
        END;

    end;

    procedure AsegDato(pwDato: Text)
    begin
        // AsegDato

        IF DELCHR(pwDato, '<>') = '' THEN
            currXMLport.SKIP;
    end;

    procedure AsegDatoDec(pwDato: Decimal)
    begin
        // AsegDatoDec

        IF pwDato = 0 THEN
            currXMLport.SKIP;
    end;

    procedure AsegDatoDate(pwDato: Date)
    begin
        // AsegDatoDate

        IF pwDato = 0D THEN
            currXMLport.SKIP;
    end;

    procedure GettTextSnt(pwDato: Text) Result: Text
    begin
        // GettTextSnt

        pwDato := DELCHR(pwDato, '<>');
        Result := pwDato;
        IF Result <> '' THEN
            Result := STRSUBSTNO('![CDATA[%1]]', Result);
        //Result := STRSUBSTNO('<![CDATA[%1]]>', Result);
    end;

    procedure EsPapel() Result: Boolean
    begin
        // wEsPapel
        // Devuelve true si el codgio Soporte corresponde a Papel

        Result := FALSE;
        IF wSopPapel = '' THEN
            EXIT;

        Result := wSopPapel = Item.Soporte;
    end;

    procedure EsTipSlicSdig() Result: Boolean
    begin
        // EsTipSlicSdig

        Result := FALSE;

        IF wTipSLIC <> '' THEN BEGIN
            IF Item."Item Category Code" = wTipSLIC THEN
                Result := TRUE;
        END;

        IF wTipSDIG <> '' THEN BEGIN
            IF Item."Item Category Code" = wTipSDIG THEN
                Result := TRUE;
        END;
    end;
    */
}

