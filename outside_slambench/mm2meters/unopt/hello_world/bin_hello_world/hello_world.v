// (C) 1992-2015 Altera Corporation. All rights reserved.                         
// Your use of Altera Corporation's design tools, logic functions and other       
// software and tools, and its AMPP partner logic functions, and any output       
// files any of the foregoing (including device programming or simulation         
// files), and any associated documentation or information are expressly subject  
// to the terms and conditions of the Altera Program License Subscription         
// Agreement, Altera MegaCore Function License Agreement, or other applicable     
// license agreement, including, without limitation, that your use is for the     
// sole purpose of programming logic devices manufactured by Altera and sold by   
// Altera or its authorized distributors.  Please refer to the applicable         
// agreement for further details.                                                 
    

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module AOCmm2metersKernel_basic_block_0
	(
		input 		clock,
		input 		resetn,
		input 		start,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_global_id_1,
		output 		valid_out,
		input 		stall_in,
		output [31:0] 		lvb_input_global_id_0,
		output [31:0] 		lvb_input_global_id_1,
		input [31:0] 		workgroup_size
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in;
 reg merge_node_valid_out_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_1_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = (|(merge_node_stall_in & merge_node_valid_out_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_global_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_global_id_0_staging_reg_NO_SHIFT_REG <= input_global_id_0;
				input_global_id_1_staging_reg_NO_SHIFT_REG <= input_global_id_1;
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in))
			begin
				merge_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_input_global_id_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_1_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = merge_node_valid_out_NO_SHIFT_REG;
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign merge_node_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_input_global_id_0 = lvb_input_global_id_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_1 = lvb_input_global_id_1_reg_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_input_global_id_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_1_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_input_global_id_0_reg_NO_SHIFT_REG <= local_lvm_input_global_id_0_NO_SHIFT_REG;
			lvb_input_global_id_1_reg_NO_SHIFT_REG <= local_lvm_input_global_id_1_NO_SHIFT_REG;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module AOCmm2metersKernel_basic_block_1
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_inSize_x,
		input [31:0] 		input_depthSize_x,
		input [31:0] 		input_ratio,
		input [63:0] 		input_depth,
		input [63:0] 		input_in,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_global_id_1,
		output 		valid_out,
		input 		stall_in,
		input [31:0] 		workgroup_size,
		input 		start,
		input [511:0] 		avm_local_bb1_ld__readdata,
		input 		avm_local_bb1_ld__readdatavalid,
		input 		avm_local_bb1_ld__waitrequest,
		output [32:0] 		avm_local_bb1_ld__address,
		output 		avm_local_bb1_ld__read,
		output 		avm_local_bb1_ld__write,
		input 		avm_local_bb1_ld__writeack,
		output [511:0] 		avm_local_bb1_ld__writedata,
		output [63:0] 		avm_local_bb1_ld__byteenable,
		output [4:0] 		avm_local_bb1_ld__burstcount,
		output 		local_bb1_ld__active,
		input 		clock2x,
		input [511:0] 		avm_local_bb1_st_c0_exe1_readdata,
		input 		avm_local_bb1_st_c0_exe1_readdatavalid,
		input 		avm_local_bb1_st_c0_exe1_waitrequest,
		output [32:0] 		avm_local_bb1_st_c0_exe1_address,
		output 		avm_local_bb1_st_c0_exe1_read,
		output 		avm_local_bb1_st_c0_exe1_write,
		input 		avm_local_bb1_st_c0_exe1_writeack,
		output [511:0] 		avm_local_bb1_st_c0_exe1_writedata,
		output [63:0] 		avm_local_bb1_st_c0_exe1_byteenable,
		output [4:0] 		avm_local_bb1_st_c0_exe1_burstcount,
		output 		local_bb1_st_c0_exe1_active
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_node_stall_in_2;
 reg merge_node_valid_out_2_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_1_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_global_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_global_id_0_staging_reg_NO_SHIFT_REG <= input_global_id_0;
				input_global_id_1_staging_reg_NO_SHIFT_REG <= input_global_id_1;
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_2))
			begin
				merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements a registered operation.
// 
wire local_bb1_mul4_inputs_ready;
 reg local_bb1_mul4_valid_out_NO_SHIFT_REG;
wire local_bb1_mul4_stall_in;
wire local_bb1_mul4_output_regs_ready;
wire [31:0] local_bb1_mul4;
 reg local_bb1_mul4_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_mul4_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_mul4_causedstall;

acl_int_mult int_module_local_bb1_mul4 (
	.clock(clock),
	.dataa(local_lvm_input_global_id_1_NO_SHIFT_REG),
	.datab(input_inSize_x),
	.enable(local_bb1_mul4_output_regs_ready),
	.result(local_bb1_mul4)
);

defparam int_module_local_bb1_mul4.INPUT1_WIDTH = 32;
defparam int_module_local_bb1_mul4.INPUT2_WIDTH = 32;
defparam int_module_local_bb1_mul4.OUTPUT_WIDTH = 32;
defparam int_module_local_bb1_mul4.LATENCY = 3;
defparam int_module_local_bb1_mul4.SIGNED = 0;

