char keypadPort at PORTD;

sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;

char txt[20];
char kp = 0, oldState = 0, oldOldState = 0;
int tmp = 0;
short typeUser = 0;

short flagTime = 0, flagPlus = 0, flag3 = 0, flag = 0, flagDveTocki = 0;
short pomestuvanje = 0, vreme = 0;
int temp = 0, brStanici = 0;
int linija[16];
short minuti = 0, saati = 0;
short min1Stanica = 0, min2Stanica = 0;
short min1Time = 1440, min2Time = 1440;
short razlika=0,stanica=0;
char proba = 0, uart_rd;
char citaj;
short j = 0, brCifri = 0;
int i = 0;


void greska(){
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Out(1,1, "Greshka");
     Delay_ms(10);
     oldState=kp=0;
     brCifri = 0;
     brStanici = 0;
     flagPlus = 0;
     flag3 = 0;
}

void clear(){
     oldState=kp=0;
     brCifri = 0;
     brStanici = 0;
     flagPlus = 0;
     flag3 = 0;
}

void main() {
     Keypad_Init();
     ANSEL = 0x80;
     ANSELH = 0;
     TRISA = 0xFF;
     Lcd_Init();
     Lcd_Cmd(_LCD_Clear);
     Lcd_Cmd(_LCD_CURSOR_OFF);
     ADC_Init();
     typeUser = ADC_Read(7);
     WordToStr(typeUser, txt);
     Lcd_Out(1,1, txt);
     
     C1ON_bit = 0;
     C2ON_bit = 0;
     UART1_Init(9600);
     Delay_ms(50);
     
     while(1){
       if(typeUser == 0){
       do
          {
          Lcd_Cmd(_LCD_Clear);
          Lcd_Out(1,1, "Vnesi");
          if(kp != 43 && kp != 45 && kp != 46 && kp != 47)
              oldState = kp;
          kp = 0;
          do{
          kp = Keypad_Key_Click();
          typeUser = ADC_Read(7);
          if(typeUser != 0){
           break;
          }
          }while (!kp);
          if(typeUser != 0){
           break;
          }
          switch (kp)
          {
          case 1: kp = 49; break; // 1
          case 2: kp = 52; break; // 4
          case 3: kp = 55; break; // 7
          case 4: kp = 74; break; // J
          case 5: kp = 50; break; // 2
          case 6: kp = 53; break; // 5
          case 7: kp = 56; break; // 8
          case 8: kp = 48; break; // 0
          case 9: kp = 51; break; // 3
          case 10: kp = 54; break; // 6
          case 11: kp = 57; break; // 9
          case 12: kp = 76; break; // L
          case 13: kp = 43; break; // +
          case 14: kp = 45; break; // Time
          case 15: kp = 46; break; // Add
          case 16: kp = 47; break; // Erase
          }

          if(oldState == 0){
           if(kp == 43 || kp == 45 || kp == 46 || kp == 47){
             greska();
           }
          }

          if(kp == 43){// +
          flagPlus = 1;
           switch (oldstate)
                {
                 case 49: oldState = 65; break; // A
                 case 52: oldState = 68; break; // D
                 case 55: oldState = 71; break; // G
                 case 74: oldState = 86; break; // V
                 case 50: oldState = 66; break; // B
                 case 53: oldState = 69; break; // E
                 case 56: oldState = 72; break; // H
                 case 48: oldState = 75; break; // K
                 case 51: oldState = 67; break; // C
                 case 54: oldState = 70; break; // F
                 case 57: oldState = 73; break; // I
                 case 76: oldState = 89; break; // Y

                 case 65: oldState = 77; break; // M
                 case 68: oldState = 80; break; // P
                 case 71: oldState = 83; break; // S
                 case 86: oldState = 87; break; // W
                 case 66: oldState = 78; break; // N
                 case 69: oldState = 81; break; // Q
                 case 72: oldState = 84; break; // T
                 case 75: oldState = 88; break; // X
                 case 67: oldState = 79; break; // O
                 case 70: oldState = 82; break; // R
                 case 73: oldState = 85; break; // U
                 case 89: oldState = 90; break; // Z
                 default: flag3 = 1;
                }
                if(flag3){
                 greska();
                }
          }else if(kp == 45){  //Time
           flagTime = 1;
           brStanici = brStanici * 10 + (oldState - 48);
           oldState = 0;
           vreme = brStanici;
           brStanici = 0;
           brCifri = 0;
          }else if(kp == 46){  //Add
            Lcd_Cmd(_LCD_CLEAR);
            if(flagTime){           //Ako sakame da vneseme vreme
              brStanici = brStanici * 10 + (oldState - 48);
              Lcd_Cmd(_LCD_CLEAR);
              brCifri = vreme + 48;
              Lcd_Out(1,1, brCifri);
              Delay_ms(10);
              tmp = brStanici * 16 + 11;
              EEPROM_Write(tmp, vreme);
              brCifri = 0;
              flagTime = 0;
            }else{ //Obicno vnesuvanje na avtobuska linija bez vreme
                if(oldState >= 48 && oldState <= 57){
                 brStanici = brStanici * 10 + (oldState - 48);
                 EEPROM_Write(brStanici * 16, brStanici);
                 brCifri = 0;
                 tmp = brStanici * 16;
                for(i = 0; i < 15; i++){
                 tmp += 1;
                 EEPROM_Write(tmp, linija[i]);
                 }
                }else{
                 greska();
                }
                brStanici = 0;
                clear();
            }
          }else if(kp == 47){  //Erase
          Lcd_Cmd(_LCD_CLEAR);
          temp = brStanici * 16;
              for(i = 0; i < 15; i++){
                EEPROM_Write(temp, 0);
                temp +=1;
              }
          }else{
             if(flagPlus){  //Ako stisneme +
               linija[pomestuvanje] = oldState;
               oldState = 0;
               pomestuvanje++;
               brCifri = 0;
               flagPlus = 0;
              }else if(oldState == 76 || oldState == 74){ // J ili L
                 linija[pomestuvanje] = oldState;
                 oldState = 0;
                 pomestuvanje++;
                 Lcd_Cmd(_LCD_CLEAR);
                 Lcd_Out(1,1, "J ili L");
                 brCifri = 0;
              }else{
               if(oldState >= 48 && oldState <= 57){   // Ako e vnesena brojka
                brStanici = brStanici * 10 + (oldState - 48);
                Lcd_Out(1,1, "Vnesena Brojka");
                Delay_ms(10);
               }
              }
            }
   }while(1);
  }else{
       i = 0;
        brCifri = 0;
        Lcd_Cmd(_LCD_CLEAR);
        Lcd_Out(1,1, "Korisnicki");
        strcpy(txt, "GET TIME");
       while(1){
         if (UART1_Data_Ready()) {
           if(!flag){
              uart_rd = UART1_Read();
                if(uart_rd == txt[i]){
                 i++;
                }else{
                 i = 0;
                }
               if(i == 8){
                flag = 1;
               }
            }else{
             uart_rd = UART1_Read();
             if(uart_rd == 58){
                  flagDveTocki = 1;
                  continue;
             }else if(flagDveTocki == 0){
              saati = saati * 10 + (uart_rd - 48);
             }else{
               minuti = minuti * 10 + (uart_rd - 48);
               brCifri++;
               if(brCifri == 2){
                saati *= 60;
                minuti += saati;
                break;
               }
              }
            }
          }
          }
//          najdiNajmali;
            i=0;
            for(i=0;i<16;i++) {
              tmp = i*16;
              tmp += 11;
              vreme=EEPROM_Read(tmp);
              if(vreme>minuti) {
                razlika=vreme-minuti;
                if(razlika<min1Time) {
                  min2Time=min1Time;
                  min1Time=razlika;
                  min2Stanica=min1Stanica;
                  min1Stanica=EEPROM_Read(i*16);
                }
                else if(razlika<min2Time && razlika!=min1Time) {
                  min2Time=razlika;
                  min2Stanica=EEPROM_Read(i*16);
                }
              }
            }

          Lcd_Cmd(_LCD_CLEAR);
          Lcd_Out(1,1, txt);
          i=0;
          for(i=0;i<16;i++) {
            stanica=EEPROM_Read(i*16);
            if(stanica==min1Stanica) {
              Lcd_Out(1,1,stanica);
              Lcd_Out_Cp(" ");
              j=0;
              for(j=1;j<=10;j++) {
                citaj=EEPROM_Read(i*16+j);
                Lcd_Out_Cp(citaj);
              }
              vreme=EEPROM_Read(i*16+11);
              razlika=vreme-minuti;
              Lcd_Out_Cp(razlika);
              Lcd_Out_Cp("Min");
              Delay_ms(10);
            }
            if(stanica==min2Stanica) {
              Lcd_Out(2,1,stanica);
              Lcd_Out_Cp(" ");
              j=0;
              for(j=1;j <= 10;j++) {
                citaj=EEPROM_Read(i*16+j);
                Lcd_Out_Cp(citaj);
              }
              vreme=EEPROM_Read(i*16+11);
              razlika=vreme-minuti;
              Lcd_Out_Cp(razlika);
              Lcd_Out_Cp("Min");
            }
          }
          Delay_ms(10);
    }
  }
}