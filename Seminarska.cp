#line 1 "D:/Viktor/PersonalDocs/7.Projects/Microprocessor systems/Seminarska.c"
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

char textTest[20];
char kp = 0, oldState = 0;
int tmp = 0;
short typeUser = 0;
short countStanici = 0;
short flagTime = 0, flagPlus = 0, flag3 = 0, flagUart = 0, flagDveTocki = 0, flagVneseno = 0;
short pomestuvanje = 0, vreme = 0;
int temp = 0, brStanici = 0;
int linija[16];
char print[20];
short minuti = 0, saati = 0;
short min1Stanica = 100, min2Stanica = 100;
int min1Time = 1440, min2Time = 1440;
short razlika=0,stanica=0;
char uart_rd;
short j = 0, brCifri = 0;
short k;
int i = 0;
short sporedba = 100;
char getTime[20];
char porakaOdEsurat[20];


void TrimLeft(char *str) {
char count = 1;
 while (*str++ != 0) {
 if (*str != 32) {
 *(str - count--) = *str;
 }
 count++;
 }
}

void stavi(char neso){
 strncpy(print,neso,pomestuvanje);
 pomestuvanje++;
}

void pecatiMin(short q, int p, short red){
 k=1;
 temp = q * 16;
 temp++;
 WordToStr(q, print);
 TrimLeft(print);
 LCD_Out(red, 1, print);
 k++;
 LCD_Chr(red, k, 32);
 k++;
 for(i = 0; i < 9; i++){
 kp = EEPROM_Read(temp);
 if(kp > 64 && kp < 123){
 Lcd_Chr(red, k, kp);
 k++;
 }
 temp++;
 }
 k = 10;
 WordToStr(p, print);
 LCD_Chr(red, k, 32);
 k++;
 TrimLeft(print);
 Lcd_Out(red, k, print);
 temp+=2;
 for(i = 0; i < 3; i++){
 kp = EEPROM_Read(temp);
 Lcd_Chr_CP(kp);
 temp+=1;
 k++;
 }
}

void pecati(){
 Lcd_Cmd(_LCD_CLEAR);
 if(min1Stanica != 100){
 pecatiMin(min1Stanica, min1Time, 1);
 }
 if(min2Stanica != 100){
 pecatiMin(min2Stanica, min2Time, 2);
 }

}

void greska(){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1, "Greshka");
 Delay_ms(10);
 oldState=kp=0;
 brCifri = 0;
 brStanici = 0;
 flagPlus = 0;
 flag3 = 0;
 flagVneseno = 0;
 temp = 0;
}

void clear(){
 oldState=kp=0;
 brCifri = 0;
 brStanici = 0;
 flagPlus = 0;
 flag3 = 0;
 pomestuvanje = 0;
 flagTime = 0;
 flagVneseno = 0;
 temp = 0;
}