assign local_bb1_mul4_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb1_mul4_output_regs_ready = (&(~(local_bb1_mul4_valid_out_NO_SHIFT_REG) | ~(local_bb1_mul4_stall_in)));
assign merge_node_stall_in_0 = (~(local_bb1_mul4_output_regs_ready) | ~(local_bb1_mul4_inputs_ready));
assign local_bb1_mul4_causedstall = (local_bb1_mul4_inputs_ready && (~(local_bb1_mul4_output_regs_ready) && !(~(local_bb1_mul4_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul4_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul4_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul4_output_regs_ready)
		begin
			local_bb1_mul4_valid_pipe_0_NO_SHIFT_REG <= local_bb1_mul4_inputs_ready;
			local_bb1_mul4_valid_pipe_1_NO_SHIFT_REG <= local_bb1_mul4_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul4_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul4_output_regs_ready)
		begin
			local_bb1_mul4_valid_out_NO_SHIFT_REG <= local_bb1_mul4_valid_pipe_1_NO_SHIFT_REG;
		end
		else
		begin
			if (~(local_bb1_mul4_stall_in))
			begin
				local_bb1_mul4_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_mul8_inputs_ready;
 reg local_bb1_mul8_valid_out_NO_SHIFT_REG;
wire local_bb1_mul8_stall_in;
wire local_bb1_mul8_output_regs_ready;
wire [31:0] local_bb1_mul8;
 reg local_bb1_mul8_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_mul8_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_mul8_causedstall;

acl_int_mult int_module_local_bb1_mul8 (
	.clock(clock),
	.dataa(local_lvm_input_global_id_1_NO_SHIFT_REG),
	.datab(input_depthSize_x),
	.enable(local_bb1_mul8_output_regs_ready),
	.result(local_bb1_mul8)
);

defparam int_module_local_bb1_mul8.INPUT1_WIDTH = 32;
defparam int_module_local_bb1_mul8.INPUT2_WIDTH = 32;
defparam int_module_local_bb1_mul8.OUTPUT_WIDTH = 32;
defparam int_module_local_bb1_mul8.LATENCY = 3;
defparam int_module_local_bb1_mul8.SIGNED = 0;

assign local_bb1_mul8_inputs_ready = merge_node_valid_out_1_NO_SHIFT_REG;
assign local_bb1_mul8_output_regs_ready = (&(~(local_bb1_mul8_valid_out_NO_SHIFT_REG) | ~(local_bb1_mul8_stall_in)));
assign merge_node_stall_in_1 = (~(local_bb1_mul8_output_regs_ready) | ~(local_bb1_mul8_inputs_ready));
assign local_bb1_mul8_causedstall = (local_bb1_mul8_inputs_ready && (~(local_bb1_mul8_output_regs_ready) && !(~(local_bb1_mul8_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul8_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul8_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul8_output_regs_ready)
		begin
			local_bb1_mul8_valid_pipe_0_NO_SHIFT_REG <= local_bb1_mul8_inputs_ready;
			local_bb1_mul8_valid_pipe_1_NO_SHIFT_REG <= local_bb1_mul8_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul8_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul8_output_regs_ready)
		begin
			local_bb1_mul8_valid_out_NO_SHIFT_REG <= local_bb1_mul8_valid_pipe_1_NO_SHIFT_REG;
		end
		else
		begin
			if (~(local_bb1_mul8_stall_in))
			begin
				local_bb1_mul8_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_1to4_input_global_id_0_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_1to4_input_global_id_0_0_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_1to4_input_global_id_0_1_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to4_input_global_id_0_0_reg_4_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_valid_out_0_reg_4_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_stall_in_0_reg_4_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_stall_out_reg_4_NO_SHIFT_REG;
 reg rnode_1to4_input_global_id_0_0_consumed_0_NO_SHIFT_REG;
 reg rnode_1to4_input_global_id_0_0_consumed_1_NO_SHIFT_REG;

acl_data_fifo rnode_1to4_input_global_id_0_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to4_input_global_id_0_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to4_input_global_id_0_0_stall_in_0_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_1to4_input_global_id_0_0_valid_out_0_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_1to4_input_global_id_0_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(local_lvm_input_global_id_0_NO_SHIFT_REG),
	.data_out(rnode_1to4_input_global_id_0_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_1to4_input_global_id_0_0_reg_4_fifo.DEPTH = 4;
defparam rnode_1to4_input_global_id_0_0_reg_4_fifo.DATA_WIDTH = 32;
defparam rnode_1to4_input_global_id_0_0_reg_4_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to4_input_global_id_0_0_reg_4_fifo.IMPL = "ll_reg";

assign rnode_1to4_input_global_id_0_0_reg_4_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_2_NO_SHIFT_REG;
assign merge_node_stall_in_2 = rnode_1to4_input_global_id_0_0_stall_out_reg_4_NO_SHIFT_REG;
assign rnode_1to4_input_global_id_0_0_stall_in_0_reg_4_NO_SHIFT_REG = ((rnode_1to4_input_global_id_0_0_stall_in_0_NO_SHIFT_REG & ~(rnode_1to4_input_global_id_0_0_consumed_0_NO_SHIFT_REG)) | (rnode_1to4_input_global_id_0_0_stall_in_1_NO_SHIFT_REG & ~(rnode_1to4_input_global_id_0_0_consumed_1_NO_SHIFT_REG)));
assign rnode_1to4_input_global_id_0_0_valid_out_0_NO_SHIFT_REG = (rnode_1to4_input_global_id_0_0_valid_out_0_reg_4_NO_SHIFT_REG & ~(rnode_1to4_input_global_id_0_0_consumed_0_NO_SHIFT_REG));
assign rnode_1to4_input_global_id_0_0_valid_out_1_NO_SHIFT_REG = (rnode_1to4_input_global_id_0_0_valid_out_0_reg_4_NO_SHIFT_REG & ~(rnode_1to4_input_global_id_0_0_consumed_1_NO_SHIFT_REG));
assign rnode_1to4_input_global_id_0_0_NO_SHIFT_REG = rnode_1to4_input_global_id_0_0_reg_4_NO_SHIFT_REG;
assign rnode_1to4_input_global_id_0_1_NO_SHIFT_REG = rnode_1to4_input_global_id_0_0_reg_4_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rnode_1to4_input_global_id_0_0_consumed_0_NO_SHIFT_REG <= 1'b0;
		rnode_1to4_input_global_id_0_0_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rnode_1to4_input_global_id_0_0_consumed_0_NO_SHIFT_REG <= (rnode_1to4_input_global_id_0_0_valid_out_0_reg_4_NO_SHIFT_REG & (rnode_1to4_input_global_id_0_0_consumed_0_NO_SHIFT_REG | ~(rnode_1to4_input_global_id_0_0_stall_in_0_NO_SHIFT_REG)) & rnode_1to4_input_global_id_0_0_stall_in_0_reg_4_NO_SHIFT_REG);
		rnode_1to4_input_global_id_0_0_consumed_1_NO_SHIFT_REG <= (rnode_1to4_input_global_id_0_0_valid_out_0_reg_4_NO_SHIFT_REG & (rnode_1to4_input_global_id_0_0_consumed_1_NO_SHIFT_REG | ~(rnode_1to4_input_global_id_0_0_stall_in_1_NO_SHIFT_REG)) & rnode_1to4_input_global_id_0_0_stall_in_0_reg_4_NO_SHIFT_REG);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_mul3_valid_out;
wire local_bb1_mul3_stall_in;
wire local_bb1_mul3_inputs_ready;
wire local_bb1_mul3_stall_local;
wire [31:0] local_bb1_mul3;

assign local_bb1_mul3_inputs_ready = (local_bb1_mul4_valid_out_NO_SHIFT_REG & rnode_1to4_input_global_id_0_0_valid_out_0_NO_SHIFT_REG);
assign local_bb1_mul3 = (local_bb1_mul4 + rnode_1to4_input_global_id_0_0_NO_SHIFT_REG);
assign local_bb1_mul3_valid_out = local_bb1_mul3_inputs_ready;
assign local_bb1_mul3_stall_local = local_bb1_mul3_stall_in;
assign local_bb1_mul4_stall_in = (local_bb1_mul3_stall_local | ~(local_bb1_mul3_inputs_ready));
assign rnode_1to4_input_global_id_0_0_stall_in_0_NO_SHIFT_REG = (local_bb1_mul3_stall_local | ~(local_bb1_mul3_inputs_ready));

// This section implements an unregistered operation.
// 
wire local_bb1_add9_valid_out;
wire local_bb1_add9_stall_in;
wire local_bb1_add9_inputs_ready;
wire local_bb1_add9_stall_local;
wire [31:0] local_bb1_add9;

assign local_bb1_add9_inputs_ready = (local_bb1_mul8_valid_out_NO_SHIFT_REG & rnode_1to4_input_global_id_0_0_valid_out_1_NO_SHIFT_REG);
assign local_bb1_add9 = (local_bb1_mul8 + rnode_1to4_input_global_id_0_1_NO_SHIFT_REG);
assign local_bb1_add9_valid_out = local_bb1_add9_inputs_ready;
assign local_bb1_add9_stall_local = local_bb1_add9_stall_in;
assign local_bb1_mul8_stall_in = (local_bb1_add9_stall_local | ~(local_bb1_add9_inputs_ready));
assign rnode_1to4_input_global_id_0_0_stall_in_1_NO_SHIFT_REG = (local_bb1_add9_stall_local | ~(local_bb1_add9_inputs_ready));

// This section implements a registered operation.
// 
wire local_bb1_add_inputs_ready;
 reg local_bb1_add_valid_out_NO_SHIFT_REG;
wire local_bb1_add_stall_in;
wire local_bb1_add_output_regs_ready;
wire [31:0] local_bb1_add;
 reg local_bb1_add_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_add_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_add_causedstall;

acl_int_mult int_module_local_bb1_add (
	.clock(clock),
	.dataa(local_bb1_mul3),
	.datab(input_ratio),
	.enable(local_bb1_add_output_regs_ready),
	.result(local_bb1_add)
);

defparam int_module_local_bb1_add.INPUT1_WIDTH = 32;
defparam int_module_local_bb1_add.INPUT2_WIDTH = 32;
defparam int_module_local_bb1_add.OUTPUT_WIDTH = 32;
defparam int_module_local_bb1_add.LATENCY = 3;
defparam int_module_local_bb1_add.SIGNED = 0;

assign local_bb1_add_inputs_ready = local_bb1_mul3_valid_out;
assign local_bb1_add_output_regs_ready = (&(~(local_bb1_add_valid_out_NO_SHIFT_REG) | ~(local_bb1_add_stall_in)));
assign local_bb1_mul3_stall_in = (~(local_bb1_add_output_regs_ready) | ~(local_bb1_add_inputs_ready));
assign local_bb1_add_causedstall = (local_bb1_add_inputs_ready && (~(local_bb1_add_output_regs_ready) && !(~(local_bb1_add_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_add_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_add_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_add_output_regs_ready)
		begin
			local_bb1_add_valid_pipe_0_NO_SHIFT_REG <= local_bb1_add_inputs_ready;
			local_bb1_add_valid_pipe_1_NO_SHIFT_REG <= local_bb1_add_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_add_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_add_output_regs_ready)
		begin
			local_bb1_add_valid_out_NO_SHIFT_REG <= local_bb1_add_valid_pipe_1_NO_SHIFT_REG;
		end
		else
		begin
			if (~(local_bb1_add_stall_in))
			begin
				local_bb1_add_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 189
//  * capacity = 189
 logic rnode_4to193_bb1_add9_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to193_bb1_add9_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_4to193_bb1_add9_0_NO_SHIFT_REG;
 logic rnode_4to193_bb1_add9_0_reg_193_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_4to193_bb1_add9_0_reg_193_NO_SHIFT_REG;
 logic rnode_4to193_bb1_add9_0_valid_out_reg_193_NO_SHIFT_REG;
 logic rnode_4to193_bb1_add9_0_stall_in_reg_193_NO_SHIFT_REG;
 logic rnode_4to193_bb1_add9_0_stall_out_reg_193_NO_SHIFT_REG;

acl_data_fifo rnode_4to193_bb1_add9_0_reg_193_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to193_bb1_add9_0_reg_193_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to193_bb1_add9_0_stall_in_reg_193_NO_SHIFT_REG),
	.valid_out(rnode_4to193_bb1_add9_0_valid_out_reg_193_NO_SHIFT_REG),
	.stall_out(rnode_4to193_bb1_add9_0_stall_out_reg_193_NO_SHIFT_REG),
	.data_in(local_bb1_add9),
	.data_out(rnode_4to193_bb1_add9_0_reg_193_NO_SHIFT_REG)
);

defparam rnode_4to193_bb1_add9_0_reg_193_fifo.DEPTH = 190;
defparam rnode_4to193_bb1_add9_0_reg_193_fifo.DATA_WIDTH = 32;
defparam rnode_4to193_bb1_add9_0_reg_193_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_4to193_bb1_add9_0_reg_193_fifo.IMPL = "ram";

assign rnode_4to193_bb1_add9_0_reg_193_inputs_ready_NO_SHIFT_REG = local_bb1_add9_valid_out;
assign local_bb1_add9_stall_in = rnode_4to193_bb1_add9_0_stall_out_reg_193_NO_SHIFT_REG;
assign rnode_4to193_bb1_add9_0_NO_SHIFT_REG = rnode_4to193_bb1_add9_0_reg_193_NO_SHIFT_REG;
assign rnode_4to193_bb1_add9_0_stall_in_reg_193_NO_SHIFT_REG = rnode_4to193_bb1_add9_0_stall_in_NO_SHIFT_REG;
assign rnode_4to193_bb1_add9_0_valid_out_NO_SHIFT_REG = rnode_4to193_bb1_add9_0_valid_out_reg_193_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_idxprom_valid_out;
wire local_bb1_idxprom_stall_in;
wire local_bb1_idxprom_inputs_ready;
wire local_bb1_idxprom_stall_local;
wire [63:0] local_bb1_idxprom;

assign local_bb1_idxprom_inputs_ready = local_bb1_add_valid_out_NO_SHIFT_REG;
assign local_bb1_idxprom[63:32] = 32'h0;
assign local_bb1_idxprom[31:0] = local_bb1_add;
assign local_bb1_idxprom_valid_out = local_bb1_idxprom_inputs_ready;
assign local_bb1_idxprom_stall_local = local_bb1_idxprom_stall_in;
assign local_bb1_add_stall_in = (|local_bb1_idxprom_stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_193to194_bb1_add9_0_valid_out_NO_SHIFT_REG;
 logic rnode_193to194_bb1_add9_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_193to194_bb1_add9_0_NO_SHIFT_REG;
 logic rnode_193to194_bb1_add9_0_reg_194_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_193to194_bb1_add9_0_reg_194_NO_SHIFT_REG;
 logic rnode_193to194_bb1_add9_0_valid_out_reg_194_NO_SHIFT_REG;
 logic rnode_193to194_bb1_add9_0_stall_in_reg_194_NO_SHIFT_REG;
 logic rnode_193to194_bb1_add9_0_stall_out_reg_194_NO_SHIFT_REG;

acl_data_fifo rnode_193to194_bb1_add9_0_reg_194_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_193to194_bb1_add9_0_reg_194_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_193to194_bb1_add9_0_stall_in_reg_194_NO_SHIFT_REG),
	.valid_out(rnode_193to194_bb1_add9_0_valid_out_reg_194_NO_SHIFT_REG),
	.stall_out(rnode_193to194_bb1_add9_0_stall_out_reg_194_NO_SHIFT_REG),
	.data_in(rnode_4to193_bb1_add9_0_NO_SHIFT_REG),
	.data_out(rnode_193to194_bb1_add9_0_reg_194_NO_SHIFT_REG)
);

defparam rnode_193to194_bb1_add9_0_reg_194_fifo.DEPTH = 1;
defparam rnode_193to194_bb1_add9_0_reg_194_fifo.DATA_WIDTH = 32;
defparam rnode_193to194_bb1_add9_0_reg_194_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_193to194_bb1_add9_0_reg_194_fifo.IMPL = "ll_reg";

assign rnode_193to194_bb1_add9_0_reg_194_inputs_ready_NO_SHIFT_REG = rnode_4to193_bb1_add9_0_valid_out_NO_SHIFT_REG;
assign rnode_4to193_bb1_add9_0_stall_in_NO_SHIFT_REG = rnode_193to194_bb1_add9_0_stall_out_reg_194_NO_SHIFT_REG;
assign rnode_193to194_bb1_add9_0_NO_SHIFT_REG = rnode_193to194_bb1_add9_0_reg_194_NO_SHIFT_REG;
assign rnode_193to194_bb1_add9_0_stall_in_reg_194_NO_SHIFT_REG = rnode_193to194_bb1_add9_0_stall_in_NO_SHIFT_REG;
assign rnode_193to194_bb1_add9_0_valid_out_NO_SHIFT_REG = rnode_193to194_bb1_add9_0_valid_out_reg_194_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_7to8_bb1_idxprom_0_valid_out_NO_SHIFT_REG;
 logic rnode_7to8_bb1_idxprom_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_7to8_bb1_idxprom_0_NO_SHIFT_REG;
 logic rnode_7to8_bb1_idxprom_0_reg_8_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_7to8_bb1_idxprom_0_reg_8_NO_SHIFT_REG;
 logic rnode_7to8_bb1_idxprom_0_valid_out_reg_8_NO_SHIFT_REG;
 logic rnode_7to8_bb1_idxprom_0_stall_in_reg_8_NO_SHIFT_REG;
 logic rnode_7to8_bb1_idxprom_0_stall_out_reg_8_NO_SHIFT_REG;

acl_data_fifo rnode_7to8_bb1_idxprom_0_reg_8_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_7to8_bb1_idxprom_0_reg_8_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_7to8_bb1_idxprom_0_stall_in_reg_8_NO_SHIFT_REG),
	.valid_out(rnode_7to8_bb1_idxprom_0_valid_out_reg_8_NO_SHIFT_REG),
	.stall_out(rnode_7to8_bb1_idxprom_0_stall_out_reg_8_NO_SHIFT_REG),
	.data_in((local_bb1_idxprom & 64'hFFFFFFFF)),
	.data_out(rnode_7to8_bb1_idxprom_0_reg_8_NO_SHIFT_REG)
);

defparam rnode_7to8_bb1_idxprom_0_reg_8_fifo.DEPTH = 1;
defparam rnode_7to8_bb1_idxprom_0_reg_8_fifo.DATA_WIDTH = 64;
defparam rnode_7to8_bb1_idxprom_0_reg_8_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_7to8_bb1_idxprom_0_reg_8_fifo.IMPL = "ll_reg";

assign rnode_7to8_bb1_idxprom_0_reg_8_inputs_ready_NO_SHIFT_REG = local_bb1_idxprom_valid_out;
assign local_bb1_idxprom_stall_in = rnode_7to8_bb1_idxprom_0_stall_out_reg_8_NO_SHIFT_REG;
assign rnode_7to8_bb1_idxprom_0_NO_SHIFT_REG = rnode_7to8_bb1_idxprom_0_reg_8_NO_SHIFT_REG;
assign rnode_7to8_bb1_idxprom_0_stall_in_reg_8_NO_SHIFT_REG = rnode_7to8_bb1_idxprom_0_stall_in_NO_SHIFT_REG;
assign rnode_7to8_bb1_idxprom_0_valid_out_NO_SHIFT_REG = rnode_7to8_bb1_idxprom_0_valid_out_reg_8_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_idxprom10_stall_local;
wire [63:0] local_bb1_idxprom10;

assign local_bb1_idxprom10[63:32] = 32'h0;
assign local_bb1_idxprom10[31:0] = rnode_193to194_bb1_add9_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_arrayidx_valid_out;
wire local_bb1_arrayidx_stall_in;
wire local_bb1_arrayidx_inputs_ready;
wire local_bb1_arrayidx_stall_local;
wire [63:0] local_bb1_arrayidx;

assign local_bb1_arrayidx_inputs_ready = rnode_7to8_bb1_idxprom_0_valid_out_NO_SHIFT_REG;
assign local_bb1_arrayidx = ((input_in & 64'hFFFFFFFFFFFFFC00) + ((rnode_7to8_bb1_idxprom_0_NO_SHIFT_REG & 64'hFFFFFFFF) << 6'h1));
assign local_bb1_arrayidx_valid_out = local_bb1_arrayidx_inputs_ready;
assign local_bb1_arrayidx_stall_local = local_bb1_arrayidx_stall_in;
assign rnode_7to8_bb1_idxprom_0_stall_in_NO_SHIFT_REG = (|local_bb1_arrayidx_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_arrayidx11_valid_out;
wire local_bb1_arrayidx11_stall_in;
wire local_bb1_arrayidx11_inputs_ready;
wire local_bb1_arrayidx11_stall_local;
wire [63:0] local_bb1_arrayidx11;

assign local_bb1_arrayidx11_inputs_ready = rnode_193to194_bb1_add9_0_valid_out_NO_SHIFT_REG;
assign local_bb1_arrayidx11 = ((input_depth & 64'hFFFFFFFFFFFFFC00) + ((local_bb1_idxprom10 & 64'hFFFFFFFF) << 6'h2));
assign local_bb1_arrayidx11_valid_out = local_bb1_arrayidx11_inputs_ready;
assign local_bb1_arrayidx11_stall_local = local_bb1_arrayidx11_stall_in;
assign rnode_193to194_bb1_add9_0_stall_in_NO_SHIFT_REG = (|local_bb1_arrayidx11_stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_8to9_bb1_arrayidx_0_valid_out_NO_SHIFT_REG;
 logic rnode_8to9_bb1_arrayidx_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_8to9_bb1_arrayidx_0_NO_SHIFT_REG;
 logic rnode_8to9_bb1_arrayidx_0_reg_9_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_8to9_bb1_arrayidx_0_reg_9_NO_SHIFT_REG;
 logic rnode_8to9_bb1_arrayidx_0_valid_out_reg_9_NO_SHIFT_REG;
 logic rnode_8to9_bb1_arrayidx_0_stall_in_reg_9_NO_SHIFT_REG;
 logic rnode_8to9_bb1_arrayidx_0_stall_out_reg_9_NO_SHIFT_REG;

acl_data_fifo rnode_8to9_bb1_arrayidx_0_reg_9_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_8to9_bb1_arrayidx_0_reg_9_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_8to9_bb1_arrayidx_0_stall_in_reg_9_NO_SHIFT_REG),
	.valid_out(rnode_8to9_bb1_arrayidx_0_valid_out_reg_9_NO_SHIFT_REG),
	.stall_out(rnode_8to9_bb1_arrayidx_0_stall_out_reg_9_NO_SHIFT_REG),
	.data_in((local_bb1_arrayidx & 64'hFFFFFFFFFFFFFFFE)),
	.data_out(rnode_8to9_bb1_arrayidx_0_reg_9_NO_SHIFT_REG)
);

defparam rnode_8to9_bb1_arrayidx_0_reg_9_fifo.DEPTH = 2;
defparam rnode_8to9_bb1_arrayidx_0_reg_9_fifo.DATA_WIDTH = 64;
defparam rnode_8to9_bb1_arrayidx_0_reg_9_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_8to9_bb1_arrayidx_0_reg_9_fifo.IMPL = "ll_reg";

assign rnode_8to9_bb1_arrayidx_0_reg_9_inputs_ready_NO_SHIFT_REG = local_bb1_arrayidx_valid_out;
assign local_bb1_arrayidx_stall_in = rnode_8to9_bb1_arrayidx_0_stall_out_reg_9_NO_SHIFT_REG;
assign rnode_8to9_bb1_arrayidx_0_NO_SHIFT_REG = rnode_8to9_bb1_arrayidx_0_reg_9_NO_SHIFT_REG;
assign rnode_8to9_bb1_arrayidx_0_stall_in_reg_9_NO_SHIFT_REG = rnode_8to9_bb1_arrayidx_0_stall_in_NO_SHIFT_REG;
assign rnode_8to9_bb1_arrayidx_0_valid_out_NO_SHIFT_REG = rnode_8to9_bb1_arrayidx_0_valid_out_reg_9_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_194to195_bb1_arrayidx11_0_valid_out_NO_SHIFT_REG;
 logic rnode_194to195_bb1_arrayidx11_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_194to195_bb1_arrayidx11_0_NO_SHIFT_REG;
 logic rnode_194to195_bb1_arrayidx11_0_reg_195_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_194to195_bb1_arrayidx11_0_reg_195_NO_SHIFT_REG;
 logic rnode_194to195_bb1_arrayidx11_0_valid_out_reg_195_NO_SHIFT_REG;
 logic rnode_194to195_bb1_arrayidx11_0_stall_in_reg_195_NO_SHIFT_REG;
 logic rnode_194to195_bb1_arrayidx11_0_stall_out_reg_195_NO_SHIFT_REG;

acl_data_fifo rnode_194to195_bb1_arrayidx11_0_reg_195_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_194to195_bb1_arrayidx11_0_reg_195_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_194to195_bb1_arrayidx11_0_stall_in_reg_195_NO_SHIFT_REG),
	.valid_out(rnode_194to195_bb1_arrayidx11_0_valid_out_reg_195_NO_SHIFT_REG),
	.stall_out(rnode_194to195_bb1_arrayidx11_0_stall_out_reg_195_NO_SHIFT_REG),
	.data_in((local_bb1_arrayidx11 & 64'hFFFFFFFFFFFFFFFC)),
	.data_out(rnode_194to195_bb1_arrayidx11_0_reg_195_NO_SHIFT_REG)
);

defparam rnode_194to195_bb1_arrayidx11_0_reg_195_fifo.DEPTH = 2;
defparam rnode_194to195_bb1_arrayidx11_0_reg_195_fifo.DATA_WIDTH = 64;
defparam rnode_194to195_bb1_arrayidx11_0_reg_195_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_194to195_bb1_arrayidx11_0_reg_195_fifo.IMPL = "ll_reg";

assign rnode_194to195_bb1_arrayidx11_0_reg_195_inputs_ready_NO_SHIFT_REG = local_bb1_arrayidx11_valid_out;
assign local_bb1_arrayidx11_stall_in = rnode_194to195_bb1_arrayidx11_0_stall_out_reg_195_NO_SHIFT_REG;
assign rnode_194to195_bb1_arrayidx11_0_NO_SHIFT_REG = rnode_194to195_bb1_arrayidx11_0_reg_195_NO_SHIFT_REG;
assign rnode_194to195_bb1_arrayidx11_0_stall_in_reg_195_NO_SHIFT_REG = rnode_194to195_bb1_arrayidx11_0_stall_in_NO_SHIFT_REG;
assign rnode_194to195_bb1_arrayidx11_0_valid_out_NO_SHIFT_REG = rnode_194to195_bb1_arrayidx11_0_valid_out_reg_195_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_ld__inputs_ready;
 reg local_bb1_ld__valid_out_NO_SHIFT_REG;
wire local_bb1_ld__stall_in;
wire local_bb1_ld__output_regs_ready;
wire local_bb1_ld__fu_stall_out;
wire local_bb1_ld__fu_valid_out;
wire [15:0] local_bb1_ld__lsu_dataout;
 reg [15:0] local_bb1_ld__NO_SHIFT_REG;
wire local_bb1_ld__causedstall;

lsu_top lsu_local_bb1_ld_ (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb1_ld__fu_stall_out),
	.i_valid(local_bb1_ld__inputs_ready),
	.i_address((rnode_8to9_bb1_arrayidx_0_NO_SHIFT_REG & 64'hFFFFFFFFFFFFFFFE)),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(1'b0),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb1_ld__output_regs_ready)),
	.o_valid(local_bb1_ld__fu_valid_out),
	.o_readdata(local_bb1_ld__lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb1_ld__active),
	.avm_address(avm_local_bb1_ld__address),
	.avm_read(avm_local_bb1_ld__read),
	.avm_readdata(avm_local_bb1_ld__readdata),
	.avm_write(avm_local_bb1_ld__write),
	.avm_writeack(avm_local_bb1_ld__writeack),
	.avm_burstcount(avm_local_bb1_ld__burstcount),
	.avm_writedata(avm_local_bb1_ld__writedata),
	.avm_byteenable(avm_local_bb1_ld__byteenable),
	.avm_waitrequest(avm_local_bb1_ld__waitrequest),
	.avm_readdatavalid(avm_local_bb1_ld__readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb1_ld_.AWIDTH = 33;
defparam lsu_local_bb1_ld_.WIDTH_BYTES = 2;
defparam lsu_local_bb1_ld_.MWIDTH_BYTES = 64;
defparam lsu_local_bb1_ld_.WRITEDATAWIDTH_BYTES = 64;
defparam lsu_local_bb1_ld_.ALIGNMENT_BYTES = 2;
defparam lsu_local_bb1_ld_.READ = 1;
defparam lsu_local_bb1_ld_.ATOMIC = 0;
defparam lsu_local_bb1_ld_.WIDTH = 16;
defparam lsu_local_bb1_ld_.MWIDTH = 512;
defparam lsu_local_bb1_ld_.ATOMIC_WIDTH = 3;
defparam lsu_local_bb1_ld_.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb1_ld_.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb1_ld_.MEMORY_SIDE_MEM_LATENCY = 67;
defparam lsu_local_bb1_ld_.USE_WRITE_ACK = 0;
defparam lsu_local_bb1_ld_.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb1_ld_.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb1_ld_.NUMBER_BANKS = 1;
defparam lsu_local_bb1_ld_.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb1_ld_.INTENDED_DEVICE_FAMILY = "Stratix V";
defparam lsu_local_bb1_ld_.USEINPUTFIFO = 0;
defparam lsu_local_bb1_ld_.USECACHING = 0;
defparam lsu_local_bb1_ld_.USEOUTPUTFIFO = 1;
defparam lsu_local_bb1_ld_.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb1_ld_.HIGH_FMAX = 1;
defparam lsu_local_bb1_ld_.ADDRSPACE = 1;
defparam lsu_local_bb1_ld_.STYLE = "BURST-COALESCED";

assign local_bb1_ld__inputs_ready = rnode_8to9_bb1_arrayidx_0_valid_out_NO_SHIFT_REG;
assign local_bb1_ld__output_regs_ready = (&(~(local_bb1_ld__valid_out_NO_SHIFT_REG) | ~(local_bb1_ld__stall_in)));
assign rnode_8to9_bb1_arrayidx_0_stall_in_NO_SHIFT_REG = (local_bb1_ld__fu_stall_out | ~(local_bb1_ld__inputs_ready));
assign local_bb1_ld__causedstall = (local_bb1_ld__inputs_ready && (local_bb1_ld__fu_stall_out && !(~(local_bb1_ld__output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_ld__NO_SHIFT_REG <= 'x;
		local_bb1_ld__valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_ld__output_regs_ready)
		begin
			local_bb1_ld__NO_SHIFT_REG <= local_bb1_ld__lsu_dataout;
			local_bb1_ld__valid_out_NO_SHIFT_REG <= local_bb1_ld__fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_ld__stall_in))
			begin
				local_bb1_ld__valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_169to169_bb1_ld__valid_out;
wire rstag_169to169_bb1_ld__stall_in;
wire rstag_169to169_bb1_ld__inputs_ready;
wire rstag_169to169_bb1_ld__stall_local;
 reg rstag_169to169_bb1_ld__staging_valid_NO_SHIFT_REG;
wire rstag_169to169_bb1_ld__combined_valid;
 reg [15:0] rstag_169to169_bb1_ld__staging_reg_NO_SHIFT_REG;
wire [15:0] rstag_169to169_bb1_ld_;

assign rstag_169to169_bb1_ld__inputs_ready = local_bb1_ld__valid_out_NO_SHIFT_REG;
assign rstag_169to169_bb1_ld_ = (rstag_169to169_bb1_ld__staging_valid_NO_SHIFT_REG ? rstag_169to169_bb1_ld__staging_reg_NO_SHIFT_REG : local_bb1_ld__NO_SHIFT_REG);
assign rstag_169to169_bb1_ld__combined_valid = (rstag_169to169_bb1_ld__staging_valid_NO_SHIFT_REG | rstag_169to169_bb1_ld__inputs_ready);
assign rstag_169to169_bb1_ld__valid_out = rstag_169to169_bb1_ld__combined_valid;
assign rstag_169to169_bb1_ld__stall_local = rstag_169to169_bb1_ld__stall_in;
assign local_bb1_ld__stall_in = (|rstag_169to169_bb1_ld__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_169to169_bb1_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_169to169_bb1_ld__staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_169to169_bb1_ld__stall_local)
		begin
			if (~(rstag_169to169_bb1_ld__staging_valid_NO_SHIFT_REG))
			begin
				rstag_169to169_bb1_ld__staging_valid_NO_SHIFT_REG <= rstag_169to169_bb1_ld__inputs_ready;
			end
		end
		else
		begin
			rstag_169to169_bb1_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_169to169_bb1_ld__staging_valid_NO_SHIFT_REG))
		begin
			rstag_169to169_bb1_ld__staging_reg_NO_SHIFT_REG <= local_bb1_ld__NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni1_valid_out;
wire local_bb1_c0_eni1_stall_in;
wire local_bb1_c0_eni1_inputs_ready;
wire local_bb1_c0_eni1_stall_local;
wire [31:0] local_bb1_c0_eni1;

assign local_bb1_c0_eni1_inputs_ready = rstag_169to169_bb1_ld__valid_out;
assign local_bb1_c0_eni1[15:0] = 16'bx;
assign local_bb1_c0_eni1[31:16] = rstag_169to169_bb1_ld_;
assign local_bb1_c0_eni1_valid_out = local_bb1_c0_eni1_inputs_ready;
assign local_bb1_c0_eni1_stall_local = local_bb1_c0_eni1_stall_in;
assign rstag_169to169_bb1_ld__stall_in = (|local_bb1_c0_eni1_stall_local);

// This section implements a registered operation.
// 
wire local_bb1_c0_enter_c0_eni1_inputs_ready;
 reg local_bb1_c0_enter_c0_eni1_valid_out_0_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni1_stall_in_0;
 reg local_bb1_c0_enter_c0_eni1_valid_out_1_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni1_stall_in_1;
wire local_bb1_c0_enter_c0_eni1_output_regs_ready;
 reg [31:0] local_bb1_c0_enter_c0_eni1_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni1_input_accepted;
 reg local_bb1_c0_enter_c0_eni1_valid_bit_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi1_entry_stall;
wire local_bb1_c0_exit_c0_exi1_output_regs_ready;
wire [21:0] local_bb1_c0_exit_c0_exi1_valid_bits;
wire local_bb1_c0_exit_c0_exi1_valid_in;
wire local_bb1_c0_exit_c0_exi1_phases;
wire local_bb1_c0_enter_c0_eni1_inc_pipelined_thread;
wire local_bb1_c0_enter_c0_eni1_dec_pipelined_thread;
wire local_bb1_c0_enter_c0_eni1_causedstall;

assign local_bb1_c0_enter_c0_eni1_inputs_ready = local_bb1_c0_eni1_valid_out;
assign local_bb1_c0_enter_c0_eni1_output_regs_ready = 1'b1;
assign local_bb1_c0_enter_c0_eni1_input_accepted = (local_bb1_c0_enter_c0_eni1_inputs_ready && !(local_bb1_c0_exit_c0_exi1_entry_stall));
assign local_bb1_c0_enter_c0_eni1_inc_pipelined_thread = 1'b1;
assign local_bb1_c0_enter_c0_eni1_dec_pipelined_thread = ~(1'b0);
assign local_bb1_c0_eni1_stall_in = ((~(local_bb1_c0_enter_c0_eni1_inputs_ready) | local_bb1_c0_exit_c0_exi1_entry_stall) | ~(1'b1));
assign local_bb1_c0_enter_c0_eni1_causedstall = (1'b1 && ((~(local_bb1_c0_enter_c0_eni1_inputs_ready) | local_bb1_c0_exit_c0_exi1_entry_stall) && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_enter_c0_eni1_valid_bit_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_c0_enter_c0_eni1_valid_bit_NO_SHIFT_REG <= local_bb1_c0_enter_c0_eni1_input_accepted;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_enter_c0_eni1_NO_SHIFT_REG <= 'x;
		local_bb1_c0_enter_c0_eni1_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_enter_c0_eni1_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c0_enter_c0_eni1_output_regs_ready)
		begin
			local_bb1_c0_enter_c0_eni1_NO_SHIFT_REG <= local_bb1_c0_eni1;
			local_bb1_c0_enter_c0_eni1_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_enter_c0_eni1_valid_out_1_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_c0_enter_c0_eni1_stall_in_0))
			begin
				local_bb1_c0_enter_c0_eni1_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_enter_c0_eni1_stall_in_1))
			begin
				local_bb1_c0_enter_c0_eni1_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene1_stall_local;
wire [15:0] local_bb1_c0_ene1;

assign local_bb1_c0_ene1 = local_bb1_c0_enter_c0_eni1_NO_SHIFT_REG[31:16];

// This section implements an unregistered operation.
// 
wire SFC_1_VALID_170_170_0_valid_out;
wire SFC_1_VALID_170_170_0_stall_in;
wire SFC_1_VALID_170_170_0_inputs_ready;
wire SFC_1_VALID_170_170_0_stall_local;
wire SFC_1_VALID_170_170_0;

assign SFC_1_VALID_170_170_0_inputs_ready = local_bb1_c0_enter_c0_eni1_valid_out_1_NO_SHIFT_REG;
assign SFC_1_VALID_170_170_0 = local_bb1_c0_enter_c0_eni1_valid_bit_NO_SHIFT_REG;
assign SFC_1_VALID_170_170_0_valid_out = 1'b1;
assign local_bb1_c0_enter_c0_eni1_stall_in_1 = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_conv6_valid_out;
wire local_bb1_conv6_stall_in;
wire local_bb1_conv6_inputs_ready;
wire local_bb1_conv6_stall_local;
wire [31:0] local_bb1_conv6;

assign local_bb1_conv6_inputs_ready = local_bb1_c0_enter_c0_eni1_valid_out_0_NO_SHIFT_REG;
assign local_bb1_conv6[31:16] = 16'h0;
assign local_bb1_conv6[15:0] = local_bb1_c0_ene1;
assign local_bb1_conv6_valid_out = 1'b1;
assign local_bb1_c0_enter_c0_eni1_stall_in_0 = 1'b0;

// This section implements a registered operation.
// 
wire SFC_1_VALID_170_171_0_inputs_ready;
 reg SFC_1_VALID_170_171_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_170_171_0_stall_in;
wire SFC_1_VALID_170_171_0_output_regs_ready;
 reg SFC_1_VALID_170_171_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_170_171_0_causedstall;

assign SFC_1_VALID_170_171_0_inputs_ready = 1'b1;
assign SFC_1_VALID_170_171_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_170_170_0_stall_in = 1'b0;
assign SFC_1_VALID_170_171_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_170_171_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_170_171_0_output_regs_ready)
		begin
			SFC_1_VALID_170_171_0_NO_SHIFT_REG <= SFC_1_VALID_170_170_0;
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_conv7_inputs_ready;
 reg local_bb1_conv7_valid_out_NO_SHIFT_REG;
wire local_bb1_conv7_stall_in;
wire local_bb1_conv7_output_regs_ready;
wire [31:0] local_bb1_conv7;
 reg local_bb1_conv7_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_conv7_valid_pipe_1_NO_SHIFT_REG;
 reg local_bb1_conv7_valid_pipe_2_NO_SHIFT_REG;
 reg local_bb1_conv7_valid_pipe_3_NO_SHIFT_REG;
 reg local_bb1_conv7_valid_pipe_4_NO_SHIFT_REG;
wire local_bb1_conv7_causedstall;

acl_fp_sitofp fp_module_local_bb1_conv7 (
	.clock(clock),
	.dataa((local_bb1_conv6 & 32'hFFFF)),
	.enable(local_bb1_conv7_output_regs_ready),
	.result(local_bb1_conv7)
);


assign local_bb1_conv7_inputs_ready = 1'b1;
assign local_bb1_conv7_output_regs_ready = 1'b1;
assign local_bb1_conv6_stall_in = 1'b0;
assign local_bb1_conv7_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_conv7_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv7_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv7_valid_pipe_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv7_valid_pipe_3_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv7_valid_pipe_4_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_conv7_output_regs_ready)
		begin
			local_bb1_conv7_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_conv7_valid_pipe_1_NO_SHIFT_REG <= local_bb1_conv7_valid_pipe_0_NO_SHIFT_REG;
			local_bb1_conv7_valid_pipe_2_NO_SHIFT_REG <= local_bb1_conv7_valid_pipe_1_NO_SHIFT_REG;
			local_bb1_conv7_valid_pipe_3_NO_SHIFT_REG <= local_bb1_conv7_valid_pipe_2_NO_SHIFT_REG;
			local_bb1_conv7_valid_pipe_4_NO_SHIFT_REG <= local_bb1_conv7_valid_pipe_3_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_conv7_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_conv7_output_regs_ready)
		begin
			local_bb1_conv7_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_conv7_stall_in))
			begin
				local_bb1_conv7_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_171_172_0_inputs_ready;
 reg SFC_1_VALID_171_172_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_171_172_0_stall_in;
wire SFC_1_VALID_171_172_0_output_regs_ready;
 reg SFC_1_VALID_171_172_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_171_172_0_causedstall;

assign SFC_1_VALID_171_172_0_inputs_ready = 1'b1;
assign SFC_1_VALID_171_172_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_170_171_0_stall_in = 1'b0;
assign SFC_1_VALID_171_172_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_171_172_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_171_172_0_output_regs_ready)
		begin
			SFC_1_VALID_171_172_0_NO_SHIFT_REG <= SFC_1_VALID_170_171_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_div_inputs_ready;
 reg local_bb1_div_valid_out_NO_SHIFT_REG;
wire local_bb1_div_stall_in;
wire local_bb1_div_output_regs_ready;
wire [31:0] local_bb1_div;
 reg local_bb1_div_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_1_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_2_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_3_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_4_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_5_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_6_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_7_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_8_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_9_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_10_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_11_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_12_NO_SHIFT_REG;
wire local_bb1_div_causedstall;

acl_fp_div_s5 fp_module_local_bb1_div (
	.clock(clock),
	.dataa(local_bb1_conv7),
	.datab(32'h447A0000),
	.enable(local_bb1_div_output_regs_ready),
	.result(local_bb1_div)
);


assign local_bb1_div_inputs_ready = 1'b1;
assign local_bb1_div_output_regs_ready = 1'b1;
assign local_bb1_conv7_stall_in = 1'b0;
assign local_bb1_div_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_div_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_3_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_4_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_5_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_6_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_7_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_8_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_9_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_10_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_11_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_12_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_div_output_regs_ready)
		begin
			local_bb1_div_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_div_valid_pipe_1_NO_SHIFT_REG <= local_bb1_div_valid_pipe_0_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_2_NO_SHIFT_REG <= local_bb1_div_valid_pipe_1_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_3_NO_SHIFT_REG <= local_bb1_div_valid_pipe_2_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_4_NO_SHIFT_REG <= local_bb1_div_valid_pipe_3_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_5_NO_SHIFT_REG <= local_bb1_div_valid_pipe_4_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_6_NO_SHIFT_REG <= local_bb1_div_valid_pipe_5_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_7_NO_SHIFT_REG <= local_bb1_div_valid_pipe_6_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_8_NO_SHIFT_REG <= local_bb1_div_valid_pipe_7_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_9_NO_SHIFT_REG <= local_bb1_div_valid_pipe_8_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_10_NO_SHIFT_REG <= local_bb1_div_valid_pipe_9_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_11_NO_SHIFT_REG <= local_bb1_div_valid_pipe_10_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_12_NO_SHIFT_REG <= local_bb1_div_valid_pipe_11_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_div_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_div_output_regs_ready)
		begin
			local_bb1_div_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_div_stall_in))
			begin
				local_bb1_div_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_172_173_0_inputs_ready;
 reg SFC_1_VALID_172_173_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_172_173_0_stall_in;
