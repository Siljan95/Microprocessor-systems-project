
_stavi:

;Seminarska.c,41 :: 		void stavi(char neso){
;Seminarska.c,42 :: 		strncpy(print,neso,pomestuvanje);
	MOVLW      _print+0
	MOVWF      FARG_strncpy_to+0
	MOVF       FARG_stavi_neso+0, 0
	MOVWF      FARG_strncpy_from+0
	MOVF       _pomestuvanje+0, 0
	MOVWF      FARG_strncpy_size+0
	MOVLW      0
	BTFSC      FARG_strncpy_size+0, 7
	MOVLW      255
	MOVWF      FARG_strncpy_size+1
	CALL       _strncpy+0
;Seminarska.c,43 :: 		pomestuvanje++;
	INCF       _pomestuvanje+0, 1
;Seminarska.c,44 :: 		}
L_end_stavi:
	RETURN
; end of _stavi

_greska:

;Seminarska.c,46 :: 		void greska(){
;Seminarska.c,47 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,48 :: 		Lcd_Out(1,1, "Greshka");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,49 :: 		Delay_ms(10);
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
;Seminarska.c,50 :: 		oldState=kp=0;
	CLRF       _kp+0
	CLRF       _oldState+0
;Seminarska.c,51 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,52 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,53 :: 		flagPlus = 0;
	CLRF       _flagPlus+0
;Seminarska.c,54 :: 		flag3 = 0;
	CLRF       _flag3+0
;Seminarska.c,55 :: 		}
L_end_greska:
	RETURN
; end of _greska

_clear:

;Seminarska.c,57 :: 		void clear(){
;Seminarska.c,58 :: 		oldState=kp=0;
	CLRF       _kp+0
	CLRF       _oldState+0
;Seminarska.c,59 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,60 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,61 :: 		flagPlus = 0;
	CLRF       _flagPlus+0
;Seminarska.c,62 :: 		flag3 = 0;
	CLRF       _flag3+0
;Seminarska.c,63 :: 		pomestuvanje = 0;
	CLRF       _pomestuvanje+0
;Seminarska.c,64 :: 		flagTime = 0;
	CLRF       _flagTime+0
;Seminarska.c,65 :: 		}
L_end_clear:
	RETURN
; end of _clear

_main:

;Seminarska.c,67 :: 		void main() {
;Seminarska.c,68 :: 		Keypad_Init();
	CALL       _Keypad_Init+0
;Seminarska.c,69 :: 		ANSEL = 0x80;
	MOVLW      128
	MOVWF      ANSEL+0
;Seminarska.c,70 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Seminarska.c,71 :: 		TRISA = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;Seminarska.c,72 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Seminarska.c,73 :: 		Lcd_Cmd(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,74 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,75 :: 		ADC_Init();
	CALL       _ADC_Init+0
;Seminarska.c,76 :: 		typeUser = ADC_Read(7);
	MOVLW      7
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _typeUser+0
;Seminarska.c,84 :: 		C1ON_bit = 0;
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;Seminarska.c,85 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;Seminarska.c,86 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Seminarska.c,87 :: 		Delay_ms(50);
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
;Seminarska.c,89 :: 		while(1){
L_main2:
;Seminarska.c,90 :: 		if(typeUser == 1){
	MOVF       _typeUser+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;Seminarska.c,91 :: 		do
L_main5:
;Seminarska.c,93 :: 		Lcd_Cmd(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,94 :: 		Lcd_Out(1,1, "Vnesi");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,95 :: 		if(kp != 43 && kp != 45 && kp != 46 && kp != 47)
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
L__main151:
;Seminarska.c,96 :: 		oldState = kp;
	MOVF       _kp+0, 0
	MOVWF      _oldState+0
L_main10:
;Seminarska.c,97 :: 		kp = 0;
	CLRF       _kp+0
;Seminarska.c,98 :: 		do{
L_main11:
;Seminarska.c,99 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;Seminarska.c,100 :: 		typeUser = ADC_Read(7);
	MOVLW      7
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _typeUser+0
;Seminarska.c,101 :: 		if(typeUser != 0){
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
;Seminarska.c,102 :: 		break;
	GOTO       L_main12
;Seminarska.c,103 :: 		}
L_main14:
;Seminarska.c,104 :: 		}while (!kp);
	MOVF       _kp+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main11
L_main12:
;Seminarska.c,105 :: 		if(typeUser != 0){
	MOVF       _typeUser+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main15
;Seminarska.c,106 :: 		break;
	GOTO       L_main6
;Seminarska.c,107 :: 		}
L_main15:
;Seminarska.c,108 :: 		switch (kp)
	GOTO       L_main16
;Seminarska.c,110 :: 		case 1: kp = 49; break; // 1
L_main18:
	MOVLW      49
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,111 :: 		case 2: kp = 52; break; // 4
L_main19:
	MOVLW      52
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,112 :: 		case 3: kp = 55; break; // 7
L_main20:
	MOVLW      55
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,113 :: 		case 4: kp = 74; break; // J
L_main21:
	MOVLW      74
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,114 :: 		case 5: kp = 50; break; // 2
L_main22:
	MOVLW      50
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,115 :: 		case 6: kp = 53; break; // 5
L_main23:
	MOVLW      53
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,116 :: 		case 7: kp = 56; break; // 8
L_main24:
	MOVLW      56
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,117 :: 		case 8: kp = 48; break; // 0
L_main25:
	MOVLW      48
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,118 :: 		case 9: kp = 51; break; // 3
L_main26:
	MOVLW      51
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,119 :: 		case 10: kp = 54; break; // 6
L_main27:
	MOVLW      54
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,120 :: 		case 11: kp = 57; break; // 9
L_main28:
	MOVLW      57
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,121 :: 		case 12: kp = 76; break; // L
L_main29:
	MOVLW      76
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,122 :: 		case 13: kp = 43; break; // +
L_main30:
	MOVLW      43
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,123 :: 		case 14: kp = 45; break; // Time
L_main31:
	MOVLW      45
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,124 :: 		case 15: kp = 46; break; // Add
L_main32:
	MOVLW      46
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,125 :: 		case 16: kp = 47; break; // Erase
L_main33:
	MOVLW      47
	MOVWF      _kp+0
	GOTO       L_main17
;Seminarska.c,126 :: 		}
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
;Seminarska.c,128 :: 		if(oldState == 0){
	MOVF       _oldState+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main34
;Seminarska.c,129 :: 		if(kp == 43 || kp == 45 || kp == 46 || kp == 47){
	MOVF       _kp+0, 0
	XORLW      43
	BTFSC      STATUS+0, 2
	GOTO       L__main150
	MOVF       _kp+0, 0
	XORLW      45
	BTFSC      STATUS+0, 2
	GOTO       L__main150
	MOVF       _kp+0, 0
	XORLW      46
	BTFSC      STATUS+0, 2
	GOTO       L__main150
	MOVF       _kp+0, 0
	XORLW      47
	BTFSC      STATUS+0, 2
	GOTO       L__main150
	GOTO       L_main37
L__main150:
;Seminarska.c,130 :: 		greska();
	CALL       _greska+0
;Seminarska.c,131 :: 		}
L_main37:
;Seminarska.c,132 :: 		}
L_main34:
;Seminarska.c,134 :: 		if(kp == 43){// +
	MOVF       _kp+0, 0
	XORLW      43
	BTFSS      STATUS+0, 2
	GOTO       L_main38
;Seminarska.c,135 :: 		flagPlus = 1;
	MOVLW      1
	MOVWF      _flagPlus+0
;Seminarska.c,136 :: 		switch (oldstate)
	GOTO       L_main39
;Seminarska.c,138 :: 		case 49: oldState = 65; break; // A
L_main41:
	MOVLW      65
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,139 :: 		case 52: oldState = 68; break; // D
L_main42:
	MOVLW      68
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,140 :: 		case 55: oldState = 71; break; // G
L_main43:
	MOVLW      71
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,141 :: 		case 74: oldState = 86; break; // V
L_main44:
	MOVLW      86
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,142 :: 		case 50: oldState = 66; break; // B
L_main45:
	MOVLW      66
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,143 :: 		case 53: oldState = 69; break; // E
L_main46:
	MOVLW      69
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,144 :: 		case 56: oldState = 72; break; // H
L_main47:
	MOVLW      72
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,145 :: 		case 48: oldState = 75; break; // K
L_main48:
	MOVLW      75
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,146 :: 		case 51: oldState = 67; break; // C
L_main49:
	MOVLW      67
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,147 :: 		case 54: oldState = 70; break; // F
L_main50:
	MOVLW      70
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,148 :: 		case 57: oldState = 73; break; // I
L_main51:
	MOVLW      73
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,149 :: 		case 76: oldState = 89; break; // Y
L_main52:
	MOVLW      89
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,151 :: 		case 65: oldState = 77; break; // M
L_main53:
	MOVLW      77
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,152 :: 		case 68: oldState = 80; break; // P
L_main54:
	MOVLW      80
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,153 :: 		case 71: oldState = 83; break; // S
L_main55:
	MOVLW      83
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,154 :: 		case 86: oldState = 87; break; // W
L_main56:
	MOVLW      87
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,155 :: 		case 66: oldState = 78; break; // N
L_main57:
	MOVLW      78
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,156 :: 		case 69: oldState = 81; break; // Q
L_main58:
	MOVLW      81
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,157 :: 		case 72: oldState = 84; break; // T
L_main59:
	MOVLW      84
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,158 :: 		case 75: oldState = 88; break; // X
L_main60:
	MOVLW      88
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,159 :: 		case 67: oldState = 79; break; // O
L_main61:
	MOVLW      79
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,160 :: 		case 70: oldState = 82; break; // R
L_main62:
	MOVLW      82
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,161 :: 		case 73: oldState = 85; break; // U
L_main63:
	MOVLW      85
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,162 :: 		case 89: oldState = 90; break; // Z
L_main64:
	MOVLW      90
	MOVWF      _oldState+0
	GOTO       L_main40
;Seminarska.c,163 :: 		default: flag3 = 1;
L_main65:
	MOVLW      1
	MOVWF      _flag3+0
;Seminarska.c,164 :: 		}
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
;Seminarska.c,165 :: 		if(flag3){
	MOVF       _flag3+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main66
;Seminarska.c,166 :: 		greska();
	CALL       _greska+0
;Seminarska.c,167 :: 		}
L_main66:
;Seminarska.c,168 :: 		}else if(kp == 45){  //Time
	GOTO       L_main67
L_main38:
	MOVF       _kp+0, 0
	XORLW      45
	BTFSS      STATUS+0, 2
	GOTO       L_main68
;Seminarska.c,169 :: 		flagTime = 1;
	MOVLW      1
	MOVWF      _flagTime+0
;Seminarska.c,170 :: 		brStanici = brStanici * 10 + (oldState - 48);
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
;Seminarska.c,171 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,172 :: 		vreme = brStanici;
	MOVF       R0+0, 0
	MOVWF      _vreme+0
;Seminarska.c,173 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,174 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,175 :: 		}else if(kp == 46){  //Add
	GOTO       L_main69
L_main68:
	MOVF       _kp+0, 0
	XORLW      46
	BTFSS      STATUS+0, 2
	GOTO       L_main70
;Seminarska.c,176 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,177 :: 		if(flagTime){           //Ako sakame da vneseme vreme
	MOVF       _flagTime+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main71
;Seminarska.c,178 :: 		brStanici = brStanici * 10 + (oldState - 48);
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
;Seminarska.c,179 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,180 :: 		brCifri = vreme + 48;
	MOVLW      48
	ADDWF      _vreme+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _brCifri+0
;Seminarska.c,181 :: 		Lcd_Out(1,1, brCifri);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,182 :: 		Delay_ms(10);
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
;Seminarska.c,183 :: 		tmp = brStanici * 16 + 11;
	MOVLW      4
	MOVWF      R2+0
	MOVF       _brStanici+0, 0
	MOVWF      R0+0
	MOVF       _brStanici+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__main156:
	BTFSC      STATUS+0, 2
	GOTO       L__main157
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main156
L__main157:
	MOVLW      11
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	MOVWF      _tmp+1
;Seminarska.c,184 :: 		EEPROM_Write(tmp, vreme);
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _vreme+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,185 :: 		tmp += 2;
	MOVLW      2
	ADDWF      _tmp+0, 0
	MOVWF      R0+0
	MOVF       _tmp+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	MOVWF      _tmp+1
;Seminarska.c,186 :: 		EEPROM_Write(tmp, "M");
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      ?lstr_3_Seminarska+0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,187 :: 		tmp += 1;
	INCF       _tmp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tmp+1, 1
;Seminarska.c,188 :: 		EEPROM_Write(tmp, "i");
	MOVF       _tmp+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      ?lstr_4_Seminarska+0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,189 :: 		tmp += 1;
	INCF       _tmp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tmp+1, 1
;Seminarska.c,190 :: 		EEPROM_Write(tmp, "n");
	MOVF       _tmp+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      ?lstr_5_Seminarska+0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,191 :: 		clear();
	CALL       _clear+0
;Seminarska.c,192 :: 		}else{ //Obicno vnesuvanje na avtobuska linija bez vreme
	GOTO       L_main73
L_main71:
;Seminarska.c,193 :: 		if(oldState >= 48 && oldState <= 57){
	MOVLW      48
	SUBWF      _oldState+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main76
	MOVF       _oldState+0, 0
	SUBLW      57
	BTFSS      STATUS+0, 0
	GOTO       L_main76
L__main149:
;Seminarska.c,194 :: 		brStanici = brStanici * 10 + (oldState - 48);
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
;Seminarska.c,195 :: 		EEPROM_Write(brStanici * 16, brStanici);
	MOVLW      4
	MOVWF      R0+0
	MOVF       R2+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R0+0, 0
L__main158:
	BTFSC      STATUS+0, 2
	GOTO       L__main159
	RLF        FARG_EEPROM_Write_Address+0, 1
	BCF        FARG_EEPROM_Write_Address+0, 0
	ADDLW      255
	GOTO       L__main158
L__main159:
	MOVF       R2+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,196 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,197 :: 		tmp = brStanici * 16;
	MOVLW      4
	MOVWF      R0+0
	MOVF       _brStanici+0, 0
	MOVWF      _tmp+0
	MOVF       _brStanici+1, 0
	MOVWF      _tmp+1
	MOVF       R0+0, 0
L__main160:
	BTFSC      STATUS+0, 2
	GOTO       L__main161
	RLF        _tmp+0, 1
	RLF        _tmp+1, 1
	BCF        _tmp+0, 0
	ADDLW      255
	GOTO       L__main160
L__main161:
;Seminarska.c,198 :: 		for(i = 0; i < 15; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main77:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main162
	MOVLW      15
	SUBWF      _i+0, 0
L__main162:
	BTFSC      STATUS+0, 0
	GOTO       L_main78
;Seminarska.c,199 :: 		tmp += 1;
	INCF       _tmp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tmp+1, 1
;Seminarska.c,200 :: 		EEPROM_Write(tmp, linija[i]);
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
;Seminarska.c,198 :: 		for(i = 0; i < 15; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,201 :: 		}
	GOTO       L_main77
L_main78:
;Seminarska.c,202 :: 		}else{
	GOTO       L_main80
L_main76:
;Seminarska.c,203 :: 		greska();
	CALL       _greska+0
;Seminarska.c,204 :: 		}
L_main80:
;Seminarska.c,205 :: 		clear();
	CALL       _clear+0
;Seminarska.c,206 :: 		}
L_main73:
;Seminarska.c,207 :: 		}else if(kp == 47){  //Erase
	GOTO       L_main81
L_main70:
	MOVF       _kp+0, 0
	XORLW      47
	BTFSS      STATUS+0, 2
	GOTO       L_main82
;Seminarska.c,208 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,209 :: 		temp = brStanici * 16;
	MOVLW      4
	MOVWF      R0+0
	MOVF       _brStanici+0, 0
	MOVWF      _temp+0
	MOVF       _brStanici+1, 0
	MOVWF      _temp+1
	MOVF       R0+0, 0
L__main163:
	BTFSC      STATUS+0, 2
	GOTO       L__main164
	RLF        _temp+0, 1
	RLF        _temp+1, 1
	BCF        _temp+0, 0
	ADDLW      255
	GOTO       L__main163
L__main164:
;Seminarska.c,210 :: 		for(i = 0; i < 15; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main83:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main165
	MOVLW      15
	SUBWF      _i+0, 0
L__main165:
	BTFSC      STATUS+0, 0
	GOTO       L_main84
;Seminarska.c,211 :: 		EEPROM_Write(temp, 0);
	MOVF       _temp+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	CLRF       FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,212 :: 		temp +=1;
	INCF       _temp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _temp+1, 1
;Seminarska.c,210 :: 		for(i = 0; i < 15; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,213 :: 		}
	GOTO       L_main83
L_main84:
;Seminarska.c,214 :: 		}else{
	GOTO       L_main86
L_main82:
;Seminarska.c,215 :: 		if(flagPlus){  //Ako stisneme +
	MOVF       _flagPlus+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main87
;Seminarska.c,216 :: 		linija[pomestuvanje] = oldState;
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
;Seminarska.c,217 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,218 :: 		pomestuvanje++;
	INCF       _pomestuvanje+0, 1
;Seminarska.c,219 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,220 :: 		flagPlus = 0;
	CLRF       _flagPlus+0
;Seminarska.c,221 :: 		}else if(oldState == 76 || oldState == 74){ // J ili L
	GOTO       L_main88
L_main87:
	MOVF       _oldState+0, 0
	XORLW      76
	BTFSC      STATUS+0, 2
	GOTO       L__main148
	MOVF       _oldState+0, 0
	XORLW      74
	BTFSC      STATUS+0, 2
	GOTO       L__main148
	GOTO       L_main91
L__main148:
;Seminarska.c,222 :: 		linija[pomestuvanje] = oldState;
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
;Seminarska.c,223 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,224 :: 		pomestuvanje++;
	INCF       _pomestuvanje+0, 1
;Seminarska.c,225 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,226 :: 		Lcd_Out(1,1, "J ili L");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,227 :: 		}else{
	GOTO       L_main92
L_main91:
;Seminarska.c,228 :: 		if(oldState >= 48 && oldState <= 57){   // Ako e vnesena brojka
	MOVLW      48
	SUBWF      _oldState+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main95
	MOVF       _oldState+0, 0
	SUBLW      57
	BTFSS      STATUS+0, 0
	GOTO       L_main95
L__main147:
;Seminarska.c,229 :: 		brStanici = brStanici * 10 + (oldState - 48);
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
;Seminarska.c,230 :: 		Lcd_Out(1,1, "Vnesena Brojka");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,231 :: 		Delay_ms(10);
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
;Seminarska.c,232 :: 		}
L_main95:
;Seminarska.c,233 :: 		}
L_main92:
L_main88:
;Seminarska.c,234 :: 		}
L_main86:
L_main81:
L_main69:
L_main67:
;Seminarska.c,235 :: 		}while(1);
	GOTO       L_main5
L_main6:
;Seminarska.c,236 :: 		}else{
	GOTO       L_main97
L_main4:
;Seminarska.c,237 :: 		i = 0;
	CLRF       _i+0
	CLRF       _i+1
;Seminarska.c,238 :: 		flag=0;
	CLRF       _flag+0
;Seminarska.c,239 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,240 :: 		strcpy(getTime, "GET TIME");
	MOVLW      _getTime+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr8_Seminarska+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Seminarska.c,241 :: 		while(1){
L_main98:
;Seminarska.c,242 :: 		if (UART1_Data_Ready()) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main100
;Seminarska.c,243 :: 		uart_rd = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;Seminarska.c,244 :: 		porakaOdEsurat[i] = uart_rd;
	MOVF       _i+0, 0
	ADDLW      _porakaOdEsurat+0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Seminarska.c,245 :: 		i++;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,246 :: 		sporedba = strcmp(getTime,porakaOdEsurat);
	MOVLW      _getTime+0
	MOVWF      FARG_strcmp_s1+0
	MOVLW      _porakaOdEsurat+0
	MOVWF      FARG_strcmp_s2+0
	CALL       _strcmp+0
	MOVF       R0+0, 0
	MOVWF      _sporedba+0
;Seminarska.c,247 :: 		if(sporedba == 0){
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main101
;Seminarska.c,248 :: 		flag=1;
	MOVLW      1
	MOVWF      _flag+0
;Seminarska.c,249 :: 		Lcd_Out(1,1,"bREAK");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,250 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main102:
	DECFSZ     R13+0, 1
	GOTO       L_main102
	DECFSZ     R12+0, 1
	GOTO       L_main102
	NOP
;Seminarska.c,251 :: 		break;
	GOTO       L_main99
;Seminarska.c,252 :: 		}
L_main101:
;Seminarska.c,254 :: 		flag=0;
	CLRF       _flag+0
;Seminarska.c,256 :: 		}
L_main100:
;Seminarska.c,257 :: 		}
	GOTO       L_main98
L_main99:
;Seminarska.c,258 :: 		if(flag==1) {
	MOVF       _flag+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main104
;Seminarska.c,259 :: 		while(1){
L_main105:
;Seminarska.c,260 :: 		Lcd_Out(1,1,"PAJD");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,261 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main107
;Seminarska.c,262 :: 		uart_rd = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;Seminarska.c,263 :: 		if(uart_rd == 58){
	MOVF       R0+0, 0
	XORLW      58
	BTFSS      STATUS+0, 2
	GOTO       L_main108
;Seminarska.c,264 :: 		flagDveTocki = 1;
	MOVLW      1
	MOVWF      _flagDveTocki+0
;Seminarska.c,266 :: 		}else if(flagDveTocki == 0){
	GOTO       L_main109
L_main108:
	MOVF       _flagDveTocki+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main110
;Seminarska.c,267 :: 		saati = saati * 10 + (uart_rd - 48);
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
;Seminarska.c,268 :: 		}else{
	GOTO       L_main111
L_main110:
;Seminarska.c,269 :: 		minuti = minuti * 10 + (uart_rd - 48);
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
;Seminarska.c,270 :: 		brCifri++;
	INCF       _brCifri+0, 1
;Seminarska.c,271 :: 		if(brCifri == 2){
	MOVF       _brCifri+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main112
;Seminarska.c,272 :: 		saati *= 60;
	MOVF       _saati+0, 0
	MOVWF      R0+0
	MOVLW      60
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      _saati+0
;Seminarska.c,273 :: 		minuti += saati;
	MOVF       R0+0, 0
	ADDWF      _minuti+0, 1
;Seminarska.c,274 :: 		break;
	GOTO       L_main106
;Seminarska.c,275 :: 		}
L_main112:
;Seminarska.c,276 :: 		}
L_main111:
L_main109:
;Seminarska.c,277 :: 		}
L_main107:
;Seminarska.c,278 :: 		}
	GOTO       L_main105
L_main106:
;Seminarska.c,281 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;Seminarska.c,282 :: 		for(i=0;i<16;i++) {
	CLRF       _i+0
	CLRF       _i+1
L_main113:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main166
	MOVLW      16
	SUBWF      _i+0, 0
L__main166:
	BTFSC      STATUS+0, 0
	GOTO       L_main114
;Seminarska.c,283 :: 		tmp = i*16;
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      _tmp+0
	MOVF       _i+1, 0
	MOVWF      _tmp+1
	MOVF       R0+0, 0
L__main167:
	BTFSC      STATUS+0, 2
	GOTO       L__main168
	RLF        _tmp+0, 1
	RLF        _tmp+1, 1
	BCF        _tmp+0, 0
	ADDLW      255
	GOTO       L__main167
L__main168:
;Seminarska.c,284 :: 		tmp += 11;
	MOVLW      11
	ADDWF      _tmp+0, 1
	BTFSC      STATUS+0, 0
	INCF       _tmp+1, 1
;Seminarska.c,285 :: 		WordToStr(i, textTest);
	MOVF       _i+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       _i+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _textTest+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Seminarska.c,286 :: 		Lcd_Out(2,1, textTest);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _textTest+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,287 :: 		vreme=EEPROM_Read(tmp);
	MOVF       _tmp+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _vreme+0
;Seminarska.c,288 :: 		if(vreme == 65535){
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L__main169
	MOVLW      255
	XORWF      R0+0, 0
L__main169:
	BTFSS      STATUS+0, 2
	GOTO       L_main116
;Seminarska.c,289 :: 		continue;
	GOTO       L_main115
;Seminarska.c,290 :: 		}
L_main116:
;Seminarska.c,294 :: 		if(vreme > minuti) {
	MOVLW      128
	XORWF      _minuti+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _vreme+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main117
;Seminarska.c,295 :: 		razlika=vreme-minuti;
	MOVF       _minuti+0, 0
	SUBWF      _vreme+0, 0
	MOVWF      _razlika+0
;Seminarska.c,296 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,297 :: 		WordToStr(razlika, textTest);
	MOVF       _razlika+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVLW      0
	BTFSC      FARG_WordToStr_input+0, 7
	MOVLW      255
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _textTest+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Seminarska.c,298 :: 		Lcd_Out(1,1, textTest);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _textTest+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,299 :: 		Lcd_Out(2,1, "Proba");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,300 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main118:
	DECFSZ     R13+0, 1
	GOTO       L_main118
	DECFSZ     R12+0, 1
	GOTO       L_main118
	NOP
;Seminarska.c,301 :: 		if(razlika < min1Time) {
	MOVLW      128
	BTFSC      _razlika+0, 7
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _min1Time+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main170
	MOVF       _min1Time+0, 0
	SUBWF      _razlika+0, 0
L__main170:
	BTFSC      STATUS+0, 0
	GOTO       L_main119
;Seminarska.c,302 :: 		min2Time=min1Time;
	MOVF       _min1Time+0, 0
	MOVWF      _min2Time+0
	MOVF       _min1Time+1, 0
	MOVWF      _min2Time+1
;Seminarska.c,303 :: 		min1Time=razlika;
	MOVF       _razlika+0, 0
	MOVWF      _min1Time+0
	MOVLW      0
	BTFSC      _min1Time+0, 7
	MOVLW      255
	MOVWF      _min1Time+1
;Seminarska.c,304 :: 		min2Stanica=min1Stanica;
	MOVF       _min1Stanica+0, 0
	MOVWF      _min2Stanica+0
;Seminarska.c,305 :: 		min1Stanica=EEPROM_Read(i*16);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main171:
	BTFSC      STATUS+0, 2
	GOTO       L__main172
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main171
L__main172:
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _min1Stanica+0
;Seminarska.c,306 :: 		WordToStr(min1Stanica, textTest);
	MOVF       R0+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVLW      0
	BTFSC      FARG_WordToStr_input+0, 7
	MOVLW      255
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _textTest+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Seminarska.c,307 :: 		Lcd_Out(1,1, textTest);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _textTest+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,308 :: 		Lcd_Out(2,1, "VIkac");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,309 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main120:
	DECFSZ     R13+0, 1
	GOTO       L_main120
	DECFSZ     R12+0, 1
	GOTO       L_main120
	NOP
;Seminarska.c,310 :: 		}
	GOTO       L_main121
L_main119:
;Seminarska.c,311 :: 		else if(razlika<min2Time && razlika!=min1Time) {
	MOVLW      128
	BTFSC      _razlika+0, 7
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _min2Time+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main173
	MOVF       _min2Time+0, 0
	SUBWF      _razlika+0, 0
L__main173:
	BTFSC      STATUS+0, 0
	GOTO       L_main124
	MOVLW      0
	BTFSC      _razlika+0, 7
	MOVLW      255
	XORWF      _min1Time+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main174
	MOVF       _min1Time+0, 0
	XORWF      _razlika+0, 0
L__main174:
	BTFSC      STATUS+0, 2
	GOTO       L_main124
L__main146:
;Seminarska.c,312 :: 		min2Time=razlika;
	MOVF       _razlika+0, 0
	MOVWF      _min2Time+0
	MOVLW      0
	BTFSC      _min2Time+0, 7
	MOVLW      255
	MOVWF      _min2Time+1
;Seminarska.c,313 :: 		min2Stanica=EEPROM_Read(i*16);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main175:
	BTFSC      STATUS+0, 2
	GOTO       L__main176
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main175
L__main176:
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _min2Stanica+0
;Seminarska.c,314 :: 		}
L_main124:
L_main121:
;Seminarska.c,315 :: 		}
L_main117:
;Seminarska.c,316 :: 		}
L_main115:
;Seminarska.c,282 :: 		for(i=0;i<16;i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,316 :: 		}
	GOTO       L_main113
L_main114:
;Seminarska.c,318 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;Seminarska.c,319 :: 		pomestuvanje = 0;
	CLRF       _pomestuvanje+0
;Seminarska.c,320 :: 		for(i=0;i<16;i++) {
	CLRF       _i+0
	CLRF       _i+1
L_main125:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main177
	MOVLW      16
	SUBWF      _i+0, 0
L__main177:
	BTFSC      STATUS+0, 0
	GOTO       L_main126
;Seminarska.c,321 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,322 :: 		Lcd_Out(1,1,"Bogdan Konj");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr13_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,323 :: 		WordToStr(i, textTest);
	MOVF       _i+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       _i+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _textTest+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Seminarska.c,324 :: 		Lcd_Out(2,1,textTest);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _textTest+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,325 :: 		Delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main128:
	DECFSZ     R13+0, 1
	GOTO       L_main128
	DECFSZ     R12+0, 1
	GOTO       L_main128
	NOP
	NOP
;Seminarska.c,326 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,327 :: 		stanica=EEPROM_Read(i*16);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main178:
	BTFSC      STATUS+0, 2
	GOTO       L__main179
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main178
L__main179:
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _stanica+0
;Seminarska.c,328 :: 		if(stanica==min1Stanica) {
	MOVF       R0+0, 0
	XORWF      _min1Stanica+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main129
;Seminarska.c,329 :: 		stan=min1stanica + 48;
	MOVLW      48
	ADDWF      _min1Stanica+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _stan+0
;Seminarska.c,331 :: 		stavi(stan);
	MOVF       R0+0, 0
	MOVWF      FARG_stavi_neso+0
	CALL       _stavi+0
;Seminarska.c,334 :: 		stavi(' ');
	MOVLW      32
	MOVWF      FARG_stavi_neso+0
	CALL       _stavi+0
;Seminarska.c,336 :: 		j=0;
	CLRF       _j+0
;Seminarska.c,337 :: 		for(j=1;j<=10;j++) {
	MOVLW      1
	MOVWF      _j+0
L_main130:
	MOVLW      128
	XORLW      10
	MOVWF      R0+0
	MOVLW      128
	XORWF      _j+0, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main131
;Seminarska.c,338 :: 		citaj=EEPROM_Read(i*16+j);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main180:
	BTFSC      STATUS+0, 2
	GOTO       L__main181
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main180
L__main181:
	MOVF       _j+0, 0
	ADDWF      FARG_EEPROM_Read_Address+0, 1
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _citaj+0
;Seminarska.c,339 :: 		if(citaj == 0xFF){
	MOVF       R0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_main133
;Seminarska.c,340 :: 		break;
	GOTO       L_main131
;Seminarska.c,341 :: 		}
L_main133:
;Seminarska.c,342 :: 		print[pomestuvanje] = citaj;
	MOVF       _pomestuvanje+0, 0
	ADDLW      _print+0
	MOVWF      FSR
	MOVF       _citaj+0, 0
	MOVWF      INDF+0
;Seminarska.c,343 :: 		stavi(citaj);
	MOVF       _citaj+0, 0
	MOVWF      FARG_stavi_neso+0
	CALL       _stavi+0
;Seminarska.c,337 :: 		for(j=1;j<=10;j++) {
	INCF       _j+0, 1
;Seminarska.c,345 :: 		}
	GOTO       L_main130
L_main131:
;Seminarska.c,346 :: 		vreme=EEPROM_Read(i*16+11);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main182:
	BTFSC      STATUS+0, 2
	GOTO       L__main183
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main182
L__main183:
	MOVLW      11
	ADDWF      FARG_EEPROM_Read_Address+0, 1
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _vreme+0
;Seminarska.c,347 :: 		razlika=vreme-minuti;
	MOVF       _minuti+0, 0
	SUBWF      R0+0, 0
	MOVWF      _razlika+0
;Seminarska.c,348 :: 		while(razlika) {
L_main134:
	MOVF       _razlika+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main135
;Seminarska.c,349 :: 		stan=(razlika%10)+48;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _razlika+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      _stan+0
;Seminarska.c,351 :: 		stavi(stan);
	MOVF       R0+0, 0
	MOVWF      FARG_stavi_neso+0
	CALL       _stavi+0
;Seminarska.c,353 :: 		razlika=razlika/10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _razlika+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R0+0, 0
	MOVWF      _razlika+0
;Seminarska.c,354 :: 		}
	GOTO       L_main134
L_main135:
;Seminarska.c,356 :: 		stavi('M');
	MOVLW      77
	MOVWF      FARG_stavi_neso+0
	CALL       _stavi+0
;Seminarska.c,359 :: 		stavi('i');
	MOVLW      105
	MOVWF      FARG_stavi_neso+0
	CALL       _stavi+0
;Seminarska.c,362 :: 		stavi('n');
	MOVLW      110
	MOVWF      FARG_stavi_neso+0
	CALL       _stavi+0
;Seminarska.c,365 :: 		brCifri = strlen(print);
	MOVLW      _print+0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVF       R0+0, 0
	MOVWF      _brCifri+0
;Seminarska.c,366 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,367 :: 		Lcd_Out(1,1,"");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr14_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,368 :: 		for(i = 0; i < brCifri; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main136:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	BTFSC      _brCifri+0, 7
	MOVLW      127
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main184
	MOVF       _brCifri+0, 0
	SUBWF      _i+0, 0
L__main184:
	BTFSC      STATUS+0, 0
	GOTO       L_main137
;Seminarska.c,369 :: 		WordToStr(print[i], textTest);
	MOVF       _i+0, 0
	ADDLW      _print+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_WordToStr_input+0
	CLRF       FARG_WordToStr_input+1
	MOVLW      0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _textTest+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Seminarska.c,370 :: 		Lcd_Chr_CP(textTest);
	MOVLW      _textTest+0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Seminarska.c,368 :: 		for(i = 0; i < brCifri; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,371 :: 		}
	GOTO       L_main136
L_main137:
;Seminarska.c,373 :: 		Delay_ms(15);
	MOVLW      39
	MOVWF      R12+0
	MOVLW      245
	MOVWF      R13+0
L_main139:
	DECFSZ     R13+0, 1
	GOTO       L_main139
	DECFSZ     R12+0, 1
	GOTO       L_main139
;Seminarska.c,374 :: 		}
L_main129:
;Seminarska.c,375 :: 		if(stanica == min2Stanica) {
	MOVF       _stanica+0, 0
	XORWF      _min2Stanica+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main140
;Seminarska.c,376 :: 		WordToStr(stanica, textTest);
	MOVF       _stanica+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVLW      0
	BTFSC      FARG_WordToStr_input+0, 7
	MOVLW      255
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _textTest+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Seminarska.c,377 :: 		Lcd_Out(2,1,textTest);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _textTest+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,378 :: 		Lcd_Out_Cp(" ");
	MOVLW      ?lstr15_Seminarska+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;Seminarska.c,379 :: 		j=0;
	CLRF       _j+0
;Seminarska.c,380 :: 		for(j=1;j <= 10;j++) {
	MOVLW      1
	MOVWF      _j+0
L_main141:
	MOVLW      128
	XORLW      10
	MOVWF      R0+0
	MOVLW      128
	XORWF      _j+0, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main142
;Seminarska.c,381 :: 		citaj=EEPROM_Read(i*16+j);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main185:
	BTFSC      STATUS+0, 2
	GOTO       L__main186
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main185
L__main186:
	MOVF       _j+0, 0
	ADDWF      FARG_EEPROM_Read_Address+0, 1
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _citaj+0
;Seminarska.c,382 :: 		Lcd_Out_Cp(citaj);
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;Seminarska.c,380 :: 		for(j=1;j <= 10;j++) {
	INCF       _j+0, 1
;Seminarska.c,383 :: 		}
	GOTO       L_main141
L_main142:
;Seminarska.c,384 :: 		vreme=EEPROM_Read(i*16+11);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main187:
	BTFSC      STATUS+0, 2
	GOTO       L__main188
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main187
L__main188:
	MOVLW      11
	ADDWF      FARG_EEPROM_Read_Address+0, 1
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _vreme+0
;Seminarska.c,385 :: 		razlika=vreme-minuti;
	MOVF       _minuti+0, 0
	SUBWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      _razlika+0
;Seminarska.c,386 :: 		WordToStr(razlika, textTest);
	MOVF       R0+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVLW      0
	BTFSC      FARG_WordToStr_input+0, 7
	MOVLW      255
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _textTest+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Seminarska.c,387 :: 		Lcd_Out_Cp(textTest);
	MOVLW      _textTest+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;Seminarska.c,388 :: 		Lcd_Out_Cp("Min");
	MOVLW      ?lstr16_Seminarska+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;Seminarska.c,389 :: 		}
L_main140:
;Seminarska.c,320 :: 		for(i=0;i<16;i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,390 :: 		}
	GOTO       L_main125
L_main126:
;Seminarska.c,392 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main144:
	DECFSZ     R13+0, 1
	GOTO       L_main144
	DECFSZ     R12+0, 1
	GOTO       L_main144
	NOP
;Seminarska.c,393 :: 		Lcd_Out(1,1, "KRAJ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr17_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,394 :: 		Delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main145:
	DECFSZ     R13+0, 1
	GOTO       L_main145
	DECFSZ     R12+0, 1
	GOTO       L_main145
	NOP
	NOP
;Seminarska.c,395 :: 		}
L_main104:
;Seminarska.c,396 :: 		}
L_main97:
;Seminarska.c,397 :: 		}
	GOTO       L_main2
;Seminarska.c,398 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
