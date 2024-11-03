`include "RISCV_Lib.sv"
module execute
#(
    parameter WIDTH = 5

)
(

    input clk,rst,
    input [`WIDTH-1:0] alu_op,
    input [31:0] rs1,
    input [31:0] rs2,
    input [4:0] rd,
    input [11:0] imm_alu,

    input id_en,
    output reg [31:0] alu_out,
    output reg ex_en

    //FIX EXECUTE EN

);

logic [31:0] alu_out_t;
alu alu_exec(
    .clk(clk),
    .rst(rst),
    .alu_op(alu_op),
    .rs1(rs1), 
    .rs2(rs2),
    .imm_alu(imm_alu),
    .alu_out(alu_out_t)
);
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        ex_en <= 1'b0; // Reset ex_en to 0
    end else begin
        if (alu_out != 0 && id_en) begin // Assuming alu_out_t is a valid output
            ex_en <= 1'b1; // Set ex_en to 1 when alu_out is valid
        end else begin
            ex_en <= 1'b0; // Reset to 0 otherwise
        end
    end
end

// You may need to register the output of the ALU
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        alu_out <= 32'b0; // Reset output to 0
    end else begin
        alu_out <= alu_out_t; // Register the ALU output
    end
end


endmodule