wire SFC_1_VALID_172_173_0_output_regs_ready;
 reg SFC_1_VALID_172_173_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_172_173_0_causedstall;

assign SFC_1_VALID_172_173_0_inputs_ready = 1'b1;
assign SFC_1_VALID_172_173_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_171_172_0_stall_in = 1'b0;
assign SFC_1_VALID_172_173_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_172_173_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_172_173_0_output_regs_ready)
		begin
			SFC_1_VALID_172_173_0_NO_SHIFT_REG <= SFC_1_VALID_171_172_0_NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi1_valid_out;
wire local_bb1_c0_exi1_stall_in;
wire local_bb1_c0_exi1_inputs_ready;
wire local_bb1_c0_exi1_stall_local;
wire [63:0] local_bb1_c0_exi1;

assign local_bb1_c0_exi1_inputs_ready = local_bb1_div_valid_out_NO_SHIFT_REG;
assign local_bb1_c0_exi1[31:0] = 32'bx;
assign local_bb1_c0_exi1[63:32] = local_bb1_div;
assign local_bb1_c0_exi1_valid_out = 1'b1;
assign local_bb1_div_stall_in = 1'b0;

// This section implements a registered operation.
// 
wire SFC_1_VALID_173_174_0_inputs_ready;
 reg SFC_1_VALID_173_174_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_173_174_0_stall_in;
