#include <unistd.h>
#include <stdio.h>
#include <signal.h>
//Réponse aux questions
//1
// Deux signaux SIGUSR2 seront affichés car SIGINT et SIGUSR1 sont 
//masqués au moment de l'envoi. Puis lorsque l'on démasque le signal SIGUSR1,
//un seul signal est affiché.
//2
//Les deux signaux SIGUSR2 sont affichés en premier et ensuite viens le signal SIGUSR1
//qui est démasqué.
//3
//Le message de terminaison apparait au bout de 25 secondes environ.
void handler(int sig) {
    printf("Numéro du signal : %d\n", sig);
}

int main (int argc, char* argv[]) {
    struct sigaction theSigaction;
    theSigaction.sa_handler = handler;


    sigaction(10, &theSigaction, NULL);
    sigaction(12, &theSigaction, NULL);

//Masquage des signaux SIGINT et SIGUSR1

    sigset_t ens_signaux;
    sigemptyset(&ens_signaux);
    sigaddset(&ens_signaux, SIGINT);
    sigaddset(&ens_signaux, SIGUSR1);
    sigprocmask(SIG_BLOCK,&ens_signaux,NULL);

    for (unsigned i = 0; i<10; i++) {
	sleep(1);
    }
//Envoi de 2 signaux SIGUSR1
    kill(getpid(), 10);
    kill(getpid(), 10);

    for (unsigned i = 0; i<5; i++) {
	sleep(1);
    }
//Envoi de 2 signaux SIGUSR2

    kill(getpid(), 12);
    kill(getpid(), 12);

    
//Démasquage de SIGUSR1
sigset_t a_enlever;
    sigemptyset(&a_enlever);
    sigaddset(&a_enlever, SIGUSR1);
    sigprocmask(SIG_UNBLOCK,&a_enlever,NULL);
    for (unsigned i = 0; i<10; i++) {
	sleep(1);
    }

//Démasquage de SIGINT
    sigaddset(&a_enlever, SIGINT);
    sigprocmask(SIG_UNBLOCK,&a_enlever, NULL);
    printf("Fin du programme \n");

    return 0;
}









