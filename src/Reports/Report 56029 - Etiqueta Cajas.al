report 56029 "Etiqueta Cajas"
{
    // YFC: Yefrecis Francisco Cruz
    // ------------------------------------------------------------------------
    // No.         Firma   Fecha             Descripcion
    // ------------------------------------------------------------------------
    // #337        PLB     22/10/2013        Poder imprimir varias etiquetas al mismo tiempo
    // $001        JML     26/09/2014        Reprogramo la parte del fichero .bat porque da error de seguridad
    // #7020       PLB     26/11/2014        En caso que el CP no sea correcto, que se muestren el resto de datos del destinatario
    // #28004      FAA     04/08/2015        Se agrega Linea en Blanco
    // 001         YFC     04/12/2020        SANTINAV-1901 Impresion Etiqueta packing con varios pedidos
    // 002         YFC     14/1/2021         SANTINAV-1940 Agregar Numero de Telefono
    // 003         YFC     17/2/2021         SANTINAV-2130 Agregar Orden E-Commerce "NOP"
    // 004         YFC     15/12/2022        Ajustes etiquetas migracion BC

    ProcessingOnly = true;

    dataset
    {
        dataitem("Cab. Packing Registrado"; 56033)
        {
            dataitem("Lin. Packing Registrada"; 56034)
            {
                DataItemLink = "No." = FIELD("No.");

                trigger OnAfterGetRecord()
                begin
                    //+#337
                    /**********************************************************************
                    UsrSetUp.GET(USERID);
                    UsrSetUp.TESTFIELD("Puerto Impresora Etiquetas");
                    UsrSetUp.TESTFIELD("Tipo Conexion Impr. Etiquetas");
                    UsrSetUp.TESTFIELD("Nombre Maquina Etiqueta Caja");
                    UsrSetUp.TESTFIELD("Nombre Impresora. Etiq. Caja");
                    ConfSant.GET;
                    ConfSant.TESTFIELD("Directorio temporal etiquetas");
                    CompInf.GET;
                    
                    RWAL.RESET;
                    RWAL.SETRANGE(RWAL."No.","Lin. Packing Registrada"."No. Picking");
                    IF RWAL.FINDFIRST THEN
                      BEGIN
                        IF RWAL."Source Type" = 37 THEN
                          BEGIN
                            SSH.RESET;
                            SSH.SETCURRENTKEY("Order No.");
                            SSH.SETRANGE("Order No.",RWAL."Source No.");
                            IF SSH.FINDFIRST THEN
                              BEGIN
                                IF PostCodes.GET(SSH."Sell-to Post Code",SSH."Sell-to City") THEN
                                  BEGIN
                                    Nombre := SSH."Sell-to Customer Name";
                                    Direccion := SSH."Ship-to Address";
                                    Direccion2 := SSH."Ship-to Address 2";
                                    Provincia := PostCodes.County;
                                    Departamento := PostCodes.Colonia;
                                    IF Pais.GET(SSH."Sell-to Country/Region Code") THEN;
                                    Ciudad := SSH."Ship-to City" +' - '+Provincia +' - '+Departamento+' - '+Pais.Name;
                                  END
                              END
                            ELSE
                              BEGIN
                                SH.RESET;
                                SH.SETCURRENTKEY("Document Type","No.");
                                SH.SETRANGE("Document Type",SH."Document Type"::Order);
                                SH.SETRANGE("No.",RWAL."Source No.");
                                IF SH.FINDFIRST THEN
                                    IF PostCodes.GET(SH."Sell-to Post Code",SH."Sell-to City") THEN
                                      BEGIN
                                        Nombre := SH."Sell-to Customer Name";
                                        Direccion := SH."Ship-to Address";
                                        Direccion2 := SH."Ship-to Address 2";
                                        Provincia := PostCodes.County;
                                        Departamento := PostCodes.Colonia;
                                        IF Pais.GET(SH."Sell-to Country/Region Code") THEN;
                                        Ciudad := SH."Ship-to City" +' - '+Provincia +' - '+Departamento+' - '+Pais.Name;
                                      END;
                              END;
                          END;
                      END;
                    
                    IF RWAL."Source Type" = 5741 THEN
                      BEGIN
                        TSH.RESET;
                        TSH.SETCURRENTKEY("Transfer Order No.");
                        TSH.SETRANGE("Transfer Order No.",RWAL."Source No.");
                        IF TSH.FINDFIRST THEN
                          BEGIN
                            IF PostCodes.GET(TSH."Transfer-to Post Code",TSH."Transfer-to City") THEN
                              BEGIN
                                Nombre := TSH."Transfer-to Name";
                                Direccion := TSH."Transfer-to Address";
                                Direccion2 := TSH."Transfer-to Address 2";
                                Provincia := PostCodes.County;
                                Departamento := PostCodes.Colonia;
                                //Ciudad := TSH."Transfer-to City";
                                IF Pais.GET(TSH."Trsf.-to Country/Region Code") THEN;
                                Ciudad := TSH."Transfer-to City" +' - '+Provincia +' - '+Departamento+' - '+Pais.Name;
                              END
                          END
                        ELSE
                          BEGIN
                            TH.RESET;
                            TH.SETRANGE("No.",RWAL."Source No.");
                            IF TH.FINDFIRST THEN
                              IF PostCodes.GET(TSH."Transfer-to Post Code",TSH."Transfer-to City") THEN
                                BEGIN
                                  Nombre := TSH."Transfer-to Name";
                                  Direccion := TSH."Transfer-to Address";
                                  Direccion2 := TSH."Transfer-to Address 2";
                                  Provincia := PostCodes.County;
                                  Departamento := PostCodes.Colonia;
                                  //Ciudad := TSH."Transfer-to City";
                                  IF Pais.GET(TSH."Trsf.-to Country/Region Code") THEN;
                                  Ciudad := TSH."Transfer-to City" +' - '+Provincia +' - '+Departamento+' - '+Pais.Name;
                                END
                          END;
                      END;
                    IF NOT FileOut.CREATE(ConfSant."Directorio temporal etiquetas"+FORMAT(USERID)+'.txt') THEN
                    FileOut.OPEN(ConfSant."Directorio temporal etiquetas"+FORMAT(USERID)+'.txt');
                    
                    FileOut.CREATEOUTSTREAM(StreamOut);
                    **********************************************************************/
                    //-#337

                    StreamOut.WRITETEXT('^XA');
                    StreamOut.WRITETEXT();
                    StreamOut.WRITETEXT('^FO40,45^A0N,35,28^FD' + UPPERCASE(CompInf.Name) + '^FS');
                    StreamOut.WRITETEXT();
                    StreamOut.WRITETEXT('^FO590,45^A0N,25,28^FD' + 'Fecha: ' + FORMAT(WORKDATE) + '^FS');
                    StreamOut.WRITETEXT('^FO40,85^A0N,35,20^FD' + txt006 + '^FS');
                    StreamOut.WRITETEXT();
                    StreamOut.WRITETEXT('^FO225,125^A0N,45,80^FD' + RWAL."Source No." + '^FS');
                    StreamOut.WRITETEXT();
                    StreamOut.WRITETEXT('^FO40,155^A0N,35,28^FD--------------------------------^FS');
                    StreamOut.WRITETEXT();
                    StreamOut.WRITETEXT('^FO40,185^A0N,25,28^FD' + 'Destinatario:' + '^FS');
                    StreamOut.WRITETEXT();
                    StreamOut.WRITETEXT('^FO40,210^A0N,35,28^FD' + Nombre + '^FS');
                    StreamOut.WRITETEXT();
                    StreamOut.WRITETEXT('^FO40,245^A0N,25,28^FD' + Direccion + '^FS');
                    StreamOut.WRITETEXT();
                    //StreamOut.WRITETEXT('^FO40,275^A0N,25,28^FD'+Ciudad+'^FS');  // 002
                    StreamOut.WRITETEXT('^FO40,275^A0N,25,28^FD' + Direccion2 + '^FS');  // 002
                    StreamOut.WRITETEXT();
                    //StreamOut.WRITETEXT('^FO40,305  ^A0N,25,28^FD'+Direccion2+'^FS');   // 002
                    StreamOut.WRITETEXT('^FO40,305  ^A0N,25,28^FD' + Ciudad + '^FS');   // 002
                    StreamOut.WRITETEXT();

                    //Cantidad de Bultos
                    I := 0;
                    N := 0;

                    LPR.RESET;
                    LPR.SETRANGE("No.", "No.");
                    CantBult := LPR.COUNT;
                    IF LPR.FINDSET THEN
                        REPEAT
                            IF (LPR."No." = "No.") AND (LPR."No. Caja" = "No. Caja") THEN BEGIN
                                I := 1;
                                N += 1;
                            END
                            ELSE
                                N += 1;
                            LPR.NEXT;
                        UNTIL I = 1;

                    StreamOut.WRITETEXT('^FO40,355^A0N,55,100^FD' + 'BULTO ' + FORMAT(N) + '/' + FORMAT(CantBult) + '^FS');
                    StreamOut.WRITETEXT();
                    StreamOut.WRITETEXT('^FO40,440^A0N,35,28^FD--------------------------------^FS');
                    StreamOut.WRITETEXT();
                    CALCFIELDS("Total de Productos");
                    StreamOut.WRITETEXT('^FO240,420^A0N,35,28^FD' + 'Este bulto contiene ' + FORMAT("Total de Productos") + ' ejemplares' + '^FS');
                    StreamOut.WRITETEXT();

                    Contador := 440;
                    ContCajReg.RESET;
                    ContCajReg.SETRANGE("No. Packing", "No.");
                    ContCajReg.SETRANGE("No. Caja", "No. Caja");
                    IF ContCajReg.FINDSET THEN
                        REPEAT
                            Contador += 30;
                            ICR.RESET;
                            ICR.SETRANGE(ICR."Item No.", ContCajReg."No. Producto");
                            ICR.SETRANGE(ICR."Cross-Reference Type", ICR."Cross-Reference Type"::"Bar Code");
                            IF ICR.FINDFIRST THEN
                                StreamOut.WRITETEXT('^FO40,' + FORMAT(Contador) + '^A0N,25,28^FD' + FORMAT(ICR."Cross-Reference No.") + '^FS')
                            ELSE
                                StreamOut.WRITETEXT('^FO40,' + FORMAT(Contador) + '^A0N,25,28^FD' + FORMAT(ContCajReg."No. Producto") + '^FS');

                            StreamOut.WRITETEXT();

                            StreamOut.WRITETEXT('^FO240,' + FORMAT(Contador) + '^A0N,25,28^FD' + FORMAT(COPYSTR(ContCajReg.Descripcion, 1, 32)) + '^FS');
                            StreamOut.WRITETEXT();
                            StreamOut.WRITETEXT('^FO730,' + FORMAT(Contador) + '^A0N,25,28^FD' + FORMAT(ContCajReg.Cantidad) + '^FS');
                            StreamOut.WRITETEXT();
                        UNTIL ContCajReg.NEXT = 0;
                    StreamOut.WRITETEXT('^XZ');
                    StreamOut.WRITETEXT();

                    //+#337
                    /**********************************************************************
                    FileOut.CLOSE;
                    
                    IF ISSERVICETIER THEN
                      BEGIN
                        //El archivo fue creado en la carpeta C: del ServiceTier
                        //Por lo cual hay que pasarlo a la maquina local. Debe ser pasado a la carpeta temporal
                        //para evitar que al copiarse despliegue un cuadro de dialogo
                        MagicPath := FORMAT(USERID)+'.txt';
                        FileToDownload := ConfSant."Directorio temporal etiquetas"+FORMAT(USERID)+'.txt';
                        FileVar.OPEN(FileToDownload);
                        FileVar.CREATEINSTREAM(IStream);
                        DOWNLOADFROMSTREAM(IStream,'','<TEMP>', 'Text file(*.txt)|*.txt',MagicPath);
                        FileVar.CLOSE;
                    
                    
                        //Luego de copiado a al temporal, lo llevamos a una carpeta con un Path entendible
                        //por el automation wSHShell
                        CREATE(FileSystemObject,TRUE,TRUE);
                        DestinationFileName := ConfSant."Directorio temporal etiquetas"+FORMAT(USERID)+'.txt';
                        IF FileSystemObject.FileExists(DestinationFileName) THEN
                          FileSystemObject.DeleteFile(DestinationFileName,TRUE);
                        FileSystemObject.CopyFile(MagicPath,DestinationFileName);
                        FileSystemObject.DeleteFile(MagicPath,TRUE);
                        CLEAR(FileSystemObject);
                      END;
                    
                    
                    FileOut1.CREATE(ConfSant."Directorio temporal etiquetas"+FORMAT(USERID)+'.txt');
                    FileOut1.CREATEOUTSTREAM(StreamOut1);
                    IF UsrSetUp."Tipo Conexion Impr. Etiquetas" = UsrSetUp."Tipo Conexion Impr. Etiquetas"::"Terminal Service" THEN
                      BEGIN
                      //  StreamOut1.WRITETEXT('Net use '+ UsrSetUp."Puerto Impresora Etiquetas"+': '+'/DELETE');
                      //  StreamOut1.WRITETEXT();
                        StreamOut1.WRITETEXT('Net use '+UsrSetUp."Puerto Impresora Etiquetas"+' \\'+UsrSetUp."Nombre Maquina Etiqueta Caja"
                         +'\'+UsrSetUp."Nombre Impresora. Etiq. Caja" +' /PERSISTENT:Yes');
                        StreamOut1.WRITETEXT();
                       // ****Para que las impresora funcione en LPT1 hay que hacerle un Spooler por Windows****
                      END;
                    
                    
                    
                    StreamOut1.WRITETEXT('copy '+ConfSant."Directorio temporal etiquetas"+FORMAT(USERID)+'.txt'+' '
                    + UsrSetUp."Puerto Impresora Etiquetas");
                    StreamOut1.WRITETEXT();
                    FileOut1.CLOSE;
                    
                    IF ISSERVICETIER THEN
                      BEGIN
                        //El archivo fue creado en la carpeta C: del ServiceTier
                        //Por lo cual hay que pasarlo a la maquina local. Debe ser pasado a la carpeta temporal
                        //para evitar que al copiarse despliegue un cuadro de dialogo
                        MagicPathBat := FORMAT(USERID)+'.txt';
                        FileToDownload := ConfSant."Directorio temporal etiquetas"+FORMAT(USERID)+'.txt';
                        FileVar.OPEN(FileToDownload);
                        FileVar.CREATEINSTREAM(IStream);
                        DOWNLOADFROMSTREAM(IStream,'','<TEMP>', 'Text file(*.txt)|*.txt',MagicPathBat);
                        FileVar.CLOSE;
                    
                    
                        //Luego de copiado a al temporal, lo llevamos a una carpeta con un Path entendible
                        //por el automation wSHShell
                        CREATE(FileSystemObject,TRUE,TRUE);
                        DestinationFileName := ConfSant."Directorio temporal etiquetas"+FORMAT(USERID)+'.txt';
                        IF FileSystemObject.FileExists(DestinationFileName) THEN
                          FileSystemObject.DeleteFile(DestinationFileName,TRUE);
                        FileSystemObject.CopyFile(MagicPathBat,DestinationFileName);
                        FileSystemObject.DeleteFile(MagicPathBat,TRUE);
                        CLEAR(FileSystemObject);
                      END;
                    
                    CREATE(wSHShell,TRUE,ISSERVICETIER);
                    wSHShell.Run(ConfSant."Directorio temporal etiquetas"+FORMAT(USERID)+'.txt',dummyInt,_runModally);
                    CLEAR(wSHShell);
                    **********************************************************************/
                    //-#337

                end;
            }

            trigger OnAfterGetRecord()
            begin
                RWAL.RESET;
                RWAL.SETCURRENTKEY("No.", "No. Packing Registrado");  // 001-YFC
                RWAL.SETRANGE("No.", "Picking No.");
                RWAL.SETRANGE("No. Packing Registrado", "No.");// 001-YFC
                IF RWAL.FINDFIRST THEN BEGIN
                    IF RWAL."Source Type" = 37 THEN BEGIN
                        SSH.RESET;
                        SSH.SETCURRENTKEY("Order No.");
                        SSH.SETRANGE("Order No.", RWAL."Source No.");
                        IF SSH.FINDFIRST THEN BEGIN
                            //IF PostCodes.GET(SSH."Sell-to Post Code",SSH."Sell-to City") THEN BEGIN //-#7020
                            IF NOT PostCodes.GET(SSH."Sell-to Post Code", SSH."Sell-to City") THEN CLEAR(PostCodes); //+#7020
                            Nombre := SSH."Sell-to Customer Name";
                            Direccion := SSH."Ship-to Address";
                            Direccion2 := SSH."Ship-to Address 2";
                            Provincia := PostCodes.County;
                            Departamento := PostCodes.Colonia;
                            IF Pais.GET(SSH."Sell-to Country/Region Code") THEN;
                            // Ciudad := SSH."Ship-to City" +' - '+Provincia +' - '+Departamento+' - '+Pais.Name ;   // 003-YFC
                            // ++ 003-YFC
                            //SSI2.GET(SH."Document Type"::Order,RWAL."Source No.");
                            // ++ 003-YFC
                            SSI2.RESET;
                            SSI2.SETCURRENTKEY("Order No.");
                            SSI2.SETRANGE("Order No.", RWAL."Source No.");
                            IF SSI2.FINDFIRST THEN BEGIN
                                IF CabNop.GET(SSH."External Document No.", SSH."Sell-to Customer No.") THEN;
                                IF (CabNop."Metodo de Envio Ecommerce" <> '') AND (CabNop."Metodo de Envio Ecommerce" <> 'TERRESTRE') THEN BEGIN
                                    //Ciudad := SSH."Ship-to City" +' - '+Provincia +' - '+Departamento+' - '+Pais.Name + ' - E-Commerce: ' + SH."External Document No."+' - Método de envio: ' + CabNop."Metodo de Envio Ecommerce";   // 003-YFC
                                    Ciudad := SSH."Ship-to City" + ' - ' + Provincia + ' - ' + Departamento + ' - ' + Pais.Name + ' - Tel: ' + SSI2."No. Telefono" + ' - ' + SSI2."External Document No.";   // 003-YFC
                                END
                                ELSE
                                    Ciudad := SSH."Ship-to City" + ' - ' + Provincia + ' - ' + Departamento + ' - ' + Pais.Name + ' - Tel: ' + SSI2."No. Telefono" + ' - ' + SSI2."External Document No."  // 002-YFC

                            END; // -- 003-YFC
                                 //END //-#7020
                        END
                        ELSE BEGIN
                            SH.RESET;
                            SH.SETCURRENTKEY("Document Type", "No.");
                            SH.SETRANGE("Document Type", SH."Document Type"::Order);
                            SH.SETRANGE("No.", RWAL."Source No.");
                            IF SH.FINDFIRST THEN
                              //+#7020
                              //IF PostCodes.GET(SH."Sell-to Post Code",SH."Sell-to City") THEN BEGIN
                              BEGIN
                                IF NOT PostCodes.GET(SH."Sell-to Post Code", SH."Sell-to City") THEN CLEAR(PostCodes);
                                //-#7020
                                Nombre := SH."Sell-to Customer Name";
                                Direccion := SH."Ship-to Address";
                                Direccion2 := SH."Ship-to Address 2";
                                Provincia := PostCodes.County;
                                Departamento := PostCodes.Colonia;
                                IF Pais.GET(SH."Sell-to Country/Region Code") THEN;
                                // Ciudad := SH."Ship-to City" +' - '+Provincia +' - '+Departamento+' - '+Pais.Name  +' - Telefono: '+ SH."No. Telefono";  // 002-YFC   // 003-YFC
                                // ++ 003-YFC
                                IF CabNop.GET(SH."External Document No.", SH."Sell-to Customer No.") THEN;
                                IF (SH."Metodo de Envio E-Commerce" = SH."Metodo de Envio E-Commerce"::Recogida) AND (CabNop."Metodo de Envio Ecommerce" <> '') THEN BEGIN

                                    //Ciudad := SH."Ship-to City" +' - '+Provincia +' - '+Departamento+' - '+Pais.Name  +' - Telefono: '+ SH."No. Telefono" +' - E-Commerce: ' + SH."External Document No."+' - Método de envio: ' + CabNop."Metodo de Envio Ecommerce"  // 002-YFC
                                    Ciudad := SH."Ship-to City" + ' - ' + Provincia + ' - ' + Departamento + ' - ' + Pais.Name + ' - Tel: ' + SH."No. Telefono" + ' - ' + SH."External Document No." // 002-YFC
                                END
                                ELSE
                                    Ciudad := SH."Ship-to City" + ' - ' + Provincia + ' - ' + Departamento + ' - ' + Pais.Name + ' - Tel: ' + SH."No. Telefono" + ' - ' + SH."External Document No.";  // 002-YFC
                                                                                                                                                                                                       // ++ 003-YFC
                            END;

                        END;
                    END;

                    IF RWAL."Source Type" = 5741 THEN BEGIN
                        TSH.RESET;
                        TSH.SETCURRENTKEY("Transfer Order No.");
                        TSH.SETRANGE("Transfer Order No.", RWAL."Source No.");
                        IF TSH.FINDFIRST THEN BEGIN
                            //IF PostCodes.GET(TSH."Transfer-to Post Code",TSH."Transfer-to City") THEN BEGIN //-#7020
                            IF NOT PostCodes.GET(TSH."Transfer-to Post Code", TSH."Transfer-to City") THEN CLEAR(PostCodes); //+#7020
                            Nombre := TSH."Transfer-to Name";
                            Direccion := TSH."Transfer-to Address";
                            Direccion2 := TSH."Transfer-to Address 2";
                            Provincia := PostCodes.County;
                            Departamento := PostCodes.Colonia;
                            //Ciudad := TSH."Transfer-to City";
                            IF Pais.GET(TSH."Trsf.-to Country/Region Code") THEN;
                            Ciudad := TSH."Transfer-to City" + ' - ' + Provincia + ' - ' + Departamento + ' - ' + Pais.Name;
                            //END //-#7020
                        END
                        ELSE BEGIN
                            TH.RESET;
                            TH.SETRANGE("No.", RWAL."Source No.");
                            IF TH.FINDFIRST THEN
                              //+#7020
                              //IF PostCodes.GET(TSH."Transfer-to Post Code",TSH."Transfer-to City") THEN BEGIN
                              BEGIN
                                IF NOT PostCodes.GET(TSH."Transfer-to Post Code", TSH."Transfer-to City") THEN CLEAR(PostCodes);
                                //-#7020
                                Nombre := TSH."Transfer-to Name";
                                Direccion := TSH."Transfer-to Address";
                                Direccion2 := TSH."Transfer-to Address 2";
                                Provincia := PostCodes.County;
                                Departamento := PostCodes.Colonia;
                                //Ciudad := TSH."Transfer-to City";
                                IF Pais.GET(TSH."Trsf.-to Country/Region Code") THEN;
                                Ciudad := TSH."Transfer-to City" + ' - ' + Provincia + ' - ' + Departamento + ' - ' + Pais.Name;
                            END
                        END;
                    END;
                END;
            end;

            trigger OnPostDataItem()
            var
                texComando: Text;
                texFrom: Text;
                texTo: Text;
                ExecuteBat: DotNet ProcessStartInfo;
                Process: DotNet Process;
                Command: Text[120];
                Result: Text[120];
                ErrorMSg: Text[120];
            begin
                FileOut.CLOSE;

                IF ISSERVICETIER THEN BEGIN
                    //El archivo fue creado en la carpeta C: del ServiceTier
                    //Por lo cual hay que pasarlo a la maquina local. Debe ser pasado a la carpeta temporal
                    //para evitar que al copiarse despliegue un cuadro de dialogo

                    //MagicPath := FORMAT(FormatUser(USERID))+'.txt';
                    MagicPath := 'EtiquetaBC.txt'; // 004-YFC
                    FileToDownload := ConfSant."Directorio temporal etiquetas" + FORMAT(FormatUser(USERID)) + '.txt';


                    FileVar.OPEN(FileToDownload);
                    FileVar.CREATEINSTREAM(IStream);
                    DOWNLOADFROMSTREAM(IStream, '', '<TEMP>', 'Text file(*.txt)|*.txt', MagicPath);
                    FileVar.CLOSE;



                    //Luego de copiado a al temporal, lo llevamos a una carpeta con un Path entendible
                    //por el automation wSHShell
                    //FILE.COPY(MagicPath
                    /*
                     CREATE(FileSystemObject,TRUE,TRUE);
                     DestinationFileName := ConfSant."Directorio temporal etiquetas"+FORMAT(FormatUser(USERID))+'.txt';
                     IF FileSystemObject.FileExists(DestinationFileName) THEN
                       FileSystemObject.DeleteFile(DestinationFileName,TRUE);
                     FileSystemObject.CopyFile(MagicPath,DestinationFileName);
                     FileSystemObject.DeleteFile(MagicPath,TRUE);
                     CLEAR(FileSystemObject);
                     */
                END;

                /*  $001
                FileOut1.CREATE(ConfSant."Directorio temporal etiquetas"+FORMAT(USERID)+'.txt');
                FileOut1.CREATEOUTSTREAM(StreamOut1);
                IF UsrSetUp."Tipo Conexion Impr. Etiquetas" = UsrSetUp."Tipo Conexion Impr. Etiquetas"::"Terminal Service" THEN BEGIN
                  StreamOut1.WRITETEXT('Net use '+UsrSetUp."Puerto Impresora Etiquetas"+' \\'+UsrSetUp."Nombre Maquina Etiqueta Caja"
                   +'\'+UsrSetUp."Nombre Impresora. Etiq. Caja" +' /PERSISTENT:Yes');
                  StreamOut1.WRITETEXT();
                 // ****Para que las impresora funcione en LPT1 hay que hacerle un Spooler por Windows****
                END;
                
                StreamOut1.WRITETEXT('copy '+ConfSant."Directorio temporal etiquetas"+FORMAT(USERID)+'.txt'+' '
                + UsrSetUp."Puerto Impresora Etiquetas");
                StreamOut1.WRITETEXT();
                FileOut1.CLOSE;
                
                IF ISSERVICETIER THEN BEGIN
                  //El archivo fue creado en la carpeta C: del ServiceTier
                  //Por lo cual hay que pasarlo a la maquina local. Debe ser pasado a la carpeta temporal
                  //para evitar que al copiarse despliegue un cuadro de dialogo
                  MagicPathBat := FORMAT(USERID)+'.cmd';
                  FileToDownload := ConfSant."Directorio temporal etiquetas"+FORMAT(USERID)+'.cmd';
                  FileVar.OPEN(FileToDownload);
                  FileVar.CREATEINSTREAM(IStream);
                  DOWNLOADFROMSTREAM(IStream,'','<TEMP>', 'Text file(*.cmd)|*.cmd',MagicPathBat);
                  FileVar.CLOSE;
                
                
                  //Luego de copiado a al temporal, lo llevamos a una carpeta con un Path entendible
                  //por el automation wSHShell
                  CREATE(FileSystemObject,TRUE,TRUE);
                  DestinationFileName := ConfSant."Directorio temporal etiquetas"+FORMAT(USERID)+'.cmd';
                  IF FileSystemObject.FileExists(DestinationFileName) THEN
                    FileSystemObject.DeleteFile(DestinationFileName,TRUE);
                  FileSystemObject.CopyFile(MagicPathBat,DestinationFileName);
                  FileSystemObject.DeleteFile(MagicPathBat,TRUE);
                  CLEAR(FileSystemObject);
                END;
                
                CREATE(wSHShell,TRUE,ISSERVICETIER);
                wSHShell.Run(ConfSant."Directorio temporal etiquetas"+FORMAT(USERID)+'.cmd',dummyInt,_runModally);
                CLEAR(wSHShell);
                */


                // AMS CREATE(wSHShell,TRUE,ISSERVICETIER);
                IF UsrSetUp."Tipo Conexion Impr. Etiquetas" = UsrSetUp."Tipo Conexion Impr. Etiquetas"::"Terminal Service" THEN BEGIN
                    texComando := 'cmd /c Net use ' + UsrSetUp."Puerto Impresora Etiquetas" + ' \\' + UsrSetUp."Nombre Maquina Etiqueta Caja" + '\' + UsrSetUp."Nombre Impresora. Etiq. Caja" + ' /PERSISTENT:Yes';
                    wSHShell.Run(texComando, dummyInt, _runModally);
                END;

                //texComando := 'cmd /c copy '+ConfSant."Directorio temporal etiquetas"+FORMAT(FormatUser(USERID))+'.txt'+' '+ UsrSetUp."Puerto Impresora Etiquetas";
                //texComando := 'copy '+ConfSant."Directorio temporal etiquetas"+FORMAT(FormatUser(USERID))+'.txt';

                //texComando := ConfSant."Directorio temporal etiquetas"+FORMAT(FormatUser(USERID))+'.txt';
                texComando := 'C:\Users\kgutierrez\Downloads\' + FORMAT(FormatUser(USERID)) + '.txt' + ' ' + UsrSetUp."Puerto Impresora Etiquetas";
                //texComando := 'C:\Users\kgutierrez\Downloads\'+FORMAT(FormatUser(USERID))+'.txt';
                ExecuteBat := ExecuteBat.ProcessStartInfo('cmd', '/c "' + texComando + '"');
                ExecuteBat.RedirectStandardError := TRUE;
                ExecuteBat.RedirectStandardOutput := TRUE;
                ExecuteBat.UseShellExecute := FALSE;
                ExecuteBat.CreateNoWindow := TRUE;
                Process := Process.Process;
                Process.StartInfo(ExecuteBat);
                Process.Start;
                IF FILE.ERASE('C:\Users\kgutierrez\Downloads' + FORMAT(FormatUser(USERID)) + '.txt') THEN;

                // AMS wSHShell.Run(texComando,dummyInt,_runModally);
                // AMS CLEAR(wSHShell);
                //$001

            end;

            trigger OnPreDataItem()
            begin
                //+#337
                // Se ha añadido este dataitem

                IF FilterNo <> '' THEN
                    SETFILTER("No.", FilterNo);

                UsrSetUp.GET(USERID);
                UsrSetUp.TESTFIELD("Puerto Impresora Etiquetas");
                UsrSetUp.TESTFIELD("Tipo Conexion Impr. Etiquetas");
                IF UsrSetUp."Tipo Conexion Impr. Etiquetas" = UsrSetUp."Tipo Conexion Impr. Etiquetas"::"Terminal Service" THEN BEGIN
                    UsrSetUp.TESTFIELD("Nombre Maquina Etiqueta Caja");
                    UsrSetUp.TESTFIELD("Nombre Impresora. Etiq. Caja");
                END;
                ConfSant.GET;
                ConfSant.TESTFIELD("Directorio temporal etiquetas");
                CompInf.GET;

                IF NOT FileOut.CREATE(ConfSant."Directorio temporal etiquetas" + FORMAT(FormatUser(USERID)) + '.txt') THEN
                    FileOut.OPEN(ConfSant."Directorio temporal etiquetas" + FORMAT(FormatUser(USERID)) + '.txt');

                //IF NOT FileOut.CREATE('EtiquetaBC.txt') THEN // YFC
                //FileOut.OPEN('EtiquetaBC.txt');  // YFC

                FileOut.CREATEOUTSTREAM(StreamOut);
            end;
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        FilterNo := "Cab. Packing Registrado".GETFILTER("No.");
        IF FilterNo = '' THEN
            FilterNo := "Lin. Packing Registrada".GETFILTER("No.");
    end;

    var
        afile2: File;
        afile3: File;
        CommandProcessor: Text[1024];
        Variable1: Text[30];
        Variable2: Text[30];
        iShell: Integer;
        CompInf: Record 79;
        Cust: Record 18;
        RWAH: Record 5772;
        RWAL: Record 5773;
        CPR: Record 56033;
        LPR: Record 56034;
        CantBult: Integer;
        I: Integer;
        N: Integer;
        ContCajReg: Record 56035;
        Contador: Integer;
        ICR: Record 5717;
        UsrSetUp: Record 91;
        Pais: Record 9;
        wSHShell: Automation;
        _commandLine: Text[100];
        _runModally: Boolean;
        dummyInt: Integer;
        StreamOut: OutStream;
        FileOut: File;
        StreamIn: InStream;
        FileIn: File;
        Error001: Label 'The File Could Not be Open';
        FileOut1: File;
        StreamOut1: OutStream;
        TextLine: Text[200];
        Direccion: Text[100];
        ToFile: Variant;
        ReturnValue: Boolean;
        Text006: Label 'Export';
        Text007: Label 'Import';
        Text009: Label 'All Files (*.*)|*.*';
        FuncSant: Codeunit 56000;
        Nombre: Text[1024];
        Posicion: Integer;
        Longitud: Integer;
        NombreCompleto: Text[1024];
        MagicPath: Text[180];
        FileToDownload: Text[180];
        FileVar: File;
        IStream: InStream;
        MagicPathBat: Text[180];
        FileSystemObject: Automation;
        DestinationFileName: Text[200];
        txt005: Label 'c:\etiquetas\';
        ConfSant: Record 56001;
        Alm: Record 14;
        SSH: Record 110;
        TSH: Record 5744;
        PostCodes: Record 225;
        Provincia: Text[200];
        Departamento: Text[200];
        Direccion2: Text[200];
        Ciudad: Text[200];
        txt006: Label 'CENTRO DISTRIBUCION';
        SH: Record 36;
        TH: Record 5740;
        FilterNo: Text[250];
        CabNop: Record 50100;
        SSI2: Record 112;

    procedure FormatUser(codPrmUsuario: Code[50]): Code[50]
    begin
        EXIT(DELCHR(codPrmUsuario, '=', '\'));
    end;
}