wire SFC_1_VALID_173_174_0_output_regs_ready;
 reg SFC_1_VALID_173_174_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_173_174_0_causedstall;

assign SFC_1_VALID_173_174_0_inputs_ready = 1'b1;
assign SFC_1_VALID_173_174_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_172_173_0_stall_in = 1'b0;
assign SFC_1_VALID_173_174_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_173_174_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_173_174_0_output_regs_ready)
		begin
			SFC_1_VALID_173_174_0_NO_SHIFT_REG <= SFC_1_VALID_172_173_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_174_175_0_inputs_ready;
 reg SFC_1_VALID_174_175_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_174_175_0_stall_in;
wire SFC_1_VALID_174_175_0_output_regs_ready;
 reg SFC_1_VALID_174_175_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_174_175_0_causedstall;

assign SFC_1_VALID_174_175_0_inputs_ready = 1'b1;
assign SFC_1_VALID_174_175_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_173_174_0_stall_in = 1'b0;
assign SFC_1_VALID_174_175_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_174_175_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_174_175_0_output_regs_ready)
		begin
			SFC_1_VALID_174_175_0_NO_SHIFT_REG <= SFC_1_VALID_173_174_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_175_176_0_inputs_ready;
 reg SFC_1_VALID_175_176_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_175_176_0_stall_in;
