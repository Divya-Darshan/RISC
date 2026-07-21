# Introduction to RISC-V
# LED Matrix Display (50x50), by Eduardo Corpeño (Scaled)

###################################################
# Description
#
# This assembly code scales the 10x10 LED Matrix logo 
# to fit a 50x50 LED Matrix display (5x5 per pixel block).
#
###################################################

# Code Section
.text

###################################################
# Main entry point.
# The program starts here, at address 0x00000000
###################################################

main:
    # Initializations
    li a0, 0x100      # Environment call for LED Matrix
    la s0, logo       # Pointer to 10x10 pixels array
    li s2, 0          # Logo x coordinate (0 to 9)

logo_x_loop:
    li s1, 0          # Logo y coordinate (0 to 9)

logo_y_loop:
    lw a2, 0(s0)      # a2 holds the current pixel color (0x00RRGGBB)
    
    # --- Block Calculation for 50x50 ---
    # Each 1x1 logo pixel becomes a 5x5 square on screen
    li t0, 5
    mul t1, s2, t0    # Start X = logo_x * 5
    addi t2, t1, 5    # End X   = Start X + 5
    
    mul t3, s1, t0    # Start Y = logo_y * 5
    addi t4, t3, 5    # End Y   = Start Y + 5

    # --- Draw 5x5 Pixel Block ---
    mv s4, t1         # Current Screen X
draw_block_x:
    mv s5, t3         # Current Screen Y
draw_block_y:
    slli a1, s4, 16   # Shift x coordinate in a1 (top 16 bits)
    or a1, a1, s5     # Join y coordinate in a1 (lower 16 bits)
    ecall             # Drive LED at {x,y} with color in a2

    addi s5, s5, 1    # Next screen Y
    bne s5, t4, draw_block_y

    addi s4, s4, 1    # Next screen X
    bne s4, t2, draw_block_x

    # --- Next Logo Pixel ---
    addi s0, s0, 4    # Next pixel word in array
    addi s1, s1, 1    # Next logo Y
    li t5, 10
    bne s1, t5, logo_y_loop

    addi s2, s2, 1    # Next logo X
    bne s2, t5, logo_x_loop

    # Exit - Environment call 10
    li a0, 10
    ecall


# Constant Definitions
# These are the colors used by the logo in
# RGB format: color = 0x00RRGGBB

.equ black  0x00000000
.equ yellow 0x00F6B21A
.equ blue   0x002A3172


# Data Section
.data

# The following are the logo pixels,
# specified column by column
logo:

# Column 0
.word black, blue, blue, blue, blue, blue, blue, blue, blue, blue

# Column 1
.word black, blue, blue, blue, blue, black, black, blue, blue, blue

# Column 2
.word black, blue, blue, blue, blue, black, black, black, blue, blue

# Column 3
.word black, black, blue, blue, black, black, yellow, black, black, blue

# Column 4
.word yellow, black, black, black, black, yellow, yellow, yellow, black, black

# Column 5
.word yellow, yellow, yellow, yellow, yellow, yellow, yellow, yellow, yellow, black

# Column 6
.word yellow, yellow, yellow, yellow, yellow, yellow, yellow, yellow, black, black

# Column 7
.word yellow, yellow, yellow, yellow, yellow, yellow, yellow, black, black, blue

# Column 8
.word yellow, yellow, yellow, yellow, yellow, yellow, black, black, blue, blue

# Column 9
.word yellow, yellow, yellow, yellow, yellow, black, black, blue, blue, blue