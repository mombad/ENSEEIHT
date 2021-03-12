#include <stdio.h>  /*printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <sys/wait.h> /* wait */

int main (int argc, char *argv[]) {
    char buf[30];
    while (1) {
        printf("Quelle est votre commande ?");
        scanf("\%s", buf) ; 	       
        int f = fork();
	if (f<0){
		exit(-1);
	} else if (f==0){
	        int E = execlp(buf,buf,NULL);	
		if (E==-1) {
			printf("La commande s'est mal exécutée \n");
			}
		exit(1);

	}else{
		wait(0);
      		 }
	}
}
        
