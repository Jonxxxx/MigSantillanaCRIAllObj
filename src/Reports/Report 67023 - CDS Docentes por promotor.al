report 67023 "CDS Docentes por promotor"
{
    // 0009 CAT Modifiaciones en el formato del informe
    DefaultLayout = RDLC;
    RDLCLayout = './CDS Docentes por promotor.rdlc';


    dataset
    {
        dataitem("Colegio - Docentes"; 67043)
        {
            CalcFields = "Nombre Promotor";
            DataItemTableView = SORTING("Pertenece al CDS", "Cod. Colegio", "Apellido paterno")
                                WHERE("Pertenece al CDS" = CONST(True));
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Cod__Promotor___________Nombre_Promotor_; "Cod. Promotor" + ' - ' + "Nombre Promotor")
            {
            }
            column(texNombre; texNombre)
            {
            }
            column(TraerDescripcionCargo; TraerDescripcionCargo)
            {
            }
            column(Colegio___Docentes__Cod__Nivel_; "Cod. Nivel")
            {
            }
            column(codCDS; codCDS)
            {
            }
            column(texDocumento; texDocumento)
            {
            }
            column(texTelefono1; texTelefono1)
            {
            }
            column(texTelefono2; texTelefono2)
            {
            }
            column(texEmail; texEmail)
            {
            }
            column(Colegio___Docentes__Cod__Colegio_; "Cod. Colegio")
            {
            }
            column(Colegio___Docentes__Nombre_colegio_; "Nombre colegio")
            {
            }
            column(Colegio___Docentes__Distrito_colegio_; "Distrito colegio")
            {
            }
            column(intTotalGeneral; intTotalGeneral)
            {
            }
            column(Colegio___DocentesCaption; Colegio___DocentesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(texNombreCaption; texNombreCaptionLbl)
            {
            }
            column(TraerDescripcionCargoCaption; TraerDescripcionCargoCaptionLbl)
            {
            }
            column(Colegio___Docentes__Cod__Nivel_Caption; Colegio___Docentes__Cod__Nivel_CaptionLbl)
            {
            }
            column(codCDSCaption; codCDSCaptionLbl)
            {
            }
            column(texDocumentoCaption; texDocumentoCaptionLbl)
            {
            }
            column(texTelefono1Caption; texTelefono1CaptionLbl)
            {
            }
            column(texTelefono2Caption; texTelefono2CaptionLbl)
            {
            }
            column(texEmailCaption; texEmailCaptionLbl)
            {
            }
            column(Colegio___Docentes__Cod__Colegio_Caption; FIELDCAPTION("Cod. Colegio"))
            {
            }
            column(Colegio___Docentes__Nombre_colegio_Caption; FIELDCAPTION("Nombre colegio"))
            {
            }
            column(Colegio___Docentes__Distrito_colegio_Caption; FIELDCAPTION("Distrito colegio"))
            {
            }
            column(Cod__Colegio___________Nombre_colegio__________traerDistritoCaption; Cod__Colegio___________Nombre_colegio__________traerDistritoCaptionLbl)
            {
            }
            column(COUNTCaption; COUNTCaptionLbl)
            {
            }
            column(Colegio___Docentes_Cod__Local; "Cod. Local")
            {
            }
            column(Colegio___Docentes_Cod__Docente; "Cod. Docente")
            {
            }
            column(Colegio___Docentes_Cod__Promotor; "Cod. Promotor")
            {
            }

            trigger OnAfterGetRecord()
            begin

                CLEAR(texSaludo);
                CLEAR(codCDS);
                CLEAR(texNombre);
                CLEAR(texDocumento);
                CLEAR(texTelefono1);
                CLEAR(texTelefono2);
                CLEAR(texEmail);
                CLEAR(datFechaNac);
                CLEAR(codAño);

                IF recDocente.GET("Cod. Docente") THEN BEGIN
                    IF recSaludos.GET(recDocente."Salutation Code") THEN
                        texSaludo := recSaludos.Description;

                    //+0009
                    //codCDS := recDocente."Cod. CDS";
                    IF recDocente."No." <> '' THEN
                        EVALUATE(codCDS, recDocente."No.");
                    //-0009

                    texNombre := recDocente.GetApellidosNombre;
                    texDocumento := recDocente."Tipo documento" + ' ' + recDocente."Document ID";
                    texTelefono1 := recDocente."Phone No.";
                    texTelefono2 := recDocente."Mobile Phone No.";
                    texEmail := recDocente."E-Mail";
                    IF (recDocente."Dia Nacimiento" <> 0) AND (recDocente."Mes Nacimiento" <> 0) AND (recDocente."Ano Nacimiento" <> 0) THEN
                        datFechaNac := DMY2DATE(recDocente."Dia Nacimiento", recDocente."Mes Nacimiento", recDocente."Ano Nacimiento");
                    codAño := recDocente."Ano inscripcion CDS";
                END;

                intTotalGeneral += 1;
            end;

            trigger OnPreDataItem()
            begin
                CASE optOrden OF
                    optOrden::Docente:
                        SETCURRENTKEY("Pertenece al CDS", "Cod. Promotor", "Apellido paterno");
                    optOrden::Colegio:
                        SETCURRENTKEY("Pertenece al CDS", "Cod. Promotor", "Cod. Colegio");
                    optOrden::Distrito:
                        SETCURRENTKEY("Pertenece al CDS", "Cod. Promotor", "Distrito colegio");
                END;

                IF codPromotor <> '' THEN
                    SETRANGE("Cod. Promotor", codPromotor);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Orden; optOrden)
                {
                    OptionCaption = 'Por nombre docente,Por codigo colegio,Por distrito';
                }
                field(Promotor; codPromotor)
                {
                    TableRelation = Salesperson/Purchaser;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        recDocente: Record 67001;
        recSaludos: Record 5068;
        codPromotor: Code[20];
        optOrden: Option Docente,Colegio,Distrito;
        texSaludo: Text[30];
        codCDS: Integer;
        texNombre: Text[250];
        "codAño": Code[4];
        datFechaNac: Date;
        texDocumento: Text[60];
        texTelefono1: Text[30];
        texTelefono2: Text[30];
        texEmail: Text[80];
        intTotalGeneral: Integer;
        Colegio___DocentesCaptionLbl: Label 'CDS Docentes por promotor';
        CurrReport_PAGENOCaptionLbl: Label 'Pág.';
        texNombreCaptionLbl: Label 'Nombre docente';
        TraerDescripcionCargoCaptionLbl: Label 'Cargo';
        Colegio___Docentes__Cod__Nivel_CaptionLbl: Label 'Cod. Nivel';
        codCDSCaptionLbl: Label 'Codigo CDS';
        texDocumentoCaptionLbl: Label 'Documento';
        texTelefono1CaptionLbl: Label 'Teléfono';
        texTelefono2CaptionLbl: Label 'Teléfono 2';
        texEmailCaptionLbl: Label 'Email';
        Cod__Colegio___________Nombre_colegio__________traerDistritoCaptionLbl: Label 'Promotor:';
        COUNTCaptionLbl: Label 'Total general:';

    procedure TraerDescripcionCargo(): Text[100]
    var
        recDatAux: Record 67002;
    begin
        recDatAux.RESET;
        recDatAux.SETRANGE("Tipo registro", recDatAux."Tipo registro"::"Puestos de trabajo");
        recDatAux.SETRANGE(Codigo, "Colegio - Docentes"."Cod. Cargo");
        IF recDatAux.FINDFIRST THEN
          EXIT(recDatAux.Descripcion);
    end;

    procedure traerDistrito(): Text[30]
    var
        recColegio: Record 5050;
    begin
        IF recColegio.GET("Colegio - Docentes"."Cod. Colegio") THEN
          EXIT(recColegio.Distritos);
    end;

    procedure FormatFechaNac()
    begin
    end;
}

