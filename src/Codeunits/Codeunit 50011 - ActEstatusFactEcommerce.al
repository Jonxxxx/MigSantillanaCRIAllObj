codeunit 50011 ActEstatusFactEcommerce
{
    Permissions = TableData 112 = rm;

    trigger OnRun()
    begin
    end;

    var
        SIH Record: 112;

    procedure EnProceso(SIH_Record 112")
    begin
        SIH.GET(SIH_."No.");
        SIH."Estado E-Commerce" := SIH."Estado E-Commerce"::"En Proceso";
        SIH.MODIFY;
    end;

    procedure ListoParaEntrega(SIH_Record 112")
    begin
        SIH.GET(SIH_."No.");
        SIH."Estado E-Commerce" := SIH."Estado E-Commerce"::"Listo para entrega";
        SIH.MODIFY;
    end;

    procedure Entregado(SIH_Record 112")
    begin
        SIH.GET(SIH_."No.");
        SIH."Estado E-Commerce" := SIH."Estado E-Commerce"::Entregado;
        SIH.MODIFY;
    end;
}

