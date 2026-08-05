tableextension 55053 EXCCRICurrencyExchangeRate extends "Currency Exchange Rate"
{
    fields
    {
        field(55000; "Valor t.c. divisa relac. - SIC"; Decimal)
        {
            Caption = 'SIC - Relational Exch. Rate Amount', Comment = 'ESP=Valor Tipo de Cambio relacionada - SIC';
            DataClassification = CustomerContent;
        }
    }
}
