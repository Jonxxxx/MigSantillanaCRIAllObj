page 67038 "Promotor - Planif. Visitas"
{
    PageType = ListPart;
    SourceTable = 67038;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Promotor"; "Cod. Promotor")
                {
                    Visible = false;
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field(Fecha; Fecha)
                {
                    Editable = false;
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                    Editable = false;
                }
                field(Estado; Estado)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Fecha Visita"; "Fecha Visita")
                {
                }
                field("Hora Inicial Visita"; "Hora Inicial Visita")
                {
                }
                field("Hora Final Visita"; "Hora Final Visita")
                {
                }
                field("Fecha Proxima Visita"; "Fecha Proxima Visita")
                {
                }
                //TODO: Ver 
                /*
                field(FuncAPS.ColCalcInvMuestras("Cod. Colegio");
                    FuncAPS.ColCalcInvMuestras("Cod. Colegio"))
                {
                    Caption = 'Sample Inventory';
                }
                */
                field(Comentario; Comentario)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1906587504>")
            {
                Caption = 'F&unctions';
                action("<Action1905623604>")
                {
                    Caption = '&Edit Line';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+E';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.PAGE.*/
                        //ShowPrices

                        IF Estado > 0 THEN
                            AbreVisita;

                    end;
                }
            }
        }
    }

    var
    //TODO: Ver FuncAPS: Codeunit 67000;

    procedure CargaEntregaMuestras()
    var
        Promotor: Record 13;
        Alm: Record 14;
        PromEM: Record 5740;
        PromEM2: Record 5740;
        fPromEM: Page 67074;
        Bins: Record 7354;
        Bins2: Record 7354;
        Colegio: Record 5050;
    begin

        Promotor.GET("Cod. Promotor");
        Promotor.TESTFIELD("Location code");

        Colegio.GET("Cod. Colegio");
        Colegio.TESTFIELD("Samples Location Code");

        //Doy de alta a la Ubicacion del Promotor
        Bins.RESET;
        Bins2.SETRANGE("Location Code", Promotor."Location code");
        Bins.SETRANGE(Code, "Cod. Promotor");
        IF NOT Bins.FINDFIRST THEN BEGIN
            CLEAR(Bins);
            Bins.VALIDATE("Location Code", Promotor."Location code");
            Bins.Code := "Cod. Promotor";
            Bins.Description := COPYSTR(Promotor.Name, 1, 50);
            Bins.Default := TRUE;
            IF Bins.INSERT(TRUE) THEN
                COMMIT;
        END;


        //Doy de alta a la Ubicacion del Colegio
        Bins2.RESET;
        Bins2.SETRANGE("Location Code", Colegio."Samples Location Code");
        Bins2.SETRANGE(Code, "Cod. Colegio");
        IF NOT Bins2.FINDFIRST THEN BEGIN
            CLEAR(Bins2);
            Bins2.VALIDATE("Location Code", Colegio."Samples Location Code");
            Bins2.Code := Colegio."No.";
            Bins2.Description := COPYSTR(Colegio.Name, 1, 50);
            Bins2.Default := TRUE;
            IF Bins2.INSERT(TRUE) THEN
                COMMIT;
        END;

        CLEAR(PromEM);
        PromEM2.RESET;
        PromEM2.SETRANGE("Transfer-from Code", Promotor."Location code");
        PromEM2.SETRANGE("Transfer-to Code", Colegio."Samples Location Code");
        PromEM2.SETRANGE("Cod. Ubicacion Alm. Origen", Promotor.Code);
        PromEM2.SETRANGE("Cod. Ubicacion Alm. Destino", Colegio."No.");

        IF NOT PromEM2.FINDFIRST THEN BEGIN
            PromEM.INSERT(TRUE);
            PromEM.SETRANGE("No.");
            PromEM.VALIDATE("Cod. Vendedor", Promotor.Code);
            PromEM."Pedido Consignacion" := TRUE;
            PromEM."Consignacion Muestras" := TRUE;

            PromEM.VALIDATE("Transfer-from Code", Promotor."Location code");
            PromEM.VALIDATE("Transfer-to Code", Colegio."Samples Location Code");
            //    Colegio.GET("Cod. Colegio");
            PromEM."Transfer-to Name" := Colegio.Name;
            PromEM."Transfer-to Address" := Colegio.Address;
            PromEM2."Transfer-to Address 2" := Colegio."Address 2";
            PromEM2."Transfer-to Post Code" := Colegio."Post Code";
            PromEM2."Transfer-to City" := Colegio.City;
            PromEM."Transfer-to County" := Colegio.County;
            PromEM."Trsf.-to Country/Region Code" := Colegio."Country/Region Code";

            PromEM.VALIDATE("Posting Date", Fecha);
            PromEM.VALIDATE("Cod. Ubicacion Alm. Origen", "Cod. Promotor");
            PromEM.VALIDATE("Cod. Ubicacion Alm. Destino", "Cod. Colegio");
            PromEM.MODIFY;
            fPromEM.SETTABLEVIEW(PromEM);
            fPromEM.SETRECORD(PromEM);
            //fPromEM.RecibeParametros(PromEM."Transfer-from Code",PromEM."Transfer-to Code","Cod. Promotor","Cod. Colegio");
            COMMIT;
        END
        ELSE BEGIN
            fPromEM.SETTABLEVIEW(PromEM2);
            fPromEM.SETRECORD(PromEM2);
        END;

        fPromEM.RUNMODAL;
        CLEAR(fPromEM);
    end;

    procedure CargaDevolucionMuestras()
    var
        Promotor: Record 13;
        Alm: Record 14;
        PromEM: Record 5740;
        PromEM2: Record 5740;
        fPromEM: Page 67074;
        Bins: Record 7354;
        Bins2: Record 7354;
        Colegio: Record 5050;
    begin

        Promotor.GET("Cod. Promotor");
        Promotor.TESTFIELD("Location code");

        Colegio.GET("Cod. Colegio");
        Colegio.TESTFIELD("Samples Location Code");

        //Doy de alta a la Ubicacion del Promotor
        Bins.RESET;
        Bins.SETRANGE("Location Code", Promotor."Location code");
        Bins.SETRANGE(Code, "Cod. Promotor");
        Bins.FINDFIRST;

        //Doy de alta a la Ubicacion del Colegio
        Bins2.RESET;
        Bins2.SETRANGE("Location Code", Colegio."Samples Location Code");
        Bins2.SETRANGE(Code, "Cod. Colegio");
        Bins2.FINDFIRST;

        CLEAR(PromEM);
        PromEM2.RESET;
        PromEM2.SETRANGE("Transfer-from Code", Colegio."Samples Location Code");
        PromEM2.SETRANGE("Transfer-to Code", Promotor."Location code");
        PromEM2.SETRANGE("Cod. Ubicacion Alm. Origen", Colegio."No.");
        PromEM2.SETRANGE("Cod. Ubicacion Alm. Destino", Promotor.Code);


        IF NOT PromEM2.FINDFIRST THEN BEGIN
            PromEM.INSERT(TRUE);
            PromEM.SETRANGE("No.");
            PromEM.VALIDATE("Cod. Vendedor", Promotor.Code);
            PromEM."Pedido Consignacion" := TRUE;
            PromEM."Consignacion Muestras" := TRUE;
            PromEM.VALIDATE("Transfer-from Code", Colegio."Samples Location Code");
            PromEM.VALIDATE("Transfer-to Code", Promotor."Location code");
            Colegio.GET("Cod. Colegio");
            PromEM."Transfer-to Name" := Colegio.Name;
            PromEM."Transfer-to Address" := Colegio.Address;
            PromEM2."Transfer-to Address 2" := Colegio."Address 2";
            PromEM2."Transfer-to Post Code" := Colegio."Post Code";
            PromEM2."Transfer-to City" := Colegio.City;
            PromEM."Transfer-to County" := Colegio.County;
            PromEM."Trsf.-to Country/Region Code" := Colegio."Country/Region Code";

            PromEM.VALIDATE("Posting Date", Fecha);
            PromEM.VALIDATE("Cod. Ubicacion Alm. Origen", "Cod. Colegio");
            PromEM.VALIDATE("Cod. Ubicacion Alm. Destino", "Cod. Promotor");
            PromEM.MODIFY;
            fPromEM.SETTABLEVIEW(PromEM);
            fPromEM.SETRECORD(PromEM);
            //fPromEM.RecibeParametros(PromEM."Transfer-from Code",PromEM."Transfer-to Code","Cod. Promotor","Cod. Colegio");
            COMMIT;
        END
        ELSE BEGIN
            fPromEM.SETTABLEVIEW(PromEM2);
            fPromEM.SETRECORD(PromEM2);
        END;

        fPromEM.RUNMODAL;
        CLEAR(fPromEM);
    end;

    procedure AbreVisita()
    var
        PromPV: Record 67038;
        fPromPV: Page 67065;
    begin
        CurrPage.SETSELECTIONFILTER(PromPV);
        fPromPV.SETTABLEVIEW(PromPV);
        fPromPV.SETRECORD(PromPV);
        fPromPV.RUNMODAL;
        CLEAR(fPromPV);
    end;
}