void main() {
 Keypad_Init();
 ANSEL = 0x80;
 ANSELH = 0;
 TRISA = 0xFF;
 Lcd_Init();
 Lcd_Cmd(_LCD_Clear);
#line 151 "D:/Viktor/PersonalDocs/7.Projects/Microprocessor systems/Seminarska.c"
 Lcd_Cmd(_LCD_CURSOR_OFF);

 typeUser = ADC_Read(7);
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
 case 1: kp = 49; break;
 case 2: kp = 52; break;
 case 3: kp = 55; break;
 case 4: kp = 74; break;
 case 5: kp = 50; break;
 case 6: kp = 53; break;
 case 7: kp = 56; break;
 case 8: kp = 48; break;
 case 9: kp = 51; break;
 case 10: kp = 54; break;
 case 11: kp = 57; break;
 case 12: kp = 76; break;
 case 13: kp = 43; break;
 case 14: kp = 45; break;
 case 15: kp = 46; break;
 case 16: kp = 47; break;
 }

 if(oldState == 0){
 if(kp == 43 || kp == 45 || kp == 46 || kp == 47){
 greska();
 }
 }

 if(kp == 43){
 flagPlus = 1;
 switch (oldstate)
 {
 case 49: oldState = 65; break;
 case 52: oldState = 68; break;
 case 55: oldState = 71; break;
 case 74: oldState = 86; break;
 case 50: oldState = 66; break;
 case 53: oldState = 69; break;
 case 56: oldState = 72; break;
 case 48: oldState = 75; break;
 case 51: oldState = 67; break;
 case 54: oldState = 70; break;
 case 57: oldState = 73; break;
 case 76: oldState = 89; break;

 case 65: oldState = 77; break;
 case 68: oldState = 80; break;
 case 71: oldState = 83; break;
 case 86: oldState = 87; break;
 case 66: oldState = 78; break;
 case 69: oldState = 81; break;
 case 72: oldState = 84; break;
 case 75: oldState = 88; break;
 case 67: oldState = 79; break;
 case 70: oldState = 82; break;
 case 73: oldState = 85; break;
 case 89: oldState = 90; break;
 default: flag3 = 1;
 }
 if(flag3){
 greska();
 }
 }else if(kp == 45){
 flagTime = 1;
 brStanici = brStanici * 10 + (oldState - 48);
 oldState = 0;
 vreme = brStanici;
 brStanici = 0;
 }else if(kp == 46){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2,1, "VIKAC");
 Delay_ms(10);
 if(flagTime){
 brStanici = brStanici * 10 + (oldState - 48);
 Lcd_Cmd(_LCD_CLEAR);
 for(i = 0; i < 16; i++){
 if(brStanici == EEPROM_Read(i * 16)){
 tmp = i * 16 + 11;
 EEPROM_Write(tmp, vreme);
 tmp += 2;
 EEPROM_Write(tmp, "M");
 tmp += 1;
 EEPROM_Write(tmp, "i");
 tmp += 1;
 EEPROM_Write(tmp, "n");
 }
 }
 clear();
 }else{
 if(oldState >= 48 && oldState <= 57){
 brStanici = brStanici * 10 + (oldState - 48);
 for(i = 0; i < 16; i++){
 if(brStanici == EEPROM_Read(i * 16)){
 temp = i * 16;
 flagVneseno = 1;
 }
 }
 if(flagVneseno == 0){
 EEPROM_Write(countStanici * 16, brStanici);
 tmp = countStanici * 16;
 for(i = 0; i < pomestuvanje; i++){
 tmp += 1;
 EEPROM_Write(tmp, linija[i]);
 }
 brCifri = 15 - pomestuvanje;
 for(i = 0; i < brCifri; i++){
 tmp += 1;
 EEPROM_Write(tmp, 0);
 }
 countStanici++;
 }else{
 greska();
 }
 }else{
 greska();
 }
 clear();
 }
 }else if(kp == 47){
 Lcd_Cmd(_LCD_CLEAR);
 temp = brStanici * 16;
 for(i = 0; i < 15; i++){
 EEPROM_Write(temp, 0);
 temp +=1;
 }
 }else{
 if(flagPlus){
 linija[pomestuvanje] = oldState;
 oldState = 0;
 pomestuvanje++;
 flagPlus = 0;
 }else if(oldState == 76 || oldState == 74){
 linija[pomestuvanje] = oldState;
 oldState = 0;
 pomestuvanje++;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1, "J ili L");
 }else{
 if(oldState >= 48 && oldState <= 57){
 brStanici = brStanici * 10 + (oldState - 48);
 Lcd_Out(1,1, "Vnesena Brojka");
 Delay_ms(10);
 }
 }
 }
 }while(1);
 }else{
 i = 0;
 flagUart=0;
 brCifri = 0;
 strcpy(getTime, "GET TIME");
 while(1){
 typeUser = ADC_Read(7);
 if(typeUser == 0)
 break;
 if (UART1_Data_Ready()) {
 uart_rd = UART1_Read();
 porakaOdEsurat[i] = uart_rd;
 i++;
 sporedba = strcmp(getTime,porakaOdEsurat);
 if(sporedba == 0){
 flagUart=1;
 break;
 }
 else{
 flagUart=0;
 }
 }
 }
 for(j = 0; j < 20; j++){
 porakaOdEsurat[j] = 0;
 }
 if(flagUart==1) {
 while(1){
 if(UART1_Data_Ready()){
 uart_rd = UART1_Read();

 if(uart_rd == 58){
 flagDveTocki = 1;

 Lcd_Out(2,1, "vIKAC");
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


 i=0;
 for(i=0;i<16;i++) {
 tmp = i*16;
 tmp += 11;
 vreme=EEPROM_Read(tmp);
 if(vreme == 65535){
 continue;
 }
 if(vreme > minuti) {
 razlika = vreme-minuti;
 Lcd_Cmd(_LCD_CLEAR);
 kp = razlika;
 if(razlika < min1Time) {
 min2Time=min1Time;
 min1Time=razlika;
 min2Stanica=min1Stanica;
 min1Stanica= i;
 WordToStr(min1Stanica, textTest);
 Lcd_Out(1,1,min1Stanica);
 }
 else if(razlika<min2Time && razlika!=min1Time) {
 min2Time=razlika;
 min2Stanica= i;
 }
 }
 }

 i=0;
 pomestuvanje = 0;
 pecati();

 Delay_ms(20);
 Lcd_Out(2,1, "KRAJ");
 Delay_ms(5);
 }
 }
 }
}
