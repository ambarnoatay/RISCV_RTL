module tb;
    reg clk, rst;
    reg [31:0] icache_instr;
    
    core uut_core(
        .clk(clk),
        .rst(rst),
        .icache_instr(icache_instr)
    );

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk; // Clock period of 10 time units
    end

    initial begin
    // Initialize the instruction cache and reset signal
    icache_instr = 32'b0;
    rst = 1'b0;

    // Release reset after 10 time units
    #10 rst = 1'b1;

    // First instruction: addi x1, x0, 2
    //#20 icache_instr = 32'h00200093; 
    //new instruction sub x4, x3, x1
    //#20 icache_instr = 32'h40118233;
    // Second instruction: addi x2, x0, 5
    //#20 icache_instr = 32'h00500113; 
    //new instruction and x7, x1, x2
    //#20 icache_instr = 32'h0020F3B3;

    // Third instruction: add x3, x1, x2
    //#20 icache_instr = 32'h002081B3; 

    // Fourth instruction: mul x5, x1, x2
    //#20 icache_instr = 32'h022082B3;

    // add x5, x4, x2
    //#20 icache_instr = 32'h002202B3;
    
    //#30 icache_instr = 32'b0;
    
//ADDI x1, x0, 10

#20 icache_instr = 32'b00000000101000000000000010010011;
//ADDI x2, x0, 20

#20 icache_instr = 32'b00000001010000000000000100010011;
//ADD x3, x1, x2

#20 icache_instr = 32'b00000000001000001000000110110011;
//SUB x4, x3, x1

#20 icache_instr = 32'b01000000000100011000001000110011;
//ADD x5, x1, x2

#20 icache_instr = 32'b00000000001000001000001010110011;

//AND x7, x1, x2

#20 icache_instr = 32'b00000000001000001111001110110011;
//OR x8, x1, x2

#20 icache_instr = 32'b00000000001000001110010000110011;
//XOR x9, x1, x2

#20 icache_instr = 32'b00000000001000001100010010110011;
//SLL x10, x1, x2

#20 icache_instr = 32'b00000000001000001001010100110011;
//SRL x11, x2, x1

#20 icache_instr = 32'b00000000000100010101010110110011;
//SRA x12, x2, x1

#20 icache_instr = 32'b01000000000100010101011000110011;
//ADDI x3, x4, 1

#20 icache_instr = 32'b00000000000100100000000110010011;
//SUB x5, x6, x7

#20 icache_instr = 32'b01000000011100110000001010110011;
//AND x8, x9, x10

#20 icache_instr = 32'b00000000101001001111010000110011;
//OR x1, x2, x3

#20 icache_instr = 32'b00000000001100010110000010110011;
//XOR x4, x5, x6

#20 icache_instr = 32'b00000000011000101100001000110011;
//SLL x7, x8, x9

#20 icache_instr = 32'b00000000100101000001001110110011;
//SRL x10, x11, x12

#20 icache_instr = 32'b00000000110001011101010100110011;
//SRA x1, x2, x3

#20 icache_instr = 32'b01000000001100010101000010110011;
//ADDI x5, x6, 2

#20 icache_instr = 32'b00000000001000110000001010010011;
//SUB x7, x8, x9

#20 icache_instr = 32'b01000000100101000000001110110011;
//AND x10, x1, x2

#20 icache_instr = 32'b00000000001000001111010100110011;
//OR x3, x4, x5

#20 icache_instr = 32'b00000000010100100110000110110011;
//XOR x6, x7, x8

#20 icache_instr = 32'b00000000100000111100001100110011;
//SLL x9, x10, x1

#20 icache_instr = 32'b00000000000101010001010010110011;
//SRL x2, x3, x4

#20 icache_instr = 32'b00000000010000011101000100110011;
//SRA x5, x6, x7

#20 icache_instr = 32'b01000000011100110101001010110011;
//ADDI x9, x10, 3

#20 icache_instr = 32'b00000000001101010000010010010011;
//SUB x1, x2, x3

#20 icache_instr = 32'b01000000001100010000000010110011;
//AND x4, x5, x6

#20 icache_instr = 32'b00000000011000101111001000110011;
//OR x7, x8, x9

#20 icache_instr = 32'b00000000100101000110001110110011;
//XOR x10, x1, x2

#20 icache_instr = 32'b00000000001000001100010100110011;
//SLL x3, x4, x5

#20 icache_instr = 32'b00000000010100100001000110110011;
//SRL x6, x7, x8

#20 icache_instr = 32'b00000000100000111101001100110011;
//SRA x9, x10, x1

#20 icache_instr = 32'b01000000000101010101010010110011;

#30 icache_instr = 32'b0;


end

// Task to display the contents of the register file
// Declare a temporary array to hold ARF values
reg [31:0] arf_temp[0:31];

// Task to display the contents of the register file




    // VCD dump for waveform analysis
    initial begin
        $dumpfile("zTest.vcd");
        $dumpvars(0, tb);
    end

    // Finish simulation after 100 time units
    initial begin
        #900 $finish;
    end

    // Monitor signals
    
endmodule
