#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
#include "readcmd.h"

void execut(struct cmdline *commande){
    char* listecommande[]={"cd","exit"};
    if (commande != NULL){
	if (commande->seq[0] != NULL){
        	if(!strcmp(commande->seq[0][0],listecommande[0])){
            		chdir(commande->seq[0][1]);
        	} else if(!strcmp(commande->seq[0][0],listecommande[1])){
            		exit(0);
        	} else {    
            		int f = fork();
            		int *status = 0;       
            		int option = 0;   
            		if (f<0){
	        	    	exit(-1);
            		} else if (f==0){ 
				int E = execvp(commande->seq[0][0],commande->seq[0]);             
                		if (E==-1) {
    		        		printf("La commande s'est mal exécutée \n");
		        	}
	            		exit(1);
	        	} else {
               			if (commande->backgrounded == NULL){
                    			waitpid(f,status,option);
                		}
      			}
	    	}
    	}
    }
}

int main (int argc, char *argv[]) {
    struct cmdline *commande;
    while (1) {
        printf("Mohamed@Minishell:~");
        char pwd[200];
        if (getcwd(pwd, sizeof(pwd)) != NULL) {
            printf("%s",pwd);
            printf("$ ");
	}
        commande = readcmd();
        execut(commande);
	}
    return 0;
}

