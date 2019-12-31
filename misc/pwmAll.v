module pwmAll (input CLOCK_50,output [17:0] LEDR,output [7:0] LEDG);
reg [25:0] clk_div;
reg [10:0] pwm_width;
reg [10:0] pwm_cnt;
assign {LEDR,LEDG}=LED;
reg [26:0] LED;

reg increase;
wire pwm_out;
always @(posedge CLOCK_50) begin
pwm_cnt = pwm_cnt+8'b1;
end
assign pwm_out = (pwm_cnt <= pwm_width) ? 1'b1 : 1'b0;
initial begin
LED <= 0;
clk_div <= 0;
end
always @(*) LED = {26{pwm_out}};
always @(posedge CLOCK_50) begin
clk_div <= clk_div+26'b1;
end
always @(posedge clk_div[13]) begin
if (increase) pwm_width = pwm_width+1'b1; else pwm_width = pwm_width-1'b1;
if (pwm_width==11'd2047) increase=1'b0;
if (pwm_width==11'd0) increase=1'b1;
end
endmodule
