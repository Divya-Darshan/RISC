.data
msg: .string "Hello World\n"    # Store the text in memory

.text
main:
    # Print String
    li a0, 4                   # Call ID 4: Print String
    la a2, msg                 # Load memory address of msg into a1
    ecall                      # Execute print call

    # Exit Program
    li a0, 10                  # Call ID 10: Exit
    ecall