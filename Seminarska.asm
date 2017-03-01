
_TrimLeft:

;Seminarska.c,39 :: 		void TrimLeft(char *str) {
;Seminarska.c,40 :: 		char count  = 1;
	MOVLW      1
	MOVWF      TrimLeft_count_L0+0
;Seminarska.c,41 :: 		while (*str++ != 0) {
L_TrimLeft0:
	MOVF       FARG_TrimLeft_str+0, 0
	MOVWF      R1+0
	INCF       FARG_TrimLeft_str+0, 1
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_TrimLeft1
;Seminarska.c,42 :: 		if (*str != 32) {
	MOVF       FARG_TrimLeft_str+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      32
	BTFSC      STATUS+0, 2
	GOTO       L_TrimLeft2
;Seminarska.c,43 :: 		*(str - count--) = *str;
	MOVF       TrimLeft_count_L0+0, 0
	SUBWF      FARG_TrimLeft_str+0, 0
	MOVWF      R1+0
	MOVF       FARG_TrimLeft_str+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	DECF       TrimLeft_count_L0+0, 1
;Seminarska.c,44 :: 		}
L_TrimLeft2:
;Seminarska.c,45 :: 		count++;
	INCF       TrimLeft_count_L0+0, 1
;Seminarska.c,46 :: 		}
	GOTO       L_TrimLeft0
L_TrimLeft1:
;Seminarska.c,47 :: 		}
	RETURN
; end of _TrimLeft

_stavi:

;Seminarska.c,49 :: 		void stavi(char neso){
;Seminarska.c,50 :: 		strncpy(print,neso,pomestuvanje);
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
;Seminarska.c,51 :: 		pomestuvanje++;
	INCF       _pomestuvanje+0, 1
;Seminarska.c,52 :: 		}
	RETURN
; end of _stavi

_pecatiMin:

