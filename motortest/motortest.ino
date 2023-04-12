


const int R_Motor_1 = 5; 
const int R_Motor_2 = 9; 
const int L_Motor_1 = 6; 
const int L_Motor_2 = 10; 
const int RM=3;
const int LM=11;

// Definir les vitesses 
int MIN_SPEED =   0;
int MAX_SPEED = 180;
int REF_SPEED = 180;



void setup() {
Serial.begin(9600);



pinMode(R_Motor_1,OUTPUT);
pinMode(R_Motor_2,OUTPUT);
pinMode(L_Motor_1,OUTPUT);
pinMode(L_Motor_2,OUTPUT);
pinMode(LM,OUTPUT);
pinMode(RM,OUTPUT);

// Initialisation de la carte de puissance
digitalWrite(R_Motor_1,LOW);
digitalWrite(R_Motor_2,LOW);
digitalWrite(L_Motor_1,LOW);
digitalWrite(L_Motor_2,LOW);
digitalWrite(RM,HIGH);
digitalWrite(LM,HIGH);

}

void loop() {
fr();

}

void fr(){
  digitalWrite(L_Motor_1, HIGH);
  digitalWrite(L_Motor_2, HIGH );  
  delay(1000);
  digitalWrite(L_Motor_1, LOW);
  digitalWrite(L_Motor_2, LOW); 
  
}



