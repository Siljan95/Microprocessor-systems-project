
_greska:

;Seminarska.c,30 :: 		void greska(){
;Seminarska.c,31 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,32 :: 		Lcd_Out(1,1, "Greshka");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,33 :: 		Delay_ms(10);
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
;Seminarska.c,34 :: 		oldState=kp=0;
	CLRF       _kp+0
	CLRF       _oldState+0
;Seminarska.c,35 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,36 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,37 :: 		flagPlus = 0;
	CLRF       _flagPlus+0
;Seminarska.c,38 :: 		flag3 = 0;
	CLRF       _flag3+0
;Seminarska.c,39 :: 		}
L_end_greska:
	RETURN
; end of _greska

_main:

;Seminarska.c,41 :: 		void main() {
;Seminarska.c,42 :: 		Keypad_Init();
	CALL       _Keypad_Init+0
;Seminarska.c,43 :: 		ANSEL = 0x80;
	MOVLW      128
	MOVWF      ANSEL+0
;Seminarska.c,44 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Seminarska.c,45 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Seminarska.c,46 :: 		Lcd_Cmd(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,47 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,48 :: 		while(1){
L_main1:
;Seminarska.c,49 :: 		if(RE2_bit == 0){
	BTFSC      RE2_bit+0, BitPos(RE2_bit+0)
	GOTO       L_main3
;Seminarska.c,50 :: 		do
L_main4:
;Seminarska.c,52 :: 		Lcd_Cmd(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,53 :: 		Lcd_Out(1,1, "Vnesi");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,54 :: 		if(kp != 43 && kp != 45 && kp != 46 && kp != 47)
	MOVF       _kp+0, 0
	XORLW      43
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _kp+0, 0
	XORLW      45
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _kp+0, 0
	XORLW      46
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _kp+0, 0
	XORLW      47
	BTFSC      STATUS+0, 2
	GOTO       L_main9
L__main99:
;Seminarska.c,55 :: 		oldState = kp;
	MOVF       _kp+0, 0
	MOVWF      _oldState+0
L_main9:
;Seminarska.c,56 :: 		kp = 0;
	CLRF       _kp+0
;Seminarska.c,57 :: 		do{
L_main10:
;Seminarska.c,58 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;Seminarska.c,59 :: 		if(RE2_bit != 0){
	BTFSS      RE2_bit+0, BitPos(RE2_bit+0)
	GOTO       L_main13
;Seminarska.c,60 :: 		break;
	GOTO       L_main11
;Seminarska.c,61 :: 		}
L_main13:
;Seminarska.c,62 :: 		}while (!kp);
	MOVF       _kp+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
L_main11:
;Seminarska.c,63 :: 		if(RE2_bit != 0){
	BTFSS      RE2_bit+0, BitPos(RE2_bit+0)
	GOTO       L_main14
;Seminarska.c,64 :: 		break;
	GOTO       L_main5
;Seminarska.c,65 :: 		}
L_main14:
;Seminarska.c,66 :: 		switch (kp)
	GOTO       L_main15
;Seminarska.c,68 :: 		case 1: kp = 49; break; // 1
L_main17:
	MOVLW      49
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,69 :: 		case 2: kp = 52; break; // 4
L_main18:
	MOVLW      52
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,70 :: 		case 3: kp = 55; break; // 7
L_main19:
	MOVLW      55
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,71 :: 		case 4: kp = 74; break; // J
L_main20:
	MOVLW      74
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,72 :: 		case 5: kp = 50; break; // 2
L_main21:
	MOVLW      50
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,73 :: 		case 6: kp = 53; break; // 5
L_main22:
	MOVLW      53
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,74 :: 		case 7: kp = 56; break; // 8
L_main23:
	MOVLW      56
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,75 :: 		case 8: kp = 48; break; // 0
L_main24:
	MOVLW      48
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,76 :: 		case 9: kp = 51; break; // 3
L_main25:
	MOVLW      51
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,77 :: 		case 10: kp = 54; break; // 6
L_main26:
	MOVLW      54
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,78 :: 		case 11: kp = 57; break; // 9
L_main27:
	MOVLW      57
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,79 :: 		case 12: kp = 76; break; // L
L_main28:
	MOVLW      76
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,80 :: 		case 13: kp = 43; break; // +
L_main29:
	MOVLW      43
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,81 :: 		case 14: kp = 45; break; // Time
L_main30:
	MOVLW      45
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,82 :: 		case 15: kp = 46; break; // Add
L_main31:
	MOVLW      46
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,83 :: 		case 16: kp = 47; break; // Erase
L_main32:
	MOVLW      47
	MOVWF      _kp+0
	GOTO       L_main16
;Seminarska.c,84 :: 		}
L_main15:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main17
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	MOVF       _kp+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main20
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main22
	MOVF       _kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main23
	MOVF       _kp+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	MOVF       _kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main25
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main26
	MOVF       _kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_main27
	MOVF       _kp+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_main28
	MOVF       _kp+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main30
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main31
	MOVF       _kp+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_main32
L_main16:
;Seminarska.c,86 :: 		if(oldState == 0){
	MOVF       _oldState+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main33
;Seminarska.c,87 :: 		if(kp == 43 || kp == 45 || kp == 46 || kp == 47){
	MOVF       _kp+0, 0
	XORLW      43
	BTFSC      STATUS+0, 2
	GOTO       L__main98
	MOVF       _kp+0, 0
	XORLW      45
	BTFSC      STATUS+0, 2
	GOTO       L__main98
	MOVF       _kp+0, 0
	XORLW      46
	BTFSC      STATUS+0, 2
	GOTO       L__main98
	MOVF       _kp+0, 0
	XORLW      47
	BTFSC      STATUS+0, 2
	GOTO       L__main98
	GOTO       L_main36
L__main98:
;Seminarska.c,88 :: 		greska();
	CALL       _greska+0
;Seminarska.c,89 :: 		}
L_main36:
;Seminarska.c,90 :: 		}
L_main33:
;Seminarska.c,92 :: 		if(kp == 43){// +
	MOVF       _kp+0, 0
	XORLW      43
	BTFSS      STATUS+0, 2
	GOTO       L_main37
;Seminarska.c,93 :: 		flagPlus = 1;
	MOVLW      1
	MOVWF      _flagPlus+0
;Seminarska.c,94 :: 		switch (oldstate)
	GOTO       L_main38
;Seminarska.c,96 :: 		case 49: oldState = 65; break; // A
L_main40:
	MOVLW      65
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,97 :: 		case 52: oldState = 68; break; // D
L_main41:
	MOVLW      68
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,98 :: 		case 55: oldState = 71; break; // G
L_main42:
	MOVLW      71
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,99 :: 		case 74: oldState = 86; break; // V
L_main43:
	MOVLW      86
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,100 :: 		case 50: oldState = 66; break; // B
L_main44:
	MOVLW      66
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,101 :: 		case 53: oldState = 69; break; // E
L_main45:
	MOVLW      69
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,102 :: 		case 56: oldState = 72; break; // H
L_main46:
	MOVLW      72
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,103 :: 		case 48: oldState = 75; break; // K
L_main47:
	MOVLW      75
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,104 :: 		case 51: oldState = 67; break; // C
L_main48:
	MOVLW      67
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,105 :: 		case 54: oldState = 70; break; // F
L_main49:
	MOVLW      70
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,106 :: 		case 57: oldState = 73; break; // I
L_main50:
	MOVLW      73
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,107 :: 		case 76: oldState = 89; break; // Y
L_main51:
	MOVLW      89
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,109 :: 		case 65: oldState = 77; break; // M
L_main52:
	MOVLW      77
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,110 :: 		case 68: oldState = 80; break; // P
L_main53:
	MOVLW      80
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,111 :: 		case 71: oldState = 83; break; // S
L_main54:
	MOVLW      83
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,112 :: 		case 86: oldState = 87; break; // W
L_main55:
	MOVLW      87
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,113 :: 		case 66: oldState = 78; break; // N
L_main56:
	MOVLW      78
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,114 :: 		case 69: oldState = 81; break; // Q
L_main57:
	MOVLW      81
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,115 :: 		case 72: oldState = 84; break; // T
L_main58:
	MOVLW      84
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,116 :: 		case 75: oldState = 88; break; // X
L_main59:
	MOVLW      88
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,117 :: 		case 67: oldState = 79; break; // O
L_main60:
	MOVLW      79
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,118 :: 		case 70: oldState = 82; break; // R
L_main61:
	MOVLW      82
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,119 :: 		case 73: oldState = 85; break; // U
L_main62:
	MOVLW      85
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,120 :: 		case 89: oldState = 90; break; // Z
L_main63:
	MOVLW      90
	MOVWF      _oldState+0
	GOTO       L_main39
;Seminarska.c,121 :: 		default: flag3 = 1;
L_main64:
	MOVLW      1
	MOVWF      _flag3+0
;Seminarska.c,122 :: 		}
	GOTO       L_main39
L_main38:
	MOVF       _oldState+0, 0
	XORLW      49
	BTFSC      STATUS+0, 2
	GOTO       L_main40
	MOVF       _oldState+0, 0
	XORLW      52
	BTFSC      STATUS+0, 2
	GOTO       L_main41
	MOVF       _oldState+0, 0
	XORLW      55
	BTFSC      STATUS+0, 2
	GOTO       L_main42
	MOVF       _oldState+0, 0
	XORLW      74
	BTFSC      STATUS+0, 2
	GOTO       L_main43
	MOVF       _oldState+0, 0
	XORLW      50
	BTFSC      STATUS+0, 2
	GOTO       L_main44
	MOVF       _oldState+0, 0
	XORLW      53
	BTFSC      STATUS+0, 2
	GOTO       L_main45
	MOVF       _oldState+0, 0
	XORLW      56
	BTFSC      STATUS+0, 2
	GOTO       L_main46
	MOVF       _oldState+0, 0
	XORLW      48
	BTFSC      STATUS+0, 2
	GOTO       L_main47
	MOVF       _oldState+0, 0
	XORLW      51
	BTFSC      STATUS+0, 2
	GOTO       L_main48
	MOVF       _oldState+0, 0
	XORLW      54
	BTFSC      STATUS+0, 2
	GOTO       L_main49
	MOVF       _oldState+0, 0
	XORLW      57
	BTFSC      STATUS+0, 2
	GOTO       L_main50
	MOVF       _oldState+0, 0
	XORLW      76
	BTFSC      STATUS+0, 2
	GOTO       L_main51
	MOVF       _oldState+0, 0
	XORLW      65
	BTFSC      STATUS+0, 2
	GOTO       L_main52
	MOVF       _oldState+0, 0
	XORLW      68
	BTFSC      STATUS+0, 2
	GOTO       L_main53
	MOVF       _oldState+0, 0
	XORLW      71
	BTFSC      STATUS+0, 2
	GOTO       L_main54
	MOVF       _oldState+0, 0
	XORLW      86
	BTFSC      STATUS+0, 2
	GOTO       L_main55
	MOVF       _oldState+0, 0
	XORLW      66
	BTFSC      STATUS+0, 2
	GOTO       L_main56
	MOVF       _oldState+0, 0
	XORLW      69
	BTFSC      STATUS+0, 2
	GOTO       L_main57
	MOVF       _oldState+0, 0
	XORLW      72
	BTFSC      STATUS+0, 2
	GOTO       L_main58
	MOVF       _oldState+0, 0
	XORLW      75
	BTFSC      STATUS+0, 2
	GOTO       L_main59
	MOVF       _oldState+0, 0
	XORLW      67
	BTFSC      STATUS+0, 2
	GOTO       L_main60
	MOVF       _oldState+0, 0
	XORLW      70
	BTFSC      STATUS+0, 2
	GOTO       L_main61
	MOVF       _oldState+0, 0
	XORLW      73
	BTFSC      STATUS+0, 2
	GOTO       L_main62
	MOVF       _oldState+0, 0
	XORLW      89
	BTFSC      STATUS+0, 2
	GOTO       L_main63
	GOTO       L_main64
L_main39:
;Seminarska.c,123 :: 		if(flag3){
	MOVF       _flag3+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main65
;Seminarska.c,124 :: 		greska();
	CALL       _greska+0
;Seminarska.c,125 :: 		}
L_main65:
;Seminarska.c,126 :: 		}else if(kp == 45){  //Time
	GOTO       L_main66
L_main37:
	MOVF       _kp+0, 0
	XORLW      45
	BTFSS      STATUS+0, 2
	GOTO       L_main67
;Seminarska.c,127 :: 		flagTime = 1;
	MOVLW      1
	MOVWF      _flagTime+0
;Seminarska.c,128 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,129 :: 		vreme = brStanici;
	MOVF       _brStanici+0, 0
	MOVWF      _vreme+0
;Seminarska.c,130 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,131 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,132 :: 		}else if(kp == 46){  //Add
	GOTO       L_main68
L_main67:
	MOVF       _kp+0, 0
	XORLW      46
	BTFSS      STATUS+0, 2
	GOTO       L_main69
;Seminarska.c,133 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,134 :: 		if(flagTime){           //Ako sakame da vneseme vreme
	MOVF       _flagTime+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main70
;Seminarska.c,135 :: 		brStanici += brCifri * 10 + (oldState - 48);
	MOVF       _brCifri+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8X8_S+0
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
	ADDWF      _brStanici+0, 0
	MOVWF      R3+0
	MOVF       _brStanici+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      _brStanici+0
	MOVF       R3+1, 0
	MOVWF      _brStanici+1
;Seminarska.c,136 :: 		tmp = brStanici * 16 + 11;
	MOVLW      4
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__main102:
	BTFSC      STATUS+0, 2
	GOTO       L__main103
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main102
L__main103:
	MOVLW      11
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	MOVWF      _tmp+1
;Seminarska.c,137 :: 		EEPROM_Write(tmp, vreme);
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _vreme+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,138 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,139 :: 		}else{ //Obicno vnesuvanje na avtobuska linija bez vreme
	GOTO       L_main71
L_main70:
;Seminarska.c,140 :: 		if(oldState >= 48 && oldState <= 57){
	MOVLW      48
	SUBWF      _oldState+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main74
	MOVF       _oldState+0, 0
	SUBLW      57
	BTFSS      STATUS+0, 0
	GOTO       L_main74
L__main97:
;Seminarska.c,141 :: 		brStanici += brCifri * 10 + (oldState - 48);
	MOVF       _brCifri+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8X8_S+0
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
	ADDWF      _brStanici+0, 0
	MOVWF      R2+0
	MOVF       _brStanici+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	MOVWF      _brStanici+0
	MOVF       R2+1, 0
	MOVWF      _brStanici+1
;Seminarska.c,142 :: 		EEPROM_Write(brStanici * 16, brStanici);
	MOVLW      4
	MOVWF      R0+0
	MOVF       R2+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R0+0, 0
L__main104:
	BTFSC      STATUS+0, 2
	GOTO       L__main105
	RLF        FARG_EEPROM_Write_Address+0, 1
	BCF        FARG_EEPROM_Write_Address+0, 0
	ADDLW      255
	GOTO       L__main104
L__main105:
	MOVF       R2+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,143 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,144 :: 		tmp = brStanici * 16;
	MOVLW      4
	MOVWF      R0+0
	MOVF       _brStanici+0, 0
	MOVWF      _tmp+0
	MOVF       _brStanici+1, 0
	MOVWF      _tmp+1
	MOVF       R0+0, 0
L__main106:
	BTFSC      STATUS+0, 2
	GOTO       L__main107
	RLF        _tmp+0, 1
	RLF        _tmp+1, 1
	BCF        _tmp+0, 0
	ADDLW      255
	GOTO       L__main106
L__main107:
;Seminarska.c,145 :: 		for(i = 0; i < 15; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main75:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main108
	MOVLW      15
	SUBWF      _i+0, 0
L__main108:
	BTFSC      STATUS+0, 0
	GOTO       L_main76
;Seminarska.c,146 :: 		tmp += 1;
	INCF       _tmp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tmp+1, 1
;Seminarska.c,147 :: 		EEPROM_Write(tmp, linija[i]);
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
;Seminarska.c,145 :: 		for(i = 0; i < 15; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,148 :: 		}
	GOTO       L_main75
L_main76:
;Seminarska.c,149 :: 		}else{
	GOTO       L_main78
L_main74:
;Seminarska.c,150 :: 		greska();
	CALL       _greska+0
;Seminarska.c,151 :: 		}
L_main78:
;Seminarska.c,152 :: 		}
L_main71:
;Seminarska.c,153 :: 		}else if(kp == 47){  //Erase
	GOTO       L_main79
L_main69:
	MOVF       _kp+0, 0
	XORLW      47
	BTFSS      STATUS+0, 2
	GOTO       L_main80
;Seminarska.c,154 :: 		temp = brStanici * 16;
	MOVLW      4
	MOVWF      R0+0
	MOVF       _brStanici+0, 0
	MOVWF      _temp+0
	MOVF       _brStanici+1, 0
	MOVWF      _temp+1
	MOVF       R0+0, 0
L__main109:
	BTFSC      STATUS+0, 2
	GOTO       L__main110
	RLF        _temp+0, 1
	RLF        _temp+1, 1
	BCF        _temp+0, 0
	ADDLW      255
	GOTO       L__main109
L__main110:
;Seminarska.c,155 :: 		for(i = 0; i < 15; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main81:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main111
	MOVLW      15
	SUBWF      _i+0, 0
L__main111:
	BTFSC      STATUS+0, 0
	GOTO       L_main82
;Seminarska.c,156 :: 		EEPROM_Write(temp, 0);
	MOVF       _temp+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	CLRF       FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,157 :: 		temp +=1;
	INCF       _temp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _temp+1, 1
;Seminarska.c,155 :: 		for(i = 0; i < 15; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,158 :: 		}
	GOTO       L_main81
L_main82:
;Seminarska.c,159 :: 		}else{
	GOTO       L_main84
L_main80:
;Seminarska.c,160 :: 		if(flagPlus){  //Ako stisneme +
	MOVF       _flagPlus+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main85
;Seminarska.c,161 :: 		linija[pomestuvanje] = oldState;
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
;Seminarska.c,162 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,163 :: 		pomestuvanje++;
	INCF       _pomestuvanje+0, 1
;Seminarska.c,164 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,165 :: 		}else if(oldState == 76 || oldState == 74){ // J ili L
	GOTO       L_main86
L_main85:
	MOVF       _oldState+0, 0
	XORLW      76
	BTFSC      STATUS+0, 2
	GOTO       L__main96
	MOVF       _oldState+0, 0
	XORLW      74
	BTFSC      STATUS+0, 2
	GOTO       L__main96
	GOTO       L_main89
L__main96:
;Seminarska.c,166 :: 		linija[pomestuvanje] = oldState;
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
;Seminarska.c,167 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,168 :: 		pomestuvanje++;
	INCF       _pomestuvanje+0, 1
;Seminarska.c,169 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,170 :: 		Lcd_Out(1,1, "J ili L");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,171 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,172 :: 		}else{
	GOTO       L_main90
L_main89:
;Seminarska.c,173 :: 		if(oldState >= 48 && oldState <= 57){   // Ako e vnesena brojka
	MOVLW      48
	SUBWF      _oldState+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main93
	MOVF       _oldState+0, 0
	SUBLW      57
	BTFSS      STATUS+0, 0
	GOTO       L_main93
L__main95:
;Seminarska.c,174 :: 		brStanici += brCifri * 10 + (oldState - 48);
	MOVF       _brCifri+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8X8_S+0
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
	ADDWF      _brStanici+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _brStanici+1, 1
;Seminarska.c,175 :: 		brCifri++;
	INCF       _brCifri+0, 1
;Seminarska.c,176 :: 		}
L_main93:
;Seminarska.c,177 :: 		}
L_main90:
L_main86:
;Seminarska.c,178 :: 		}
L_main84:
L_main79:
L_main68:
L_main66:
;Seminarska.c,179 :: 		}while(1);
	GOTO       L_main4
L_main5:
;Seminarska.c,180 :: 		}else{
	GOTO       L_main94
L_main3:
;Seminarska.c,181 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,182 :: 		Lcd_Out(1,1, "Ropakinja");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,183 :: 		}
L_main94:
;Seminarska.c,184 :: 		}
	GOTO       L_main1
;Seminarska.c,185 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
