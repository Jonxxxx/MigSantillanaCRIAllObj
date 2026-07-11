xmlport 58007 "Asigna depto y Secc"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(AsignaDeptoSecc)
        {
            tableelement(Table2000000026; Table2000000026)
            {
                XmlName = 'DepSec';
                textelement(CodEmpl)
                {
                }
                textelement(Nomb)
                {
                }
                textelement(Nomb2)
                {
                }
                textelement(Ape1)
                {
                }
                textelement(Ape2)
                {
                }
                textelement(Cargo)
                {
                }
                textelement(Ciudad)
                {
                }
                textelement(Basura)
                {
                }
                textelement(Tel1)
                {
                }
                textelement(Cel)
                {
                }
                textelement(Basura2)
                {
                }
                textelement(fecnac)
                {
                }
                textelement(sex)
                {
                }
                textelement(fecing)
                {
                }
                textelement(mail)
                {
                }
                textelement(Basura3)
                {
                }
                textelement(Basura4)
                {
                }
                textelement(ced)
                {
                }
                textelement(Nac)
                {
                }
                textelement(LugarNac)
                {
                }
                textelement(estc)
                {
                }
                textelement(Basura5)
                {
                }
                textelement(TipoCta)
                {
                }
                textelement(ctaban)
                {
                }
                textelement(sueldo)
                {
                }
                textelement(Codcte)
                {
                }
                textelement(NSS)
                {
                }
                textelement(SubDepto)
                {
                }
                textelement(Depto)
                {
                }
                textelement(Basura6)
                {
                }
                textelement(tipoempl)
                {
                }
                textelement(Basura7)
                {
                }
                textelement(Basura8)
                {
                }
            }

            trigger OnAfterAssignVariable()
            begin

                IF SubDepto <> '' THEN BEGIN
                    IF STRPOS(SubDepto, ' ') <> 0 THEN
                        SubDepto := COPYSTR(SubDepto, STRPOS(SubDepto, ' ') + 1, 4)
                    ELSE
                        IF STRPOS(SubDepto, '-') <> 0 THEN
                            SubDepto := COPYSTR(SubDepto, STRPOS(SubDepto, '-') + 1, 4)

                END;

                IF STRPOS(Depto, '-') <> 0 THEN
                    Depart.SETFILTER(Descripcion, COPYSTR(Depto, STRPOS(Depto, '-') + 1, 3) + '*');
                Depart.FINDFIRST;

                Empl.GET(CodEmpl);
                Empl.Departamento := Depart.Codigo;

                IF SubDepto <> '' THEN BEGIN
                    SubDe.SETRANGE("Cod. Departamento", Depart.Codigo);
                    SubDe.SETFILTER(Descripcion, '*' + SubDepto + '*');
                    SubDe.FINDFIRST;
                END;
                Empl."Sub-Departamento" := SubDe.Codigo;
                Empl.MODIFY;
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

    var
        Empl: Record 5200;
        esqsal: Record 34002115;
        contra: Record 34002109;
        CARGOS: Record 34002110;
        Depart: Record 34002135;
        SubDe: Record 34002136;
}