wire SFC_1_VALID_175_176_0_output_regs_ready;
 reg SFC_1_VALID_175_176_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_175_176_0_causedstall;

assign SFC_1_VALID_175_176_0_inputs_ready = 1'b1;
assign SFC_1_VALID_175_176_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_174_175_0_stall_in = 1'b0;
assign SFC_1_VALID_175_176_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_175_176_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_175_176_0_output_regs_ready)
		begin
			SFC_1_VALID_175_176_0_NO_SHIFT_REG <= SFC_1_VALID_174_175_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_176_177_0_inputs_ready;
 reg SFC_1_VALID_176_177_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_176_177_0_stall_in;
wire SFC_1_VALID_176_177_0_output_regs_ready;
 reg SFC_1_VALID_176_177_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_176_177_0_causedstall;

assign SFC_1_VALID_176_177_0_inputs_ready = 1'b1;
assign SFC_1_VALID_176_177_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_175_176_0_stall_in = 1'b0;
assign SFC_1_VALID_176_177_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_176_177_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_176_177_0_output_regs_ready)
		begin
			SFC_1_VALID_176_177_0_NO_SHIFT_REG <= SFC_1_VALID_175_176_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_177_178_0_inputs_ready;
 reg SFC_1_VALID_177_178_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_177_178_0_stall_in;
wire SFC_1_VALID_177_178_0_output_regs_ready;
 reg SFC_1_VALID_177_178_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_177_178_0_causedstall;

assign SFC_1_VALID_177_178_0_inputs_ready = 1'b1;
assign SFC_1_VALID_177_178_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_176_177_0_stall_in = 1'b0;
assign SFC_1_VALID_177_178_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_177_178_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_177_178_0_output_regs_ready)
		begin
			SFC_1_VALID_177_178_0_NO_SHIFT_REG <= SFC_1_VALID_176_177_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_178_179_0_inputs_ready;
 reg SFC_1_VALID_178_179_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_178_179_0_stall_in;
wire SFC_1_VALID_178_179_0_output_regs_ready;
 reg SFC_1_VALID_178_179_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_178_179_0_causedstall;

assign SFC_1_VALID_178_179_0_inputs_ready = 1'b1;
assign SFC_1_VALID_178_179_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_177_178_0_stall_in = 1'b0;
assign SFC_1_VALID_178_179_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_178_179_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_178_179_0_output_regs_ready)
		begin
			SFC_1_VALID_178_179_0_NO_SHIFT_REG <= SFC_1_VALID_177_178_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_179_180_0_inputs_ready;
 reg SFC_1_VALID_179_180_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_179_180_0_stall_in;
wire SFC_1_VALID_179_180_0_output_regs_ready;
 reg SFC_1_VALID_179_180_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_179_180_0_causedstall;

assign SFC_1_VALID_179_180_0_inputs_ready = 1'b1;
assign SFC_1_VALID_179_180_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_178_179_0_stall_in = 1'b0;
assign SFC_1_VALID_179_180_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_179_180_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_179_180_0_output_regs_ready)
		begin
			SFC_1_VALID_179_180_0_NO_SHIFT_REG <= SFC_1_VALID_178_179_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_180_181_0_inputs_ready;
 reg SFC_1_VALID_180_181_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_180_181_0_stall_in;
wire SFC_1_VALID_180_181_0_output_regs_ready;
 reg SFC_1_VALID_180_181_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_180_181_0_causedstall;

assign SFC_1_VALID_180_181_0_inputs_ready = 1'b1;
assign SFC_1_VALID_180_181_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_179_180_0_stall_in = 1'b0;
assign SFC_1_VALID_180_181_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_180_181_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_180_181_0_output_regs_ready)
		begin
			SFC_1_VALID_180_181_0_NO_SHIFT_REG <= SFC_1_VALID_179_180_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_181_182_0_inputs_ready;
 reg SFC_1_VALID_181_182_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_181_182_0_stall_in;
wire SFC_1_VALID_181_182_0_output_regs_ready;
 reg SFC_1_VALID_181_182_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_181_182_0_causedstall;

assign SFC_1_VALID_181_182_0_inputs_ready = 1'b1;
assign SFC_1_VALID_181_182_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_180_181_0_stall_in = 1'b0;
assign SFC_1_VALID_181_182_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_181_182_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_181_182_0_output_regs_ready)
		begin
			SFC_1_VALID_181_182_0_NO_SHIFT_REG <= SFC_1_VALID_180_181_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_182_183_0_inputs_ready;
 reg SFC_1_VALID_182_183_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_182_183_0_stall_in;
wire SFC_1_VALID_182_183_0_output_regs_ready;
 reg SFC_1_VALID_182_183_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_182_183_0_causedstall;

assign SFC_1_VALID_182_183_0_inputs_ready = 1'b1;
assign SFC_1_VALID_182_183_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_181_182_0_stall_in = 1'b0;
assign SFC_1_VALID_182_183_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_182_183_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_182_183_0_output_regs_ready)
		begin
			SFC_1_VALID_182_183_0_NO_SHIFT_REG <= SFC_1_VALID_181_182_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_183_184_0_inputs_ready;
 reg SFC_1_VALID_183_184_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_183_184_0_stall_in;
wire SFC_1_VALID_183_184_0_output_regs_ready;
 reg SFC_1_VALID_183_184_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_183_184_0_causedstall;

assign SFC_1_VALID_183_184_0_inputs_ready = 1'b1;
assign SFC_1_VALID_183_184_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_182_183_0_stall_in = 1'b0;
assign SFC_1_VALID_183_184_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_183_184_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_183_184_0_output_regs_ready)
		begin
			SFC_1_VALID_183_184_0_NO_SHIFT_REG <= SFC_1_VALID_182_183_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_184_185_0_inputs_ready;
 reg SFC_1_VALID_184_185_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_184_185_0_stall_in;
wire SFC_1_VALID_184_185_0_output_regs_ready;
 reg SFC_1_VALID_184_185_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_184_185_0_causedstall;

assign SFC_1_VALID_184_185_0_inputs_ready = 1'b1;
assign SFC_1_VALID_184_185_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_183_184_0_stall_in = 1'b0;
assign SFC_1_VALID_184_185_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_184_185_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_184_185_0_output_regs_ready)
		begin
			SFC_1_VALID_184_185_0_NO_SHIFT_REG <= SFC_1_VALID_183_184_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_185_186_0_inputs_ready;
 reg SFC_1_VALID_185_186_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_185_186_0_stall_in;
wire SFC_1_VALID_185_186_0_output_regs_ready;
 reg SFC_1_VALID_185_186_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_185_186_0_causedstall;

assign SFC_1_VALID_185_186_0_inputs_ready = 1'b1;
assign SFC_1_VALID_185_186_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_184_185_0_stall_in = 1'b0;
assign SFC_1_VALID_185_186_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_185_186_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_185_186_0_output_regs_ready)
		begin
			SFC_1_VALID_185_186_0_NO_SHIFT_REG <= SFC_1_VALID_184_185_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_186_187_0_inputs_ready;
 reg SFC_1_VALID_186_187_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_186_187_0_stall_in;
wire SFC_1_VALID_186_187_0_output_regs_ready;
 reg SFC_1_VALID_186_187_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_186_187_0_causedstall;

assign SFC_1_VALID_186_187_0_inputs_ready = 1'b1;
assign SFC_1_VALID_186_187_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_185_186_0_stall_in = 1'b0;
assign SFC_1_VALID_186_187_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_186_187_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_186_187_0_output_regs_ready)
		begin
			SFC_1_VALID_186_187_0_NO_SHIFT_REG <= SFC_1_VALID_185_186_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_187_188_0_inputs_ready;
 reg SFC_1_VALID_187_188_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_187_188_0_stall_in;
wire SFC_1_VALID_187_188_0_output_regs_ready;
 reg SFC_1_VALID_187_188_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_187_188_0_causedstall;

assign SFC_1_VALID_187_188_0_inputs_ready = 1'b1;
assign SFC_1_VALID_187_188_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_186_187_0_stall_in = 1'b0;
assign SFC_1_VALID_187_188_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_187_188_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_187_188_0_output_regs_ready)
		begin
			SFC_1_VALID_187_188_0_NO_SHIFT_REG <= SFC_1_VALID_186_187_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_188_189_0_inputs_ready;
 reg SFC_1_VALID_188_189_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_188_189_0_stall_in;
wire SFC_1_VALID_188_189_0_output_regs_ready;
 reg SFC_1_VALID_188_189_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_188_189_0_causedstall;

assign SFC_1_VALID_188_189_0_inputs_ready = 1'b1;
assign SFC_1_VALID_188_189_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_187_188_0_stall_in = 1'b0;
assign SFC_1_VALID_188_189_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_188_189_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_188_189_0_output_regs_ready)
		begin
			SFC_1_VALID_188_189_0_NO_SHIFT_REG <= SFC_1_VALID_187_188_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_1_VALID_189_190_0_inputs_ready;
 reg SFC_1_VALID_189_190_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_189_190_0_stall_in;
