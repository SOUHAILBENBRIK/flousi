#include <Arduino.h>

// Déclaration des pins   vous pouvez utiliser ces pin si vous allez travailler avec 8 capteurs27,26,25,33,32,15,2,4
const int Sensor0 = A7;    
const int Sensor1 = A6;
const int Sensor2 = A5;
const int Sensor3 = A4;
const int Sensor4 = A3;
const int Sensor5 = A2;
const int Sensor6 = A1;
const int Sensor7 = A0;
const int SensorRight = 2;
const int SensorLeft  = 4;

const int R_Motor_1 = 10; 
const int R_Motor_2 = 9; 
const int L_Motor_1 = 6; 
const int L_Motor_2 = 5; 
const int RM=3;
const int LM=11;

// Definir les vitesses 
int MIN_SPEED =   0;
int MAX_SPEED = 100;
int REF_SPEED = 85;

// Definir les constantes de correction PID
double kp = 0.2; //Propportionnel
double Ki = 0;   //Integrateur
double Kd = 0.5; //Dérivateur 

// Definir les variables de correction
int p=0,der=0,lastError=0,I;

// Definir les variables de l'algorithme 
int R,L,a,b,c,d,e,f,g,h; // pour la lecture des capteurs
int pos,po,virage=0; // position

bool line_detected; // Condition pour incrémenter le compteur 

int l=0; // compteur 



void setup() {
Serial.begin(9600);

//déclaration des Input/Output  
pinMode(Sensor0,INPUT);
pinMode(Sensor1,INPUT);
pinMode(Sensor2,INPUT);
pinMode(Sensor3,INPUT);
pinMode(Sensor4,INPUT);
pinMode(Sensor5,INPUT);
pinMode(Sensor6,INPUT);
pinMode(Sensor7,INPUT);
pinMode(SensorRight,INPUT);
pinMode(SensorLeft,INPUT);

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

R=digitalRead(SensorRight); // Capteur Droite(Right)
L=digitalRead(SensorLeft);  // Capteur Gauche(Left )

virage=R*1+L*10;  // presenter l'état de deux capteur en un seul variable afin d'optimiser et de simplifier  
Serial.println(virage);
  switch (virage) {
     case 0:  // les capteur R et L sur une surface Blanche 
     PID_control();Serial.print(po);
      break;
    case 1:  // le capteur R sur une surface Blanche et L sur une surface Noir  
      digitalWrite(L_Motor_1,MIN_SPEED ); digitalWrite(R_Motor_1,MAX_SPEED ); delay(100); 
       
      break;
    case 10: // le capteur L sur une surface Blanche et R sur une surface Noir     
      digitalWrite(L_Motor_1,MAX_SPEED );digitalWrite(R_Motor_1, MIN_SPEED);delay(100);
 
      break;
    case 11: // les capteur R et L sur une surface Noir 
     digitalWrite(L_Motor_1,MAX_SPEED );digitalWrite(R_Motor_1, MAX_SPEED);delay(100); // Forcer l'avance pour eviter les boucles infinie ( Parfois il faut activer cette condition à l'aide d'un compteur)
 
      break;
  }

}

int position() 
{ //lire les valeurs du capteur QTR
  a=digitalRead(Sensor0);  
  b=digitalRead(Sensor1);
  c=digitalRead(Sensor2);
  d=digitalRead(Sensor3);
  e=digitalRead(Sensor4);
  f=digitalRead(Sensor5);
  g=digitalRead(Sensor6);
  h=digitalRead(Sensor7);
  
  po = ((b*1000)+(c*2000)+(d*3000)+(e*4000)+(f*5000)+(g*6000)+(h*7000))/(a+b+c+d+e+f+g+h); 
  return po; // position instantané 
}

void PID_control() 
{
  int pos=position();

  int error = 3500 - pos; // erreur= consigne - valeur instantané  (3500 si 8RC)

   p = error;
  // I = error + I;
   der = error - lastError;
   lastError = error; 

  int motorSpeedChange = p*kp + der*Kd ;//+ I*Ki ; 

  analogWrite(L_Motor_1, constrain(REF_SPEED + motorSpeedChange, MIN_SPEED, MAX_SPEED));
  analogWrite(R_Motor_1, constrain(REF_SPEED - motorSpeedChange, MIN_SPEED, MAX_SPEED));
}

// Principe de fonctionnement d'un compteur 
// La variable l va compter le nombre d'intersection avec une ligne noir  "+"

/*if (line_detected == false)   
{
if (virage==11 ){l++;line_detected=true;} 
else if (virage==0 ) {line_detected=false;}
}
*/
