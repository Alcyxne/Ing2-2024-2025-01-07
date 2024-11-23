Create trophy networks
#include <stdio.h>
#include <stdlib.h>

#define MAX_SPECIES 10

// Structure pour représenter une espèce
typedef struct {
    char name[50];
    float biomass; // Biomasse de l'espèce
} Species;

// Afficher le réseau trophique (matrice d'adjacence)
void displayNetwork(int matrix[MAX_SPECIES][MAX_SPECIES], Species species[], int n) {
    printf("\nRéseau Trophique :\n");
    printf("   ");
    for (int i = 0; i < n; i++) {
        printf("%s ", species[i].name);
    }
    printf("\n");
    
    for (int i = 0; i < n; i++) {
        printf("%s ", species[i].name);
        for (int j = 0; j < n; j++) {
            printf("  %d ", matrix[i][j]);
        }
        printf("\n");
    }
}

// Ajouter une interaction trophique
void addInteraction(int matrix[MAX_SPECIES][MAX_SPECIES], int prey, int predator) {
    matrix[prey][predator] = 1; // Le prédateur dépend de la proie
}

// Simuler une dynamique simplifiée des biomasses
void simulateDynamics(int matrix[MAX_SPECIES][MAX_SPECIES], Species species[], int n, int steps) {
    for (int step = 0; step < steps; step++) {
        printf("\nÉtat au pas de temps %d :\n", step + 1);
        for (int i = 0; i < n; i++) {
            float loss = 0.1 * species[i].biomass; // Perte naturelle
            float gain = 0;

            // Calcul des gains de biomasse depuis les proies
            for (int j = 0; j < n; j++) {
                if (matrix[j][i] == 1) { // Si j est une proie de i
                    gain += 0.05 * species[j].biomass; // Gain proportionnel
                }
            }

            // Mise à jour de la biomasse
            species[i].biomass = species[i].biomass + gain - loss;

            // Empêcher des biomasses négatives
            if (species[i].biomass < 0) {
                species[i].biomass = 0;
            }

            printf("%s : Biomasse = %.2f\n", species[i].name, species[i].biomass);
        }
    }
}

int main() {
    int n; // Nombre d'espèces
 