wire SFC_1_VALID_189_190_0_output_regs_ready;
 reg SFC_1_VALID_189_190_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_189_190_0_causedstall;

assign SFC_1_VALID_189_190_0_inputs_ready = 1'b1;
assign SFC_1_VALID_189_190_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_188_189_0_stall_in = 1'b0;
assign SFC_1_VALID_189_190_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_189_190_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_189_190_0_output_regs_ready)
		begin
			SFC_1_VALID_189_190_0_NO_SHIFT_REG <= SFC_1_VALID_188_189_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_c0_exit_c0_exi1_inputs_ready;
 reg local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi1_stall_in;
 reg [63:0] local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG;
wire [63:0] local_bb1_c0_exit_c0_exi1_in;
wire local_bb1_c0_exit_c0_exi1_valid;
wire local_bb1_c0_exit_c0_exi1_causedstall;

acl_stall_free_sink local_bb1_c0_exit_c0_exi1_instance (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_bb1_c0_exi1),
	.data_out(local_bb1_c0_exit_c0_exi1_in),
	.input_accepted(local_bb1_c0_enter_c0_eni1_input_accepted),
	.valid_out(local_bb1_c0_exit_c0_exi1_valid),
	.stall_in(~(local_bb1_c0_exit_c0_exi1_output_regs_ready)),
	.stall_entry(local_bb1_c0_exit_c0_exi1_entry_stall),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_in),
	.IIphases(local_bb1_c0_exit_c0_exi1_phases),
	.inc_pipelined_thread(local_bb1_c0_enter_c0_eni1_inc_pipelined_thread),
	.dec_pipelined_thread(local_bb1_c0_enter_c0_eni1_dec_pipelined_thread)
);

defparam local_bb1_c0_exit_c0_exi1_instance.DATA_WIDTH = 64;
defparam local_bb1_c0_exit_c0_exi1_instance.PIPELINE_DEPTH = 26;
defparam local_bb1_c0_exit_c0_exi1_instance.SHARINGII = 1;
defparam local_bb1_c0_exit_c0_exi1_instance.SCHEDULEII = 1;
defparam local_bb1_c0_exit_c0_exi1_instance.ALWAYS_THROTTLE = 0;

