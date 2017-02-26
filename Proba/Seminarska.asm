
_greska:

;Seminarska.c,35 :: 		void greska(){
;Seminarska.c,36 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,37 :: 		Lcd_Out(1,1, "Greshka");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,38 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_greska0:
	DECFSZ     R13+0, 1
	GOTO       L_greska0
	DECFSZ     R12+0, 1
	GOTO       L_greska0
	NOP
;Seminarska.c,39 :: 		oldState=kp=0;
	CLRF       _kp+0
	CLRF       _oldState+0
;Seminarska.c,40 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,41 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,42 :: 		flagPlus = 0;
	CLRF       _flagPlus+0
;Seminarska.c,43 :: 		flag3 = 0;
	CLRF       _flag3+0
;Seminarska.c,44 :: 		}
L_end_greska:
	RETURN
; end of _greska

_clear:

;Seminarska.c,46 :: 		void clear(){
;Seminarska.c,47 :: 		oldState=kp=0;
	CLRF       _kp+0
	CLRF       _oldState+0
;Seminarska.c,48 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,49 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,50 :: 		flagPlus = 0;
	CLRF       _flagPlus+0
;Seminarska.c,51 :: 		flag3 = 0;
	CLRF       _flag3+0
;Seminarska.c,52 :: 		}
L_end_clear:
	RETURN
; end of _clear

_main:

