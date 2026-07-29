table 67032 "FlagsInRepeater Bitmaps"
{

    fields
    {
        field(1;Status;Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionCaption = ' ,Sent by salesperson,Approved,Programmed,Voided,Rejected,Done';
            OptionMembers = " ","Enviada por promotor",Aprobada,Programada,Cancelada,Rechazada,Realizada;
        }
        field(2;Bitmap;BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Bitmap';
            SubType = Bitmap;
        }
    }

    keys
    {
        key(Key1;Status)
        {
        }
    }

    fieldgroups
    {
    }
}