assign local_bb1_c0_exit_c0_exi1_inputs_ready = 1'b1;
assign local_bb1_c0_exit_c0_exi1_output_regs_ready = (&(~(local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG) | ~(local_bb1_c0_exit_c0_exi1_stall_in)));
assign local_bb1_c0_exit_c0_exi1_valid_in = SFC_1_VALID_189_190_0_NO_SHIFT_REG;
assign local_bb1_c0_exi1_stall_in = 1'b0;
assign SFC_1_VALID_189_190_0_stall_in = 1'b0;
assign local_bb1_c0_exit_c0_exi1_causedstall = (1'b1 && (1'b0 && !(~(local_bb1_c0_exit_c0_exi1_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG <= 'x;
		local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c0_exit_c0_exi1_output_regs_ready)
		begin
			local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi1_in;
			local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi1_valid;
		end
		else
		begin
			if (~(local_bb1_c0_exit_c0_exi1_stall_in))
			begin
				local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_exe1_valid_out;
wire local_bb1_c0_exe1_stall_in;
wire local_bb1_c0_exe1_inputs_ready;
wire local_bb1_c0_exe1_stall_local;
wire [31:0] local_bb1_c0_exe1;

assign local_bb1_c0_exe1_inputs_ready = local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG;
assign local_bb1_c0_exe1 = local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG[63:32];
assign local_bb1_c0_exe1_valid_out = local_bb1_c0_exe1_inputs_ready;
assign local_bb1_c0_exe1_stall_local = local_bb1_c0_exe1_stall_in;
assign local_bb1_c0_exit_c0_exi1_stall_in = (|local_bb1_c0_exe1_stall_local);

// This section implements a registered operation.
// 
wire local_bb1_st_c0_exe1_inputs_ready;
 reg local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG;
wire local_bb1_st_c0_exe1_stall_in;
wire local_bb1_st_c0_exe1_output_regs_ready;
wire local_bb1_st_c0_exe1_fu_stall_out;
wire local_bb1_st_c0_exe1_fu_valid_out;
wire local_bb1_st_c0_exe1_causedstall;

lsu_top lsu_local_bb1_st_c0_exe1 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb1_st_c0_exe1_fu_stall_out),
	.i_valid(local_bb1_st_c0_exe1_inputs_ready),
	.i_address((rnode_194to195_bb1_arrayidx11_0_NO_SHIFT_REG & 64'hFFFFFFFFFFFFFFFC)),
	.i_writedata(local_bb1_c0_exe1),
	.i_cmpdata(),
	.i_predicate(1'b0),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb1_st_c0_exe1_output_regs_ready)),
	.o_valid(local_bb1_st_c0_exe1_fu_valid_out),
	.o_readdata(),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb1_st_c0_exe1_active),
	.avm_address(avm_local_bb1_st_c0_exe1_address),
	.avm_read(avm_local_bb1_st_c0_exe1_read),
	.avm_readdata(avm_local_bb1_st_c0_exe1_readdata),
	.avm_write(avm_local_bb1_st_c0_exe1_write),
	.avm_writeack(avm_local_bb1_st_c0_exe1_writeack),
	.avm_burstcount(avm_local_bb1_st_c0_exe1_burstcount),
	.avm_writedata(avm_local_bb1_st_c0_exe1_writedata),
	.avm_byteenable(avm_local_bb1_st_c0_exe1_byteenable),
	.avm_waitrequest(avm_local_bb1_st_c0_exe1_waitrequest),
	.avm_readdatavalid(avm_local_bb1_st_c0_exe1_readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb1_st_c0_exe1.AWIDTH = 33;
defparam lsu_local_bb1_st_c0_exe1.WIDTH_BYTES = 4;
defparam lsu_local_bb1_st_c0_exe1.MWIDTH_BYTES = 64;
defparam lsu_local_bb1_st_c0_exe1.WRITEDATAWIDTH_BYTES = 64;
defparam lsu_local_bb1_st_c0_exe1.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb1_st_c0_exe1.READ = 0;
defparam lsu_local_bb1_st_c0_exe1.ATOMIC = 0;
defparam lsu_local_bb1_st_c0_exe1.WIDTH = 32;
defparam lsu_local_bb1_st_c0_exe1.MWIDTH = 512;
defparam lsu_local_bb1_st_c0_exe1.ATOMIC_WIDTH = 3;
defparam lsu_local_bb1_st_c0_exe1.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb1_st_c0_exe1.KERNEL_SIDE_MEM_LATENCY = 4;
defparam lsu_local_bb1_st_c0_exe1.MEMORY_SIDE_MEM_LATENCY = 8;
defparam lsu_local_bb1_st_c0_exe1.USE_WRITE_ACK = 0;
defparam lsu_local_bb1_st_c0_exe1.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb1_st_c0_exe1.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb1_st_c0_exe1.NUMBER_BANKS = 1;
defparam lsu_local_bb1_st_c0_exe1.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb1_st_c0_exe1.INTENDED_DEVICE_FAMILY = "Stratix V";
defparam lsu_local_bb1_st_c0_exe1.USEINPUTFIFO = 0;
defparam lsu_local_bb1_st_c0_exe1.USECACHING = 0;
defparam lsu_local_bb1_st_c0_exe1.USEOUTPUTFIFO = 1;
defparam lsu_local_bb1_st_c0_exe1.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb1_st_c0_exe1.HIGH_FMAX = 1;
defparam lsu_local_bb1_st_c0_exe1.ADDRSPACE = 1;
defparam lsu_local_bb1_st_c0_exe1.STYLE = "BURST-COALESCED";
defparam lsu_local_bb1_st_c0_exe1.USE_BYTE_EN = 0;

assign local_bb1_st_c0_exe1_inputs_ready = (local_bb1_c0_exe1_valid_out & rnode_194to195_bb1_arrayidx11_0_valid_out_NO_SHIFT_REG);
assign local_bb1_st_c0_exe1_output_regs_ready = (&(~(local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG) | ~(local_bb1_st_c0_exe1_stall_in)));
assign local_bb1_c0_exe1_stall_in = (local_bb1_st_c0_exe1_fu_stall_out | ~(local_bb1_st_c0_exe1_inputs_ready));
assign rnode_194to195_bb1_arrayidx11_0_stall_in_NO_SHIFT_REG = (local_bb1_st_c0_exe1_fu_stall_out | ~(local_bb1_st_c0_exe1_inputs_ready));
assign local_bb1_st_c0_exe1_causedstall = (local_bb1_st_c0_exe1_inputs_ready && (local_bb1_st_c0_exe1_fu_stall_out && !(~(local_bb1_st_c0_exe1_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_st_c0_exe1_output_regs_ready)
		begin
			local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG <= local_bb1_st_c0_exe1_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_st_c0_exe1_stall_in))
			begin
				local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_199to199_bb1_st_c0_exe1_valid_out;
wire rstag_199to199_bb1_st_c0_exe1_stall_in;
wire rstag_199to199_bb1_st_c0_exe1_inputs_ready;
wire rstag_199to199_bb1_st_c0_exe1_stall_local;
 reg rstag_199to199_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG;
wire rstag_199to199_bb1_st_c0_exe1_combined_valid;

assign rstag_199to199_bb1_st_c0_exe1_inputs_ready = local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG;
assign rstag_199to199_bb1_st_c0_exe1_combined_valid = (rstag_199to199_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG | rstag_199to199_bb1_st_c0_exe1_inputs_ready);
assign rstag_199to199_bb1_st_c0_exe1_valid_out = rstag_199to199_bb1_st_c0_exe1_combined_valid;
assign rstag_199to199_bb1_st_c0_exe1_stall_local = rstag_199to199_bb1_st_c0_exe1_stall_in;
assign local_bb1_st_c0_exe1_stall_in = (|rstag_199to199_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_199to199_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (rstag_199to199_bb1_st_c0_exe1_stall_local)
		begin
			if (~(rstag_199to199_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG))
			begin
				rstag_199to199_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG <= rstag_199to199_bb1_st_c0_exe1_inputs_ready;
			end
		end
		else
		begin
			rstag_199to199_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
wire branch_var__output_regs_ready;

assign branch_var__inputs_ready = rstag_199to199_bb1_st_c0_exe1_valid_out;
assign branch_var__output_regs_ready = ~(stall_in);
assign rstag_199to199_bb1_st_c0_exe1_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign valid_out = branch_var__inputs_ready;

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module AOCmm2metersKernel_function
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_global_id_1,
		output 		stall_out,
		input 		valid_in,
		output 		valid_out,
		input 		stall_in,
		input [31:0] 		workgroup_size,
		input [511:0] 		avm_local_bb1_ld__readdata,
		input 		avm_local_bb1_ld__readdatavalid,
		input 		avm_local_bb1_ld__waitrequest,
		output [32:0] 		avm_local_bb1_ld__address,
		output 		avm_local_bb1_ld__read,
		output 		avm_local_bb1_ld__write,
		input 		avm_local_bb1_ld__writeack,
		output [511:0] 		avm_local_bb1_ld__writedata,
		output [63:0] 		avm_local_bb1_ld__byteenable,
		output [4:0] 		avm_local_bb1_ld__burstcount,
		input [511:0] 		avm_local_bb1_st_c0_exe1_readdata,
		input 		avm_local_bb1_st_c0_exe1_readdatavalid,
		input 		avm_local_bb1_st_c0_exe1_waitrequest,
		output [32:0] 		avm_local_bb1_st_c0_exe1_address,
		output 		avm_local_bb1_st_c0_exe1_read,
		output 		avm_local_bb1_st_c0_exe1_write,
		input 		avm_local_bb1_st_c0_exe1_writeack,
		output [511:0] 		avm_local_bb1_st_c0_exe1_writedata,
		output [63:0] 		avm_local_bb1_st_c0_exe1_byteenable,
		output [4:0] 		avm_local_bb1_st_c0_exe1_burstcount,
		input 		start,
		input 		clock2x,
		input [31:0] 		input_inSize_x,
		input [31:0] 		input_depthSize_x,
		input [31:0] 		input_ratio,
		input [63:0] 		input_depth,
		input [63:0] 		input_in,
		output reg 		has_a_write_pending,
		output reg 		has_a_lsu_active
	);


wire [31:0] cur_cycle;
wire bb_0_stall_out;
wire bb_0_valid_out;
wire [31:0] bb_0_lvb_input_global_id_0;
wire [31:0] bb_0_lvb_input_global_id_1;
wire bb_1_stall_out;
wire bb_1_valid_out;
wire bb_1_local_bb1_ld__active;
wire bb_1_local_bb1_st_c0_exe1_active;
wire writes_pending;
wire [1:0] lsus_active;

AOCmm2metersKernel_basic_block_0 AOCmm2metersKernel_basic_block_0 (
	.clock(clock),
	.resetn(resetn),
	.start(start),
	.valid_in(valid_in),
	.stall_out(bb_0_stall_out),
	.input_global_id_0(input_global_id_0),
	.input_global_id_1(input_global_id_1),
	.valid_out(bb_0_valid_out),
	.stall_in(bb_1_stall_out),
	.lvb_input_global_id_0(bb_0_lvb_input_global_id_0),
	.lvb_input_global_id_1(bb_0_lvb_input_global_id_1),
	.workgroup_size(workgroup_size)
);


AOCmm2metersKernel_basic_block_1 AOCmm2metersKernel_basic_block_1 (
	.clock(clock),
	.resetn(resetn),
	.input_inSize_x(input_inSize_x),
	.input_depthSize_x(input_depthSize_x),
	.input_ratio(input_ratio),
	.input_depth(input_depth),
	.input_in(input_in),
	.valid_in(bb_0_valid_out),
	.stall_out(bb_1_stall_out),
	.input_global_id_0(bb_0_lvb_input_global_id_0),
	.input_global_id_1(bb_0_lvb_input_global_id_1),
	.valid_out(bb_1_valid_out),
	.stall_in(stall_in),
	.workgroup_size(workgroup_size),
	.start(start),
	.avm_local_bb1_ld__readdata(avm_local_bb1_ld__readdata),
	.avm_local_bb1_ld__readdatavalid(avm_local_bb1_ld__readdatavalid),
	.avm_local_bb1_ld__waitrequest(avm_local_bb1_ld__waitrequest),
	.avm_local_bb1_ld__address(avm_local_bb1_ld__address),
	.avm_local_bb1_ld__read(avm_local_bb1_ld__read),
	.avm_local_bb1_ld__write(avm_local_bb1_ld__write),
	.avm_local_bb1_ld__writeack(avm_local_bb1_ld__writeack),
	.avm_local_bb1_ld__writedata(avm_local_bb1_ld__writedata),
	.avm_local_bb1_ld__byteenable(avm_local_bb1_ld__byteenable),
	.avm_local_bb1_ld__burstcount(avm_local_bb1_ld__burstcount),
	.local_bb1_ld__active(bb_1_local_bb1_ld__active),
	.clock2x(clock2x),
	.avm_local_bb1_st_c0_exe1_readdata(avm_local_bb1_st_c0_exe1_readdata),
	.avm_local_bb1_st_c0_exe1_readdatavalid(avm_local_bb1_st_c0_exe1_readdatavalid),
	.avm_local_bb1_st_c0_exe1_waitrequest(avm_local_bb1_st_c0_exe1_waitrequest),
	.avm_local_bb1_st_c0_exe1_address(avm_local_bb1_st_c0_exe1_address),
	.avm_local_bb1_st_c0_exe1_read(avm_local_bb1_st_c0_exe1_read),
	.avm_local_bb1_st_c0_exe1_write(avm_local_bb1_st_c0_exe1_write),
	.avm_local_bb1_st_c0_exe1_writeack(avm_local_bb1_st_c0_exe1_writeack),
	.avm_local_bb1_st_c0_exe1_writedata(avm_local_bb1_st_c0_exe1_writedata),
	.avm_local_bb1_st_c0_exe1_byteenable(avm_local_bb1_st_c0_exe1_byteenable),
	.avm_local_bb1_st_c0_exe1_burstcount(avm_local_bb1_st_c0_exe1_burstcount),
	.local_bb1_st_c0_exe1_active(bb_1_local_bb1_st_c0_exe1_active)
);


AOCmm2metersKernel_sys_cycle_time system_cycle_time_module (
	.clock(clock),
	.resetn(resetn),
	.cur_cycle(cur_cycle)
);


assign valid_out = bb_1_valid_out;
assign stall_out = bb_0_stall_out;
assign writes_pending = bb_1_local_bb1_st_c0_exe1_active;
assign lsus_active[0] = bb_1_local_bb1_ld__active;
assign lsus_active[1] = bb_1_local_bb1_st_c0_exe1_active;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		has_a_write_pending <= 1'b0;
		has_a_lsu_active <= 1'b0;
	end
	else
	begin
		has_a_write_pending <= (|writes_pending);
		has_a_lsu_active <= (|lsus_active);
	end
end

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module AOCmm2metersKernel_function_wrapper
	(
		input 		clock,
		input 		resetn,
		input 		clock2x,
		input 		local_router_hang,
		input 		avs_cra_read,
		input 		avs_cra_write,
		input [4:0] 		avs_cra_address,
		input [63:0] 		avs_cra_writedata,
		input [7:0] 		avs_cra_byteenable,
		output reg [63:0] 		avs_cra_readdata,
		output reg 		avs_cra_readdatavalid,
		output 		cra_irq,
		input [511:0] 		avm_local_bb1_ld__inst0_readdata,
		input 		avm_local_bb1_ld__inst0_readdatavalid,
		input 		avm_local_bb1_ld__inst0_waitrequest,
		output [32:0] 		avm_local_bb1_ld__inst0_address,
		output 		avm_local_bb1_ld__inst0_read,
		output 		avm_local_bb1_ld__inst0_write,
		input 		avm_local_bb1_ld__inst0_writeack,
		output [511:0] 		avm_local_bb1_ld__inst0_writedata,
		output [63:0] 		avm_local_bb1_ld__inst0_byteenable,
		output [4:0] 		avm_local_bb1_ld__inst0_burstcount,
		input [511:0] 		avm_local_bb1_st_c0_exe1_inst0_readdata,
		input 		avm_local_bb1_st_c0_exe1_inst0_readdatavalid,
		input 		avm_local_bb1_st_c0_exe1_inst0_waitrequest,
		output [32:0] 		avm_local_bb1_st_c0_exe1_inst0_address,
		output 		avm_local_bb1_st_c0_exe1_inst0_read,
		output 		avm_local_bb1_st_c0_exe1_inst0_write,
		input 		avm_local_bb1_st_c0_exe1_inst0_writeack,
		output [511:0] 		avm_local_bb1_st_c0_exe1_inst0_writedata,
		output [63:0] 		avm_local_bb1_st_c0_exe1_inst0_byteenable,
		output [4:0] 		avm_local_bb1_st_c0_exe1_inst0_burstcount
	);

// Responsible for interfacing a kernel with the outside world. It comprises a
// slave interface to specify the kernel arguments and retain kernel status. 

// This section of the wrapper implements the slave interface.
// twoXclock_consumer uses clock2x, even if nobody inside the kernel does. Keeps interface to acl_iface consistent for all kernels.
 reg start_NO_SHIFT_REG;
 reg started_NO_SHIFT_REG;
wire finish;
 reg [31:0] status_NO_SHIFT_REG;
wire has_a_write_pending;
wire has_a_lsu_active;
 reg [287:0] kernel_arguments_NO_SHIFT_REG;
 reg twoXclock_consumer_NO_SHIFT_REG /* synthesis  preserve  noprune  */;
 reg [31:0] workgroup_size_NO_SHIFT_REG;
 reg [31:0] global_size_NO_SHIFT_REG[2:0];
 reg [31:0] num_groups_NO_SHIFT_REG[2:0];
 reg [31:0] local_size_NO_SHIFT_REG[2:0];
 reg [31:0] work_dim_NO_SHIFT_REG;
 reg [31:0] global_offset_NO_SHIFT_REG[2:0];
 reg [63:0] profile_data_NO_SHIFT_REG;
 reg [31:0] profile_ctrl_NO_SHIFT_REG;
 reg [63:0] profile_start_cycle_NO_SHIFT_REG;
 reg [63:0] profile_stop_cycle_NO_SHIFT_REG;
wire dispatched_all_groups;
wire [31:0] group_id_tmp[2:0];
wire [31:0] global_id_base_out[2:0];
wire start_out;
wire [31:0] local_id[0:0][2:0];
wire [31:0] global_id[0:0][2:0];
wire [31:0] group_id[0:0][2:0];
wire iter_valid_in;
wire iter_stall_out;
wire stall_in;
wire stall_out;
wire valid_in;
wire valid_out;

always @(posedge clock2x or negedge resetn)
begin
	if (~(resetn))
	begin
		twoXclock_consumer_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		twoXclock_consumer_NO_SHIFT_REG <= 1'b1;
	end
end



// Work group dispatcher is responsible for issuing work-groups to id iterator(s)
acl_work_group_dispatcher group_dispatcher (
	.clock(clock),
	.resetn(resetn),
	.start(start_NO_SHIFT_REG),
	.num_groups(num_groups_NO_SHIFT_REG),
	.local_size(local_size_NO_SHIFT_REG),
	.stall_in(iter_stall_out),
	.valid_out(iter_valid_in),
	.group_id_out(group_id_tmp),
	.global_id_base_out(global_id_base_out),
	.start_out(start_out),
	.dispatched_all_groups(dispatched_all_groups)
);

defparam group_dispatcher.NUM_COPIES = 1;
defparam group_dispatcher.RUN_FOREVER = 0;


// This section of the wrapper implements an Avalon Slave Interface used to configure a kernel invocation.
// The few words words contain the status and the workgroup size registers.
// The remaining addressable space is reserved for kernel arguments.
 reg [63:0] cra_readdata_st1_NO_SHIFT_REG;
 reg [4:0] cra_addr_st1_NO_SHIFT_REG;
 reg cra_read_st1_NO_SHIFT_REG;
wire [63:0] bitenable;

assign bitenable[7:0] = (avs_cra_byteenable[0] ? 8'hFF : 8'h0);
assign bitenable[15:8] = (avs_cra_byteenable[1] ? 8'hFF : 8'h0);
assign bitenable[23:16] = (avs_cra_byteenable[2] ? 8'hFF : 8'h0);
assign bitenable[31:24] = (avs_cra_byteenable[3] ? 8'hFF : 8'h0);
assign bitenable[39:32] = (avs_cra_byteenable[4] ? 8'hFF : 8'h0);
assign bitenable[47:40] = (avs_cra_byteenable[5] ? 8'hFF : 8'h0);
assign bitenable[55:48] = (avs_cra_byteenable[6] ? 8'hFF : 8'h0);
assign bitenable[63:56] = (avs_cra_byteenable[7] ? 8'hFF : 8'h0);
assign cra_irq = (status_NO_SHIFT_REG[1] | status_NO_SHIFT_REG[3]);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		start_NO_SHIFT_REG <= 1'b0;
		started_NO_SHIFT_REG <= 1'b0;
		kernel_arguments_NO_SHIFT_REG <= 288'h0;
		status_NO_SHIFT_REG <= 32'h30000;
		profile_ctrl_NO_SHIFT_REG <= 32'h4;
		profile_start_cycle_NO_SHIFT_REG <= 64'h0;
		profile_stop_cycle_NO_SHIFT_REG <= 64'hFFFFFFFFFFFFFFFF;
		work_dim_NO_SHIFT_REG <= 32'h0;
		workgroup_size_NO_SHIFT_REG <= 32'h0;
		global_size_NO_SHIFT_REG[0] <= 32'h0;
		global_size_NO_SHIFT_REG[1] <= 32'h0;
		global_size_NO_SHIFT_REG[2] <= 32'h0;
		num_groups_NO_SHIFT_REG[0] <= 32'h0;
		num_groups_NO_SHIFT_REG[1] <= 32'h0;
		num_groups_NO_SHIFT_REG[2] <= 32'h0;
		local_size_NO_SHIFT_REG[0] <= 32'h0;
		local_size_NO_SHIFT_REG[1] <= 32'h0;
		local_size_NO_SHIFT_REG[2] <= 32'h0;
		global_offset_NO_SHIFT_REG[0] <= 32'h0;
		global_offset_NO_SHIFT_REG[1] <= 32'h0;
		global_offset_NO_SHIFT_REG[2] <= 32'h0;
	end
	else
	begin
		if (avs_cra_write)
		begin
			case (avs_cra_address)
				5'h0:
				begin
					status_NO_SHIFT_REG[31:16] <= 16'h3;
					status_NO_SHIFT_REG[15:0] <= ((status_NO_SHIFT_REG[15:0] & ~(bitenable[15:0])) | (avs_cra_writedata[15:0] & bitenable[15:0]));
				end

				5'h1:
				begin
					profile_ctrl_NO_SHIFT_REG <= ((profile_ctrl_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				5'h3:
				begin
					profile_start_cycle_NO_SHIFT_REG[31:0] <= ((profile_start_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_start_cycle_NO_SHIFT_REG[63:32] <= ((profile_start_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				5'h4:
				begin
					profile_stop_cycle_NO_SHIFT_REG[31:0] <= ((profile_stop_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_stop_cycle_NO_SHIFT_REG[63:32] <= ((profile_stop_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				5'h5:
				begin
					work_dim_NO_SHIFT_REG <= ((work_dim_NO_SHIFT_REG & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					workgroup_size_NO_SHIFT_REG <= ((workgroup_size_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				5'h6:
				begin
					global_size_NO_SHIFT_REG[0] <= ((global_size_NO_SHIFT_REG[0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_size_NO_SHIFT_REG[1] <= ((global_size_NO_SHIFT_REG[1] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				5'h7:
				begin
					global_size_NO_SHIFT_REG[2] <= ((global_size_NO_SHIFT_REG[2] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_NO_SHIFT_REG[0] <= ((num_groups_NO_SHIFT_REG[0] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				5'h8:
				begin
					num_groups_NO_SHIFT_REG[1] <= ((num_groups_NO_SHIFT_REG[1] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_NO_SHIFT_REG[2] <= ((num_groups_NO_SHIFT_REG[2] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				5'h9:
				begin
					local_size_NO_SHIFT_REG[0] <= ((local_size_NO_SHIFT_REG[0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					local_size_NO_SHIFT_REG[1] <= ((local_size_NO_SHIFT_REG[1] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				5'hA:
				begin
					local_size_NO_SHIFT_REG[2] <= ((local_size_NO_SHIFT_REG[2] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_NO_SHIFT_REG[0] <= ((global_offset_NO_SHIFT_REG[0] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				5'hB:
				begin
					global_offset_NO_SHIFT_REG[1] <= ((global_offset_NO_SHIFT_REG[1] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_NO_SHIFT_REG[2] <= ((global_offset_NO_SHIFT_REG[2] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				5'hC:
				begin
					kernel_arguments_NO_SHIFT_REG[31:0] <= ((kernel_arguments_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[63:32] <= ((kernel_arguments_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				5'hD:
				begin
					kernel_arguments_NO_SHIFT_REG[95:64] <= ((kernel_arguments_NO_SHIFT_REG[95:64] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[127:96] <= ((kernel_arguments_NO_SHIFT_REG[127:96] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				5'hE:
				begin
					kernel_arguments_NO_SHIFT_REG[159:128] <= ((kernel_arguments_NO_SHIFT_REG[159:128] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[191:160] <= ((kernel_arguments_NO_SHIFT_REG[191:160] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				5'hF:
				begin
					kernel_arguments_NO_SHIFT_REG[223:192] <= ((kernel_arguments_NO_SHIFT_REG[223:192] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[255:224] <= ((kernel_arguments_NO_SHIFT_REG[255:224] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				5'h10:
				begin
					kernel_arguments_NO_SHIFT_REG[287:256] <= ((kernel_arguments_NO_SHIFT_REG[287:256] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
				end

				default:
				begin
				end

			endcase
		end
		else
		begin
			if (status_NO_SHIFT_REG[0])
			begin
				start_NO_SHIFT_REG <= 1'b1;
			end
			if (start_NO_SHIFT_REG)
			begin
				status_NO_SHIFT_REG[0] <= 1'b0;
				started_NO_SHIFT_REG <= 1'b1;
			end
			if (started_NO_SHIFT_REG)
			begin
				start_NO_SHIFT_REG <= 1'b0;
			end
			if (finish)
			begin
				status_NO_SHIFT_REG[1] <= 1'b1;
				started_NO_SHIFT_REG <= 1'b0;
			end
		end
		status_NO_SHIFT_REG[11] <= 1'b0;
		status_NO_SHIFT_REG[12] <= (|has_a_lsu_active);
		status_NO_SHIFT_REG[13] <= (|has_a_write_pending);
		status_NO_SHIFT_REG[14] <= (|valid_in);
		status_NO_SHIFT_REG[15] <= started_NO_SHIFT_REG;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		cra_read_st1_NO_SHIFT_REG <= 1'b0;
		cra_addr_st1_NO_SHIFT_REG <= 5'h0;
		cra_readdata_st1_NO_SHIFT_REG <= 64'h0;
	end
	else
	begin
		cra_read_st1_NO_SHIFT_REG <= avs_cra_read;
		cra_addr_st1_NO_SHIFT_REG <= avs_cra_address;
		case (avs_cra_address)
			5'h0:
			begin
				cra_readdata_st1_NO_SHIFT_REG[31:0] <= status_NO_SHIFT_REG;
				cra_readdata_st1_NO_SHIFT_REG[63:32] <= 32'h0;
			end

			5'h1:
			begin
				cra_readdata_st1_NO_SHIFT_REG[31:0] <= 'x;
				cra_readdata_st1_NO_SHIFT_REG[63:32] <= 32'h0;
			end

			5'h2:
			begin
				cra_readdata_st1_NO_SHIFT_REG[63:0] <= 64'h0;
			end

			5'h3:
			begin
				cra_readdata_st1_NO_SHIFT_REG[63:0] <= 64'h0;
			end

			5'h4:
			begin
				cra_readdata_st1_NO_SHIFT_REG[63:0] <= 64'h0;
			end

			default:
			begin
				cra_readdata_st1_NO_SHIFT_REG <= status_NO_SHIFT_REG;
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		avs_cra_readdatavalid <= 1'b0;
		avs_cra_readdata <= 64'h0;
	end
	else
	begin
		avs_cra_readdatavalid <= cra_read_st1_NO_SHIFT_REG;
		case (cra_addr_st1_NO_SHIFT_REG)
			5'h2:
			begin
				avs_cra_readdata[63:0] <= profile_data_NO_SHIFT_REG;
			end

			default:
			begin
				avs_cra_readdata <= cra_readdata_st1_NO_SHIFT_REG;
			end

		endcase
	end
end


// Handshaking signals used to control data through the pipeline

// Determine when the kernel is finished.
acl_kernel_finish_detector kernel_finish_detector (
	.clock(clock),
	.resetn(resetn),
	.start(start_NO_SHIFT_REG),
	.wg_size(workgroup_size_NO_SHIFT_REG),
	.wg_dispatch_valid_out(iter_valid_in),
	.wg_dispatch_stall_in(iter_stall_out),
	.dispatched_all_groups(dispatched_all_groups),
	.kernel_copy_valid_out(valid_out),
	.kernel_copy_stall_in(stall_in),
	.pending_writes(has_a_write_pending),
	.finish(finish)
);

defparam kernel_finish_detector.TESSELLATION_SIZE = 0;
defparam kernel_finish_detector.NUM_COPIES = 1;
defparam kernel_finish_detector.WG_SIZE_W = 32;

assign stall_in = 1'b0;

// Creating ID iterator and kernel instance for every requested kernel copy

// ID iterator is responsible for iterating over all local ids for given work-groups
acl_id_iterator id_iter_inst0 (
	.clock(clock),
	.resetn(resetn),
	.start(start_out),
	.valid_in(iter_valid_in),
	.stall_out(iter_stall_out),
	.stall_in(stall_out),
	.valid_out(valid_in),
	.group_id_in(group_id_tmp),
	.global_id_base_in(global_id_base_out),
	.local_size(local_size_NO_SHIFT_REG),
	.global_size(global_size_NO_SHIFT_REG),
	.local_id(local_id[0]),
	.global_id(global_id[0]),
	.group_id(group_id[0])
);



// This section instantiates a kernel function block
AOCmm2metersKernel_function AOCmm2metersKernel_function_inst0 (
	.clock(clock),
	.resetn(resetn),
	.input_global_id_0(global_id[0][0]),
	.input_global_id_1(global_id[0][1]),
	.stall_out(stall_out),
	.valid_in(valid_in),
	.valid_out(valid_out),
	.stall_in(stall_in),
	.workgroup_size(workgroup_size_NO_SHIFT_REG),
	.avm_local_bb1_ld__readdata(avm_local_bb1_ld__inst0_readdata),
	.avm_local_bb1_ld__readdatavalid(avm_local_bb1_ld__inst0_readdatavalid),
	.avm_local_bb1_ld__waitrequest(avm_local_bb1_ld__inst0_waitrequest),
	.avm_local_bb1_ld__address(avm_local_bb1_ld__inst0_address),
	.avm_local_bb1_ld__read(avm_local_bb1_ld__inst0_read),
	.avm_local_bb1_ld__write(avm_local_bb1_ld__inst0_write),
	.avm_local_bb1_ld__writeack(avm_local_bb1_ld__inst0_writeack),
	.avm_local_bb1_ld__writedata(avm_local_bb1_ld__inst0_writedata),
	.avm_local_bb1_ld__byteenable(avm_local_bb1_ld__inst0_byteenable),
	.avm_local_bb1_ld__burstcount(avm_local_bb1_ld__inst0_burstcount),
	.avm_local_bb1_st_c0_exe1_readdata(avm_local_bb1_st_c0_exe1_inst0_readdata),
	.avm_local_bb1_st_c0_exe1_readdatavalid(avm_local_bb1_st_c0_exe1_inst0_readdatavalid),
	.avm_local_bb1_st_c0_exe1_waitrequest(avm_local_bb1_st_c0_exe1_inst0_waitrequest),
	.avm_local_bb1_st_c0_exe1_address(avm_local_bb1_st_c0_exe1_inst0_address),
	.avm_local_bb1_st_c0_exe1_read(avm_local_bb1_st_c0_exe1_inst0_read),
	.avm_local_bb1_st_c0_exe1_write(avm_local_bb1_st_c0_exe1_inst0_write),
	.avm_local_bb1_st_c0_exe1_writeack(avm_local_bb1_st_c0_exe1_inst0_writeack),
	.avm_local_bb1_st_c0_exe1_writedata(avm_local_bb1_st_c0_exe1_inst0_writedata),
	.avm_local_bb1_st_c0_exe1_byteenable(avm_local_bb1_st_c0_exe1_inst0_byteenable),
	.avm_local_bb1_st_c0_exe1_burstcount(avm_local_bb1_st_c0_exe1_inst0_burstcount),
	.start(start_out),
	.clock2x(clock2x),
	.input_inSize_x(kernel_arguments_NO_SHIFT_REG[223:192]),
	.input_depthSize_x(kernel_arguments_NO_SHIFT_REG[95:64]),
	.input_ratio(kernel_arguments_NO_SHIFT_REG[287:256]),
	.input_depth(kernel_arguments_NO_SHIFT_REG[63:0]),
	.input_in(kernel_arguments_NO_SHIFT_REG[191:128]),
	.has_a_write_pending(has_a_write_pending),
	.has_a_lsu_active(has_a_lsu_active)
);



endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module AOCmm2metersKernel_sys_cycle_time
	(
		input 		clock,
		input 		resetn,
		output [31:0] 		cur_cycle
	);


 reg [31:0] cur_count_NO_SHIFT_REG;

assign cur_cycle = cur_count_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		cur_count_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		cur_count_NO_SHIFT_REG <= (cur_count_NO_SHIFT_REG + 32'h1);
	end
end

endmodule

