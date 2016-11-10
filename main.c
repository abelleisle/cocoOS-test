#include <cocoos.h>
#include <stdio.h>

static void hello_task(void) {
	task_open();
	for(;;) {
		//uart_send_string("Hello World!");
		task_wait( 20 );
	}
	task_close();
}

 

int main(void) {
	/* Setup ports, clock... */
	//system_init();
		    

	os_init();

	/* Create kernel objects */
	task_create( hello_task, 1, NULL, 0, 0 ); 

	os_start();
				 
	/* Will never end up here */
	return 0;
}
