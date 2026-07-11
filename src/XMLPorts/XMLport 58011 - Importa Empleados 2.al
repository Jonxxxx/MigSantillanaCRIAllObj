xmlport 58011 "Importa Empleados 2"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(ImportaEmpleados)
        {
            tableelement(Table2000000026; Table2000000026)
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
                textelement(Ciudad)
                {
                }
                textelement(cp)
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
                textelement(tipodoc)
                {
                }
                textelement(ced)
                {
                }
                textelement(cargo)
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
            }

            trigger OnAfterAssignVariable()
            begin

                found := 0;
                //txtApellidos := CONVERTSTR(Ape,' ',',');
                //IF Nomb2 <> 'Rolando' THEN
                //   EXIT;
                //IF Nomb2 = 'Rolando' THEN
                //   MESSAGE('aa%1 bb%2',Ape1,Ape2);

                Nomb := CONVERTSTR(Nomb, 'Ý', 'í');
                Nomb := CONVERTSTR(Nomb, '±', 'ñ');
                Nomb := CONVERTSTR(Nomb, 'Ð', 'ñ');
                Nomb := CONVERTSTR(Nomb, '¾', 'ó');
                Nomb2 := CONVERTSTR(Nomb2, 'Ý', 'í');
                Nomb2 := CONVERTSTR(Nomb2, '±', 'ñ');
                Nomb2 := CONVERTSTR(Nomb2, 'Ð', 'ñ');
                Nomb2 := CONVERTSTR(Nomb2, '¾', 'ó');
                Ape1 := CONVERTSTR(Ape1, 'Ý', 'í');
                Ape1 := CONVERTSTR(Ape1, '±', 'ñ');
                Ape1 := CONVERTSTR(Ape1, 'Ð', 'ñ');
                Ape1 := CONVERTSTR(Ape1, '¾', 'ó');
                Ape2 := CONVERTSTR(Ape2, 'Ý', 'í');
                Ape2 := CONVERTSTR(Ape2, '±', 'ñ');
                Ape2 := CONVERTSTR(Ape2, 'Ð', 'ñ');
                Ape2 := CONVERTSTR(Ape2, '¾', 'ó');

                CLEAR(Empl);
                Empl."No." := CodEmpl;
                Empl."First Name" := Nomb;
                Empl."Middle Name" := Nomb2;
                Empl."Last Name" := Ape1;
                Empl."Second Last Name" := Ape2;

                Empl.VALIDATE("First Name");
                //Empl."Working Center" := Sucursal;
                Empl.Address := Dir;
                Empl.VALIDATE(City, Ciudad);
                IF cp <> '' THEN
                    Empl.VALIDATE("Post Code", cp);
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

                IF fecing <> '' THEN
                    EVALUATE(Empl."Employment Date", fecing);

                Empl."Company E-Mail" := mail2;

                Empl.Company := 'SANTILLANA';
                IF tipodoc = 'DPI' THEN
                    Empl."Document Type" := 2
                ELSE
                    IF tipodoc = 'PASAPORTE' THEN
                        Empl."Document Type" := 1
                    ELSE
                        Empl."Document Type" := 0;

                Empl.VALIDATE("Document ID", ced);
                //IF (Nac = 'Guatemalteca') OR (Nac = 'Guatemalteco') THEN
                IF COPYSTR(Nac, 1, 5) = 'Panam' THEN
                    Empl.Nacionalidad := 'PA'
                ELSE
                    Empl.Nacionalidad := 'ES';

                Empl."Lugar Nacimiento MT" := LugarNac;
                IF Empl.INSERT THEN;

                IF NOT Empl.GET(CodEmpl) THEN
                    EXIT;


                IF (COPYSTR(estc, 1, 4) = 'Casa') OR (COPYSTR(estc, 1, 4) = 'casa') THEN
                    Empl."Estado civil" := 1
                ELSE
                    IF (COPYSTR(estc, 1, 4) = 'Divo') OR (COPYSTR(estc, 1, 4) = 'divo') THEN
                        Empl."Estado civil" := 4
                    ELSE
                        IF (COPYSTR(estc, 1, 4) = 'Viud') OR (COPYSTR(estc, 1, 4) = 'viud') THEN
                            Empl."Estado civil" := 2
                        ELSE
                            Empl."Estado civil" := 0;

                DistCta."Cod. Banco" := 'BCR_A';
                DistCta."No. empleado" := Empl."No.";
                IF DistCta.INSERT THEN;

                Empl."Dia nacimiento" := NSS;


                Departamento.FINDFIRST;
                Empl.VALIDATE(Departamento, Departamento.Codigo);

                //Empl."Sub-Departamento" := subdepto;
                Empl."Lugar Nacimiento MT" := LugarNac;
                Empl."Lugar nacimiento" := LugarNac;
                Empl.MODIFY;

                IF cargo <> '' THEN
                    Empl.VALIDATE("Job Type Code", cargo);

                //Empl.VALIDATE("Job Type Code",cargo);
                IF fecnac <> '' THEN
                    EVALUATE(Empl."Birth Date", fecnac);

                IF NOT Empl.INSERT THEN
                    Empl.MODIFY;

                Empl.VALIDATE("Emplymt. Contract Code", '100');

                /*
                IF tipoempl ='100' THEN
                   BEGIN
                    contra.INIT;
                    contra.VALIDATE("No. empleado",CodEmpl);
                    contra.VALIDATE("Cód. contrato",'100');
                    Empl.VALIDATE("Emplymt. Contract Code",'100');
                    IF contra.INSERT THEN;
                   END
                ELSE
                   BEGIN
                    contra.VALIDATE("No. empleado",CodEmpl);
                    contra.VALIDATE("Cód. contrato",'101');
                    Empl.VALIDATE("Emplymt. Contract Code",'101');
                    IF contra.INSERT THEN;
                   END;
                */

                //Empl.VALIDATE("Job Type Code",CARGOS.Código);

                Empl.MODIFY;
                /*
                DimVal.SETRANGE("Dimension Code",'EMPLEADOS');
                DimVal.SETRANGE(Code,DimEmp);
                IF DimVal.FINDFIRST THEN
                   BEGIN
                    IF DimVal.Name = '' THEN
                       BEGIN
                        DimVal.Name := Empl."Full Name";
                        DimVal.MODIFY;
                       END;
                   END
                ELSE
                  BEGIN
                   CLEAR(DimVal);
                   DimVal."Dimension Code" := 'EMPLEADOS';
                   DimVal.Code := DimEmp;
                   DimVal.Name := Empl."Full Name";
                   DimVal.INSERT;
                  END;
                
                CLEAR(DefDim);
                DefDim."Table ID" := 5200;
                DefDim."No." := Empl."No.";
                DefDim.VALIDATE("Dimension Code",'DEPARTAMENTO');
                DefDim.VALIDATE("Dimension Value Code",DimDepto);
                IF DefDim.INSERT(TRUE) THEN;
                
                CLEAR(DefDim);
                DefDim."Table ID" := 5200;
                DefDim."No." := Empl."No.";
                DefDim.VALIDATE("Dimension Code",'LINEA_NEGOCIO');
                DefDim.VALIDATE("Dimension Value Code",DimLin);
                IF DefDim.INSERT(TRUE) THEN;
                
                CLEAR(DefDim);
                DefDim."Table ID" := 5200;
                DefDim."No." := Empl."No.";
                DefDim.VALIDATE("Dimension Code",'EMPLEADOS');
                DefDim.VALIDATE("Dimension Value Code",DimEmp);
                IF DefDim.INSERT(TRUE) THEN;
                */

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
        esqsal: Record 34002115;
        contra: Record 34002109;
        CARGOS: Record 34002110;
        DistCta: Record 34002108;
        DefDim: Record 352;
        DimVal: Record 349;
        Departamento: Record 34002135;
        SubDepartamento: Record 34002136;
        Sucursal: Code[10];
        found: Integer;
}

