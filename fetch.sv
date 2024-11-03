module fetch
//#(parameter)
(
    input clk,rst,icache_error,
    input [31:0] icache_instr,
    input stall,
    output reg instr_valid,
    output reg [31:0] instr,
    output icache_req,
    output icache_addr
);
reg [31:0] instr_t;

always@(posedge clk or negedge rst)
begin 
    if(!rst)
    begin
        instr_t <= 32'b0;
        
    end
    else if(stall)
    begin
        instr_t <= instr_t;
    end
    else 
    begin
        instr_t <= icache_instr;
       
    end
end
always@(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        instr_valid <= 1'b0;
    end
    else if(icache_instr == 32'b0)
    begin
        instr_valid <= 1'b0;
    end
    else
    begin
        instr_valid <= 1'b1;
    end
end

always_comb begin
    instr = instr_t;
end






endmodule