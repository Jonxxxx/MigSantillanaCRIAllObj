xmlport 50006 "Importar Pedidos CRM"
{
    // YFC     : Yefrecis Francisco Cruz
    // ------------------------------------------------------------------------
    // No.         Firma   Fecha         Descripcion
    // ------------------------------------------------------------------------
    // 001         YFC     31/01/2024    SANTINAV-5207

    Caption = 'Import CRM Orders';
    DefaultNamespace = 'xmlns:xsi=http://www.w3.org/2001/XMLSchema-instance';
    Encoding = UTF8;
    FormatEvaluate = Legacy;
    InlineSchema = false;
    PreserveWhiteSpace = false;
    UseDefaultNamespace = false;
    UseLax = false;

    schema
    {
        textelement(Pedidos_CRM)
        {
            MinOccurs = Once;
            textelement(Cabeceras)
            {
                textelement(Cabecera)
                {
                    textelement(no_documento)
                    {
                        MaxOccurs = Once;

                        trigger OnBeforePassVariable()
                        begin
                            no_documento := 'no_documento';
                        end;
                    }
                    textelement(doc_externo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;

                        trigger OnBeforePassVariable()
                        begin
                            doc_externo := 'doc_externo';
                        end;
                    }
                    textelement(cod_colegio)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            cod_colegio := 'cod_colegio';
                        end;
                    }
                    textelement(cod_vendedor)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            cod_vendedor := 'cod_vendedor';
                        end;
                    }
                    textelement(cod_direccion_envio)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            cod_direccion_envio := 'cod_direccion_envio';
                        end;
                    }
                    textelement(envio_nombre)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            envio_nombre := 'envio_nombre';
                        end;
                    }
                    textelement(envio_direccion)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            envio_direccion := 'envio_direccion';
                        end;
                    }
                    textelement(envio_colonia2)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            envio_colonia2 := 'envio_colonia2';
                        end;
                    }
                    textelement(envio_cp)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            envio_cp := 'envio_cp';
                        end;
                    }
                    textelement(fecha_pago)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            fecha_pago := 'fecha_pago';
                        end;
                    }
                    textelement(nombre_fact)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            nombre_fact := 'nombre_fact';
                        end;
                    }
                    textelement(cedula)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            cedula := 'cedula';
                        end;
                    }
                    textelement(direccion1_fact)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            direccion1_fact := 'direccion1_fact';
                        end;
                    }
                    textelement(Provincia_fac)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            Provincia_fac := 'Provincia_fac';
                        end;
                    }
                    textelement(Canton_fac)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            Canton_fac := 'Canton_fac';
                        end;
                    }
                    textelement(Distrito_fac)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            Distrito_fac := 'Distrito_fac'
                        end;
                    }
                    textelement(codigo_postal_fact)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            codigo_postal_fact := 'codigo_postal_fact';
                        end;
                    }
                    textelement(email_fact)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            email_fact := 'email_fact';
                        end;
                    }
                    textelement(telefono_celular_fact)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            telefono_celular_fact := 'telefono_celular_fact';
                        end;
                    }
                    textelement(metodo_entrega)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            metodo_entrega := 'metodo_entrega';
                        end;
                    }
                    textelement(forma_pago)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            forma_pago := 'forma_pago';
                        end;

                        trigger OnAfterAssignVariable()
                        begin
                            ConfigEmpresa.GET;
                            SH.INIT;
                            SH.VALIDATE("Document Type", SH."Document Type"::Order);

                            // Encuentra la posicion del primer guion ("-")+
                            CLEAR(Serie);
                            CLEAR(Prefijo);
                            NoSeriesLine.RESET;
                            NoSeriesLine.SETRANGE("Series Code", ConfigEmpresa."No. Serie CRM");
                            IF NoSeriesLine.FINDFIRST THEN BEGIN
                                //Serie:= NoSeriesLine."Starting No.";
                                IF STRPOS(NoSeriesLine."Starting No.", '-') > 0 THEN BEGIN
                                    // Extrae el prefijo hasta el guion
                                    Prefijo := COPYSTR(NoSeriesLine."Starting No.", 1, STRPOS(NoSeriesLine."Starting No.", '-'));
                                END;
                            END;
                            // Encuentra la posicion del primer guion ("-")-

                            //Obtengo el cliente+
                            IF Customer.GET(ConfigEmpresa."Cliente CRM") THEN;
                            //Obtengo el cliente-

                            SH."No." := Prefijo + no_documento;
                            SH.VALIDATE("Sell-to Customer No.", ConfigEmpresa."Cliente CRM");
                            SH.INSERT(TRUE);

                            //Fechas+
                            CLEAR(FechaConvertida);
                            IF EVALUATE(FechaConvertida, fecha_pago) THEN
                                SH.VALIDATE("Posting Date", FechaConvertida);

                            SH.VALIDATE("Order Date", SH."Posting Date");
                            SH.VALIDATE("Shipment Date", SH."Posting Date");
                            SH.VALIDATE("Document Date", SH."Posting Date");
                            //Fechas-

                            SH.VALIDATE("Bill-to Customer No.", ConfigEmpresa."Cliente CRM");

                            //TOOD: Ver 
                            /*
                            IF cod_colegio <> '' THEN BEGIN
                                SH.VALIDATE("Cod. Colegio", cod_colegio);
                            END ELSE
                                SH.VALIDATE("Cod. Colegio", Customer."Cod. Colegio");*/

                            SH.VALIDATE("External Document No.", doc_externo);
                            SH.VALIDATE("Location Code", ConfigEmpresa."Almacen CRM");

                            //Obtengo el Colegio para datos del vendedor+
                            //TOOD: Ver 
                            /*
                            IF (cod_colegio <> '') AND (cod_vendedor = '') THEN BEGIN
                                IF Contact.GET(cod_colegio) THEN;
                            END ELSE
                                IF (cod_colegio = '') AND (cod_vendedor = '') THEN BEGIN
                                    IF Contact.GET(Customer."Cod. Colegio") THEN;
                                END;
                                */

                            IF cod_vendedor <> '' THEN BEGIN
                                SH.VALIDATE("Salesperson Code", cod_vendedor);
                            END ELSE
                                SH.VALIDATE("Salesperson Code", Contact."Salesperson Code");
                            //Obtengo el Colegio para datos del vendedor-

                            SH.VALIDATE("Location Code", ConfigEmpresa."Almacen CRM");

                            //Envio+
                            IF cod_direccion_envio <> '' THEN BEGIN
                                SH.VALIDATE("Ship-to Code", cod_direccion_envio);
                            END ELSE
                                SH.VALIDATE("Ship-to Code", Customer."Ship-to Code");

                            SH.VALIDATE("Ship-to Name", envio_nombre);
                            SH.VALIDATE("Ship-to Address", envio_direccion);
                            SH.VALIDATE("Ship-to City", envio_colonia2);
                            SH.VALIDATE("Ship-to Post Code", envio_cp);
                            //Envio-

                            //Facturacion+
                            IF nombre_fact <> '' THEN BEGIN
                                SH.VALIDATE("Bill-to Name", nombre_fact);
                            END ELSE
                                SH.VALIDATE("Bill-to Name", Customer.Name);

                            IF cedula <> '' THEN BEGIN
                                SH.VALIDATE("VAT Registration No.", cedula);
                            END ELSE BEGIN
                                SH.VALIDATE("VAT Registration No.", Customer."VAT Registration No.");
                            END;

                            IF direccion1_fact <> '' THEN BEGIN
                                SH.VALIDATE("Bill-to Address", direccion1_fact);
                            END ELSE BEGIN
                                SH.VALIDATE("Bill-to Address", Customer.Address);
                            END;

                            IF Provincia_fac <> '' THEN BEGIN
                                SH.VALIDATE("Bill-to Address 2", Provincia_fac);
                            END ELSE BEGIN
                                SH.VALIDATE("Bill-to Address 2", Customer."Address 2");
                            END;

                            IF Canton_fac <> '' THEN BEGIN
                                SH.VALIDATE("Bill-to City", Canton_fac);
                            END ELSE BEGIN
                                SH.VALIDATE("Bill-to City", Customer.City);
                            END;

                            IF Distrito_fac <> '' THEN BEGIN
                                SH.VALIDATE("Bill-to County", Distrito_fac);
                            END ELSE BEGIN
                                SH.VALIDATE("Bill-to County", Customer.Address);
                            END;

                            IF codigo_postal_fact <> '' THEN BEGIN
                                SH.VALIDATE("Bill-to Post Code", codigo_postal_fact);
                            END ELSE BEGIN
                                SH.VALIDATE("Bill-to Post Code", Customer."Post Code");
                            END;

                            //TOOD: Ver 
                            /*
                            IF email_fact <> '' THEN BEGIN
                                SH.VALIDATE("E-Mail-FE", email_fact);
                            END ELSE BEGIN
                                SH.VALIDATE("E-Mail-FE", Customer."E-Mail");
                            END;*/

                            IF telefono_celular_fact <> '' THEN BEGIN
                                SH.VALIDATE("Sell-to Phone No.", telefono_celular_fact);
                            END ELSE BEGIN
                                SH.VALIDATE("Sell-to Phone No.", Customer."Phone No.");
                            END;

                            IF forma_pago <> '' THEN BEGIN
                                SH.VALIDATE("Payment Method Code", forma_pago);
                            END ELSE BEGIN
                                SH.VALIDATE("Payment Method Code", Customer."Payment Method Code");
                            END;


                            /*
                            SH.VALIDATE("VAT Registration No.",cedula);
                            SH.VALIDATE("Bill-to Address", direccion1_fact);
                            SH.VALIDATE("Bill-to Address 2", Provincia_fac);
                            SH.VALIDATE("Bill-to City",Canton_fac);
                            SH.VALIDATE("Bill-to County",Distrito_fac);
                            SH.VALIDATE("Bill-to Post Code",codigo_postal_fact);
                            SH.VALIDATE("Sell-to E-Mail",email_fact);
                            SH.VALIDATE("Sell-to Phone No.",telefono_celular_fact);
                            SH.VALIDATE("Payment Method Code",forma_pago);
                            */
                            //Facturacion-

                            /*
                            IF envio_nombre = '' THEN
                              SH.VALIDATE("Ship-to Code",cod_direccion_envio)
                            ELSE
                              BEGIN
                                // ++ envio
                                IF envio_nombre <> '' THEN
                                  SH.VALIDATE("Ship-to Name",envio_nombre);
                            
                                IF envio_direccion <> '' THEN
                                  SH.VALIDATE( "Ship-to Address",envio_direccion);
                            
                                IF envio_colonia2 <> '' THEN
                                  SH.VALIDATE("Ship-to Address 2",envio_colonia2);
                            
                                IF envio_cp <> '' THEN
                                  SH.VALIDATE("Ship-to Post Code",envio_cp);
                            
                            
                                //SH."Ship-to Phone"  :=  envio_telefono;
                                //SH."Ship-to City" := envio_municipio ;
                                //SH."Ship-to County" := envio_estado  ;
                                // -- envio
                              END;
                            
                            //SH.VALIDATE("Ship-to Post Code",no_periodo);
                            */
                            SH.MODIFY;
                            COMMIT;
                            // -- 001-YFC

                        end;
                    }
                }
            }
            textelement(Lineas)
            {
                textelement(Linea)
                {
                    textelement(no_pedido)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            no_pedido := 'no_pedido';
                        end;
                    }
                    textelement(tipo_producto)
                    {
                        MaxOccurs = Once;

                        trigger OnBeforePassVariable()
                        begin
                            tipo_producto := 'tipo_producto';
                        end;
                    }
                    textelement(producto)
                    {
                        MaxOccurs = Once;

                        trigger OnBeforePassVariable()
                        begin
                            producto := 'producto';
                        end;
                    }
                    textelement(cantidad)
                    {
                        MaxOccurs = Once;

                        trigger OnBeforePassVariable()
                        begin
                            cantidad := 'cantidad';
                        end;
                    }
                    textelement(importe_dto)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            importe_dto := 'importe_dto';
                        end;
                    }
                    textelement(precio_unitario_sinIVA)
                    {
                        MaxOccurs = Once;

                        trigger OnBeforePassVariable()
                        begin
                            precio_unitario_sinIVA := 'precio_unitario_sinIVA';
                        end;

                        trigger OnAfterAssignVariable()
                        begin
                            SL.INIT;
                            SL.VALIDATE("Document Type", SL."Document Type"::Order);
                            SL.VALIDATE("Document No.", Prefijo + no_pedido);

                            IF NoDoc_anterior = '' THEN BEGIN
                                NoDoc_anterior := Prefijo + no_pedido;

                                IF Nolinea = 0 THEN
                                    Nolinea := 10000;
                            END
                            ELSE BEGIN
                                IF NoDoc_anterior = Prefijo + no_pedido THEN BEGIN
                                    Nolinea += 10000;
                                END
                                ELSE BEGIN
                                    _pedidos.GET(SL."Document Type", NoDoc_anterior);
                                    //_pedidos.VALIDATE("% de aprobacion",100);
                                    // _pedidos.MODIFY();

                                    Nolinea := 10000;
                                    NoDoc_anterior := Prefijo + no_pedido;

                                END;
                            END;

                            SL.VALIDATE("Line No.", Nolinea);
                            //SL.VALIDATE("Sell-to Customer No." ,no_cliente);
                            //SL.VALIDATE("Bill-to Customer No.",no_cliente);

                            CASE tipo_producto OF
                                'Cuenta':
                                    SL.VALIDATE(Type, SL.Type::"G/L Account");
                                'Producto':
                                    SL.VALIDATE(Type, SL.Type::Item);
                                'Recurso':
                                    SL.VALIDATE(Type, SL.Type::Resource);
                                'Activo Fijo':
                                    SL.VALIDATE(Type, SL.Type::"Fixed Asset");
                                'Cargo (prod.)':
                                    SL.VALIDATE(Type, SL.Type::"Charge (Item)");
                            END;

                            SL.SetHideValidationDialog(TRUE);
                            SL.VALIDATE("No.", producto);

                            CLEAR(ConvertDecimal);
                            EVALUATE(ConvertDecimal, cantidad);

                            //TOOD: Ver SL.VALIDATE("Cantidad Solicitada", ConvertDecimal);

                            IF precio_unitario_sinIVA <> '' THEN BEGIN
                                CLEAR(ConvertDecimal);
                                //TOOD: Ver ReemplazarDecimal := precio_unitario_sinIVA;
                                //TOOD: Ver NuevoValor := ReemplazarDecimal.Replace('.', ',');

                                EVALUATE(ConvertDecimal, NuevoValor);
                                SL.VALIDATE("Unit Price", ConvertDecimal);
                            END;

                            //TOOD: Ver 
                            /*
                            IF (SL."Cantidad Solicitada" = 0) THEN BEGIN
                                CLEAR(ConvertDecimal);
                                EVALUATE(ConvertDecimal, cantidad);
                                SL.VALIDATE(SL."Cantidad Solicitada", ConvertDecimal);
                            END;*/

                            IF (importe_dto <> '') AND (importe_dto <> '0') THEN BEGIN
                                CLEAR(ConvertDecimal);
                                StrParam := CONVERTSTR(importe_dto, '.', ',');
                                EVALUATE(ConvertDecimal, StrParam);
                                SL.VALIDATE("Line Discount Amount", ConvertDecimal);
                            END;

                            //IF grupo_registroIVA_product <> '' THEN
                            //  SL.VALIDATE("VAT Prod. Posting Group" ,grupo_registroIVA_product);

                            //TOOD: Ver 
                            /*
                            IF SL."Cantidad Solicitada" = 0 THEN BEGIN
                                CLEAR(ConvertDecimal);
                                EVALUATE(ConvertDecimal, cantidad);
                                SL.VALIDATE("Cantidad Solicitada", ConvertDecimal);
                            END;*/

                            SL.INSERT;
                            COMMIT;
                        end;
                    }
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin

        IF _pedidos.GET(_pedidos."Document Type"::Order, NoDoc_anterior) THEN BEGIN
            //_pedidos.VALIDATE("% de aprobacion",100);
            //_pedidos.MODIFY();
        END;

        MESSAGE(Tex01);
    end;

    var
        SH: Record 36;
        SL: Record 37;
        ConvertFecha: Date;
        ConvertDecimal: Decimal;
        Nolinea: Integer;
        NoDoc_anterior: Code[20];
        //TOOD: Ver ReemplazarDecimal: DotNet String;
        NuevoValor: Text;
        StrParam: Text[1024];
        _pedidos: Record 36;
        Tex01: Label 'Proceso Finalizado';
        ConfigEmpresa: Record 56001;
        NoSeriesLine: Record 309;
        Serie: Code[20];
        Prefijo: Text[10];
        Customer: Record 18;
        Contact: Record 5050;
        FechaConvertida: Date;
}