;Seminarska.c,54 :: 		void main() {
;Seminarska.c,55 :: 		Keypad_Init();
	CALL       _Keypad_Init+0
;Seminarska.c,56 :: 		ANSEL = 0x80;
	MOVLW      128
	MOVWF      ANSEL+0
;Seminarska.c,57 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Seminarska.c,58 :: 		TRISA = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;Seminarska.c,59 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Seminarska.c,60 :: 		Lcd_Cmd(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,61 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,62 :: 		ADC_Init();
	CALL       _ADC_Init+0
;Seminarska.c,63 :: 		typeUser = ADC_Read(7);
	MOVLW      7
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _typeUser+0
;Seminarska.c,64 :: 		WordToStr(typeUser, txt);
	MOVF       R0+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVLW      0
	BTFSC      FARG_WordToStr_input+0, 7
	MOVLW      255
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Seminarska.c,65 :: 		Lcd_Out(1,1, txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,67 :: 		C1ON_bit = 0;
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;Seminarska.c,68 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;Seminarska.c,69 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Seminarska.c,70 :: 		Delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	NOP
	NOP
;Seminarska.c,72 :: 		while(1){
L_main2:
;Seminarska.c,73 :: 		if(typeUser == 0){
	MOVF       _typeUser+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;Seminarska.c,74 :: 		do
L_main5:
;Seminarska.c,76 :: 		Lcd_Cmd(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,77 :: 		Lcd_Out(1,1, "Vnesi");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,78 :: 		if(kp != 43 && kp != 45 && kp != 46 && kp != 47)
	MOVF       _kp+0, 0
	XORLW      43
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _kp+0, 0
	XORLW      45
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _kp+0, 0
	XORLW      46
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _kp+0, 0
	XORLW      47
	BTFSC      STATUS+0, 2
	GOTO       L_main10
L__main138:
;Seminarska.c,79 :: 		oldState = kp;
	MOVF       _kp+0, 0
	MOVWF      _oldState+0
L_main10:
;Seminarska.c,80 :: 		kp = 0;
	CLRF       _kp+0
;Seminarska.c,81 :: 		do{
L_main11:
;Seminarska.c,82 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;Seminarska.c,83 :: 		typeUser = ADC_Read(7);
	MOVLW      7
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _typeUser+0
;Seminarska.c,84 :: 		if(typeUser != 0){
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
;Seminarska.c,85 :: 		break;
	GOTO       L_main12
;Seminarska.c,86 :: 		}
L_main14:
;Seminarska.c,87 :: 		}while (!kp);
	MOVF       _kp+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main11
L_main12:
;Seminarska.c,88 :: 		if(typeUser != 0){
	MOVF       _typeUser+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main15
;Seminarska.c,89 :: 		break;
	GOTO       L_main6
;Seminarska.c,90 :: 		}
L_main15:
;Seminarska.c,91 :: 		switch (kp)
	GOTO       L_main16
;Seminarska.c,93 :: 		case 1: kp = 49; break; // 1
L_main18:
	MOVLW      49
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,94 :: 		case 2: kp = 52; break; // 4
L_main19:
	MOVLW      52
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,95 :: 		case 3: kp = 55; break; // 7
L_main20:
	MOVLW      55
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,96 :: 		case 4: kp = 74; break; // J
L_main21:
	MOVLW      74
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,97 :: 		case 5: kp = 50; break; // 2
L_main22:
	MOVLW      50
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,98 :: 		case 6: kp = 53; break; // 5
L_main23:
	MOVLW      53
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,99 :: 		case 7: kp = 56; break; // 8
L_main24:
	MOVLW      56
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,100 :: 		case 8: kp = 48; break; // 0
L_main25:
	MOVLW      48
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,101 :: 		case 9: kp = 51; break; // 3
L_main26:
	MOVLW      51
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,102 :: 		case 10: kp = 54; break; // 6
L_main27:
	MOVLW      54
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,103 :: 		case 11: kp = 57; break; // 9
L_main28:
	MOVLW      57
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,104 :: 		case 12: kp = 76; break; // L
L_main29:
	MOVLW      76
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,105 :: 		case 13: kp = 43; break; // +
L_main30:
	MOVLW      43
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,106 :: 		case 14: kp = 45; break; // Time
L_main31:
	MOVLW      45
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,107 :: 		case 15: kp = 46; break; // Add
L_main32:
	MOVLW      46
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,108 :: 		case 16: kp = 47; break; // Erase
L_main33:
	MOVLW      47
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,109 :: 		}
L_main16:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main20
	MOVF       _kp+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main22
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main23
	MOVF       _kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	MOVF       _kp+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_main25
	MOVF       _kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main26
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main27
	MOVF       _kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_main28
	MOVF       _kp+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	MOVF       _kp+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main30
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main31
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main32
	MOVF       _kp+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_main33
L_main17:
;Seminarska.c,111 :: 		if(oldState == 0){
	MOVF       _oldState+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main34
;Seminarska.c,112 :: 		if(kp == 43 || kp == 45 || kp == 46 || kp == 47){
	MOVF       _kp+0, 0
	XORLW      43
	BTFSC      STATUS+0, 2
	GOTO       L__main137
	MOVF       _kp+0, 0
	XORLW      45
	BTFSC      STATUS+0, 2
	GOTO       L__main137
	MOVF       _kp+0, 0
	XORLW      46
	BTFSC      STATUS+0, 2
	GOTO       L__main137
	MOVF       _kp+0, 0
	XORLW      47
	BTFSC      STATUS+0, 2
	GOTO       L__main137
	GOTO       L_main37
L__main137:
;Seminarska.c,113 :: 		greska();
	CALL       _greska+0
;Seminarska.c,114 :: 		}
L_main37:
;Seminarska.c,115 :: 		}
L_main34:
;Seminarska.c,117 :: 		if(kp == 43){// +
	MOVF       _kp+0, 0
	XORLW      43
	BTFSS      STATUS+0, 2
	GOTO       L_main38
;Seminarska.c,118 :: 		flagPlus = 1;
	MOVLW      1
	MOVWF      _flagPlus+0
;Seminarska.c,119 :: 		switch (oldstate)
	GOTO       L_main39
;Seminarska.c,121 :: 		case 49: oldState = 65; break; // A
L_main41:
	MOVLW      65
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,122 :: 		case 52: oldState = 68; break; // D
L_main42:
	MOVLW      68
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,123 :: 		case 55: oldState = 71; break; // G
L_main43:
	MOVLW      71
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,124 :: 		case 74: oldState = 86; break; // V
L_main44:
	MOVLW      86
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,125 :: 		case 50: oldState = 66; break; // B
L_main45:
	MOVLW      66
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,126 :: 		case 53: oldState = 69; break; // E
L_main46:
	MOVLW      69
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,127 :: 		case 56: oldState = 72; break; // H
L_main47:
	MOVLW      72
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,128 :: 		case 48: oldState = 75; break; // K
L_main48:
	MOVLW      75
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,129 :: 		case 51: oldState = 67; break; // C
L_main49:
	MOVLW      67
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,130 :: 		case 54: oldState = 70; break; // F
L_main50:
	MOVLW      70
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,131 :: 		case 57: oldState = 73; break; // I
L_main51:
	MOVLW      73
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,132 :: 		case 76: oldState = 89; break; // Y
L_main52:
	MOVLW      89
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,134 :: 		case 65: oldState = 77; break; // M
L_main53:
	MOVLW      77
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,135 :: 		case 68: oldState = 80; break; // P
L_main54:
	MOVLW      80
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,136 :: 		case 71: oldState = 83; break; // S
L_main55:
	MOVLW      83
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,137 :: 		case 86: oldState = 87; break; // W
L_main56:
	MOVLW      87
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,138 :: 		case 66: oldState = 78; break; // N
L_main57:
	MOVLW      78
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,139 :: 		case 69: oldState = 81; break; // Q
L_main58:
	MOVLW      81
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,140 :: 		case 72: oldState = 84; break; // T
L_main59:
	MOVLW      84
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,141 :: 		case 75: oldState = 88; break; // X
L_main60:
	MOVLW      88
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,142 :: 		case 67: oldState = 79; break; // O
L_main61:
	MOVLW      79
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,143 :: 		case 70: oldState = 82; break; // R
L_main62:
	MOVLW      82
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,144 :: 		case 73: oldState = 85; break; // U
L_main63:
	MOVLW      85
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,145 :: 		case 89: oldState = 90; break; // Z
L_main64:
	MOVLW      90
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,146 :: 		default: flag3 = 1;
L_main65:
	MOVLW      1
	MOVWF      _flag3+0
;Seminarska.c,147 :: 		}
	GOTO       L_main40
L_main39:
	MOVF       _oldState+0, 0
	XORLW      49
	BTFSC      STATUS+0, 2
	GOTO       L_main41
	MOVF       _oldState+0, 0
	XORLW      52
	BTFSC      STATUS+0, 2
	GOTO       L_main42
	MOVF       _oldState+0, 0
	XORLW      55
	BTFSC      STATUS+0, 2
	GOTO       L_main43
	MOVF       _oldState+0, 0
	XORLW      74
	BTFSC      STATUS+0, 2
	GOTO       L_main44
	MOVF       _oldState+0, 0
	XORLW      50
	BTFSC      STATUS+0, 2
	GOTO       L_main45
	MOVF       _oldState+0, 0
	XORLW      53
	BTFSC      STATUS+0, 2
	GOTO       L_main46
	MOVF       _oldState+0, 0
	XORLW      56
	BTFSC      STATUS+0, 2
	GOTO       L_main47
	MOVF       _oldState+0, 0
	XORLW      48
	BTFSC      STATUS+0, 2
	GOTO       L_main48
	MOVF       _oldState+0, 0
	XORLW      51
	BTFSC      STATUS+0, 2
	GOTO       L_main49
	MOVF       _oldState+0, 0
	XORLW      54
	BTFSC      STATUS+0, 2
	GOTO       L_main50
	MOVF       _oldState+0, 0
	XORLW      57
	BTFSC      STATUS+0, 2
	GOTO       L_main51
	MOVF       _oldState+0, 0
	XORLW      76
	BTFSC      STATUS+0, 2
	GOTO       L_main52
	MOVF       _oldState+0, 0
	XORLW      65
	BTFSC      STATUS+0, 2
	GOTO       L_main53
	MOVF       _oldState+0, 0
	XORLW      68
	BTFSC      STATUS+0, 2
	GOTO       L_main54
	MOVF       _oldState+0, 0
	XORLW      71
	BTFSC      STATUS+0, 2
	GOTO       L_main55
	MOVF       _oldState+0, 0
	XORLW      86
	BTFSC      STATUS+0, 2
	GOTO       L_main56
	MOVF       _oldState+0, 0
	XORLW      66
	BTFSC      STATUS+0, 2
	GOTO       L_main57
	MOVF       _oldState+0, 0
	XORLW      69
	BTFSC      STATUS+0, 2
	GOTO       L_main58
	MOVF       _oldState+0, 0
	XORLW      72
	BTFSC      STATUS+0, 2
	GOTO       L_main59
	MOVF       _oldState+0, 0
	XORLW      75
	BTFSC      STATUS+0, 2
	GOTO       L_main60
	MOVF       _oldState+0, 0
	XORLW      67
	BTFSC      STATUS+0, 2
	GOTO       L_main61
	MOVF       _oldState+0, 0
	XORLW      70
	BTFSC      STATUS+0, 2
	GOTO       L_main62
	MOVF       _oldState+0, 0
	XORLW      73
	BTFSC      STATUS+0, 2
	GOTO       L_main63
	MOVF       _oldState+0, 0
	XORLW      89
	BTFSC      STATUS+0, 2
	GOTO       L_main64
	GOTO       L_main65
L_main40:
;Seminarska.c,148 :: 		if(flag3){
	MOVF       _flag3+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main66
;Seminarska.c,149 :: 		greska();
	CALL       _greska+0
;Seminarska.c,150 :: 		}
L_main66:
;Seminarska.c,151 :: 		}else if(kp == 45){  //Time
	GOTO       L_main67
L_main38:
	MOVF       _kp+0, 0
	XORLW      45
	BTFSS      STATUS+0, 2
	GOTO       L_main68
;Seminarska.c,152 :: 		flagTime = 1;
	MOVLW      1
	MOVWF      _flagTime+0
;Seminarska.c,153 :: 		brStanici = brStanici * 10 + (oldState - 48);
	MOVF       _brStanici+0, 0
	MOVWF      R0+0
	MOVF       _brStanici+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      48
	SUBWF      _oldState+0, 0
	MOVWF      R2+0
	CLRF       R2+1
	BTFSS      STATUS+0, 0
	DECF       R2+1, 1
	MOVF       R2+0, 0
	ADDWF      R0+0, 1
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _brStanici+0
	MOVF       R0+1, 0
	MOVWF      _brStanici+1
;Seminarska.c,154 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,155 :: 		vreme = brStanici;
	MOVF       R0+0, 0
	MOVWF      _vreme+0
;Seminarska.c,156 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,157 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,158 :: 		}else if(kp == 46){  //Add
	GOTO       L_main69
L_main68:
	MOVF       _kp+0, 0
	XORLW      46
	BTFSS      STATUS+0, 2
	GOTO       L_main70
;Seminarska.c,159 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,160 :: 		if(flagTime){           //Ako sakame da vneseme vreme
	MOVF       _flagTime+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main71
;Seminarska.c,161 :: 		brStanici = brStanici * 10 + (oldState - 48);
	MOVF       _brStanici+0, 0
	MOVWF      R0+0
	MOVF       _brStanici+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      48
	SUBWF      _oldState+0, 0
	MOVWF      R2+0
	CLRF       R2+1
	BTFSS      STATUS+0, 0
	DECF       R2+1, 1
	MOVF       R2+0, 0
	ADDWF      R0+0, 0
	MOVWF      _brStanici+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      _brStanici+1
;Seminarska.c,162 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,163 :: 		brCifri = vreme + 48;
	MOVLW      48
	ADDWF      _vreme+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _brCifri+0
;Seminarska.c,164 :: 		Lcd_Out(1,1, brCifri);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,165 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main72:
	DECFSZ     R13+0, 1
	GOTO       L_main72
	DECFSZ     R12+0, 1
	GOTO       L_main72
	NOP
;Seminarska.c,166 :: 		tmp = brStanici * 16 + 11;
	MOVLW      4
	MOVWF      R2+0
	MOVF       _brStanici+0, 0
	MOVWF      R0+0
	MOVF       _brStanici+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__main142:
	BTFSC      STATUS+0, 2
	GOTO       L__main143
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main142
L__main143:
	MOVLW      11
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	MOVWF      _tmp+1
;Seminarska.c,167 :: 		EEPROM_Write(tmp, vreme);
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _vreme+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,168 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,169 :: 		flagTime = 0;
	CLRF       _flagTime+0
;Seminarska.c,170 :: 		}else{ //Obicno vnesuvanje na avtobuska linija bez vreme
	GOTO       L_main73
L_main71:
;Seminarska.c,171 :: 		if(oldState >= 48 && oldState <= 57){
	MOVLW      48
	SUBWF      _oldState+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main76
	MOVF       _oldState+0, 0
	SUBLW      57
	BTFSS      STATUS+0, 0
	GOTO       L_main76
L__main136:
;Seminarska.c,172 :: 		brStanici = brStanici * 10 + (oldState - 48);
	MOVF       _brStanici+0, 0
	MOVWF      R0+0
	MOVF       _brStanici+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      48
	SUBWF      _oldState+0, 0
	MOVWF      R2+0
	CLRF       R2+1
	BTFSS      STATUS+0, 0
	DECF       R2+1, 1
	MOVF       R0+0, 0
	ADDWF      R2+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 1
	MOVF       R2+0, 0
	MOVWF      _brStanici+0
	MOVF       R2+1, 0
	MOVWF      _brStanici+1
;Seminarska.c,173 :: 		EEPROM_Write(brStanici * 16, brStanici);
	MOVLW      4
	MOVWF      R0+0
	MOVF       R2+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R0+0, 0
L__main144:
	BTFSC      STATUS+0, 2
	GOTO       L__main145
	RLF        FARG_EEPROM_Write_Address+0, 1
	BCF        FARG_EEPROM_Write_Address+0, 0
	ADDLW      255
	GOTO       L__main144
L__main145:
	MOVF       R2+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,174 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,175 :: 		tmp = brStanici * 16;
	MOVLW      4
	MOVWF      R0+0
	MOVF       _brStanici+0, 0
	MOVWF      _tmp+0
	MOVF       _brStanici+1, 0
	MOVWF      _tmp+1
	MOVF       R0+0, 0
L__main146:
	BTFSC      STATUS+0, 2
	GOTO       L__main147
	RLF        _tmp+0, 1
	RLF        _tmp+1, 1
	BCF        _tmp+0, 0
	ADDLW      255
	GOTO       L__main146
L__main147:
;Seminarska.c,176 :: 		for(i = 0; i < 15; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main77:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main148
	MOVLW      15
	SUBWF      _i+0, 0
L__main148:
	BTFSC      STATUS+0, 0
	GOTO       L_main78
;Seminarska.c,177 :: 		tmp += 1;
	INCF       _tmp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tmp+1, 1
;Seminarska.c,178 :: 		EEPROM_Write(tmp, linija[i]);
	MOVF       _tmp+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _linija+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,176 :: 		for(i = 0; i < 15; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,179 :: 		}
	GOTO       L_main77
L_main78:
;Seminarska.c,180 :: 		}else{
	GOTO       L_main80
L_main76:
;Seminarska.c,181 :: 		greska();
	CALL       _greska+0
;Seminarska.c,182 :: 		}
L_main80:
;Seminarska.c,183 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,184 :: 		clear();
	CALL       _clear+0
;Seminarska.c,185 :: 		}
L_main73:
;Seminarska.c,186 :: 		}else if(kp == 47){  //Erase
	GOTO       L_main81
L_main70:
	MOVF       _kp+0, 0
	XORLW      47
	BTFSS      STATUS+0, 2
	GOTO       L_main82
;Seminarska.c,187 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,188 :: 		temp = brStanici * 16;
	MOVLW      4
	MOVWF      R0+0
	MOVF       _brStanici+0, 0
	MOVWF      _temp+0
	MOVF       _brStanici+1, 0
	MOVWF      _temp+1
	MOVF       R0+0, 0
L__main149:
	BTFSC      STATUS+0, 2
	GOTO       L__main150
	RLF        _temp+0, 1
	RLF        _temp+1, 1
	BCF        _temp+0, 0
	ADDLW      255
	GOTO       L__main149
L__main150:
;Seminarska.c,189 :: 		for(i = 0; i < 15; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main83:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main151
	MOVLW      15
	SUBWF      _i+0, 0
L__main151:
	BTFSC      STATUS+0, 0
	GOTO       L_main84
;Seminarska.c,190 :: 		EEPROM_Write(temp, 0);
	MOVF       _temp+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	CLRF       FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,191 :: 		temp +=1;
	INCF       _temp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _temp+1, 1
;Seminarska.c,189 :: 		for(i = 0; i < 15; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,192 :: 		}
	GOTO       L_main83
L_main84:
;Seminarska.c,193 :: 		}else{
	GOTO       L_main86
L_main82:
;Seminarska.c,194 :: 		if(flagPlus){  //Ako stisneme +
	MOVF       _flagPlus+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main87
;Seminarska.c,195 :: 		linija[pomestuvanje] = oldState;
	MOVF       _pomestuvanje+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _linija+0
	MOVWF      FSR
	MOVF       _oldState+0, 0
	MOVWF      INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
;Seminarska.c,196 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,197 :: 		pomestuvanje++;
	INCF       _pomestuvanje+0, 1
;Seminarska.c,198 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,199 :: 		flagPlus = 0;
	CLRF       _flagPlus+0
;Seminarska.c,200 :: 		}else if(oldState == 76 || oldState == 74){ // J ili L
	GOTO       L_main88
L_main87:
	MOVF       _oldState+0, 0
	XORLW      76
	BTFSC      STATUS+0, 2
	GOTO       L__main135
	MOVF       _oldState+0, 0
	XORLW      74
	BTFSC      STATUS+0, 2
	GOTO       L__main135
	GOTO       L_main91
L__main135:
;Seminarska.c,201 :: 		linija[pomestuvanje] = oldState;
	MOVF       _pomestuvanje+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _linija+0
	MOVWF      FSR
	MOVF       _oldState+0, 0
	MOVWF      INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
;Seminarska.c,202 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,203 :: 		pomestuvanje++;
	INCF       _pomestuvanje+0, 1
;Seminarska.c,204 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,205 :: 		Lcd_Out(1,1, "J ili L");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,206 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,207 :: 		}else{
	GOTO       L_main92
L_main91:
;Seminarska.c,208 :: 		if(oldState >= 48 && oldState <= 57){   // Ako e vnesena brojka
	MOVLW      48
	SUBWF      _oldState+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main95
	MOVF       _oldState+0, 0
	SUBLW      57
	BTFSS      STATUS+0, 0
	GOTO       L_main95
L__main134:
;Seminarska.c,209 :: 		brStanici = brStanici * 10 + (oldState - 48);
	MOVF       _brStanici+0, 0
	MOVWF      R0+0
	MOVF       _brStanici+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      48
	SUBWF      _oldState+0, 0
	MOVWF      R2+0
	CLRF       R2+1
	BTFSS      STATUS+0, 0
	DECF       R2+1, 1
	MOVF       R2+0, 0
	ADDWF      R0+0, 0
	MOVWF      _brStanici+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      _brStanici+1
;Seminarska.c,210 :: 		Lcd_Out(1,1, "Vnesena Brojka");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,211 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main96:
	DECFSZ     R13+0, 1
	GOTO       L_main96
	DECFSZ     R12+0, 1
	GOTO       L_main96
	NOP
;Seminarska.c,212 :: 		}
L_main95:
;Seminarska.c,213 :: 		}
L_main92:
L_main88:
;Seminarska.c,214 :: 		}
L_main86:
L_main81:
L_main69:
L_main67:
;Seminarska.c,215 :: 		}while(1);
	GOTO       L_main5
L_main6:
;Seminarska.c,216 :: 		}else{
	GOTO       L_main97
L_main4:
;Seminarska.c,217 :: 		i = 0;
	CLRF       _i+0
	CLRF       _i+1
;Seminarska.c,218 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,219 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,220 :: 		Lcd_Out(1,1, "Korisnicki");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,221 :: 		strcpy(txt, "GET TIME");
	MOVLW      _txt+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr6_Seminarska+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Seminarska.c,222 :: 		while(1){
L_main98:
;Seminarska.c,223 :: 		if (UART1_Data_Ready()) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main100
;Seminarska.c,224 :: 		if(!flag){
	MOVF       _flag+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main101
;Seminarska.c,225 :: 		uart_rd = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;Seminarska.c,226 :: 		if(uart_rd == txt[i]){
	MOVF       _i+0, 0
	ADDLW      _txt+0
	MOVWF      FSR
	MOVF       R0+0, 0
	XORWF      INDF+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main102
;Seminarska.c,227 :: 		i++;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,228 :: 		}else{
	GOTO       L_main103
L_main102:
;Seminarska.c,229 :: 		i = 0;
	CLRF       _i+0
	CLRF       _i+1
;Seminarska.c,230 :: 		}
L_main103:
;Seminarska.c,231 :: 		if(i == 8){
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main152
	MOVLW      8
	XORWF      _i+0, 0
L__main152:
	BTFSS      STATUS+0, 2
	GOTO       L_main104
;Seminarska.c,232 :: 		flag = 1;
	MOVLW      1
	MOVWF      _flag+0
;Seminarska.c,233 :: 		}
L_main104:
;Seminarska.c,234 :: 		}else{
	GOTO       L_main105
L_main101:
;Seminarska.c,235 :: 		uart_rd = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;Seminarska.c,236 :: 		if(uart_rd == 58){
	MOVF       R0+0, 0
	XORLW      58
	BTFSS      STATUS+0, 2
	GOTO       L_main106
;Seminarska.c,237 :: 		flagDveTocki = 1;
	MOVLW      1
	MOVWF      _flagDveTocki+0
;Seminarska.c,238 :: 		continue;
	GOTO       L_main98
;Seminarska.c,239 :: 		}else if(flagDveTocki == 0){
L_main106:
	MOVF       _flagDveTocki+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main108
;Seminarska.c,240 :: 		saati = saati * 10 + (uart_rd - 48);
	MOVF       _saati+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVLW      48
	SUBWF      _uart_rd+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	ADDWF      R0+0, 0
	MOVWF      _saati+0
;Seminarska.c,241 :: 		}else{
	GOTO       L_main109
L_main108:
;Seminarska.c,242 :: 		minuti = minuti * 10 + (uart_rd - 48);
	MOVF       _minuti+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVLW      48
	SUBWF      _uart_rd+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	ADDWF      R0+0, 0
	MOVWF      _minuti+0
;Seminarska.c,243 :: 		brCifri++;
	INCF       _brCifri+0, 1
;Seminarska.c,244 :: 		if(brCifri == 2){
	MOVF       _brCifri+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main110
;Seminarska.c,245 :: 		saati *= 60;
	MOVF       _saati+0, 0
	MOVWF      R0+0
	MOVLW      60
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      _saati+0
;Seminarska.c,246 :: 		minuti += saati;
	MOVF       R0+0, 0
	ADDWF      _minuti+0, 1
;Seminarska.c,247 :: 		break;
	GOTO       L_main99
;Seminarska.c,248 :: 		}
L_main110:
;Seminarska.c,249 :: 		}
L_main109:
;Seminarska.c,250 :: 		}
L_main105:
;Seminarska.c,251 :: 		}
L_main100:
;Seminarska.c,252 :: 		}
	GOTO       L_main98
L_main99:
;Seminarska.c,254 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;Seminarska.c,255 :: 		for(i=0;i<16;i++) {
	CLRF       _i+0
	CLRF       _i+1
L_main111:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main153
	MOVLW      16
	SUBWF      _i+0, 0
L__main153:
	BTFSC      STATUS+0, 0
	GOTO       L_main112
;Seminarska.c,256 :: 		tmp = i*16;
	MOVLW      4
	MOVWF      R2+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__main154:
	BTFSC      STATUS+0, 2
	GOTO       L__main155
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main154
L__main155:
	MOVF       R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	MOVWF      _tmp+1
;Seminarska.c,257 :: 		tmp += 11;
	MOVLW      11
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	MOVWF      _tmp+1
;Seminarska.c,258 :: 		vreme=EEPROM_Read(tmp);
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _vreme+0
;Seminarska.c,259 :: 		if(vreme>minuti) {
	MOVLW      128
	XORWF      _minuti+0, 0
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main114
;Seminarska.c,260 :: 		razlika=vreme-minuti;
	MOVF       _minuti+0, 0
	SUBWF      _vreme+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _razlika+0
;Seminarska.c,261 :: 		if(razlika<min1Time) {
	MOVLW      128
	XORWF      R1+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _min1Time+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main115
;Seminarska.c,262 :: 		min2Time=min1Time;
	MOVF       _min1Time+0, 0
	MOVWF      _min2Time+0
;Seminarska.c,263 :: 		min1Time=razlika;
	MOVF       _razlika+0, 0
	MOVWF      _min1Time+0
;Seminarska.c,264 :: 		min2Stanica=min1Stanica;
	MOVF       _min1Stanica+0, 0
	MOVWF      _min2Stanica+0
;Seminarska.c,265 :: 		min1Stanica=EEPROM_Read(i*16);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main156:
	BTFSC      STATUS+0, 2
	GOTO       L__main157
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main156
L__main157:
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _min1Stanica+0
;Seminarska.c,266 :: 		}
	GOTO       L_main116
L_main115:
;Seminarska.c,267 :: 		else if(razlika<min2Time && razlika!=min1Time) {
	MOVLW      128
	XORWF      _razlika+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _min2Time+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main119
	MOVF       _razlika+0, 0
	XORWF      _min1Time+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main119
L__main133:
;Seminarska.c,268 :: 		min2Time=razlika;
	MOVF       _razlika+0, 0
	MOVWF      _min2Time+0
;Seminarska.c,269 :: 		min2Stanica=EEPROM_Read(i*16);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main158:
	BTFSC      STATUS+0, 2
	GOTO       L__main159
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main158
L__main159:
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _min2Stanica+0
;Seminarska.c,270 :: 		}
L_main119:
L_main116:
;Seminarska.c,271 :: 		}
L_main114:
;Seminarska.c,255 :: 		for(i=0;i<16;i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,272 :: 		}
	GOTO       L_main111
L_main112:
;Seminarska.c,274 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,275 :: 		Lcd_Out(1,1, txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,276 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;Seminarska.c,277 :: 		for(i=0;i<16;i++) {
	CLRF       _i+0
	CLRF       _i+1
L_main120:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main160
	MOVLW      16
	SUBWF      _i+0, 0
L__main160:
	BTFSC      STATUS+0, 0
	GOTO       L_main121
;Seminarska.c,278 :: 		stanica=EEPROM_Read(i*16);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main161:
	BTFSC      STATUS+0, 2
	GOTO       L__main162
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main161
L__main162:
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _stanica+0
;Seminarska.c,279 :: 		if(stanica==min1Stanica) {
	MOVF       R0+0, 0
	XORWF      _min1Stanica+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main123
;Seminarska.c,280 :: 		Lcd_Out(1,1,stanica);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _stanica+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,281 :: 		Lcd_Out_Cp(" ");
	MOVLW      ?lstr7_Seminarska+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;Seminarska.c,282 :: 		j=0;
	CLRF       _j+0
;Seminarska.c,283 :: 		for(j=1;j<=10;j++) {
	MOVLW      1
	MOVWF      _j+0
L_main124:
	MOVLW      128
	XORLW      10
	MOVWF      R0+0
	MOVLW      128
	XORWF      _j+0, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main125
;Seminarska.c,284 :: 		citaj=EEPROM_Read(i*16+j);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main163:
	BTFSC      STATUS+0, 2
	GOTO       L__main164
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main163
L__main164:
	MOVF       _j+0, 0
	ADDWF      FARG_EEPROM_Read_Address+0, 1
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _citaj+0
;Seminarska.c,285 :: 		Lcd_Out_Cp(citaj);
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;Seminarska.c,283 :: 		for(j=1;j<=10;j++) {
	INCF       _j+0, 1
;Seminarska.c,286 :: 		}
	GOTO       L_main124
L_main125:
;Seminarska.c,287 :: 		vreme=EEPROM_Read(i*16+11);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main165:
	BTFSC      STATUS+0, 2
	GOTO       L__main166
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main165
L__main166:
	MOVLW      11
	ADDWF      FARG_EEPROM_Read_Address+0, 1
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _vreme+0
;Seminarska.c,288 :: 		razlika=vreme-minuti;
	MOVF       _minuti+0, 0
	SUBWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      _razlika+0
;Seminarska.c,289 :: 		Lcd_Out_Cp(razlika);
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;Seminarska.c,290 :: 		Lcd_Out_Cp("Min");
	MOVLW      ?lstr8_Seminarska+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;Seminarska.c,291 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main127:
	DECFSZ     R13+0, 1
	GOTO       L_main127
	DECFSZ     R12+0, 1
	GOTO       L_main127
	NOP
;Seminarska.c,292 :: 		}
L_main123:
;Seminarska.c,293 :: 		if(stanica==min2Stanica) {
	MOVF       _stanica+0, 0
	XORWF      _min2Stanica+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main128
;Seminarska.c,294 :: 		Lcd_Out(2,1,stanica);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _stanica+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,295 :: 		Lcd_Out_Cp(" ");
	MOVLW      ?lstr9_Seminarska+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;Seminarska.c,296 :: 		j=0;
	CLRF       _j+0
;Seminarska.c,297 :: 		for(j=1;j <= 10;j++) {
	MOVLW      1
	MOVWF      _j+0
L_main129:
	MOVLW      128
	XORLW      10
	MOVWF      R0+0
	MOVLW      128
	XORWF      _j+0, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main130
;Seminarska.c,298 :: 		citaj=EEPROM_Read(i*16+j);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main167:
	BTFSC      STATUS+0, 2
	GOTO       L__main168
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main167
L__main168:
	MOVF       _j+0, 0
	ADDWF      FARG_EEPROM_Read_Address+0, 1
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _citaj+0
;Seminarska.c,299 :: 		Lcd_Out_Cp(citaj);
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;Seminarska.c,297 :: 		for(j=1;j <= 10;j++) {
	INCF       _j+0, 1
;Seminarska.c,300 :: 		}
	GOTO       L_main129
L_main130:
;Seminarska.c,301 :: 		vreme=EEPROM_Read(i*16+11);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main169:
	BTFSC      STATUS+0, 2
	GOTO       L__main170
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main169
L__main170:
	MOVLW      11
	ADDWF      FARG_EEPROM_Read_Address+0, 1
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _vreme+0
;Seminarska.c,302 :: 		razlika=vreme-minuti;
	MOVF       _minuti+0, 0
	SUBWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      _razlika+0
;Seminarska.c,303 :: 		Lcd_Out_Cp(razlika);
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;Seminarska.c,304 :: 		Lcd_Out_Cp("Min");
	MOVLW      ?lstr10_Seminarska+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;Seminarska.c,305 :: 		}
L_main128:
;Seminarska.c,277 :: 		for(i=0;i<16;i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,306 :: 		}
	GOTO       L_main120
L_main121:
;Seminarska.c,307 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main132:
	DECFSZ     R13+0, 1
	GOTO       L_main132
	DECFSZ     R12+0, 1
	GOTO       L_main132
	NOP
;Seminarska.c,308 :: 		}
L_main97:
;Seminarska.c,309 :: 		}
	GOTO       L_main2
;Seminarska.c,310 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
