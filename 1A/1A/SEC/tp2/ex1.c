#include <unistd.h>
#include <stdio.h>
#include <signal.h>

void handler(int sig) {
    printf("Numéro du signal : %d\n", sig);
}

int main (int argc, char* argv[]) {
    int errorCode;
    struct sigaction theSigaction;
    theSigaction.sa_handler = handler;


    for (unsigned int i = 1; i < NSIG; i++){
	if (i == SIGKILL || i == SIGSTOP ) {
		continue;
	}
    errorCode = sigaction(i, &theSigaction, NULL);
    if (errorCode ==-1){
	printf("%d...\n",i);
	perror("sigaction");
}
}
    while(1) {
	for (int j = 0; j<5; j++){
		sleep(1);
	}
	printf("Toujours actif");
	pause();
    }
    return 0;
}
