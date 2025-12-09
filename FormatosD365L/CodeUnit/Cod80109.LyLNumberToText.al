///<summary>
///CodeUnit con todo el proceso de convertir de numeros a texto hasta 999.999.999.999
///</summary>
codeunit 50147 "LyL NumberToText_ING"
{
    ///<summary>
    ///Procedimiento para validar numero que ingresa y condicionar que texto concuerda
    ///</summary>
    ///<param name="CurrencyCode">Recibe el codigo de la divisa</param>
    ///<param name="No">Recibe la cantidad a convertir a texto</param>
    ///<param name="NoText">Recibe el numero dividido en secciones dependiendo la cantidad de digitos</param>
    procedure FormatNoText(var NoText: array[2] of Text[500]; No: Decimal; CurrencyCode: Code[10]);
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        milmill: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        //NoText[1] := '****';
        NoText[1] := '';
        milmill := 0;

        if (No >= 1000000000.00) AND (No < 2000000000.00) then begin
            No := No - 1000000000;
            milmill := 1;
        end;
        if (No >= 2000000000.00) AND (No < 3000000000.00) then begin
            No := No - 2000000000.00;
            milmill := 2;
        end;
        if (No >= 3000000000.00) AND (No < 4000000000.00) then begin
            No := No - 3000000000.00;
            milmill := 3;
        end;
        if (No >= 4000000000.00) AND (No < 5000000000.00) then begin
            No := No - 4000000000.00;
            milmill := 4;
        end;
        if (No >= 5000000000.00) AND (No < 6000000000.00) then begin
            No := No - 5000000000.00;
            milmill := 5;
        end;
        if (No >= 6000000000.00) AND (No < 7000000000.00) then begin
            No := No - 6000000000.00;
            milmill := 6;
        end;
        if (No >= 7000000000.00) AND (No < 8000000000.00) then begin
            No := No - 7000000000.00;
            milmill := 7;
        end;
        if (No >= 8000000000.00) AND (No < 9000000000.00) then begin
            No := No - 8000000000.00;
            milmill := 8;
        end;
        if (No >= 9000000000.00) AND (No < 10000000000.00) then begin
            No := No - 9000000000.00;
            milmill := 9;
        end;



        if No > 999999999 then exit;
        //ERROR(Text1100768, No);

        if ROUND(No, 1, '<') = 0 then
            AddToNoText(NoText, NoTextIndex, Text1100765);

        HundMilion := ROUND(No, 1, '<') div 100000000;
        Remainder := ROUND(No, 1, '<') mod 100000000;
        TenMilion := Remainder div 10000000;
        Remainder := Remainder mod 10000000;
        UnitsMilion := Remainder div 1000000;
        Remainder := Remainder mod 1000000;
        HundThousands := Remainder div 100000;
        Remainder := Remainder mod 100000;
        TenThousands := Remainder div 10000;
        Remainder := Remainder mod 10000;
        UnitsThousands := Remainder div 1000;
        Remainder := Remainder mod 1000;
        Hundreds := Remainder div 100;
        Remainder := Remainder mod 100;
        Tens := Remainder div 10;
        Units := Remainder mod 10;
        DecimalPlaces := STRLEN(FORMAT(No, 0, Text1100700));
        if DecimalPlaces > 0 then begin
            DecimalPlaces := DecimalPlaces - 1;
            Decimals := (No - ROUND(No, 1, '<')) * POWER(10, DecimalPlaces);
            if DecimalPlaces = 1 then
                Decimals := Decimals * 10;
            if (CurrencyCode = 'COP') or (CurrencyCode = '') then
                DecimalString := TextNoDecimals(DecimalPlaces);
        end;

        AddToNoText(NoText, NoTextIndex, TextHundMilion(HundMilion, TenMilion, UnitsMilion, true));
        AddToNoText(NoText, NoTextIndex, TextTenUnitsMilion(HundMilion, TenMilion, UnitsMilion, true));
        AddToNoText(NoText, NoTextIndex, TextHundThousands(HundThousands, TenThousands, UnitsThousands, false));
        AddToNoText(NoText, NoTextIndex, TextTenUnitsThousands(HundThousands, TenThousands, UnitsThousands, false));
        AddToNoText(NoText, NoTextIndex, TextHundreds(Hundreds, Tens, Units, false));
        AddToNoText(NoText, NoTextIndex, TextTensUnits(Tens, Units, false));
        if DecimalPlaces > 0 then begin
            FormatNoText(DecimalText, Decimals, '');
            if (CurrencyCode = 'COP') or (CurrencyCode = '') then begin
                AddToNoText(NoText, NoTextIndex, 'PESOS ' + Text1100767 + DecimalText[1] + DecimalString);
            end else begin
                AddToNoText(NoText, NoTextIndex, ' ' + Text1100767 + DecimalText[1] + DecimalString);
            end;
        end;
        if CurrencyCode <> '' then
            AddToNoText(NoText, NoTextIndex, '');

        if milmill > 0 then begin
            if milmill = 1 then
                NoText[1] := 'MIL MILLONES ' + NoText[1];
            if milmill = 2 then
                NoText[1] := 'DOS MIL MILLONES ' + NoText[1];
            if milmill = 3 then
                NoText[1] := 'TRES MIL MILLONES ' + NoText[1];
            if milmill = 4 then
                NoText[1] := 'CUATRO MIL MILLONES ' + NoText[1];
            if milmill = 5 then
                NoText[1] := 'CINCO MIL MILLONES ' + NoText[1];
            if milmill = 6 then
                NoText[1] := 'SEIS MIL MILLONES ' + NoText[1];
            if milmill = 7 then
                NoText[1] := 'SIETE MIL MILLONES ' + NoText[1];
            if milmill = 8 then
                NoText[1] := 'OCHO MIL MILLONES ' + NoText[1];
            if milmill = 9 then
                NoText[1] := 'NUEVE MIL MILLONES ' + NoText[1];
        end;

    end;
    ///<summary>
    ///Procedimiento que valida en que seccion debe ir cada parte del numero
    ///</summary>
    ///<param name="NoText">Recibe y divide en secciones</param>
    ///<param name="NoTextIndex">Recibe y valida el orden de cada seccion</param>
    ///<param name="AddText">Recibe las secciones y convierte el texto segun la seccion</param>
    local procedure AddToNoText(var NoText: array[2] of Text[500]; var NoTextIndex: Integer; AddText: Text[500]);
    begin
        while STRLEN(NoText[NoTextIndex] + AddText) > MAXSTRLEN(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ARRAYLEN(NoText) then
                exit;
        end;
        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + AddText, '<');
    end;
    ///<summary>
    ///Procedimiento que valida los decimales en el numero
    ///</summary>
    ///<param name="NoDecimals">Recibe solo los decimales del total del numero</param>
    procedure TextNoDecimals(NoDecimals: Integer): Text[15];
    begin
        if Decimals > 1 then
            case NoDecimals of
                0:
                    exit('');
                1:
                    exit(Text1100755);
                2:
                    exit(Text1100756);
                3:
                    exit(Text1100757);
                4:
                    exit(Text1100758);
            end
        else
            case NoDecimals of
                0:
                    exit('');
                1:
                    exit(Text1100759);
                2:
                    exit(Text1100760);
                3:
                    exit(Text1100761);
                4:
                    exit(Text1100762);
            end;
    end;
    ///<summary>
    /// Procedimiento cuando el numero supera 100000000
    /// </summary>
    /// <param name="Hundreds">Recibe los multiplos de 100</param>
    /// <param name="Ten">Recibe los multiplos de 10</param>
    /// <param name="Masc">Recibe y valida si sobrepasa 100000000</param>
    /// <param name="Units">Recibe la cantidad</param>
    procedure TextHundMilion(Hundreds: Integer; Ten: Integer; Units: Integer; Masc: Boolean): Text[250];
    begin
        if Hundreds <> 0 then
            exit(TextHundreds(Hundreds, Ten, Units, true));
    end;
    ///<summary>
    /// Procedimiento cuando el numero supera 10000000
    /// </summary>
    /// <param name="Hundreds">Recibe los multiplos de 100</param>
    /// <param name="Ten">Recibe los multiplos de 10</param>
    /// <param name="Masc">Recibe y valida si sobrepasa 10000000</param>
    /// <param name="Units">Recibe la cantidad</param>
    procedure TextTenUnitsMilion(Hundreds: Integer; Ten: Integer; Units: Integer; Masc: Boolean): Text[250];
    begin
        if (Hundreds <> 0) and (Ten = 0) and (Units = 0) then
            exit(Text1100701);
        if (Hundreds = 0) and (Ten = 0) and (Units = 1) then
            exit(Text1100702);
        if (Ten <> 0) or (Units <> 0) then
            exit(TextTensUnits(Ten, Units, Masc) + Text1100701);
    end;
    ///<summary>
    /// Procedimiento cuando el numero supera 1000
    /// </summary>
    /// <param name="Hundreds">Recibe los multiplos de 100</param>
    /// <param name="Ten">Recibe los multiplos de 10</param>
    /// <param name="Masc">Recibe y valida si sobrepasa 1000</param>
    /// <param name="Units">Recibe la cantidad</param>
    procedure TextHundThousands(Hundreds: Integer; Ten: Integer; Units: Integer; Masc: Boolean): Text[250];
    begin
        if Hundreds <> 0 then
            exit(TextHundreds(Hundreds, Ten, Units, Masc))
    end;
    ///<summary>
    /// Procedimiento cuando el numero supera 10000
    /// </summary>
    /// <param name="Hundreds">Recibe los multiplos de 100</param>
    /// <param name="Ten">Recibe los multiplos de 10</param>
    /// <param name="Masc">Recibe y valida si sobrepasa 10000</param>
    /// <param name="Units">Recibe la cantidad</param>
    procedure TextTenUnitsThousands(Hundreds: Integer; Ten: Integer; Units: Integer; Masc: Boolean): Text[250];
    begin
        if (Hundreds <> 0) and (Ten = 0) and (Units = 0) then
            exit(Text1100703);
        if (Hundreds = 0) and (Ten = 0) and (Units = 1) then
            exit(Text1100703);
        if (Ten <> 0) or (Units <> 0) then
            exit(TextTensUnits(Ten, Units, Masc) + Text1100703);
    end;
    ///<summary>
    /// Procedimiento cuando el numero supera 100
    /// </summary>
    /// <param name="Hundreds">Recibe los multiplos de 100</param>
    /// <param name="Ten">Recibe los multiplos de 10</param>
    /// <param name="Masc">Recibe y valida si sobrepasa 100</param>
    /// <param name="Units">Recibe la cantidad</param>
    procedure TextHundreds(Hundreds: Integer; Tens: Integer; Units: Integer; Masc: Boolean): Text[250];
    begin
        if Hundreds = 0 then
            exit('');
        if Masc then
            case Hundreds of
                1:
                    if (Tens = 0) and (Units = 0) then
                        exit(Text1100704)
                    else
                        exit(Text1100705);
                2:
                    exit(Text1100706);
                3:
                    exit(Text1100707);
                4:
                    exit(Text1100708);
                5:
                    exit(Text1100709);
                6:
                    exit(Text1100710);
                7:
                    exit(Text1100711);
                8:
                    exit(Text1100712);
                9:
                    exit(Text1100713);
            end
        else
            case Hundreds of
                1:
                    if (Tens = 0) and (Units = 0) then
                        exit(Text1100704)
                    else
                        exit(Text1100705);
                2:
                    exit(Text1100714);
                3:
                    exit(Text1100715);
                4:
                    exit(Text1100716);
                5:
                    exit(Text1100717);
                6:
                    exit(Text1100718);
                7:
                    exit(Text1100719);
                8:
                    exit(Text1100720);
                9:
                    exit(Text1100721);
            end;
    end;
    ///<summary>
    /// Procedimiento cuando el numero supera 10
    /// </summary>
    /// <param name="Tens">Recibe los multiplos de 10</param>
    /// <param name="Masc">Recibe y valida si sobrepasa 10</param>
    /// <param name="Units">Recibe la cantidad</param>
    procedure TextTensUnits(Tens: Integer; Units: Integer; Masc: Boolean): Text[250];
    begin
        case Tens of
            0:
                exit(TextUnits(Units, Masc));
            1:
                case Units of
                    0:
                        exit(Text1100722);
                    1:
                        exit(Text1100723);
                    2:
                        exit(Text1100724);
                    3:
                        exit(Text1100725);
                    4:
                        exit(Text1100726);
                    5:
                        exit(Text1100727);
                    else
                        exit(Text1100728 + TextUnits(Units, Masc));
                end;
            2:
                if Units = 0 then
                    exit(Text1100729)
                else
                    exit(Text1100730 + TextUnits(Units, Masc));
            3:
                if Units = 0 then
                    exit(Text1100731)
                else
                    exit(Text1100732 + TextUnits(Units, Masc));
            4:
                if Units = 0 then
                    exit(Text1100733)
                else
                    exit(Text1100734 + TextUnits(Units, Masc));
            5:
                if Units = 0 then
                    exit(Text1100735)
                else
                    exit(Text1100736 + TextUnits(Units, Masc));
            6:
                if Units = 0 then
                    exit(Text1100737)
                else
                    exit(Text1100738 + TextUnits(Units, Masc));
            7:
                if Units = 0 then
                    exit(Text1100739)
                else
                    exit(Text1100740 + TextUnits(Units, Masc));
            8:
                if Units = 0 then
                    exit(Text1100741)
                else
                    exit(Text1100742 + TextUnits(Units, Masc));
            9:
                if Units = 0 then
                    exit(Text1100743)
                else
                    exit(Text1100744 + TextUnits(Units, Masc));
        end;
    end;
    ///<summary>
    /// Procedimiento valida las unidades
    /// </summary>
    /// <param name="Masc">Recibe y valida las unidades individuales</param>
    /// <param name="Units">Recibe la cantidad</param>
    procedure TextUnits(Units: Integer; Masc: Boolean): Text[250];
    begin
        case Units of
            0:
                exit('');
            1:
                if Masc then
                    exit(Text1100745)
                else
                    exit(Text1100746);
            2:
                exit(Text1100747);
            3:
                exit(Text1100748);
            4:
                exit(Text1100749);
            5:
                exit(Text1100750);
            6:
                exit(Text1100751);
            7:
                exit(Text1100752);
            8:
                exit(Text1100753);
            9:
                exit(Text1100754);
        end;
    end;

    var
        Text1100700: Label '<decimals>';
        Text1100701: Label 'MILLONES ';
        Text1100702: Label 'UN MILLÓN ';
        Text1100703: Label 'MIL ';
        Text1100704: Label 'CIEN ';
        Text1100705: Label 'CIENTO ';
        Text1100706: Label 'DOSCIENTOS ';
        Text1100707: Label 'TRESCIENTOS ';
        Text1100708: Label 'CUATROCIENTOS ';
        Text1100709: Label 'QUINIENTOS ';
        Text1100710: Label 'SEISCIENTOS ';
        Text1100711: Label 'SETECIENTOS ';
        Text1100712: Label 'OCHOCIENTOS ';
        Text1100713: Label 'NOVECIENTOS ';
        Text1100714: Label 'DOSCIENTOS ';
        Text1100715: Label 'TRESCIENTOS ';
        Text1100716: Label 'CUATROCIENTOS ';
        Text1100717: Label 'QUINIENTOS ';
        Text1100718: Label 'SEISCIENTOS ';
        Text1100719: Label 'SETECIENTOS ';
        Text1100720: Label 'OCHOCIENTOS ';
        Text1100721: Label 'NOVECIENTOS ';
        Text1100722: Label 'DIEZ ';
        Text1100723: Label 'ONCE ';
        Text1100724: Label 'DOCE ';
        Text1100725: Label 'TRECE ';
        Text1100726: Label 'CATORCE ';
        Text1100727: Label 'QUINCE ';
        Text1100728: Label 'DIECI';
        Text1100729: Label 'VEINTE ';
        Text1100730: Label 'VEINTI';
        Text1100731: Label 'TREINTA ';
        Text1100732: Label 'TREINTA Y ';
        Text1100733: Label 'CUARENTA ';
        Text1100734: Label 'CUARENTA Y ';
        Text1100735: Label 'CINCUENTA ';
        Text1100736: Label 'CINCUENTA Y ';
        Text1100737: Label 'SESENTA ';
        Text1100738: Label 'SESENTA Y ';
        Text1100739: Label 'SETENTA ';
        Text1100740: Label 'SETENTA Y ';
        Text1100741: Label 'OCHENTA ';
        Text1100742: Label 'OCHENTA Y ';
        Text1100743: Label 'NOVENTA ';
        Text1100744: Label 'NOVENTA Y ';
        Text1100745: Label 'UN ';
        Text1100746: Label 'UNO ';
        Text1100747: Label 'DOS ';
        Text1100748: Label 'TRES ';
        Text1100749: Label 'CUATRO ';
        Text1100750: Label 'CINCO ';
        Text1100751: Label 'SEIS ';
        Text1100752: Label 'SIETE ';
        Text1100753: Label 'OCHO ';
        Text1100754: Label 'NUEVE ';
        Text1100755: Label 'CENTAVOS';
        Text1100756: Label 'CENTAVOS';
        Text1100757: Label 'MILSIMAS';
        Text1100758: Label 'DIEZMILSIMAS';
        Text1100759: Label 'CÉNTIMO';
        Text1100760: Label 'CÉNTIMO';
        Text1100761: Label 'MILSIMA';
        Text1100762: Label 'DIEZMILSIMA';
        Text1100768: Label '%1 is too big to be text-formatted';
        Text1100765: Label 'CERO';
        Text1100767: Label 'CON ';
        Remainder: Integer;
        HundMilion: Integer;
        TenMilion: Integer;
        UnitsMilion: Integer;
        HundThousands: Integer;
        TenThousands: Integer;
        UnitsThousands: Integer;
        Hundreds: Integer;
        Tens: Integer;
        Units: Integer;
        DecimalPlaces: Integer;
        DecimalText: array[2] of Text[500];
        DecimalString: Text[15];
        Decimals: Integer;
        Text1100764: Label '%1 \results in a written number which is too long.';
}