#include <stdio.h>
#include <stdbool.h>
#include "tinypty.h"

char buf[100];
int main(){
  printf("starting!...\n");
  init_pty();
  unsigned count=0;
  while(true){
    char rx ;
    count++;
    if(count%9999999==0){
      sprintf(buf,"\n\rHello from master;%d\n\r",count);
      pty_write_str(buf);
      continue;
    }
    if((rx = pty_read_byte())){
      if(rx=='\r'){
        pty_write_str("\n\r");
        printf("\n\r");
      }
      printf("%c",rx);
      pty_write_byte(rx);
      fflush(stdout);
    }
  }
}

