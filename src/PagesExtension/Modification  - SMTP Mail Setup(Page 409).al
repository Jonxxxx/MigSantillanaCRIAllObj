pageextension 70000061 pageextension70000061 extends "SMTP Mail Setup" 
{
    actions
    {

        //Unsupported feature: Code Modification on "SendTestMail(Action 5).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CODEUNIT.RUN(CODEUNIT::"SMTP Test Mail");//LDP-001//Se comenta solicitud por Mairiela para que puedan indcar el estado las facturas electronicas.
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CODEUNIT.RUN(CODEUNIT::"SMTP Test Mail");
            */
        //end;
    }
}

