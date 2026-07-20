.text
main:
    li t0, 5
    
    li t1, 10
 
    add t2, t0, t1    
    
  
    li a7, 10         # System code 10 tells the simulator to exit
    ecall             # "Environment Call" - executes the exit command