
//TO RUN: runcoresv
module core 
#(parameter superscalar = 0)
(
    input clk,rst,
    input [31:0] icache_instr
);
//From Fetch
reg [31:0] instr;
reg instr_valid_to_exe;
fetch fetch_inst(
    .clk(clk),
    .rst(rst),
    .icache_instr(icache_instr),
    .instr(instr),
    .instr_valid(instr_valid_to_exe),
    .stall(stall_decode)  
);

logic stall_off_decode;

always@(posedge clk or negedge rst)
begin 
    if(!rst)
    begin
        stall_off_decode <= 1'b0;
    end
    else
    begin
        if(stall_decode) 
        begin
            stall_off_decode <= 1'b1;
        end
        else
        begin
            stall_off_decode <= 1'b0;
        end
    end
end


//From Decode
reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;
reg [4:0] op;
reg [11:0] imm_alu;
reg stall_decode;

//To Execute
reg [31:0] rs1_data;
reg [31:0] rs2_data;
reg [4:0] rd_EXE;
reg [11:0] imm_alu_EXE; 

always@(posedge clk or negedge rst)
begin 
    if(!rst)
    begin
        rs1_data <= 32'b0;
        rs2_data <= 32'b0;
        rd_EXE <= 5'b0;
        imm_alu_EXE <= 12'b0;
    end
    else if(stall_decode)
    begin
        rs1_data <= rs1_data;
        rs2_data <= rs2_data;
        rd_EXE <= rd_EXE;
        imm_alu_EXE <= imm_alu_EXE;
    end
    else
    begin
        rs1_data <= data_out1;
        rs2_data <= data_out2;
        rd_EXE <= rd;
        imm_alu_EXE <= imm_alu;
    end
end
decode decode_inst(
    .clk(clk),
    .rst(rst),
    .instr(instr),
    .stall_off(stall_off_decode),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .operation(op),
    .imm_alu(imm_alu),
    .stall_decode(stall_decode)
);


//From Regfile
reg [31:0] data_out1;
reg [31:0] data_out2;

regfile regfile_inst(
    .clk(clk),
    .rst(rst),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd_EXE),
    .wr_en(exe_enable),
    .rd_en(1'b1),
    .data_in(d_out),
    .data_out1(data_out1),
    .data_out2(data_out2)
);
logic [31:0] d_out;
logic exe_enable;
execute execute_inst(
    .clk(clk),
    .rst(rst),
    .alu_op(op),
    .rs1(data_out1),
    .rs2(data_out2),
    .rd(rd),
    .imm_alu(imm_alu),
    
    .id_en(instr_valid_to_exe),
    .alu_out(d_out),
    .ex_en(exe_enable)
);

endmodule 
