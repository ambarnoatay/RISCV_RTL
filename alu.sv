module alu
(
    input clk,rst,
    input [31:0] rs1,
    input [31:0] rs2,
    input [4:0] alu_op,
    input alu_en,
    input [11:0] imm_alu,
    output reg [31:0] alu_out

);

assign alu_out = alu_op==`ADD ? rs1 + rs2 : 
                alu_op==`SUB ? rs1 - rs2 : 
                alu_op==`AND ? rs1 & rs2 : 
                alu_op==`OR ? rs1 | rs2 : 
                alu_op==`XOR ? rs1 ^ rs2 : 
                alu_op==`SLL ? rs1 << rs2 : 
                alu_op==`SRL ? rs1 >> rs2 : 
                alu_op==`SRA ? rs1 >>> rs2 : 
                alu_op==`SLT ? (rs1 < rs2) ? 32'b1 : 32'b0 : 
                alu_op==`SLTU ? (rs1 < rs2) ? 32'b1 : 32'b0 : 
                alu_op==`ADDI ? rs1 + imm_alu : 
                alu_op==`ANDI ? rs1 & imm_alu : 
                alu_op==`ORI ? rs1 | imm_alu : 
                alu_op==`XORI ? rs1 ^ imm_alu : 
                alu_op==`SLLI ? rs1 << imm_alu : 
                alu_op==`SRLI ? rs1 >> imm_alu : 
                alu_op==`SRAI ? rs1 >>> imm_alu :
                alu_op==`MUL ? rs1 * imm_alu :
                alu_op==`DIV ? rs1 / imm_alu : 
                alu_op==`SLTI ? (rs1 < imm_alu) ? 32'b1 : 32'b0 : 
                32'b0;

endmodule 