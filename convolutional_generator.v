`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/28 07:48:18
// Design Name: 
// Module Name: convolutional_generator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module convolutional_generator(
        input clk,
        input i_data,
        output o_sig0,
        output o_sig1,
        output o_sig2
    );
    
    reg[1:0] state;
    reg[1:0] past_state;
    
    parameter initial_state = 2'b00;
    parameter A = 2'b01;
    parameter B = 2'b10;
    parameter C = 2'b11;
    
    initial
    begin
        state <= initial_state;
    end
    //output 결정한 뒤에 state 바꾸기
    assign o_sig0 = i_data ^ past_state[0] ^ past_state[1];
    assign o_sig1 = i_data ^ past_state[1];
    assign o_sig2 = i_data ^ past_state[0];
    
    always@(posedge clk)
    begin
        past_state <= state;
        
        case (state)
            initial_state:
                if(i_data) state <= A;
                else       state <= initial_state;
            A:
                if(i_data) state <= C;
                else       state <= B;
            B: 
                if(i_data) state <= A;
                else       state <= initial_state;
            C:
                if(i_data) state <= C;
                else       state <= B;
            default:
                state <= state;
            endcase      
    end
        
endmodule
