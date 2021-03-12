package factions;

public interface Capacite {

	/* Obtenir une description de la capacité */
	void getCAPACITE();
	
	/* Démarrage du temps de recharge pour les capacité actives, le temps de recharge est fixé en fonction de la puissance de la 
	/* capacité. Il faut utiliser cette méthode au début de la partie et après chaque utilisation d'une capacité active. */
	void initialisationTPSRECHARGE();

	/* Capacité active : Active la capacité si cette dernière est rechargée. */
    /* Capacité passive : déclenche cette capacité de façon permanente */
	void useCAPACITE();

}
