module regfile (
    input clk,rst,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input reg wr_en,
    input reg rd_en,
    input [31:0] data_in,
    output reg [31:0] data_out1,
    output reg [31:0] data_out2
);
assign data_out1 = arf[rs1];
assign data_out2 = arf[rs2];
reg [31:0] arf[31:0];

always@(posedge clk or negedge rst) begin 
    if(!rst) begin
        for(int i=0;i<32;i=i+1) begin
            arf[i] <= 0;
        end
        
        
    end
    else begin
        if(wr_en) begin
            arf[rd] <= data_in;
        end
        
        

    end
end
endmodule
