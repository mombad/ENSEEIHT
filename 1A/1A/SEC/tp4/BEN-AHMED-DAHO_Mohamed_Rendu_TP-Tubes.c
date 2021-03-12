#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

int main (void) {
    int p[2];
    int q[2];
    int pid1;
    int pid2;

    if (pipe(p) != 0){
        printf("Erreur pipe 1");
        exit(-1);
    }

    pid1 = fork();

    if (pid1<0) {
        printf("Erreur fils 1");
        exit(-1);
    } else if (pid1==0) {

        if (pipe(q) != 0){
            printf("Erreur pipe 2");
            exit(-1);
        }

        pid2 = fork();
        if (pid2<0) {
            printf("Erreur fils 2");
            exit(-1);

        } else if (pid2==0) {
            dup2(q[0],0);
            close(p[0]);
            close(p[1]);
            close(q[1]);
            execlp("wc","wc","-l",NULL);

        } else {
            dup2(p[0],0);
            dup2(q[1],1);
            close(p[1]);
            close(q[0]);
            execlp("grep","grep","nom_utilisateur",NULL);
        }
    } else {
    
        dup2(p[1],1);
        close(p[0]);
        execlp("who","who",NULL,NULL);
    }
}








    
