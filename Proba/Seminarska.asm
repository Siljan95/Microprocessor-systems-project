
_stavi:

;Seminarska.c,42 :: 		void stavi(char neso){
;Seminarska.c,43 :: 		strncpy(print,neso,pomestuvanje);
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
;Seminarska.c,44 :: 		pomestuvanje++;
	INCF       _pomestuvanje+0, 1
;Seminarska.c,45 :: 		}
L_end_stavi:
	RETURN
; end of _stavi

_pecatiMin:

;Seminarska.c,47 :: 		void pecatiMin(short q, int p, short red){
;Seminarska.c,48 :: 		k=1;
	MOVLW      1
	MOVWF      _k+0
;Seminarska.c,49 :: 		temp = q * 16;
	MOVLW      4
	MOVWF      R0+0
	MOVF       FARG_pecatiMin_q+0, 0
	MOVWF      _temp+0
	MOVLW      0
	BTFSC      _temp+0, 7
	MOVLW      255
	MOVWF      _temp+1
	MOVF       R0+0, 0
L__pecatiMin144:
	BTFSC      STATUS+0, 2
	GOTO       L__pecatiMin145
	RLF        _temp+0, 1
	RLF        _temp+1, 1
	BCF        _temp+0, 0
	ADDLW      255
	GOTO       L__pecatiMin144
L__pecatiMin145:
;Seminarska.c,50 :: 		temp++;
	INCF       _temp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _temp+1, 1
;Seminarska.c,51 :: 		WordToStr(q, print);
	MOVF       FARG_pecatiMin_q+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVLW      0
	BTFSC      FARG_WordToStr_input+0, 7
	MOVLW      255
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _print+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Seminarska.c,52 :: 		LCD_Out(red, 1, Ltrim(print));
	MOVLW      _print+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVF       FARG_pecatiMin_red+0, 0
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
;Seminarska.c,53 :: 		k++;
	INCF       _k+0, 1
;Seminarska.c,54 :: 		LCD_Chr(red, k, 32);
	MOVF       FARG_pecatiMin_red+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _k+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Seminarska.c,55 :: 		k++;
	INCF       _k+0, 1
;Seminarska.c,56 :: 		for(i = 0; i < 9; i++){
	CLRF       _i+0
	CLRF       _i+1
L_pecatiMin0:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pecatiMin146
	MOVLW      9
	SUBWF      _i+0, 0
L__pecatiMin146:
	BTFSC      STATUS+0, 0
	GOTO       L_pecatiMin1
;Seminarska.c,57 :: 		stan = EEPROM_Read(temp);
	MOVF       _temp+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _stan+0
;Seminarska.c,58 :: 		if(stan > 64 && stan < 123){
	MOVF       R0+0, 0
	SUBLW      64
	BTFSC      STATUS+0, 0
	GOTO       L_pecatiMin5
	MOVLW      123
	SUBWF      _stan+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_pecatiMin5
L__pecatiMin135:
;Seminarska.c,59 :: 		Lcd_Chr(red, k, stan);
	MOVF       FARG_pecatiMin_red+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _k+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _stan+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Seminarska.c,60 :: 		k++;
	INCF       _k+0, 1
;Seminarska.c,61 :: 		}
L_pecatiMin5:
;Seminarska.c,62 :: 		temp++;
	INCF       _temp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _temp+1, 1
;Seminarska.c,56 :: 		for(i = 0; i < 9; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,63 :: 		}
	GOTO       L_pecatiMin0
L_pecatiMin1:
;Seminarska.c,64 :: 		k = 10;
	MOVLW      10
	MOVWF      _k+0
;Seminarska.c,65 :: 		WordToStr(p, print);
	MOVF       FARG_pecatiMin_p+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       FARG_pecatiMin_p+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _print+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Seminarska.c,66 :: 		LCD_Chr(red, k, 32);
	MOVF       FARG_pecatiMin_red+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _k+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Seminarska.c,67 :: 		k++;
	INCF       _k+0, 1
;Seminarska.c,68 :: 		Lcd_Out(red, k, Ltrim(print));
	MOVLW      _print+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVF       FARG_pecatiMin_red+0, 0
	MOVWF      FARG_Lcd_Out_row+0
	MOVF       _k+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
;Seminarska.c,69 :: 		temp+=2;
	MOVLW      2
	ADDWF      _temp+0, 1
	BTFSC      STATUS+0, 0
	INCF       _temp+1, 1
;Seminarska.c,70 :: 		for(i = 0; i < 3; i++){
	CLRF       _i+0
	CLRF       _i+1
L_pecatiMin6:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pecatiMin147
	MOVLW      3
	SUBWF      _i+0, 0
L__pecatiMin147:
	BTFSC      STATUS+0, 0
	GOTO       L_pecatiMin7
;Seminarska.c,71 :: 		stan = EEPROM_Read(temp);
	MOVF       _temp+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _stan+0
;Seminarska.c,72 :: 		Lcd_Chr_CP(stan);
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Seminarska.c,73 :: 		temp+=1;
	INCF       _temp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _temp+1, 1
;Seminarska.c,74 :: 		k++;
	INCF       _k+0, 1
;Seminarska.c,70 :: 		for(i = 0; i < 3; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,75 :: 		}
	GOTO       L_pecatiMin6
L_pecatiMin7:
;Seminarska.c,76 :: 		}
L_end_pecatiMin:
	RETURN
; end of _pecatiMin

_pecati:

;Seminarska.c,78 :: 		void pecati(){
;Seminarska.c,79 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,80 :: 		if(min1Stanica != 100){
	MOVF       _min1Stanica+0, 0
	XORLW      100
	BTFSC      STATUS+0, 2
	GOTO       L_pecati9
;Seminarska.c,81 :: 		pecatiMin(min1Stanica, min1Time, 1);
	MOVF       _min1Stanica+0, 0
	MOVWF      FARG_pecatiMin_q+0
	MOVF       _min1Time+0, 0
	MOVWF      FARG_pecatiMin_p+0
	MOVF       _min1Time+1, 0
	MOVWF      FARG_pecatiMin_p+1
	MOVLW      1
	MOVWF      FARG_pecatiMin_red+0
	CALL       _pecatiMin+0
;Seminarska.c,82 :: 		}
L_pecati9:
;Seminarska.c,83 :: 		if(min2Stanica != 100){
	MOVF       _min2Stanica+0, 0
	XORLW      100
	BTFSC      STATUS+0, 2
	GOTO       L_pecati10
;Seminarska.c,84 :: 		pecatiMin(min2Stanica, min2Time, 2);
	MOVF       _min2Stanica+0, 0
	MOVWF      FARG_pecatiMin_q+0
	MOVF       _min2Time+0, 0
	MOVWF      FARG_pecatiMin_p+0
	MOVF       _min2Time+1, 0
	MOVWF      FARG_pecatiMin_p+1
	MOVLW      2
	MOVWF      FARG_pecatiMin_red+0
	CALL       _pecatiMin+0
;Seminarska.c,85 :: 		}
L_pecati10:
;Seminarska.c,87 :: 		}
L_end_pecati:
	RETURN
; end of _pecati

_greska:

;Seminarska.c,89 :: 		void greska(){
;Seminarska.c,90 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,91 :: 		Lcd_Out(1,1, "Greshka");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,92 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_greska11:
	DECFSZ     R13+0, 1
	GOTO       L_greska11
	DECFSZ     R12+0, 1
	GOTO       L_greska11
	NOP
;Seminarska.c,93 :: 		oldState=kp=0;
	CLRF       _kp+0
	CLRF       _oldState+0
;Seminarska.c,94 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,95 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,96 :: 		flagPlus = 0;
	CLRF       _flagPlus+0
;Seminarska.c,97 :: 		flag3 = 0;
	CLRF       _flag3+0
;Seminarska.c,98 :: 		}
L_end_greska:
	RETURN
; end of _greska

_clear:

;Seminarska.c,100 :: 		void clear(){
;Seminarska.c,101 :: 		oldState=kp=0;
	CLRF       _kp+0
	CLRF       _oldState+0
;Seminarska.c,102 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,103 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,104 :: 		flagPlus = 0;
	CLRF       _flagPlus+0
;Seminarska.c,105 :: 		flag3 = 0;
	CLRF       _flag3+0
;Seminarska.c,106 :: 		pomestuvanje = 0;
	CLRF       _pomestuvanje+0
;Seminarska.c,107 :: 		flagTime = 0;
	CLRF       _flagTime+0
;Seminarska.c,108 :: 		}
L_end_clear:
	RETURN
; end of _clear

_main:

;Seminarska.c,110 :: 		void main() {
;Seminarska.c,111 :: 		Keypad_Init();
	CALL       _Keypad_Init+0
;Seminarska.c,112 :: 		ANSEL = 0x80;
	MOVLW      128
	MOVWF      ANSEL+0
;Seminarska.c,113 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Seminarska.c,114 :: 		TRISA = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;Seminarska.c,115 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Seminarska.c,116 :: 		Lcd_Cmd(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,117 :: 		EEPROM_Write(2*16, 2);
	MOVLW      32
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      2
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,118 :: 		EEPROM_Write(2*16+1, 'K');
	MOVLW      33
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      75
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,119 :: 		EEPROM_Write(2*16+2, 'I');
	MOVLW      34
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      73
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,120 :: 		EEPROM_Write(2*16+3, 'M');
	MOVLW      35
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      77
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,121 :: 		EEPROM_Write(2*16+11, 10);
	MOVLW      43
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      10
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,122 :: 		EEPROM_Write(2*16+12, 'M');
	MOVLW      44
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      77
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,123 :: 		EEPROM_Write(2*16+13, 'i');
	MOVLW      45
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      105
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,124 :: 		EEPROM_Write(2*16+14, 'n');
	MOVLW      46
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      110
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,126 :: 		EEPROM_Write(3*16, 3);
	MOVLW      48
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      3
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,127 :: 		EEPROM_Write(3*16+1, 'F');
	MOVLW      49
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      70
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,128 :: 		EEPROM_Write(3*16+2, 'I');
	MOVLW      50
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      73
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,129 :: 		EEPROM_Write(3*16+3, 'N');
	MOVLW      51
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      78
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,130 :: 		EEPROM_Write(3*16+4, 'K');
	MOVLW      52
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      75
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,131 :: 		EEPROM_Write(3*16+5, 'I');
	MOVLW      53
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      73
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,132 :: 		EEPROM_Write(3*16+11, 25);
	MOVLW      59
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      25
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,133 :: 		EEPROM_Write(3*16+12, 'M');
	MOVLW      60
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      77
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,134 :: 		EEPROM_Write(3*16+13, 'i');
	MOVLW      61
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      105
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,135 :: 		EEPROM_Write(3*16+14, 'n');
	MOVLW      62
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      110
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,138 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,139 :: 		ADC_Init();
	CALL       _ADC_Init+0
;Seminarska.c,140 :: 		typeUser = ADC_Read(7);
	MOVLW      7
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _typeUser+0
;Seminarska.c,141 :: 		C1ON_bit = 0;
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;Seminarska.c,142 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;Seminarska.c,143 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Seminarska.c,144 :: 		Delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	NOP
	NOP
;Seminarska.c,147 :: 		while(1){
L_main13:
;Seminarska.c,148 :: 		if(typeUser == 1){
	MOVF       _typeUser+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;Seminarska.c,149 :: 		do
L_main16:
;Seminarska.c,151 :: 		Lcd_Cmd(_LCD_Clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,152 :: 		Lcd_Out(1,1, "Vnesi");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,153 :: 		if(kp != 43 && kp != 45 && kp != 46 && kp != 47)
	MOVF       _kp+0, 0
	XORLW      43
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	MOVF       _kp+0, 0
	XORLW      45
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	MOVF       _kp+0, 0
	XORLW      46
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	MOVF       _kp+0, 0
	XORLW      47
	BTFSC      STATUS+0, 2
	GOTO       L_main21
L__main141:
;Seminarska.c,154 :: 		oldState = kp;
	MOVF       _kp+0, 0
	MOVWF      _oldState+0
L_main21:
;Seminarska.c,155 :: 		kp = 0;
	CLRF       _kp+0
;Seminarska.c,156 :: 		do{
L_main22:
;Seminarska.c,157 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;Seminarska.c,158 :: 		typeUser = ADC_Read(7);
	MOVLW      7
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _typeUser+0
;Seminarska.c,159 :: 		if(typeUser != 0){
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main25
;Seminarska.c,160 :: 		break;
	GOTO       L_main23
;Seminarska.c,161 :: 		}
L_main25:
;Seminarska.c,162 :: 		}while (!kp);
	MOVF       _kp+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main22
L_main23:
;Seminarska.c,163 :: 		if(typeUser != 0){
	MOVF       _typeUser+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main26
;Seminarska.c,164 :: 		break;
	GOTO       L_main17
;Seminarska.c,165 :: 		}
L_main26:
;Seminarska.c,166 :: 		switch (kp)
	GOTO       L_main27
;Seminarska.c,168 :: 		case 1: kp = 49; break; // 1
L_main29:
	MOVLW      49
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,169 :: 		case 2: kp = 52; break; // 4
L_main30:
	MOVLW      52
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,170 :: 		case 3: kp = 55; break; // 7
L_main31:
	MOVLW      55
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,171 :: 		case 4: kp = 74; break; // J
L_main32:
	MOVLW      74
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,172 :: 		case 5: kp = 50; break; // 2
L_main33:
	MOVLW      50
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,173 :: 		case 6: kp = 53; break; // 5
L_main34:
	MOVLW      53
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,174 :: 		case 7: kp = 56; break; // 8
L_main35:
	MOVLW      56
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,175 :: 		case 8: kp = 48; break; // 0
L_main36:
	MOVLW      48
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,176 :: 		case 9: kp = 51; break; // 3
L_main37:
	MOVLW      51
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,177 :: 		case 10: kp = 54; break; // 6
L_main38:
	MOVLW      54
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,178 :: 		case 11: kp = 57; break; // 9
L_main39:
	MOVLW      57
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,179 :: 		case 12: kp = 76; break; // L
L_main40:
	MOVLW      76
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,180 :: 		case 13: kp = 43; break; // +
L_main41:
	MOVLW      43
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,181 :: 		case 14: kp = 45; break; // Time
L_main42:
	MOVLW      45
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,182 :: 		case 15: kp = 46; break; // Add
L_main43:
	MOVLW      46
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,183 :: 		case 16: kp = 47; break; // Erase
L_main44:
	MOVLW      47
	MOVWF      _kp+0
	GOTO       L_main28
;Seminarska.c,184 :: 		}
L_main27:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main30
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main31
	MOVF       _kp+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main32
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main33
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main34
	MOVF       _kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main35
	MOVF       _kp+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_main36
	MOVF       _kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main37
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main38
	MOVF       _kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_main39
	MOVF       _kp+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_main40
	MOVF       _kp+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main41
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main42
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main43
	MOVF       _kp+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_main44
L_main28:
;Seminarska.c,186 :: 		if(oldState == 0){
	MOVF       _oldState+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main45
;Seminarska.c,187 :: 		if(kp == 43 || kp == 45 || kp == 46 || kp == 47){
	MOVF       _kp+0, 0
	XORLW      43
	BTFSC      STATUS+0, 2
	GOTO       L__main140
	MOVF       _kp+0, 0
	XORLW      45
	BTFSC      STATUS+0, 2
	GOTO       L__main140
	MOVF       _kp+0, 0
	XORLW      46
	BTFSC      STATUS+0, 2
	GOTO       L__main140
	MOVF       _kp+0, 0
	XORLW      47
	BTFSC      STATUS+0, 2
	GOTO       L__main140
	GOTO       L_main48
L__main140:
;Seminarska.c,188 :: 		greska();
	CALL       _greska+0
;Seminarska.c,189 :: 		}
L_main48:
;Seminarska.c,190 :: 		}
L_main45:
;Seminarska.c,192 :: 		if(kp == 43){// +
	MOVF       _kp+0, 0
	XORLW      43
	BTFSS      STATUS+0, 2
	GOTO       L_main49
;Seminarska.c,193 :: 		flagPlus = 1;
	MOVLW      1
	MOVWF      _flagPlus+0
;Seminarska.c,194 :: 		switch (oldstate)
	GOTO       L_main50
;Seminarska.c,196 :: 		case 49: oldState = 65; break; // A
L_main52:
	MOVLW      65
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,197 :: 		case 52: oldState = 68; break; // D
L_main53:
	MOVLW      68
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,198 :: 		case 55: oldState = 71; break; // G
L_main54:
	MOVLW      71
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,199 :: 		case 74: oldState = 86; break; // V
L_main55:
	MOVLW      86
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,200 :: 		case 50: oldState = 66; break; // B
L_main56:
	MOVLW      66
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,201 :: 		case 53: oldState = 69; break; // E
L_main57:
	MOVLW      69
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,202 :: 		case 56: oldState = 72; break; // H
L_main58:
	MOVLW      72
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,203 :: 		case 48: oldState = 75; break; // K
L_main59:
	MOVLW      75
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,204 :: 		case 51: oldState = 67; break; // C
L_main60:
	MOVLW      67
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,205 :: 		case 54: oldState = 70; break; // F
L_main61:
	MOVLW      70
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,206 :: 		case 57: oldState = 73; break; // I
L_main62:
	MOVLW      73
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,207 :: 		case 76: oldState = 89; break; // Y
L_main63:
	MOVLW      89
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,209 :: 		case 65: oldState = 77; break; // M
L_main64:
	MOVLW      77
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,210 :: 		case 68: oldState = 80; break; // P
L_main65:
	MOVLW      80
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,211 :: 		case 71: oldState = 83; break; // S
L_main66:
	MOVLW      83
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,212 :: 		case 86: oldState = 87; break; // W
L_main67:
	MOVLW      87
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,213 :: 		case 66: oldState = 78; break; // N
L_main68:
	MOVLW      78
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,214 :: 		case 69: oldState = 81; break; // Q
L_main69:
	MOVLW      81
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,215 :: 		case 72: oldState = 84; break; // T
L_main70:
	MOVLW      84
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,216 :: 		case 75: oldState = 88; break; // X
L_main71:
	MOVLW      88
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,217 :: 		case 67: oldState = 79; break; // O
L_main72:
	MOVLW      79
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,218 :: 		case 70: oldState = 82; break; // R
L_main73:
	MOVLW      82
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,219 :: 		case 73: oldState = 85; break; // U
L_main74:
	MOVLW      85
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,220 :: 		case 89: oldState = 90; break; // Z
L_main75:
	MOVLW      90
	MOVWF      _oldState+0
	GOTO       L_main51
;Seminarska.c,221 :: 		default: flag3 = 1;
L_main76:
	MOVLW      1
	MOVWF      _flag3+0
;Seminarska.c,222 :: 		}
	GOTO       L_main51
L_main50:
	MOVF       _oldState+0, 0
	XORLW      49
	BTFSC      STATUS+0, 2
	GOTO       L_main52
	MOVF       _oldState+0, 0
	XORLW      52
	BTFSC      STATUS+0, 2
	GOTO       L_main53
	MOVF       _oldState+0, 0
	XORLW      55
	BTFSC      STATUS+0, 2
	GOTO       L_main54
	MOVF       _oldState+0, 0
	XORLW      74
	BTFSC      STATUS+0, 2
	GOTO       L_main55
	MOVF       _oldState+0, 0
	XORLW      50
	BTFSC      STATUS+0, 2
	GOTO       L_main56
	MOVF       _oldState+0, 0
	XORLW      53
	BTFSC      STATUS+0, 2
	GOTO       L_main57
	MOVF       _oldState+0, 0
	XORLW      56
	BTFSC      STATUS+0, 2
	GOTO       L_main58
	MOVF       _oldState+0, 0
	XORLW      48
	BTFSC      STATUS+0, 2
	GOTO       L_main59
	MOVF       _oldState+0, 0
	XORLW      51
	BTFSC      STATUS+0, 2
	GOTO       L_main60
	MOVF       _oldState+0, 0
	XORLW      54
	BTFSC      STATUS+0, 2
	GOTO       L_main61
	MOVF       _oldState+0, 0
	XORLW      57
	BTFSC      STATUS+0, 2
	GOTO       L_main62
	MOVF       _oldState+0, 0
	XORLW      76
	BTFSC      STATUS+0, 2
	GOTO       L_main63
	MOVF       _oldState+0, 0
	XORLW      65
	BTFSC      STATUS+0, 2
	GOTO       L_main64
	MOVF       _oldState+0, 0
	XORLW      68
	BTFSC      STATUS+0, 2
	GOTO       L_main65
	MOVF       _oldState+0, 0
	XORLW      71
	BTFSC      STATUS+0, 2
	GOTO       L_main66
	MOVF       _oldState+0, 0
	XORLW      86
	BTFSC      STATUS+0, 2
	GOTO       L_main67
	MOVF       _oldState+0, 0
	XORLW      66
	BTFSC      STATUS+0, 2
	GOTO       L_main68
	MOVF       _oldState+0, 0
	XORLW      69
	BTFSC      STATUS+0, 2
	GOTO       L_main69
	MOVF       _oldState+0, 0
	XORLW      72
	BTFSC      STATUS+0, 2
	GOTO       L_main70
	MOVF       _oldState+0, 0
	XORLW      75
	BTFSC      STATUS+0, 2
	GOTO       L_main71
	MOVF       _oldState+0, 0
	XORLW      67
	BTFSC      STATUS+0, 2
	GOTO       L_main72
	MOVF       _oldState+0, 0
	XORLW      70
	BTFSC      STATUS+0, 2
	GOTO       L_main73
	MOVF       _oldState+0, 0
	XORLW      73
	BTFSC      STATUS+0, 2
	GOTO       L_main74
	MOVF       _oldState+0, 0
	XORLW      89
	BTFSC      STATUS+0, 2
	GOTO       L_main75
	GOTO       L_main76
L_main51:
;Seminarska.c,223 :: 		if(flag3){
	MOVF       _flag3+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main77
;Seminarska.c,224 :: 		greska();
	CALL       _greska+0
;Seminarska.c,225 :: 		}
L_main77:
;Seminarska.c,226 :: 		}else if(kp == 45){  //Time
	GOTO       L_main78
L_main49:
	MOVF       _kp+0, 0
	XORLW      45
	BTFSS      STATUS+0, 2
	GOTO       L_main79
;Seminarska.c,227 :: 		flagTime = 1;
	MOVLW      1
	MOVWF      _flagTime+0
;Seminarska.c,228 :: 		brStanici = brStanici * 10 + (oldState - 48);
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
;Seminarska.c,229 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,230 :: 		vreme = brStanici;
	MOVF       R0+0, 0
	MOVWF      _vreme+0
;Seminarska.c,231 :: 		brStanici = 0;
	CLRF       _brStanici+0
	CLRF       _brStanici+1
;Seminarska.c,232 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,233 :: 		}else if(kp == 46){  //Add
	GOTO       L_main80
L_main79:
	MOVF       _kp+0, 0
	XORLW      46
	BTFSS      STATUS+0, 2
	GOTO       L_main81
;Seminarska.c,234 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,235 :: 		if(flagTime){           //Ako sakame da vneseme vreme
	MOVF       _flagTime+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main82
;Seminarska.c,236 :: 		brStanici = brStanici * 10 + (oldState - 48);
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
;Seminarska.c,237 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,238 :: 		brCifri = vreme + 48;
	MOVLW      48
	ADDWF      _vreme+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _brCifri+0
;Seminarska.c,239 :: 		Lcd_Out(1,1, brCifri);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,240 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main83:
	DECFSZ     R13+0, 1
	GOTO       L_main83
	DECFSZ     R12+0, 1
	GOTO       L_main83
	NOP
;Seminarska.c,241 :: 		tmp = brStanici * 16 + 11;
	MOVLW      4
	MOVWF      R2+0
	MOVF       _brStanici+0, 0
	MOVWF      R0+0
	MOVF       _brStanici+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__main152:
	BTFSC      STATUS+0, 2
	GOTO       L__main153
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main152
L__main153:
	MOVLW      11
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	MOVWF      _tmp+1
;Seminarska.c,242 :: 		EEPROM_Write(tmp, vreme);
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _vreme+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,243 :: 		tmp += 2;
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
;Seminarska.c,244 :: 		EEPROM_Write(tmp, "M");
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      ?lstr_3_Seminarska+0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,245 :: 		tmp += 1;
	INCF       _tmp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tmp+1, 1
;Seminarska.c,246 :: 		EEPROM_Write(tmp, "i");
	MOVF       _tmp+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      ?lstr_4_Seminarska+0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,247 :: 		tmp += 1;
	INCF       _tmp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tmp+1, 1
;Seminarska.c,248 :: 		EEPROM_Write(tmp, "n");
	MOVF       _tmp+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      ?lstr_5_Seminarska+0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,249 :: 		clear();
	CALL       _clear+0
;Seminarska.c,250 :: 		}else{ //Obicno vnesuvanje na avtobuska linija bez vreme
	GOTO       L_main84
L_main82:
;Seminarska.c,251 :: 		if(oldState >= 48 && oldState <= 57){
	MOVLW      48
	SUBWF      _oldState+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main87
	MOVF       _oldState+0, 0
	SUBLW      57
	BTFSS      STATUS+0, 0
	GOTO       L_main87
L__main139:
;Seminarska.c,252 :: 		brStanici = brStanici * 10 + (oldState - 48);
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
;Seminarska.c,253 :: 		EEPROM_Write(brStanici * 16, brStanici);
	MOVLW      4
	MOVWF      R0+0
	MOVF       R2+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R0+0, 0
L__main154:
	BTFSC      STATUS+0, 2
	GOTO       L__main155
	RLF        FARG_EEPROM_Write_Address+0, 1
	BCF        FARG_EEPROM_Write_Address+0, 0
	ADDLW      255
	GOTO       L__main154
L__main155:
	MOVF       R2+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,254 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,255 :: 		tmp = brStanici * 16;
	MOVLW      4
	MOVWF      R0+0
	MOVF       _brStanici+0, 0
	MOVWF      _tmp+0
	MOVF       _brStanici+1, 0
	MOVWF      _tmp+1
	MOVF       R0+0, 0
L__main156:
	BTFSC      STATUS+0, 2
	GOTO       L__main157
	RLF        _tmp+0, 1
	RLF        _tmp+1, 1
	BCF        _tmp+0, 0
	ADDLW      255
	GOTO       L__main156
L__main157:
;Seminarska.c,256 :: 		for(i = 0; i < 15; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main88:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main158
	MOVLW      15
	SUBWF      _i+0, 0
L__main158:
	BTFSC      STATUS+0, 0
	GOTO       L_main89
;Seminarska.c,257 :: 		tmp += 1;
	INCF       _tmp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tmp+1, 1
;Seminarska.c,258 :: 		EEPROM_Write(tmp, linija[i]);
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
;Seminarska.c,256 :: 		for(i = 0; i < 15; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,259 :: 		}
	GOTO       L_main88
L_main89:
;Seminarska.c,260 :: 		}else{
	GOTO       L_main91
L_main87:
;Seminarska.c,261 :: 		greska();
	CALL       _greska+0
;Seminarska.c,262 :: 		}
L_main91:
;Seminarska.c,263 :: 		clear();
	CALL       _clear+0
;Seminarska.c,264 :: 		}
L_main84:
;Seminarska.c,265 :: 		}else if(kp == 47){  //Erase
	GOTO       L_main92
L_main81:
	MOVF       _kp+0, 0
	XORLW      47
	BTFSS      STATUS+0, 2
	GOTO       L_main93
;Seminarska.c,266 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,267 :: 		temp = brStanici * 16;
	MOVLW      4
	MOVWF      R0+0
	MOVF       _brStanici+0, 0
	MOVWF      _temp+0
	MOVF       _brStanici+1, 0
	MOVWF      _temp+1
	MOVF       R0+0, 0
L__main159:
	BTFSC      STATUS+0, 2
	GOTO       L__main160
	RLF        _temp+0, 1
	RLF        _temp+1, 1
	BCF        _temp+0, 0
	ADDLW      255
	GOTO       L__main159
L__main160:
;Seminarska.c,268 :: 		for(i = 0; i < 15; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main94:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main161
	MOVLW      15
	SUBWF      _i+0, 0
L__main161:
	BTFSC      STATUS+0, 0
	GOTO       L_main95
;Seminarska.c,269 :: 		EEPROM_Write(temp, 0);
	MOVF       _temp+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	CLRF       FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Seminarska.c,270 :: 		temp +=1;
	INCF       _temp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _temp+1, 1
;Seminarska.c,268 :: 		for(i = 0; i < 15; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,271 :: 		}
	GOTO       L_main94
L_main95:
;Seminarska.c,272 :: 		}else{
	GOTO       L_main97
L_main93:
;Seminarska.c,273 :: 		if(flagPlus){  //Ako stisneme +
	MOVF       _flagPlus+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main98
;Seminarska.c,274 :: 		linija[pomestuvanje] = oldState;
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
;Seminarska.c,275 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,276 :: 		pomestuvanje++;
	INCF       _pomestuvanje+0, 1
;Seminarska.c,277 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,278 :: 		flagPlus = 0;
	CLRF       _flagPlus+0
;Seminarska.c,279 :: 		}else if(oldState == 76 || oldState == 74){ // J ili L
	GOTO       L_main99
L_main98:
	MOVF       _oldState+0, 0
	XORLW      76
	BTFSC      STATUS+0, 2
	GOTO       L__main138
	MOVF       _oldState+0, 0
	XORLW      74
	BTFSC      STATUS+0, 2
	GOTO       L__main138
	GOTO       L_main102
L__main138:
;Seminarska.c,280 :: 		linija[pomestuvanje] = oldState;
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
;Seminarska.c,281 :: 		oldState = 0;
	CLRF       _oldState+0
;Seminarska.c,282 :: 		pomestuvanje++;
	INCF       _pomestuvanje+0, 1
;Seminarska.c,283 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,284 :: 		Lcd_Out(1,1, "J ili L");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,285 :: 		}else{
	GOTO       L_main103
L_main102:
;Seminarska.c,286 :: 		if(oldState >= 48 && oldState <= 57){   // Ako e vnesena brojka
	MOVLW      48
	SUBWF      _oldState+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main106
	MOVF       _oldState+0, 0
	SUBLW      57
	BTFSS      STATUS+0, 0
	GOTO       L_main106
L__main137:
;Seminarska.c,287 :: 		brStanici = brStanici * 10 + (oldState - 48);
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
;Seminarska.c,288 :: 		Lcd_Out(1,1, "Vnesena Brojka");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,289 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main107:
	DECFSZ     R13+0, 1
	GOTO       L_main107
	DECFSZ     R12+0, 1
	GOTO       L_main107
	NOP
;Seminarska.c,290 :: 		}
L_main106:
;Seminarska.c,291 :: 		}
L_main103:
L_main99:
;Seminarska.c,292 :: 		}
L_main97:
L_main92:
L_main80:
L_main78:
;Seminarska.c,293 :: 		}while(1);
	GOTO       L_main16
L_main17:
;Seminarska.c,294 :: 		}else{
	GOTO       L_main108
L_main15:
;Seminarska.c,295 :: 		i = 0;
	CLRF       _i+0
	CLRF       _i+1
;Seminarska.c,296 :: 		flag=0;
	CLRF       _flag+0
;Seminarska.c,297 :: 		brCifri = 0;
	CLRF       _brCifri+0
;Seminarska.c,298 :: 		strcpy(getTime, "GET TIME");
	MOVLW      _getTime+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr8_Seminarska+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Seminarska.c,299 :: 		while(1){
L_main109:
;Seminarska.c,300 :: 		if (UART1_Data_Ready()) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main111
;Seminarska.c,301 :: 		uart_rd = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;Seminarska.c,302 :: 		porakaOdEsurat[i] = uart_rd;
	MOVF       _i+0, 0
	ADDLW      _porakaOdEsurat+0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Seminarska.c,303 :: 		i++;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,304 :: 		sporedba = strcmp(getTime,porakaOdEsurat);
	MOVLW      _getTime+0
	MOVWF      FARG_strcmp_s1+0
	MOVLW      _porakaOdEsurat+0
	MOVWF      FARG_strcmp_s2+0
	CALL       _strcmp+0
	MOVF       R0+0, 0
	MOVWF      _sporedba+0
;Seminarska.c,305 :: 		if(sporedba == 0){
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main112
;Seminarska.c,306 :: 		flag=1;
	MOVLW      1
	MOVWF      _flag+0
;Seminarska.c,307 :: 		break;
	GOTO       L_main110
;Seminarska.c,308 :: 		}
L_main112:
;Seminarska.c,310 :: 		flag=0;
	CLRF       _flag+0
;Seminarska.c,312 :: 		}
L_main111:
;Seminarska.c,313 :: 		}
	GOTO       L_main109
L_main110:
;Seminarska.c,314 :: 		if(flag==1) {
	MOVF       _flag+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main114
;Seminarska.c,315 :: 		while(1){
L_main115:
;Seminarska.c,316 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main117
;Seminarska.c,317 :: 		uart_rd = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;Seminarska.c,318 :: 		if(uart_rd == 58){
	MOVF       R0+0, 0
	XORLW      58
	BTFSS      STATUS+0, 2
	GOTO       L_main118
;Seminarska.c,319 :: 		flagDveTocki = 1;
	MOVLW      1
	MOVWF      _flagDveTocki+0
;Seminarska.c,320 :: 		}else if(flagDveTocki == 0){
	GOTO       L_main119
L_main118:
	MOVF       _flagDveTocki+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main120
;Seminarska.c,321 :: 		saati = saati * 10 + (uart_rd - 48);
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
;Seminarska.c,322 :: 		}else{
	GOTO       L_main121
L_main120:
;Seminarska.c,323 :: 		minuti = minuti * 10 + (uart_rd - 48);
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
;Seminarska.c,324 :: 		brCifri++;
	INCF       _brCifri+0, 1
;Seminarska.c,325 :: 		if(brCifri == 2){
	MOVF       _brCifri+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main122
;Seminarska.c,326 :: 		saati *= 60;
	MOVF       _saati+0, 0
	MOVWF      R0+0
	MOVLW      60
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      _saati+0
;Seminarska.c,327 :: 		minuti += saati;
	MOVF       R0+0, 0
	ADDWF      _minuti+0, 1
;Seminarska.c,328 :: 		break;
	GOTO       L_main116
;Seminarska.c,329 :: 		}
L_main122:
;Seminarska.c,330 :: 		}
L_main121:
L_main119:
;Seminarska.c,331 :: 		}
L_main117:
;Seminarska.c,332 :: 		}
	GOTO       L_main115
L_main116:
;Seminarska.c,335 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;Seminarska.c,336 :: 		for(i=0;i<16;i++) {
	CLRF       _i+0
	CLRF       _i+1
L_main123:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main162
	MOVLW      16
	SUBWF      _i+0, 0
L__main162:
	BTFSC      STATUS+0, 0
	GOTO       L_main124
;Seminarska.c,337 :: 		tmp = i*16;
	MOVLW      4
	MOVWF      R2+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__main163:
	BTFSC      STATUS+0, 2
	GOTO       L__main164
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main163
L__main164:
	MOVF       R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	MOVWF      _tmp+1
;Seminarska.c,338 :: 		tmp += 11;
	MOVLW      11
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	MOVWF      _tmp+1
;Seminarska.c,341 :: 		vreme=EEPROM_Read(tmp);
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _vreme+0
;Seminarska.c,342 :: 		if(vreme == 65535){
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L__main165
	MOVLW      255
	XORWF      R0+0, 0
L__main165:
	BTFSS      STATUS+0, 2
	GOTO       L_main126
;Seminarska.c,343 :: 		continue;
	GOTO       L_main125
;Seminarska.c,344 :: 		}
L_main126:
;Seminarska.c,345 :: 		if(vreme > minuti) {
	MOVLW      128
	XORWF      _minuti+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _vreme+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main127
;Seminarska.c,346 :: 		razlika=vreme-minuti;
	MOVF       _minuti+0, 0
	SUBWF      _vreme+0, 0
	MOVWF      _razlika+0
;Seminarska.c,347 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Seminarska.c,348 :: 		stan = razlika;
	MOVF       _razlika+0, 0
	MOVWF      _stan+0
;Seminarska.c,351 :: 		if(razlika < min1Time) {
	MOVLW      128
	BTFSC      _razlika+0, 7
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _min1Time+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main166
	MOVF       _min1Time+0, 0
	SUBWF      _razlika+0, 0
L__main166:
	BTFSC      STATUS+0, 0
	GOTO       L_main128
;Seminarska.c,352 :: 		min2Time=min1Time;
	MOVF       _min1Time+0, 0
	MOVWF      _min2Time+0
	MOVF       _min1Time+1, 0
	MOVWF      _min2Time+1
;Seminarska.c,353 :: 		min1Time=razlika;
	MOVF       _razlika+0, 0
	MOVWF      _min1Time+0
	MOVLW      0
	BTFSC      _min1Time+0, 7
	MOVLW      255
	MOVWF      _min1Time+1
;Seminarska.c,354 :: 		min2Stanica=min1Stanica;
	MOVF       _min1Stanica+0, 0
	MOVWF      _min2Stanica+0
;Seminarska.c,355 :: 		min1Stanica=EEPROM_Read(i*16);
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
	MOVF       R0+0, 0
	MOVWF      _min1Stanica+0
;Seminarska.c,356 :: 		WordToStr(min1Stanica, textTest);
	MOVF       R0+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVLW      0
	BTFSC      FARG_WordToStr_input+0, 7
	MOVLW      255
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _textTest+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;Seminarska.c,357 :: 		}
	GOTO       L_main129
L_main128:
;Seminarska.c,358 :: 		else if(razlika<min2Time && razlika!=min1Time) {
	MOVLW      128
	BTFSC      _razlika+0, 7
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _min2Time+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main169
	MOVF       _min2Time+0, 0
	SUBWF      _razlika+0, 0
L__main169:
	BTFSC      STATUS+0, 0
	GOTO       L_main132
	MOVLW      0
	BTFSC      _razlika+0, 7
	MOVLW      255
	XORWF      _min1Time+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main170
	MOVF       _min1Time+0, 0
	XORWF      _razlika+0, 0
L__main170:
	BTFSC      STATUS+0, 2
	GOTO       L_main132
L__main136:
;Seminarska.c,359 :: 		min2Time=razlika;
	MOVF       _razlika+0, 0
	MOVWF      _min2Time+0
	MOVLW      0
	BTFSC      _min2Time+0, 7
	MOVLW      255
	MOVWF      _min2Time+1
;Seminarska.c,360 :: 		min2Stanica=EEPROM_Read(i*16);
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
	MOVWF      _min2Stanica+0
;Seminarska.c,361 :: 		}
L_main132:
L_main129:
;Seminarska.c,362 :: 		}
L_main127:
;Seminarska.c,363 :: 		}
L_main125:
;Seminarska.c,336 :: 		for(i=0;i<16;i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Seminarska.c,363 :: 		}
	GOTO       L_main123
L_main124:
;Seminarska.c,365 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;Seminarska.c,366 :: 		pomestuvanje = 0;
	CLRF       _pomestuvanje+0
;Seminarska.c,367 :: 		pecati();
	CALL       _pecati+0
;Seminarska.c,368 :: 		Delay_ms(20);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main133:
	DECFSZ     R13+0, 1
	GOTO       L_main133
	DECFSZ     R12+0, 1
	GOTO       L_main133
	NOP
	NOP
;Seminarska.c,369 :: 		Lcd_Out(2,1, "KRAJ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_Seminarska+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Seminarska.c,370 :: 		Delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main134:
	DECFSZ     R13+0, 1
	GOTO       L_main134
	DECFSZ     R12+0, 1
	GOTO       L_main134
	NOP
	NOP
;Seminarska.c,371 :: 		}
L_main114:
;Seminarska.c,372 :: 		}
L_main108:
;Seminarska.c,373 :: 		}
	GOTO       L_main13
;Seminarska.c,374 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
