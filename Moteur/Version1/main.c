// /Users/sylvainb/documents/Atelier_c01n/Boxels/moteur


#include <avr/io.h>
#include <inttypes.h>
#include <avr/interrupt.h>

#define true 1
#define false 0
#define FOSC 16000000							// Fréquence de l'oscillateur en Hz
typedef int bool;

volatile uint8_t pasA[4];
volatile uint8_t pasB[4];
volatile uint8_t direction[8];
volatile uint8_t compteurPas;
volatile bool sensHoraire;

ISR(TIMER0_COMPA_vect) { 					// Routine d'intarruption du TIMER0
    PORTC = pasB[compteurPas];
    if (compteurPas < 3) {
        compteurPas++;
    } else {
        compteurPas = 0;
    }
    TCNT0 = 0; // REmise à zéro du compteur
}

void init(void) {
    uint8_t i;
    for (i = 0; i < 8; i++) {
        direction[i] = 0; // O : neutre, 1 : sens anti-horaire, 2 sens horaire
    }
    direction[5] = 1;
    compteurPas = 0;
    /*
    sensHoraire = false;
    if (sensHoraire) {
        pas[0] = 0b00001000;
        pas[1] = 0b00000000;
        pas[2] = 0b00000100;
        pas[3] = 0B00001100;
        
    } else {
        pas[0] = 0b00001100;
        pas[1] = 0b00000100;
        pas[2] = 0b00000000;
        pas[3] = 0B00001000;
    }*/
    uint8_t pas;
    for (pas = 0; pas < 4; pas++) {
        for (i = 0; i < 4; i++) { // Parcourt les directions des moteurs du PORTB
            switch (direction[i]) {
                case 0: // neutre
                    switch (pas) {
                        case 0: // pas 1
                            pasA[pas] &= ~(1<<(2 * i));
                            pasA[pas] &= ~(1<<(2 * i + 1));
                            break;
                        case 1: // pas 2
                            pasA[pas] &= ~(1<<(2 * i));
                            pasA[pas] &= ~(1<<(2 * i + 1));
                            break;
                        case 2: // pas 3
                            pasA[pas] &= ~(1<<(2 * i));
                            pasA[pas] &= ~(1<<(2 * i + 1));
                            break;
                        case 3: // pas 4
                            pasA[pas] &= ~(1<<(2 * i));
                            pasA[pas] &= ~(1<<(2 * i + 1));
                            break;
                    }
                    break;
                case 1: // sens horaire
                    switch (pas) {
                        case 0: // pas 1
                            pasA[pas] |= (1 << (2 * i));
                            pasA[pas] &= ~(1 << (2 * i + 1));
                            break;
                        case 1:
                            pasA[pas] &= ~(1<<(2 * i));
                            pasA[pas] &= ~(1<<(2 * i + 1));
                            break;
                        case 2:
                            pasA[pas] &= ~(1<<(2 * i));
                            pasA[pas] |= (1 << (2 * i + 1));
                            break;
                        case 3:
                            pasA[pas] |= (1 << (2 * i));
                            pasA[pas] |= (1 << (2 * i + 1));
                            break;
                    }
                    break;
                case 2: // sens anti-horaire
                    switch (pas) {
                        case 0: // pas 1
                            pasA[pas] |= (1 << (2 * i));
                            pasA[pas] |= (1 << (2 * i + 1));
                            break;
                        case 1:
                            pasA[pas] &= ~(1<<(2 * i));
                            pasA[pas] |= (1 << (2 * i + 1));
                            break;
                        case 2:
                            pasA[pas] &= ~(1<<(2 * i));
                            pasA[pas] &= ~(1<<(2 * i + 1));
                            break;
                        case 3:
                            pasA[pas] |= (1 << (2 * i));
                            pasA[pas] &= ~(1 << (2 * i + 1));
                            break;
                    }
                    break;
                default:
                    break;
            }
        }
        for ( i = 0; i < 4; i++) { // Parcourt les directions des moteurs du PORTB
            switch (direction[i + 4]) {
                case 0: // neutre
                    switch (pas) {
                        case 0: // pas 1
                            pasB[pas] &= ~(1<<(2 * i));
                            pasB[pas] &= ~(1<<(2 * i + 1));
                            break;
                        case 1:
                            pasB[pas] &= ~(1<<(2 * i));
                            pasB[pas] &= ~(1<<(2 * i + 1));
                            break;
                        case 2:
                            pasB[pas] &= ~(1<<(2 * i));
                            pasB[pas] &= ~(1<<(2 * i + 1));
                            break;
                        case 3:
                            pasB[pas] &= ~(1<<(2 * i));
                            pasB[pas] &= ~(1<<(2 * i + 1));
                            break;
                    }
                    break;
                case 1: // sens horaire
                    switch (pas) {
                        case 0: // pas 1
                            pasB[pas] |= (1 << (2 * i));
                            pasB[pas] &= ~(1 << (2 * i + 1));
                            break;
                        case 1:
                            pasB[pas] &= ~(1<<(2 * i));
                            pasB[pas] &= ~(1<<(2 * i + 1));
                            break;
                        case 2:
                            pasB[pas] &= ~(1<<(2 * i));
                            pasB[pas] |= (1 << (2 * i + 1));
                            break;
                        case 3:
                            pasB[pas] |= (1 << (2 * i));
                            pasB[pas] |= (1 << (2 * i + 1));
                            break;
                    }
                    break;
                case 2: // sens anti-horaire
                    switch (pas) {
                        case 0: // pas 1
                            pasB[pas] |= (1 << (2 * i));
                            pasB[pas] |= (1 << (2 * i + 1));
                            break;
                        case 1:
                            pasB[pas] &= ~(1<<(2 * i));
                            pasB[pas] |= (1 << (2 * i + 1));
                            break;
                        case 2:
                            pasB[pas] &= ~(1<<(2 * i));
                            pasB[pas] &= ~(1<<(2 * i + 1));
                            break;
                        case 3:
                            pasB[pas] |= (1 << (2 * i));
                            pasB[pas] &= ~(1 << (2 * i + 1));
                            break;
                    }
                    break;
                default:
                    break;
            }
        }
    }
}

void init_timer0(void) {
    TCCR0A = 0;
    TCCR0B = 0b000000100;
    OCR0A = 78; // Vitesse max 78 => 200 tours / minute
    TIMSK0 = 0b00000010; // OCIE0A : Permet interruption comparateur A
    
}

int main(void) {
    init();
    init_timer0();         // Initialize USART0
    DDRC |= (1<<PC3) | (1<<PC2);	      // Met en sortie les ports du uC
    DDRD |= (1<<PD2);
    sei();               // Enable interrupts globally

    while(1) {
        PORTD &= ~(1<<PD2);
    }
}

