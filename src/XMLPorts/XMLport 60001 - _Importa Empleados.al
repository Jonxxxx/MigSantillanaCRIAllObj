xmlport 60001 "_Importa Empleados"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(ImportaEmpleados)
        {
            tableelement(Table2000000026; 2000000026)
            {
                XmlName = 'Empleados';
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
                textelement(Dir)
                {
                }
                textelement(Dir2)
                {
                }
                textelement(Ciudad)
                {
                }
                textelement(cp)
                {
                }
                textelement(Provincia)
                {
                }
                textelement(Tel1)
                {
                }
                textelement(Cel)
                {
                }
                textelement(mail)
                {
                }
                textelement(fecnac)
                {
                }
                textelement(NSS)
                {
                }
                textelement(sex)
                {
                }
                textelement(fecing)
                {
                }
                textelement(mail2)
                {
                }
                textelement(CodVend)
                {
                }
                textelement(tipodoc)
                {
                }
                textelement(ced)
                {
                }
                textelement(cargo)
                {
                }
                textelement(Tel3)
                {
                }
                textelement(Nac)
                {
                }
                textelement(Basura1)
                {
                }
                textelement(LugarNAc)
                {
                }
                textelement(Basura2)
                {
                }
                textelement(Basura3)
                {
                }
                textelement(Basura4)
                {
                }
                textelement(estc)
                {
                }
                textelement(NumHijos)
                {
                }
                textelement(Basura5)
                {
                }
                textelement(Profes)
                {
                }
                textelement(Basura6)
                {
                }
                textelement(TipoCta)
                {
                }
                textelement(ctaban)
                {
                }
                textelement(NSS2)
                {
                }
                textelement(ced2)
                {
                }
                textelement(tipoempl)
                {
                }
                textelement(Depto)
                {
                }
                textelement(Basura7)
                {
                }
                textelement(Basura8)
                {
                }
                textelement(Basura9)
                {
                }
                textelement(Basura10)
                {
                }
                textelement(Basura11)
                {
                }
                textelement(Basura12)
                {
                }
                textelement(Basura13)
                {
                }
                textelement(Basura14)
                {
                }
                textelement(Basura15)
                {
                }
                textelement(sueldo)
                {
                }
                textelement(Basura16)
                {
                }
                textelement(Basura17)
                {
                }
                textelement(Basura18)
                {
                }
                textelement(Basura19)
                {
                }
            }

            trigger OnAfterAssignVariable()
            begin

                found := 0;
                //txtApellidos := CONVERTSTR(Ape,' ',',');
                //IF Nomb2 <> 'Rolando' THEN
                //   EXIT;
                //IF Nomb2 = 'Rolando' THEN
                //   MESSAGE('aa%1 bb%2',Ape1,Ape2);

                Nomb := CONVERTSTR(Nomb, 'Ý', 'i');
                Nomb := CONVERTSTR(Nomb, '±', 'ñ');
                Nomb := CONVERTSTR(Nomb, 'Ð', 'ñ');
                Nomb2 := CONVERTSTR(Nomb2, 'Ý', 'i');
                Nomb2 := CONVERTSTR(Nomb2, '±', 'ñ');
                Nomb2 := CONVERTSTR(Nomb2, 'Ð', 'ñ');
                Ape1 := CONVERTSTR(Ape1, 'Ý', 'i');
                Ape1 := CONVERTSTR(Ape1, '±', 'ñ');
                Ape1 := CONVERTSTR(Ape1, 'Ð', 'ñ');
                Ape2 := CONVERTSTR(Ape2, 'Ý', 'i');
                Ape2 := CONVERTSTR(Ape2, '±', 'ñ');
                Ape2 := CONVERTSTR(Ape2, 'Ð', 'ñ');

                tipoempl := 'Fi';
                CLEAR(Empl);
                Empl."No." := CodEmpl;
                Empl."First Name" := Nomb;
                Empl."Middle Name" := Nomb2;
                Empl."Last Name" := Ape1;

                /*
                //TODO: Ver 
                Empl."Second Last Name" := Ape2;

                Empl.VALIDATE("First Name");
                //Empl."Working Center" := Sucursal;
                Empl.Address := COPYSTR(Dir, 1, 60);
                Empl."Address 2" := COPYSTR(Dir2, 1, 60);
                Empl.VALIDATE(City, Ciudad);
                IF cp <> '' THEN
                    Empl.VALIDATE("Post Code", cp);
                Empl.County := Provincia;
                Empl."Phone No." := Tel1;
                Empl."Mobile Phone No." := Cel;
                Empl."E-Mail" := mail;
                IF fecnac <> '' THEN BEGIN
                    EVALUATE(Empl."Birth Date", fecnac);
                    Empl.VALIDATE("Birth Date");
                END;

                IF UPPERCASE(sex) = 'M' THEN
                    Empl.Gender := 2
                ELSE
                    Empl.Gender := 1;

                EVALUATE(Empl."Employment Date", fecing);
                Empl.VALIDATE("Employment Date");
                Empl."Company E-Mail" := mail2;
                IF CodVend <> '' THEN
                    Empl."Salespers./Purch. Code" := CodVend;

                Empl.Company := 'SANTILLANA';
                IF tipodoc = 'C.I.' THEN
                    Empl."Document Type" := 2
                ELSE
                    IF tipodoc = 'PASAPORTE' THEN
                        Empl."Document Type" := 1
                    ELSE
                        Empl."Document Type" := 0;

                Empl.VALIDATE("Document ID", ced);
                //IF (Nac = 'Guatemalteca') OR (Nac = 'Guatemalteco') THEN
                IF COPYSTR(Nac, 1, 5) = 'Boliv' THEN
                    Empl.Nacionalidad := 'BO'
                ELSE
                    Empl.Nacionalidad := 'ES';

                //Empl."Permiso Trabajo MT"  := PermTrabMT;
                Empl."Lugar Nacimiento MT" := LugarNAc;
                //Empl."Etnia MT"            := EtniaMT;
                //Empl."Idioma MT"           := IdiomaMT;
                //Empl."Numero de Hijos MT"  := NumHijos;
                //Empl."Nivel Academico MT"  := NivelAcad;
                Empl.Profesion := Profes;
                //Empl."Puesto Segun MT"     := PuestoMT;
                IF Empl.INSERT THEN;

                IF NOT Empl.GET(CodEmpl) THEN
                    EXIT;

                //Empl."Codigo Cliente" := Codcte;

                IF COPYSTR(estc, 1, 4) = 'Casa' THEN
                    Empl."Estado civil" := 1
                ELSE
                    IF COPYSTR(estc, 1, 4) = 'Divo' THEN
                        Empl."Estado civil" := 4
                    ELSE
                        Empl."Estado civil" := 0;

                DistCta."Cod. Banco" := 'B_BS_CTO';
                DistCta."No. empleado" := Empl."No.";
                DistCta."Numero Cuenta" := ctaban;
                IF DistCta.INSERT THEN;

                Empl."Dia nacimiento" := NSS;


                Departamento.SETFILTER(Descripcion, '%1', '*' + COPYSTR(Depto, 1, 4) + '*');
                Departamento.FINDFIRST;
                Empl.VALIDATE(Departamento, Departamento.Codigo);

                //Empl."Sub-Departamento" := subdepto;
                Empl."Lugar Nacimiento MT" := LugarNAc;
                Empl."Lugar nacimiento" := LugarNAc;
                Empl.MODIFY;


                IF STRLEN(cargo) = 1 THEN
                    cargo := '0' + cargo;


                IF cargo <> '' THEN BEGIN
                    //    CARGOS.SETRANGE(Descripcion,UPPERCASE(cargo));
                    //    CARGOS.FINDFIRST;
                    Empl.VALIDATE("Job Type Code", cargo);
                END;

                //Empl.VALIDATE("Job Type Code",cargo);

                EVALUATE(Empl."Birth Date", fecnac);
                Empl.VALIDATE("Birth Date");

                IF STRPOS(tipoempl, 'Fi') <> 0 THEN
                    Empl."Tipo Empleado" := 0
                ELSE
                    Empl."Tipo Empleado" := 1;
                    */

                IF NOT Empl.INSERT THEN
                    Empl.MODIFY;

                Empl.VALIDATE("Emplymt. Contract Code", '100');



                Empl.MODIFY;


                COMMIT;

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
        /*
        //TODO: Ver 
        esqsal: Record 34002115;
        contra: Record 34002109;
        CARGOS: Record 34002110;
        DistCta: Record 34002108;
        DefDim: Record 352;
        DimVal: Record 349;
        Departamento: Record 34002135;
        SubDepartamento: Record 34002136;*/
        Sucursal: Code[10];
        found: Integer;
}