;Seminarska.c,54 :: 		void pecatiMin(short q, int p, short red){
;Seminarska.c,55 :: 		k=1;
	MOVLW      1
	MOVWF      _k+0
;Seminarska.c,56 :: 		temp = q * 16;
	MOVLW      4
	MOVWF      R0+0
	MOVF       FARG_pecatiMin_q+0, 0
	MOVWF      _temp+0
	MOVLW      0
	BTFSC      _temp+0, 7
	MOVLW      255
	MOVWF      _temp+1
	MOVF       R0+0, 0
L__pecatiMin162:
	BTFSC      STATUS+0, 2
	GOTO       L__pecatiMin163
	RLF        _temp+0, 1
	RLF        _temp+1, 1
	BCF        _temp+0, 0
	ADDLW      255
	GOTO       L__pecatiMin162
L__pecatiMin163:
;Seminarska.c,57 :: 		temp++;
	INCF       _temp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _temp+1, 1
;Seminarska.c,58 :: 		WordToStr(q, print);
	MOVF       FARG_pecatiMin_q+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVLW      0
	BTFSC      FARG_WordToStr_input+0, 7
	MOVLW      255
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _print+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Seminarska.c,59 :: 		TrimLeft(print);
	MOVLW      _print+0
	MOVWF      FARG_TrimLeft_str+0
	CALL       _TrimLeft+0
;Seminarska.c,60 :: 		LCD_Out(red, 1, print);
	MOVF       FARG_pecatiMin_red+0, 0
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _print+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,61 :: 		k++;
	INCF       _k+0, 1
;Seminarska.c,62 :: 		LCD_Chr(red, k, 32);
	MOVF       FARG_pecatiMin_red+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _k+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Seminarska.c,63 :: 		k++;
	INCF       _k+0, 1
;Seminarska.c,64 :: 		for(i = 0; i < 9; i++){
	CLRF       _i+0
	CLRF       _i+1
L_pecatiMin3:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pecatiMin164
	MOVLW      9
	SUBWF      _i+0, 0
L__pecatiMin164:
	BTFSC      STATUS+0, 0
	GOTO       L_pecatiMin4
;Seminarska.c,65 :: 		kp = EEPROM_Read(temp);
	MOVF       _temp+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;Seminarska.c,66 :: 		if(kp > 64 && kp < 123){
	MOVF       R0+0, 0
	SUBLW      64
	BTFSC      STATUS+0, 0
	GOTO       L_pecatiMin8
	MOVLW      123
	SUBWF      _kp+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_pecatiMin8
L__pecatiMin155:
;Seminarska.c,67 :: 		Lcd_Chr(red, k, kp);
	MOVF       FARG_pecatiMin_red+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _k+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _kp+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Seminarska.c,68 :: 		k++;
	INCF       _k+0, 1
;Seminarska.c,69 :: 		}
L_pecatiMin8:
;Seminarska.c,70 :: 		temp++;
	INCF       _temp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _temp+1, 1
;Seminarska.c,64 :: 		for(i = 0; i < 9; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,71 :: 		}
	GOTO       L_pecatiMin3
L_pecatiMin4:
;Seminarska.c,72 :: 		k = 10;
	MOVLW      10
	MOVWF      _k+0
;Seminarska.c,73 :: 		WordToStr(p, print);
	MOVF       FARG_pecatiMin_p+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       FARG_pecatiMin_p+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _print+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Seminarska.c,74 :: 		LCD_Chr(red, k, 32);
	MOVF       FARG_pecatiMin_red+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _k+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Seminarska.c,75 :: 		k++;
	INCF       _k+0, 1
;Seminarska.c,76 :: 		TrimLeft(print);
	MOVLW      _print+0
	MOVWF      FARG_TrimLeft_str+0
	CALL       _TrimLeft+0
;Seminarska.c,77 :: 		Lcd_Out(red, k, print);
	MOVF       FARG_pecatiMin_red+0, 0
	MOVWF      FARG_Lcd_Out_row+0
	MOVF       _k+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _print+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,78 :: 		temp+=2;
	MOVLW      2
	ADDWF      _temp+0, 1
	BTFSC      STATUS+0, 0
	INCF       _temp+1, 1
;Seminarska.c,79 :: 		for(i = 0; i < 3; i++){
	CLRF       _i+0
	CLRF       _i+1
L_pecatiMin9:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pecatiMin165
	MOVLW      3
	SUBWF      _i+0, 0
L__pecatiMin165:
	BTFSC      STATUS+0, 0
	GOTO       L_pecatiMin10
;Seminarska.c,80 :: 		kp = EEPROM_Read(temp);
	MOVF       _temp+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;Seminarska.c,81 :: 		Lcd_Chr_CP(kp);
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Seminarska.c,82 :: 		temp+=1;
	INCF       _temp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _temp+1, 1
;Seminarska.c,83 :: 		k++;
	INCF       _k+0, 1
;Seminarska.c,79 :: 		for(i = 0; i < 3; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,84 :: 		}
	GOTO       L_pecatiMin9
L_pecatiMin10:
;Seminarska.c,85 :: 		}
	RETURN
; end of _pecatiMin

_pecati:

;Seminarska.c,87 :: 		void pecati(){
;Seminarska.c,88 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,89 :: 		if(min1Stanica != 100){
	MOVF       _min1Stanica+0, 0
	XORLW      100
	BTFSC      STATUS+0, 2
	GOTO       L_pecati12
;Seminarska.c,90 :: 		pecatiMin(min1Stanica, min1Time, 1);
	MOVF       _min1Stanica+0, 0
	MOVWF      FARG_pecatiMin_q+0
	MOVF       _min1Time+0, 0
	MOVWF      FARG_pecatiMin_p+0
	MOVF       _min1Time+1, 0
	MOVWF      FARG_pecatiMin_p+1
	MOVLW      1
	MOVWF      FARG_pecatiMin_red+0
	CALL       _pecatiMin+0
;Seminarska.c,91 :: 		}
L_pecati12:
;Seminarska.c,92 :: 		if(min2Stanica != 100){
	MOVF       _min2Stanica+0, 0
	XORLW      100
	BTFSC      STATUS+0, 2
	GOTO       L_pecati13
;Seminarska.c,93 :: 		pecatiMin(min2Stanica, min2Time, 2);
	MOVF       _min2Stanica+0, 0
	MOVWF      FARG_pecatiMin_q+0
	MOVF       _min2Time+0, 0
	MOVWF      FARG_pecatiMin_p+0
	MOVF       _min2Time+1, 0
	MOVWF      FARG_pecatiMin_p+1
	MOVLW      2
	MOVWF      FARG_pecatiMin_red+0
	CALL       _pecatiMin+0
;Seminarska.c,94 :: 		}
L_pecati13:
;Seminarska.c,96 :: 		}
	RETURN
; end of _pecati

_greska:

;Seminarska.c,98 :: 		void greska(){
;Seminarska.c,99 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,100 :: 		Lcd_Out(1,1, "Greshka");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,101 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_greska14:
	DECFSZ     R13+0, 1
	GOTO       L_greska14
	DECFSZ     R12+0, 1
	GOTO       L_greska14
	NOP
;Seminarska.c,102 :: 		oldState=kp=0;
	CLRF       _kp+0
	CLRF       _oldState+0
;Seminarska.c,103 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,104 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,105 :: 		flagPlus = 0;
	CLRF       _flagPlus+0
;Seminarska.c,106 :: 		flag3 = 0;
	CLRF       _flag3+0
;Seminarska.c,107 :: 		flagVneseno = 0;
	CLRF       _flagVneseno+0
;Seminarska.c,108 :: 		temp = 0;
	CLRF       _temp+0
	CLRF       _temp+1
;Seminarska.c,109 :: 		}
	RETURN
; end of _greska

_clear:

;Seminarska.c,111 :: 		void clear(){
;Seminarska.c,112 :: 		oldState=kp=0;
	CLRF       _kp+0
	CLRF       _oldState+0
;Seminarska.c,113 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,114 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,115 :: 		flagPlus = 0;
	CLRF       _flagPlus+0
;Seminarska.c,116 :: 		flag3 = 0;
	CLRF       _flag3+0
;Seminarska.c,117 :: 		pomestuvanje = 0;
	CLRF       _pomestuvanje+0
;Seminarska.c,118 :: 		flagTime = 0;
	CLRF       _flagTime+0
;Seminarska.c,119 :: 		flagVneseno = 0;
	CLRF       _flagVneseno+0
;Seminarska.c,120 :: 		temp = 0;
	CLRF       _temp+0
	CLRF       _temp+1
;Seminarska.c,121 :: 		}
	RETURN
; end of _clear

_main:

;Seminarska.c,123 :: 		void main() {
;Seminarska.c,124 :: 		Keypad_Init();
	CALL       _Keypad_Init+0
;Seminarska.c,125 :: 		ANSEL = 0x80;
	MOVLW      128
	MOVWF      ANSEL+0
;Seminarska.c,126 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Seminarska.c,127 :: 		TRISA = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;Seminarska.c,128 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Seminarska.c,129 :: 		Lcd_Cmd(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,151 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,153 :: 		typeUser = ADC_Read(7);
	MOVLW      7
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _typeUser+0
;Seminarska.c,154 :: 		C1ON_bit = 0;
	BCF        C1ON_bit+0, 7
;Seminarska.c,155 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, 7
;Seminarska.c,156 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Seminarska.c,157 :: 		Delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	NOP
	NOP
;Seminarska.c,160 :: 		while(1){
L_main16:
;Seminarska.c,161 :: 		if(typeUser == 0){
	MOVF       _typeUser+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main18
;Seminarska.c,162 :: 		do
L_main19:
;Seminarska.c,164 :: 		Lcd_Cmd(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,165 :: 		Lcd_Out(1,1, "Vnesi");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,166 :: 		if(kp != 43 && kp != 45 && kp != 46 && kp != 47)
	MOVF       _kp+0, 0
	XORLW      43
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	MOVF       _kp+0, 0
	XORLW      45
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	MOVF       _kp+0, 0
	XORLW      46
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	MOVF       _kp+0, 0
	XORLW      47
	BTFSC      STATUS+0, 2
	GOTO       L_main24
L__main161:
;Seminarska.c,167 :: 		oldState = kp;
	MOVF       _kp+0, 0
	MOVWF      _oldState+0
L_main24:
;Seminarska.c,168 :: 		kp = 0;
	CLRF       _kp+0
;Seminarska.c,169 :: 		do{
L_main25:
;Seminarska.c,170 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;Seminarska.c,171 :: 		typeUser = ADC_Read(7);
	MOVLW      7
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _typeUser+0
;Seminarska.c,172 :: 		if(typeUser != 0){
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main28
;Seminarska.c,173 :: 		break;
	GOTO       L_main26
;Seminarska.c,174 :: 		}
L_main28:
;Seminarska.c,175 :: 		}while (!kp);
	MOVF       _kp+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main25
L_main26:
;Seminarska.c,176 :: 		if(typeUser != 0){
	MOVF       _typeUser+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main29
;Seminarska.c,177 :: 		break;
	GOTO       L_main20
;Seminarska.c,178 :: 		}
L_main29:
;Seminarska.c,179 :: 		switch (kp)
	GOTO       L_main30
;Seminarska.c,181 :: 		case 1: kp = 49; break; // 1
L_main32:
	MOVLW      49
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,182 :: 		case 2: kp = 52; break; // 4
L_main33:
	MOVLW      52
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,183 :: 		case 3: kp = 55; break; // 7
L_main34:
	MOVLW      55
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,184 :: 		case 4: kp = 74; break; // J
L_main35:
	MOVLW      74
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,185 :: 		case 5: kp = 50; break; // 2
L_main36:
	MOVLW      50
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,186 :: 		case 6: kp = 53; break; // 5
L_main37:
	MOVLW      53
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,187 :: 		case 7: kp = 56; break; // 8
L_main38:
	MOVLW      56
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,188 :: 		case 8: kp = 48; break; // 0
L_main39:
	MOVLW      48
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,189 :: 		case 9: kp = 51; break; // 3
L_main40:
	MOVLW      51
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,190 :: 		case 10: kp = 54; break; // 6
L_main41:
	MOVLW      54
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,191 :: 		case 11: kp = 57; break; // 9
L_main42:
	MOVLW      57
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,192 :: 		case 12: kp = 76; break; // L
L_main43:
	MOVLW      76
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,193 :: 		case 13: kp = 43; break; // +
L_main44:
	MOVLW      43
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,194 :: 		case 14: kp = 45; break; // Time
L_main45:
	MOVLW      45
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,195 :: 		case 15: kp = 46; break; // Add
L_main46:
	MOVLW      46
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,196 :: 		case 16: kp = 47; break; // Erase
L_main47:
	MOVLW      47
	MOVWF      _kp+0
	GOTO       L_main31
;Seminarska.c,197 :: 		}
L_main30:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main32
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main33
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main34
	MOVF       _kp+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main35
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main36
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main37
	MOVF       _kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main38
	MOVF       _kp+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_main39
	MOVF       _kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main40
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main41
	MOVF       _kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_main42
	MOVF       _kp+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_main43
	MOVF       _kp+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main44
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main45
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main46
	MOVF       _kp+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_main47
L_main31:
;Seminarska.c,199 :: 		if(oldState == 0){
	MOVF       _oldState+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main48
;Seminarska.c,200 :: 		if(kp == 43 || kp == 45 || kp == 46 || kp == 47){
	MOVF       _kp+0, 0
	XORLW      43
	BTFSC      STATUS+0, 2
	GOTO       L__main160
	MOVF       _kp+0, 0
	XORLW      45
	BTFSC      STATUS+0, 2
	GOTO       L__main160
	MOVF       _kp+0, 0
	XORLW      46
	BTFSC      STATUS+0, 2
	GOTO       L__main160
	MOVF       _kp+0, 0
	XORLW      47
	BTFSC      STATUS+0, 2
	GOTO       L__main160
	GOTO       L_main51
L__main160:
;Seminarska.c,201 :: 		greska();
	CALL       _greska+0
;Seminarska.c,202 :: 		}
L_main51:
;Seminarska.c,203 :: 		}
L_main48:
;Seminarska.c,205 :: 		if(kp == 43){// +
	MOVF       _kp+0, 0
	XORLW      43
	BTFSS      STATUS+0, 2
	GOTO       L_main52
;Seminarska.c,206 :: 		flagPlus = 1;
	MOVLW      1
	MOVWF      _flagPlus+0
;Seminarska.c,207 :: 		switch (oldstate)
	GOTO       L_main53
;Seminarska.c,209 :: 		case 49: oldState = 65; break; // A
L_main55:
	MOVLW      65
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,210 :: 		case 52: oldState = 68; break; // D
L_main56:
	MOVLW      68
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,211 :: 		case 55: oldState = 71; break; // G
L_main57:
	MOVLW      71
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,212 :: 		case 74: oldState = 86; break; // V
L_main58:
	MOVLW      86
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,213 :: 		case 50: oldState = 66; break; // B
L_main59:
	MOVLW      66
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,214 :: 		case 53: oldState = 69; break; // E
L_main60:
	MOVLW      69
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,215 :: 		case 56: oldState = 72; break; // H
L_main61:
	MOVLW      72
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,216 :: 		case 48: oldState = 75; break; // K
L_main62:
	MOVLW      75
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,217 :: 		case 51: oldState = 67; break; // C
L_main63:
	MOVLW      67
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,218 :: 		case 54: oldState = 70; break; // F
L_main64:
	MOVLW      70
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,219 :: 		case 57: oldState = 73; break; // I
L_main65:
	MOVLW      73
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,220 :: 		case 76: oldState = 89; break; // Y
L_main66:
	MOVLW      89
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,222 :: 		case 65: oldState = 77; break; // M
L_main67:
	MOVLW      77
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,223 :: 		case 68: oldState = 80; break; // P
L_main68:
	MOVLW      80
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,224 :: 		case 71: oldState = 83; break; // S
L_main69:
	MOVLW      83
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,225 :: 		case 86: oldState = 87; break; // W
L_main70:
	MOVLW      87
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,226 :: 		case 66: oldState = 78; break; // N
L_main71:
	MOVLW      78
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,227 :: 		case 69: oldState = 81; break; // Q
L_main72:
	MOVLW      81
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,228 :: 		case 72: oldState = 84; break; // T
L_main73:
	MOVLW      84
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,229 :: 		case 75: oldState = 88; break; // X
L_main74:
	MOVLW      88
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,230 :: 		case 67: oldState = 79; break; // O
L_main75:
	MOVLW      79
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,231 :: 		case 70: oldState = 82; break; // R
L_main76:
	MOVLW      82
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,232 :: 		case 73: oldState = 85; break; // U
L_main77:
	MOVLW      85
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,233 :: 		case 89: oldState = 90; break; // Z
L_main78:
	MOVLW      90
	MOVWF      _oldState+0
	GOTO       L_main54
;Seminarska.c,234 :: 		default: flag3 = 1;
L_main79:
	MOVLW      1
	MOVWF      _flag3+0
;Seminarska.c,235 :: 		}
	GOTO       L_main54
L_main53:
	MOVF       _oldState+0, 0
	XORLW      49
	BTFSC      STATUS+0, 2
	GOTO       L_main55
	MOVF       _oldState+0, 0
	XORLW      52
	BTFSC      STATUS+0, 2
	GOTO       L_main56
	MOVF       _oldState+0, 0
	XORLW      55
	BTFSC      STATUS+0, 2
	GOTO       L_main57
	MOVF       _oldState+0, 0
	XORLW      74
	BTFSC      STATUS+0, 2
	GOTO       L_main58
	MOVF       _oldState+0, 0
	XORLW      50
	BTFSC      STATUS+0, 2
	GOTO       L_main59
	MOVF       _oldState+0, 0
	XORLW      53
	BTFSC      STATUS+0, 2
	GOTO       L_main60
	MOVF       _oldState+0, 0
	XORLW      56
	BTFSC      STATUS+0, 2
	GOTO       L_main61
	MOVF       _oldState+0, 0
	XORLW      48
	BTFSC      STATUS+0, 2
	GOTO       L_main62
	MOVF       _oldState+0, 0
	XORLW      51
	BTFSC      STATUS+0, 2
	GOTO       L_main63
	MOVF       _oldState+0, 0
	XORLW      54
	BTFSC      STATUS+0, 2
	GOTO       L_main64
	MOVF       _oldState+0, 0
	XORLW      57
	BTFSC      STATUS+0, 2
	GOTO       L_main65
	MOVF       _oldState+0, 0
	XORLW      76
	BTFSC      STATUS+0, 2
	GOTO       L_main66
	MOVF       _oldState+0, 0
	XORLW      65
	BTFSC      STATUS+0, 2
	GOTO       L_main67
	MOVF       _oldState+0, 0
	XORLW      68
	BTFSC      STATUS+0, 2
	GOTO       L_main68
	MOVF       _oldState+0, 0
	XORLW      71
	BTFSC      STATUS+0, 2
	GOTO       L_main69
	MOVF       _oldState+0, 0
	XORLW      86
	BTFSC      STATUS+0, 2
	GOTO       L_main70
	MOVF       _oldState+0, 0
	XORLW      66
	BTFSC      STATUS+0, 2
	GOTO       L_main71
	MOVF       _oldState+0, 0
	XORLW      69
	BTFSC      STATUS+0, 2
	GOTO       L_main72
	MOVF       _oldState+0, 0
	XORLW      72
	BTFSC      STATUS+0, 2
	GOTO       L_main73
	MOVF       _oldState+0, 0
	XORLW      75
	BTFSC      STATUS+0, 2
	GOTO       L_main74
	MOVF       _oldState+0, 0
	XORLW      67
	BTFSC      STATUS+0, 2
	GOTO       L_main75
	MOVF       _oldState+0, 0
	XORLW      70
	BTFSC      STATUS+0, 2
	GOTO       L_main76
	MOVF       _oldState+0, 0
	XORLW      73
	BTFSC      STATUS+0, 2
	GOTO       L_main77
	MOVF       _oldState+0, 0
	XORLW      89
	BTFSC      STATUS+0, 2
	GOTO       L_main78
	GOTO       L_main79
L_main54:
;Seminarska.c,236 :: 		if(flag3){
	MOVF       _flag3+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main80
;Seminarska.c,237 :: 		greska();
	CALL       _greska+0
;Seminarska.c,238 :: 		}
L_main80:
;Seminarska.c,239 :: 		}else if(kp == 45){  //Time
	GOTO       L_main81
L_main52:
	MOVF       _kp+0, 0
	XORLW      45
	BTFSS      STATUS+0, 2
	GOTO       L_main82
;Seminarska.c,240 :: 		flagTime = 1;
	MOVLW      1
	MOVWF      _flagTime+0
;Seminarska.c,241 :: 		brStanici = brStanici * 10 + (oldState - 48);
	MOVF       _brStanici+0, 0
	MOVWF      R0+0
	MOVF       _brStanici+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
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
;Seminarska.c,242 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,243 :: 		vreme = brStanici;
	MOVF       R0+0, 0
	MOVWF      _vreme+0
;Seminarska.c,244 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,245 :: 		}else if(kp == 46){  //Add
	GOTO       L_main83
L_main82:
	MOVF       _kp+0, 0
	XORLW      46
	BTFSS      STATUS+0, 2
	GOTO       L_main84
;Seminarska.c,246 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,247 :: 		Lcd_Out(2,1, "VIKAC");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,248 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main85:
	DECFSZ     R13+0, 1
	GOTO       L_main85
	DECFSZ     R12+0, 1
	GOTO       L_main85
	NOP
;Seminarska.c,249 :: 		if(flagTime){           //Ako sakame da vneseme vreme
	MOVF       _flagTime+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main86
;Seminarska.c,250 :: 		brStanici = brStanici * 10 + (oldState - 48);
	MOVF       _brStanici+0, 0
	MOVWF      R0+0
	MOVF       _brStanici+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
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
;Seminarska.c,251 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,252 :: 		for(i = 0; i < 16; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main87:
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
	GOTO       L_main88
;Seminarska.c,253 :: 		if(brStanici == EEPROM_Read(i * 16)){
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
	CALL       _EEPROM_Read+0
	MOVLW      0
	XORWF      _brStanici+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main169
	MOVF       R0+0, 0
	XORWF      _brStanici+0, 0
L__main169:
	BTFSS      STATUS+0, 2
	GOTO       L_main90
;Seminarska.c,254 :: 		tmp = i * 16 + 11;
	MOVLW      4
	MOVWF      R2+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__main170:
	BTFSC      STATUS+0, 2
	GOTO       L__main171
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main170
L__main171:
	MOVLW      11
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	MOVWF      _tmp+1
;Seminarska.c,255 :: 		EEPROM_Write(tmp, vreme);
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _vreme+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,256 :: 		tmp += 2;
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
;Seminarska.c,257 :: 		EEPROM_Write(tmp, "M");
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      ?lstr_4_Seminarska+0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,258 :: 		tmp += 1;
	INCF       _tmp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tmp+1, 1
;Seminarska.c,259 :: 		EEPROM_Write(tmp, "i");
	MOVF       _tmp+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      ?lstr_5_Seminarska+0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,260 :: 		tmp += 1;
	INCF       _tmp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tmp+1, 1
;Seminarska.c,261 :: 		EEPROM_Write(tmp, "n");
	MOVF       _tmp+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      ?lstr_6_Seminarska+0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,262 :: 		}
L_main90:
;Seminarska.c,252 :: 		for(i = 0; i < 16; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,263 :: 		}
	GOTO       L_main87
L_main88:
;Seminarska.c,264 :: 		clear();
	CALL       _clear+0
;Seminarska.c,265 :: 		}else{ //Obicno vnesuvanje na avtobuska linija bez vreme
	GOTO       L_main91
L_main86:
;Seminarska.c,266 :: 		if(oldState >= 48 && oldState <= 57){
	MOVLW      48
	SUBWF      _oldState+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main94
	MOVF       _oldState+0, 0
	SUBLW      57
	BTFSS      STATUS+0, 0
	GOTO       L_main94
L__main159:
;Seminarska.c,267 :: 		brStanici = brStanici * 10 + (oldState - 48);
	MOVF       _brStanici+0, 0
	MOVWF      R0+0
	MOVF       _brStanici+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
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
;Seminarska.c,268 :: 		for(i = 0; i < 16; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main95:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main172
	MOVLW      16
	SUBWF      _i+0, 0
L__main172:
	BTFSC      STATUS+0, 0
	GOTO       L_main96
;Seminarska.c,269 :: 		if(brStanici == EEPROM_Read(i * 16)){
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	MOVF       R0+0, 0
L__main173:
	BTFSC      STATUS+0, 2
	GOTO       L__main174
	RLF        FARG_EEPROM_Read_Address+0, 1
	BCF        FARG_EEPROM_Read_Address+0, 0
	ADDLW      255
	GOTO       L__main173
L__main174:
	CALL       _EEPROM_Read+0
	MOVLW      0
	XORWF      _brStanici+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main175
	MOVF       R0+0, 0
	XORWF      _brStanici+0, 0
L__main175:
	BTFSS      STATUS+0, 2
	GOTO       L_main98
;Seminarska.c,270 :: 		temp = i * 16;
	MOVLW      4
	MOVWF      R0+0
	MOVF       _i+0, 0
	MOVWF      _temp+0
	MOVF       _i+1, 0
	MOVWF      _temp+1
	MOVF       R0+0, 0
L__main176:
	BTFSC      STATUS+0, 2
	GOTO       L__main177
	RLF        _temp+0, 1
	RLF        _temp+1, 1
	BCF        _temp+0, 0
	ADDLW      255
	GOTO       L__main176
L__main177:
;Seminarska.c,271 :: 		flagVneseno = 1;
	MOVLW      1
	MOVWF      _flagVneseno+0
;Seminarska.c,272 :: 		}
L_main98:
;Seminarska.c,268 :: 		for(i = 0; i < 16; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,273 :: 		}
	GOTO       L_main95
L_main96:
;Seminarska.c,274 :: 		if(flagVneseno == 0){
	MOVF       _flagVneseno+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main99
;Seminarska.c,275 :: 		EEPROM_Write(countStanici * 16, brStanici);
	MOVLW      4
	MOVWF      R0+0
	MOVF       _countStanici+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R0+0, 0
L__main178:
	BTFSC      STATUS+0, 2
	GOTO       L__main179
	RLF        FARG_EEPROM_Write_Address+0, 1
	BCF        FARG_EEPROM_Write_Address+0, 0
	ADDLW      255
	GOTO       L__main178
L__main179:
	MOVF       _brStanici+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,276 :: 		tmp = countStanici * 16;
	MOVLW      4
	MOVWF      R0+0
	MOVF       _countStanici+0, 0
	MOVWF      _tmp+0
	MOVLW      0
	BTFSC      _tmp+0, 7
	MOVLW      255
	MOVWF      _tmp+1
	MOVF       R0+0, 0
L__main180:
	BTFSC      STATUS+0, 2
	GOTO       L__main181
	RLF        _tmp+0, 1
	RLF        _tmp+1, 1
	BCF        _tmp+0, 0
	ADDLW      255
	GOTO       L__main180
L__main181:
;Seminarska.c,277 :: 		for(i = 0; i < pomestuvanje; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main100:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	BTFSC      _pomestuvanje+0, 7
	MOVLW      127
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main182
	MOVF       _pomestuvanje+0, 0
	SUBWF      _i+0, 0
L__main182:
	BTFSC      STATUS+0, 0
	GOTO       L_main101
;Seminarska.c,278 :: 		tmp += 1;
	INCF       _tmp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tmp+1, 1
;Seminarska.c,279 :: 		EEPROM_Write(tmp, linija[i]);
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
;Seminarska.c,277 :: 		for(i = 0; i < pomestuvanje; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,280 :: 		}
	GOTO       L_main100
L_main101:
;Seminarska.c,281 :: 		brCifri = 15 - pomestuvanje;
	MOVF       _pomestuvanje+0, 0
	SUBLW      15
	MOVWF      _brCifri+0
;Seminarska.c,282 :: 		for(i = 0; i < brCifri; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main103:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	BTFSC      _brCifri+0, 7
	MOVLW      127
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main183
	MOVF       _brCifri+0, 0
	SUBWF      _i+0, 0
L__main183:
	BTFSC      STATUS+0, 0
	GOTO       L_main104
;Seminarska.c,283 :: 		tmp += 1;
	INCF       _tmp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tmp+1, 1
;Seminarska.c,284 :: 		EEPROM_Write(tmp, 0);
	MOVF       _tmp+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	CLRF       FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,282 :: 		for(i = 0; i < brCifri; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,285 :: 		}
	GOTO       L_main103
L_main104:
;Seminarska.c,286 :: 		countStanici++;
	INCF       _countStanici+0, 1
;Seminarska.c,287 :: 		}else{
	GOTO       L_main106
L_main99:
;Seminarska.c,288 :: 		greska();
	CALL       _greska+0
;Seminarska.c,289 :: 		}
L_main106:
;Seminarska.c,290 :: 		}else{
	GOTO       L_main107
L_main94:
;Seminarska.c,291 :: 		greska();
	CALL       _greska+0
;Seminarska.c,292 :: 		}
L_main107:
;Seminarska.c,293 :: 		clear();
	CALL       _clear+0
;Seminarska.c,294 :: 		}
L_main91:
;Seminarska.c,295 :: 		}else if(kp == 47){  //Erase
	GOTO       L_main108
L_main84:
	MOVF       _kp+0, 0
	XORLW      47
	BTFSS      STATUS+0, 2
	GOTO       L_main109
;Seminarska.c,296 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,297 :: 		temp = brStanici * 16;
	MOVLW      4
	MOVWF      R0+0
	MOVF       _brStanici+0, 0
	MOVWF      _temp+0
	MOVF       _brStanici+1, 0
	MOVWF      _temp+1
	MOVF       R0+0, 0
L__main184:
	BTFSC      STATUS+0, 2
	GOTO       L__main185
	RLF        _temp+0, 1
	RLF        _temp+1, 1
	BCF        _temp+0, 0
	ADDLW      255
	GOTO       L__main184
L__main185:
;Seminarska.c,298 :: 		for(i = 0; i < 15; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main110:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main186
	MOVLW      15
	SUBWF      _i+0, 0
L__main186:
	BTFSC      STATUS+0, 0
	GOTO       L_main111
;Seminarska.c,299 :: 		EEPROM_Write(temp, 0);
	MOVF       _temp+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	CLRF       FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,300 :: 		temp +=1;
	INCF       _temp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _temp+1, 1
;Seminarska.c,298 :: 		for(i = 0; i < 15; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,301 :: 		}
	GOTO       L_main110
L_main111:
;Seminarska.c,302 :: 		}else{
	GOTO       L_main113
L_main109:
;Seminarska.c,303 :: 		if(flagPlus){  //Ako stisneme +
	MOVF       _flagPlus+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main114
;Seminarska.c,304 :: 		linija[pomestuvanje] = oldState;
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
;Seminarska.c,305 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,306 :: 		pomestuvanje++;
	INCF       _pomestuvanje+0, 1
;Seminarska.c,307 :: 		flagPlus = 0;
	CLRF       _flagPlus+0
;Seminarska.c,308 :: 		}else if(oldState == 76 || oldState == 74){ // J ili L
	GOTO       L_main115
L_main114:
	MOVF       _oldState+0, 0
	XORLW      76
	BTFSC      STATUS+0, 2
	GOTO       L__main158
	MOVF       _oldState+0, 0
	XORLW      74
	BTFSC      STATUS+0, 2
	GOTO       L__main158
	GOTO       L_main118
L__main158:
;Seminarska.c,309 :: 		linija[pomestuvanje] = oldState;
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
;Seminarska.c,310 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,311 :: 		pomestuvanje++;
	INCF       _pomestuvanje+0, 1
;Seminarska.c,312 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,313 :: 		Lcd_Out(1,1, "J ili L");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,314 :: 		}else{
	GOTO       L_main119
L_main118:
;Seminarska.c,315 :: 		if(oldState >= 48 && oldState <= 57){   // Ako e vnesena brojka
	MOVLW      48
	SUBWF      _oldState+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main122
	MOVF       _oldState+0, 0
	SUBLW      57
	BTFSS      STATUS+0, 0
	GOTO       L_main122
L__main157:
;Seminarska.c,316 :: 		brStanici = brStanici * 10 + (oldState - 48);
	MOVF       _brStanici+0, 0
	MOVWF      R0+0
	MOVF       _brStanici+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
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
;Seminarska.c,317 :: 		Lcd_Out(1,1, "Vnesena Brojka");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,318 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main123:
	DECFSZ     R13+0, 1
	GOTO       L_main123
	DECFSZ     R12+0, 1
	GOTO       L_main123
	NOP
;Seminarska.c,319 :: 		}
L_main122:
;Seminarska.c,320 :: 		}
L_main119:
L_main115:
;Seminarska.c,321 :: 		}
L_main113:
L_main108:
L_main83:
L_main81:
;Seminarska.c,322 :: 		}while(1);
	GOTO       L_main19
L_main20:
;Seminarska.c,323 :: 		}else{
	GOTO       L_main124
L_main18:
;Seminarska.c,324 :: 		i = 0;
	CLRF       _i+0
	CLRF       _i+1
;Seminarska.c,325 :: 		flagUart=0;
	CLRF       _flagUart+0
;Seminarska.c,326 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,327 :: 		strcpy(getTime, "GET TIME");
	MOVLW      _getTime+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr9_Seminarska+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Seminarska.c,328 :: 		while(1){
L_main125:
;Seminarska.c,329 :: 		typeUser = ADC_Read(7);
	MOVLW      7
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _typeUser+0
;Seminarska.c,330 :: 		if(typeUser == 0)
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main127
;Seminarska.c,331 :: 		break;
	GOTO       L_main126
L_main127:
;Seminarska.c,332 :: 		if (UART1_Data_Ready()) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main128
;Seminarska.c,333 :: 		uart_rd = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;Seminarska.c,334 :: 		porakaOdEsurat[i] = uart_rd;
	MOVF       _i+0, 0
	ADDLW      _porakaOdEsurat+0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Seminarska.c,335 :: 		i++;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,336 :: 		sporedba = strcmp(getTime,porakaOdEsurat);
	MOVLW      _getTime+0
	MOVWF      FARG_strcmp_s1+0
	MOVLW      _porakaOdEsurat+0
	MOVWF      FARG_strcmp_s2+0
	CALL       _strcmp+0
	MOVF       R0+0, 0
	MOVWF      _sporedba+0
;Seminarska.c,337 :: 		if(sporedba == 0){
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main129
;Seminarska.c,338 :: 		flagUart=1;
	MOVLW      1
	MOVWF      _flagUart+0
;Seminarska.c,339 :: 		break;
	GOTO       L_main126
;Seminarska.c,340 :: 		}
L_main129:
;Seminarska.c,342 :: 		flagUart=0;
	CLRF       _flagUart+0
;Seminarska.c,344 :: 		}
L_main128:
;Seminarska.c,345 :: 		}
	GOTO       L_main125
L_main126:
;Seminarska.c,346 :: 		for(j = 0; j < 20; j++){
	CLRF       _j+0
L_main131:
	MOVLW      128
	XORWF      _j+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      20
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main132
;Seminarska.c,347 :: 		porakaOdEsurat[j] = 0;
	MOVF       _j+0, 0
	ADDLW      _porakaOdEsurat+0
	MOVWF      FSR
	CLRF       INDF+0
;Seminarska.c,346 :: 		for(j = 0; j < 20; j++){
	INCF       _j+0, 1
;Seminarska.c,348 :: 		}
	GOTO       L_main131
L_main132:
;Seminarska.c,349 :: 		if(flagUart==1) {
	MOVF       _flagUart+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main134
;Seminarska.c,350 :: 		while(1){
L_main135:
;Seminarska.c,351 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main137
;Seminarska.c,352 :: 		uart_rd = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;Seminarska.c,354 :: 		if(uart_rd == 58){
	MOVF       R0+0, 0
	XORLW      58
	BTFSS      STATUS+0, 2
	GOTO       L_main138
;Seminarska.c,355 :: 		flagDveTocki = 1;
	MOVLW      1
	MOVWF      _flagDveTocki+0
;Seminarska.c,357 :: 		Lcd_Out(2,1, "vIKAC");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,358 :: 		}else if(flagDveTocki == 0){
	GOTO       L_main139
L_main138:
	MOVF       _flagDveTocki+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main140
;Seminarska.c,359 :: 		saati = saati * 10 + (uart_rd - 48);
	MOVF       _saati+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      48
	SUBWF      _uart_rd+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	ADDWF      R0+0, 0
	MOVWF      _saati+0
;Seminarska.c,360 :: 		}else{
	GOTO       L_main141
L_main140:
;Seminarska.c,361 :: 		minuti = minuti * 10 + (uart_rd - 48);
	MOVF       _minuti+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      48
	SUBWF      _uart_rd+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	ADDWF      R0+0, 0
	MOVWF      _minuti+0
;Seminarska.c,362 :: 		brCifri++;
	INCF       _brCifri+0, 1
;Seminarska.c,363 :: 		if(brCifri == 2){
	MOVF       _brCifri+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main142
;Seminarska.c,364 :: 		saati *= 60;
	MOVF       _saati+0, 0
	MOVWF      R0+0
	MOVLW      60
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _saati+0
;Seminarska.c,365 :: 		minuti += saati;
	MOVF       R0+0, 0
	ADDWF      _minuti+0, 1
;Seminarska.c,366 :: 		break;
	GOTO       L_main136
;Seminarska.c,367 :: 		}
L_main142:
;Seminarska.c,368 :: 		}
L_main141:
L_main139:
;Seminarska.c,369 :: 		}
L_main137:
;Seminarska.c,370 :: 		}
	GOTO       L_main135
L_main136:
;Seminarska.c,373 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;Seminarska.c,374 :: 		for(i=0;i<16;i++) {
	CLRF       _i+0
	CLRF       _i+1
L_main143:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main187
	MOVLW      16
	SUBWF      _i+0, 0
L__main187:
	BTFSC      STATUS+0, 0
	GOTO       L_main144
;Seminarska.c,375 :: 		tmp = i*16;
	MOVLW      4
	MOVWF      R2+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__main188:
	BTFSC      STATUS+0, 2
	GOTO       L__main189
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main188
L__main189:
	MOVF       R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	MOVWF      _tmp+1
;Seminarska.c,376 :: 		tmp += 11;
	MOVLW      11
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	MOVWF      _tmp+1
;Seminarska.c,377 :: 		vreme=EEPROM_Read(tmp);
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _vreme+0
;Seminarska.c,378 :: 		if(vreme == 65535){
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L__main190
	MOVLW      255
	XORWF      R0+0, 0
L__main190:
	BTFSS      STATUS+0, 2
	GOTO       L_main146
;Seminarska.c,379 :: 		continue;
	GOTO       L_main145
;Seminarska.c,380 :: 		}
L_main146:
;Seminarska.c,381 :: 		if(vreme > minuti) {
	MOVLW      128
	XORWF      _minuti+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _vreme+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main147
;Seminarska.c,382 :: 		razlika = vreme-minuti;
	MOVF       _minuti+0, 0
	SUBWF      _vreme+0, 0
	MOVWF      _razlika+0
;Seminarska.c,383 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,384 :: 		kp = razlika;
	MOVF       _razlika+0, 0
	MOVWF      _kp+0
;Seminarska.c,385 :: 		if(razlika < min1Time) {
	MOVLW      128
	BTFSC      _razlika+0, 7
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _min1Time+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main191
	MOVF       _min1Time+0, 0
	SUBWF      _razlika+0, 0
L__main191:
	BTFSC      STATUS+0, 0
	GOTO       L_main148
;Seminarska.c,386 :: 		min2Time=min1Time;
	MOVF       _min1Time+0, 0
	MOVWF      _min2Time+0
	MOVF       _min1Time+1, 0
	MOVWF      _min2Time+1
;Seminarska.c,387 :: 		min1Time=razlika;
	MOVF       _razlika+0, 0
	MOVWF      _min1Time+0
	MOVLW      0
	BTFSC      _min1Time+0, 7
	MOVLW      255
	MOVWF      _min1Time+1
;Seminarska.c,388 :: 		min2Stanica=min1Stanica;
	MOVF       _min1Stanica+0, 0
	MOVWF      _min2Stanica+0
;Seminarska.c,389 :: 		min1Stanica= i;
	MOVF       _i+0, 0
	MOVWF      _min1Stanica+0
;Seminarska.c,390 :: 		WordToStr(min1Stanica, textTest);
	MOVF       _i+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVLW      0
	BTFSC      FARG_WordToStr_input+0, 7
	MOVLW      255
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _textTest+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Seminarska.c,391 :: 		Lcd_Out(1,1,min1Stanica);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _min1Stanica+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,392 :: 		}
	GOTO       L_main149
L_main148:
;Seminarska.c,393 :: 		else if(razlika<min2Time && razlika!=min1Time) {
	MOVLW      128
	BTFSC      _razlika+0, 7
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _min2Time+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main192
	MOVF       _min2Time+0, 0
	SUBWF      _razlika+0, 0
L__main192:
	BTFSC      STATUS+0, 0
	GOTO       L_main152
	MOVLW      0
	BTFSC      _razlika+0, 7
	MOVLW      255
	XORWF      _min1Time+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main193
	MOVF       _min1Time+0, 0
	XORWF      _razlika+0, 0
L__main193:
	BTFSC      STATUS+0, 2
	GOTO       L_main152
L__main156:
;Seminarska.c,394 :: 		min2Time=razlika;
	MOVF       _razlika+0, 0
	MOVWF      _min2Time+0
	MOVLW      0
	BTFSC      _min2Time+0, 7
	MOVLW      255
	MOVWF      _min2Time+1
;Seminarska.c,395 :: 		min2Stanica= i;
	MOVF       _i+0, 0
	MOVWF      _min2Stanica+0
;Seminarska.c,396 :: 		}
L_main152:
L_main149:
;Seminarska.c,397 :: 		}
L_main147:
;Seminarska.c,398 :: 		}
L_main145:
;Seminarska.c,374 :: 		for(i=0;i<16;i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,398 :: 		}
	GOTO       L_main143
L_main144:
;Seminarska.c,400 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;Seminarska.c,401 :: 		pomestuvanje = 0;
	CLRF       _pomestuvanje+0
;Seminarska.c,402 :: 		pecati();
	CALL       _pecati+0
;Seminarska.c,404 :: 		Delay_ms(20);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main153:
	DECFSZ     R13+0, 1
	GOTO       L_main153
	DECFSZ     R12+0, 1
	GOTO       L_main153
	NOP
	NOP
;Seminarska.c,405 :: 		Lcd_Out(2,1, "KRAJ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,406 :: 		Delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main154:
	DECFSZ     R13+0, 1
	GOTO       L_main154
	DECFSZ     R12+0, 1
	GOTO       L_main154
	NOP
	NOP
;Seminarska.c,407 :: 		}
L_main134:
;Seminarska.c,408 :: 		}
L_main124:
;Seminarska.c,409 :: 		}
	GOTO       L_main16
;Seminarska.c,410 :: 		}
	GOTO       $+0
; end of _main
