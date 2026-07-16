codeunit 34002150 "DSPayroll CaptionClass Mgmt"
{
    // Proyecto: Implementacion Microsoft Dynamics Nav
    // AMS     : Agustin Mendez
    // GRN     : Guillermo Roman
    // ------------------------------------------------------------------------
    // No.         Fecha           Firma         Descripcion
    // ------------------------------------------------------------------------
    // DSNOM1.03   27/08/2021      GRN           Modificaciones para manejar el caption de algunos campos
    // 
    // Caption conceptos salariales '4,4,x'
    // Caption maestro empleados '4,1,x'

    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        CountyTxt: Label 'State';

    [EventSubscriber(ObjectType::Codeunit, 42, 'OnResolveCaptionClass', '', true, true)]
    local procedure ResolveCaptionClass(CaptionArea: Text; CaptionExpr: Text; Language: Integer; var Caption: Text; var Resolved: Boolean)
    begin
        IF CaptionArea = '4' THEN BEGIN
            Caption := PayrollClassTranslate(CaptionExpr);
            Resolved := TRUE;
        END;
    end;

    local procedure PayrollClassTranslate(CaptionExpr: Text): Text
    var
        Configuracionnominas: Record 34002103;
        CommaPosition: Integer;
        CaptionType: Text[30];
        CaptionRef: Text;
    begin
        IF NOT Configuracionnominas.GET() THEN
            EXIT('');
        CommaPosition := STRPOS(CaptionExpr, ',');
        IF CommaPosition > 0 THEN BEGIN
            CaptionType := COPYSTR(CaptionExpr, 1, CommaPosition - 1);
            CaptionRef := COPYSTR(CaptionExpr, CommaPosition + 1);
            CASE CaptionType OF
                '1':
                    EXIT(Configuracionnominas."Caption Depto");
                '2':
                    EXIT(Configuracionnominas."Caption Sub Depto");
                '3':
                    EXIT(Configuracionnominas."Caption ISR");
                '4':
                    EXIT(Configuracionnominas."Caption AFP");
                '5':
                    EXIT(Configuracionnominas."Caption SFS");
                '6':
                    EXIT(Configuracionnominas."Caption INFOTEP");
                '7':
                    EXIT(Configuracionnominas."Caption SRL");
                ELSE
                    EXIT(CaptionRef);
            END;
        END;
        EXIT(CountyTxt);
    end;
}

