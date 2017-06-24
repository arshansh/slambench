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
		output 		valid_out,
		input 		stall_in,
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
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
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

assign branch_var__inputs_ready = merge_node_valid_out_NO_SHIFT_REG;
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign merge_node_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign combined_branch_stall_in_signal = stall_in;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
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
		input 		valid_in_0,
		output 		stall_out_0,
		input 		input_forked_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input 		input_forked_1,
		output 		valid_out,
		input 		stall_in,
		output [31:0] 		lvb_bb1_c0_exe1,
		output [31:0] 		lvb_bb1_c0_exe2,
		output 		lvb_bb1_c0_exe3,
		input [31:0] 		workgroup_size,
		input 		start,
		input 		feedback_valid_in_4,
		output 		feedback_stall_out_4,
		input [31:0] 		feedback_data_in_4,
		output 		feedback_stall_out_2,
		input 		feedback_valid_in_3,
		output 		feedback_stall_out_3,
		input 		feedback_data_in_3,
		output 		acl_pipelined_valid,
		input 		acl_pipelined_stall,
		output 		acl_pipelined_exiting_valid,
		output 		acl_pipelined_exiting_stall,
		output 		feedback_valid_out_3,
		input 		feedback_stall_in_3,
		output 		feedback_data_out_3,
		output 		feedback_valid_out_4,
		input 		feedback_stall_in_4,
		output [31:0] 		feedback_data_out_4
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((valid_in_0 & valid_in_1) & ~((stall_out_0 | stall_out_1)));
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
 reg merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
 reg input_forked_0_staging_reg_NO_SHIFT_REG;
 reg local_lvm_forked_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg input_forked_1_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = (|(merge_node_stall_in & merge_node_valid_out_NO_SHIFT_REG));
assign stall_out_0 = merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
assign stall_out_1 = merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_0_staging_reg_NO_SHIFT_REG | valid_in_0))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		if ((merge_node_valid_in_1_staging_reg_NO_SHIFT_REG | valid_in_1))
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b1;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
		end
		else
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b0;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_forked_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_forked_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_forked_0_staging_reg_NO_SHIFT_REG <= input_forked_0;
				merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= valid_in_0;
			end
		end
		else
		begin
			merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
		if (((merge_block_selector_NO_SHIFT_REG != 1'b1) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_1_staging_reg_NO_SHIFT_REG))
			begin
				input_forked_1_staging_reg_NO_SHIFT_REG <= input_forked_1;
				merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= valid_in_1;
			end
		end
		else
		begin
			merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
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
				if (merge_node_valid_in_0_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_1;
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


// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni1_stall_local;
wire [15:0] local_bb1_c0_eni1;

assign local_bb1_c0_eni1[7:0] = 8'bx;
assign local_bb1_c0_eni1[8] = local_lvm_forked_NO_SHIFT_REG;
assign local_bb1_c0_eni1[15:9] = 7'bx;

// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene1_valid_out_1;
wire local_bb1_c0_ene1_stall_in_1;
wire SFC_1_VALID_1_1_0_valid_out_0;
wire SFC_1_VALID_1_1_0_stall_in_0;
wire local_bb1_pixel_y_03_pop4_acl_pop_i32_0_valid_out;
wire local_bb1_pixel_y_03_pop4_acl_pop_i32_0_stall_in;
wire local_bb1_c0_enter_c0_eni1_inputs_ready;
wire local_bb1_c0_enter_c0_eni1_stall_local;
wire local_bb1_c0_enter_c0_eni1_input_accepted;
wire [15:0] local_bb1_c0_enter_c0_eni1;
wire local_bb1_c0_exit_c0_exi4_entry_stall;
wire local_bb1_c0_enter_c0_eni1_valid_bit;
wire local_bb1_c0_exit_c0_exi4_output_regs_ready;
wire local_bb1_c0_exit_c0_exi4_valid_in;
wire local_bb1_c0_exit_c0_exi4_phases;
wire local_bb1_c0_enter_c0_eni1_inc_pipelined_thread;
wire local_bb1_c0_enter_c0_eni1_dec_pipelined_thread;
wire local_bb1_c0_enter_c0_eni1_fu_stall_out;

assign local_bb1_c0_enter_c0_eni1_inputs_ready = merge_node_valid_out_NO_SHIFT_REG;
assign local_bb1_c0_enter_c0_eni1 = local_bb1_c0_eni1;
assign local_bb1_c0_enter_c0_eni1_input_accepted = (local_bb1_c0_enter_c0_eni1_inputs_ready && !(local_bb1_c0_exit_c0_exi4_entry_stall));
assign local_bb1_c0_enter_c0_eni1_valid_bit = local_bb1_c0_enter_c0_eni1_input_accepted;
assign local_bb1_c0_enter_c0_eni1_inc_pipelined_thread = 1'b1;
assign local_bb1_c0_enter_c0_eni1_dec_pipelined_thread = ~(1'b0);
assign local_bb1_c0_enter_c0_eni1_fu_stall_out = (~(local_bb1_c0_enter_c0_eni1_inputs_ready) | local_bb1_c0_exit_c0_exi4_entry_stall);
assign local_bb1_c0_enter_c0_eni1_stall_local = (local_bb1_c0_ene1_stall_in_1 | SFC_1_VALID_1_1_0_stall_in_0 | local_bb1_pixel_y_03_pop4_acl_pop_i32_0_stall_in);
assign local_bb1_c0_ene1_valid_out_1 = local_bb1_c0_enter_c0_eni1_inputs_ready;
assign SFC_1_VALID_1_1_0_valid_out_0 = local_bb1_c0_enter_c0_eni1_inputs_ready;
assign local_bb1_pixel_y_03_pop4_acl_pop_i32_0_valid_out = local_bb1_c0_enter_c0_eni1_inputs_ready;
assign merge_node_stall_in = (|local_bb1_c0_enter_c0_eni1_fu_stall_out);

// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene1_stall_local;
wire local_bb1_c0_ene1;

assign local_bb1_c0_ene1 = local_bb1_c0_enter_c0_eni1[8];

// This section implements an unregistered operation.
// 
wire SFC_1_VALID_1_1_0_stall_local;
wire SFC_1_VALID_1_1_0;

assign SFC_1_VALID_1_1_0 = local_bb1_c0_enter_c0_eni1_valid_bit;

// This section implements an unregistered operation.
// 
wire local_bb1_pixel_y_03_pop4_acl_pop_i32_0_stall_local;
wire [31:0] local_bb1_pixel_y_03_pop4_acl_pop_i32_0;
wire local_bb1_pixel_y_03_pop4_acl_pop_i32_0_fu_valid_out;
wire local_bb1_pixel_y_03_pop4_acl_pop_i32_0_fu_stall_out;

acl_pop local_bb1_pixel_y_03_pop4_acl_pop_i32_0_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene1),
	.predicate(1'b0),
	.data_in(32'h0),
	.stall_out(local_bb1_pixel_y_03_pop4_acl_pop_i32_0_fu_stall_out),
	.valid_in(SFC_1_VALID_1_1_0),
	.valid_out(local_bb1_pixel_y_03_pop4_acl_pop_i32_0_fu_valid_out),
	.stall_in(local_bb1_pixel_y_03_pop4_acl_pop_i32_0_stall_local),
	.data_out(local_bb1_pixel_y_03_pop4_acl_pop_i32_0),
	.feedback_in(feedback_data_in_4),
	.feedback_valid_in(feedback_valid_in_4),
	.feedback_stall_out(feedback_stall_out_4)
);

defparam local_bb1_pixel_y_03_pop4_acl_pop_i32_0_feedback.COALESCE_DISTANCE = 1;
defparam local_bb1_pixel_y_03_pop4_acl_pop_i32_0_feedback.DATA_WIDTH = 32;
defparam local_bb1_pixel_y_03_pop4_acl_pop_i32_0_feedback.STYLE = "REGULAR";

assign local_bb1_pixel_y_03_pop4_acl_pop_i32_0_stall_local = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb1_c0_ene1_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c0_ene1_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c0_ene1_0_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c0_ene1_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c0_ene1_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c0_ene1_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c0_ene1_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_c0_ene1_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb1_c0_ene1_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb1_c0_ene1_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb1_c0_ene1_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb1_c0_ene1_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb1_c0_ene1_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb1_c0_ene1),
	.data_out(rnode_1to2_bb1_c0_ene1_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb1_c0_ene1_0_reg_2_fifo.DEPTH = 1;
defparam rnode_1to2_bb1_c0_ene1_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_bb1_c0_ene1_0_reg_2_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_1to2_bb1_c0_ene1_0_reg_2_fifo.IMPL = "shift_reg";

assign rnode_1to2_bb1_c0_ene1_0_reg_2_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_c0_ene1_stall_in_1 = 1'b0;
assign rnode_1to2_bb1_c0_ene1_0_NO_SHIFT_REG = rnode_1to2_bb1_c0_ene1_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb1_c0_ene1_0_stall_in_reg_2_NO_SHIFT_REG = 1'b0;
assign rnode_1to2_bb1_c0_ene1_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire SFC_1_VALID_1_2_0_inputs_ready;
 reg SFC_1_VALID_1_2_0_valid_out_0_NO_SHIFT_REG;
wire SFC_1_VALID_1_2_0_stall_in_0;
 reg SFC_1_VALID_1_2_0_valid_out_1_NO_SHIFT_REG;
wire SFC_1_VALID_1_2_0_stall_in_1;
 reg SFC_1_VALID_1_2_0_valid_out_2_NO_SHIFT_REG;
wire SFC_1_VALID_1_2_0_stall_in_2;
 reg SFC_1_VALID_1_2_0_valid_out_3_NO_SHIFT_REG;
wire SFC_1_VALID_1_2_0_stall_in_3;
wire SFC_1_VALID_1_2_0_output_regs_ready;
 reg SFC_1_VALID_1_2_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_1_2_0_causedstall;

assign SFC_1_VALID_1_2_0_inputs_ready = 1'b1;
assign SFC_1_VALID_1_2_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_1_1_0_stall_in_0 = 1'b0;
assign SFC_1_VALID_1_2_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_1_2_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_1_2_0_output_regs_ready)
		begin
			SFC_1_VALID_1_2_0_NO_SHIFT_REG <= SFC_1_VALID_1_1_0;
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_NO_SHIFT_REG;
 logic rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_1_NO_SHIFT_REG;
 logic rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb1_pixel_y_03_pop4_acl_pop_i32_0),
	.data_out(rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_reg_2_fifo.DEPTH = 1;
defparam rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_reg_2_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_reg_2_fifo.IMPL = "shift_reg";

assign rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_reg_2_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_pixel_y_03_pop4_acl_pop_i32_0_stall_in = 1'b0;
assign rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_stall_in_0_reg_2_NO_SHIFT_REG = 1'b0;
assign rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_NO_SHIFT_REG = rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_1_NO_SHIFT_REG = rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_2_NO_SHIFT_REG = rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_reg_2_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire SFC_1_VALID_2_3_0_inputs_ready;
 reg SFC_1_VALID_2_3_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_2_3_0_stall_in;
wire SFC_1_VALID_2_3_0_output_regs_ready;
 reg SFC_1_VALID_2_3_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_2_3_0_causedstall;

assign SFC_1_VALID_2_3_0_inputs_ready = 1'b1;
assign SFC_1_VALID_2_3_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_1_2_0_stall_in_0 = 1'b0;
assign SFC_1_VALID_2_3_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_2_3_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_2_3_0_output_regs_ready)
		begin
			SFC_1_VALID_2_3_0_NO_SHIFT_REG <= SFC_1_VALID_1_2_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_keep_going2_acl_pipeline_1_inputs_ready;
 reg local_bb1_keep_going2_acl_pipeline_1_valid_out_NO_SHIFT_REG;
wire local_bb1_keep_going2_acl_pipeline_1_stall_in;
wire local_bb1_keep_going2_acl_pipeline_1_output_regs_ready;
wire local_bb1_keep_going2_acl_pipeline_1_keep_going;
wire local_bb1_keep_going2_acl_pipeline_1_fu_valid_out;
wire local_bb1_keep_going2_acl_pipeline_1_fu_stall_out;
 reg local_bb1_keep_going2_acl_pipeline_1_NO_SHIFT_REG;
wire local_bb1_keep_going2_acl_pipeline_1_feedback_pipelined;
wire local_bb1_keep_going2_acl_pipeline_1_causedstall;

acl_pipeline local_bb1_keep_going2_acl_pipeline_1_pipelined (
	.clock(clock),
	.resetn(resetn),
	.data_in(1'b1),
	.stall_out(local_bb1_keep_going2_acl_pipeline_1_fu_stall_out),
	.valid_in(SFC_1_VALID_1_2_0_NO_SHIFT_REG),
	.valid_out(local_bb1_keep_going2_acl_pipeline_1_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_keep_going2_acl_pipeline_1_keep_going),
	.initeration_in(1'b0),
	.initeration_valid_in(1'b0),
	.initeration_stall_out(feedback_stall_out_2),
	.not_exitcond_in(feedback_data_in_3),
	.not_exitcond_valid_in(feedback_valid_in_3),
	.not_exitcond_stall_out(feedback_stall_out_3),
	.pipeline_valid_out(acl_pipelined_valid),
	.pipeline_stall_in(acl_pipelined_stall),
	.exiting_valid_out(acl_pipelined_exiting_valid)
);

defparam local_bb1_keep_going2_acl_pipeline_1_pipelined.FIFO_DEPTH = 0;
defparam local_bb1_keep_going2_acl_pipeline_1_pipelined.STYLE = "NON_SPECULATIVE";

assign local_bb1_keep_going2_acl_pipeline_1_inputs_ready = 1'b1;
assign local_bb1_keep_going2_acl_pipeline_1_output_regs_ready = 1'b1;
assign acl_pipelined_exiting_stall = acl_pipelined_stall;
assign SFC_1_VALID_1_2_0_stall_in_1 = 1'b0;
assign rnode_1to2_bb1_c0_ene1_0_stall_in_NO_SHIFT_REG = 1'b0;
assign local_bb1_keep_going2_acl_pipeline_1_causedstall = (SFC_1_VALID_1_2_0_NO_SHIFT_REG && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_keep_going2_acl_pipeline_1_NO_SHIFT_REG <= 'x;
		local_bb1_keep_going2_acl_pipeline_1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_keep_going2_acl_pipeline_1_output_regs_ready)
		begin
			local_bb1_keep_going2_acl_pipeline_1_NO_SHIFT_REG <= local_bb1_keep_going2_acl_pipeline_1_keep_going;
			local_bb1_keep_going2_acl_pipeline_1_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_keep_going2_acl_pipeline_1_stall_in))
			begin
				local_bb1_keep_going2_acl_pipeline_1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
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
	.dataa(rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_NO_SHIFT_REG),
	.datab(input_inSize_x),
	.enable(local_bb1_mul4_output_regs_ready),
	.result(local_bb1_mul4)
);

defparam int_module_local_bb1_mul4.INPUT1_WIDTH = 32;
defparam int_module_local_bb1_mul4.INPUT2_WIDTH = 32;
defparam int_module_local_bb1_mul4.OUTPUT_WIDTH = 32;
defparam int_module_local_bb1_mul4.LATENCY = 3;
defparam int_module_local_bb1_mul4.SIGNED = 0;

assign local_bb1_mul4_inputs_ready = 1'b1;
assign local_bb1_mul4_output_regs_ready = 1'b1;
assign rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1_mul4_causedstall = (1'b1 && (1'b0 && !(1'b0)));

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
			local_bb1_mul4_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
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
			local_bb1_mul4_valid_out_NO_SHIFT_REG <= 1'b1;
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
wire local_bb1_mul7_inputs_ready;
 reg local_bb1_mul7_valid_out_NO_SHIFT_REG;
wire local_bb1_mul7_stall_in;
wire local_bb1_mul7_output_regs_ready;
wire [31:0] local_bb1_mul7;
 reg local_bb1_mul7_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_mul7_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_mul7_causedstall;

acl_int_mult int_module_local_bb1_mul7 (
	.clock(clock),
	.dataa(rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_1_NO_SHIFT_REG),
	.datab(input_depthSize_x),
	.enable(local_bb1_mul7_output_regs_ready),
	.result(local_bb1_mul7)
);

defparam int_module_local_bb1_mul7.INPUT1_WIDTH = 32;
defparam int_module_local_bb1_mul7.INPUT2_WIDTH = 32;
defparam int_module_local_bb1_mul7.OUTPUT_WIDTH = 32;
defparam int_module_local_bb1_mul7.LATENCY = 3;
defparam int_module_local_bb1_mul7.SIGNED = 0;

assign local_bb1_mul7_inputs_ready = 1'b1;
assign local_bb1_mul7_output_regs_ready = 1'b1;
assign rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign local_bb1_mul7_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul7_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul7_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul7_output_regs_ready)
		begin
			local_bb1_mul7_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_mul7_valid_pipe_1_NO_SHIFT_REG <= local_bb1_mul7_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul7_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul7_output_regs_ready)
		begin
			local_bb1_mul7_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_mul7_stall_in))
			begin
				local_bb1_mul7_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_inc12_stall_local;
wire [31:0] local_bb1_inc12;

assign local_bb1_inc12 = (rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_2_NO_SHIFT_REG + 32'h1);

// This section implements a registered operation.
// 
wire SFC_1_VALID_3_4_0_inputs_ready;
 reg SFC_1_VALID_3_4_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_3_4_0_stall_in;
wire SFC_1_VALID_3_4_0_output_regs_ready;
 reg SFC_1_VALID_3_4_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_3_4_0_causedstall;

assign SFC_1_VALID_3_4_0_inputs_ready = 1'b1;
assign SFC_1_VALID_3_4_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_2_3_0_stall_in = 1'b0;
assign SFC_1_VALID_3_4_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_3_4_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_3_4_0_output_regs_ready)
		begin
			SFC_1_VALID_3_4_0_NO_SHIFT_REG <= SFC_1_VALID_2_3_0_NO_SHIFT_REG;
		end
	end
end


// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_stall_in_NO_SHIFT_REG;
 logic rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_NO_SHIFT_REG;
 logic rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(local_bb1_keep_going2_acl_pipeline_1_NO_SHIFT_REG),
	.data_out(rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_reg_5_fifo.DEPTH = 2;
defparam rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_reg_5_fifo.DATA_WIDTH = 1;
defparam rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_keep_going2_acl_pipeline_1_stall_in = 1'b0;
assign rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_NO_SHIFT_REG = rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_reg_5_NO_SHIFT_REG;
assign rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi1_stall_local;
wire [127:0] local_bb1_c0_exi1;

assign local_bb1_c0_exi1[31:0] = 32'bx;
assign local_bb1_c0_exi1[63:32] = local_bb1_mul4;
assign local_bb1_c0_exi1[127:64] = 64'bx;

// This section implements an unregistered operation.
// 
wire local_bb1_exitcond4_stall_local;
wire local_bb1_exitcond4;

assign local_bb1_exitcond4 = (local_bb1_inc12 == 32'hF0);

// This section implements a registered operation.
// 
wire SFC_1_VALID_4_5_0_inputs_ready;
 reg SFC_1_VALID_4_5_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_4_5_0_stall_in;
wire SFC_1_VALID_4_5_0_output_regs_ready;
 reg SFC_1_VALID_4_5_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_4_5_0_causedstall;

assign SFC_1_VALID_4_5_0_inputs_ready = 1'b1;
assign SFC_1_VALID_4_5_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_3_4_0_stall_in = 1'b0;
assign SFC_1_VALID_4_5_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_4_5_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_4_5_0_output_regs_ready)
		begin
			SFC_1_VALID_4_5_0_NO_SHIFT_REG <= SFC_1_VALID_3_4_0_NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi2_stall_local;
wire [127:0] local_bb1_c0_exi2;

assign local_bb1_c0_exi2[63:0] = local_bb1_c0_exi1[63:0];
assign local_bb1_c0_exi2[95:64] = local_bb1_mul7;
assign local_bb1_c0_exi2[127:96] = local_bb1_c0_exi1[127:96];

// This section implements an unregistered operation.
// 
wire local_bb1_inc12_valid_out_1;
wire local_bb1_inc12_stall_in_1;
wire local_bb1_exitcond4_valid_out_1;
wire local_bb1_exitcond4_stall_in_1;
wire local_bb1_notexit4_valid_out_0;
wire local_bb1_notexit4_stall_in_0;
wire local_bb1_notexit4_valid_out_1;
wire local_bb1_notexit4_stall_in_1;
wire local_bb1_notexit4_inputs_ready;
wire local_bb1_notexit4_stall_local;
wire local_bb1_notexit4;

assign local_bb1_notexit4_inputs_ready = rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_valid_out_2_NO_SHIFT_REG;
assign local_bb1_notexit4 = (local_bb1_exitcond4 ^ 1'b1);
assign local_bb1_inc12_valid_out_1 = 1'b1;
assign local_bb1_exitcond4_valid_out_1 = 1'b1;
assign local_bb1_notexit4_valid_out_0 = 1'b1;
assign local_bb1_notexit4_valid_out_1 = 1'b1;
assign rnode_1to2_bb1_pixel_y_03_pop4_acl_pop_i32_0_0_stall_in_2_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_2to3_bb1_exitcond4_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to3_bb1_exitcond4_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to3_bb1_exitcond4_0_NO_SHIFT_REG;
 logic rnode_2to3_bb1_exitcond4_0_reg_3_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to3_bb1_exitcond4_0_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb1_exitcond4_0_valid_out_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb1_exitcond4_0_stall_in_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb1_exitcond4_0_stall_out_reg_3_NO_SHIFT_REG;

acl_data_fifo rnode_2to3_bb1_exitcond4_0_reg_3_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to3_bb1_exitcond4_0_reg_3_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to3_bb1_exitcond4_0_stall_in_reg_3_NO_SHIFT_REG),
	.valid_out(rnode_2to3_bb1_exitcond4_0_valid_out_reg_3_NO_SHIFT_REG),
	.stall_out(rnode_2to3_bb1_exitcond4_0_stall_out_reg_3_NO_SHIFT_REG),
	.data_in(local_bb1_exitcond4),
	.data_out(rnode_2to3_bb1_exitcond4_0_reg_3_NO_SHIFT_REG)
);

defparam rnode_2to3_bb1_exitcond4_0_reg_3_fifo.DEPTH = 1;
defparam rnode_2to3_bb1_exitcond4_0_reg_3_fifo.DATA_WIDTH = 1;
defparam rnode_2to3_bb1_exitcond4_0_reg_3_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_2to3_bb1_exitcond4_0_reg_3_fifo.IMPL = "shift_reg";

assign rnode_2to3_bb1_exitcond4_0_reg_3_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_exitcond4_stall_in_1 = 1'b0;
assign rnode_2to3_bb1_exitcond4_0_NO_SHIFT_REG = rnode_2to3_bb1_exitcond4_0_reg_3_NO_SHIFT_REG;
assign rnode_2to3_bb1_exitcond4_0_stall_in_reg_3_NO_SHIFT_REG = 1'b0;
assign rnode_2to3_bb1_exitcond4_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb1_notexitcond3_notexit4_inputs_ready;
 reg local_bb1_notexitcond3_notexit4_valid_out_NO_SHIFT_REG;
wire local_bb1_notexitcond3_notexit4_stall_in;
wire local_bb1_notexitcond3_notexit4_output_regs_ready;
wire local_bb1_notexitcond3_notexit4_result;
wire local_bb1_notexitcond3_notexit4_fu_valid_out;
wire local_bb1_notexitcond3_notexit4_fu_stall_out;
 reg local_bb1_notexitcond3_notexit4_NO_SHIFT_REG;
wire local_bb1_notexitcond3_notexit4_causedstall;

acl_push local_bb1_notexitcond3_notexit4_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(1'b1),
	.predicate(1'b0),
	.data_in(local_bb1_notexit4),
	.stall_out(local_bb1_notexitcond3_notexit4_fu_stall_out),
	.valid_in(SFC_1_VALID_1_2_0_NO_SHIFT_REG),
	.valid_out(local_bb1_notexitcond3_notexit4_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_notexitcond3_notexit4_result),
	.feedback_out(feedback_data_out_3),
	.feedback_valid_out(feedback_valid_out_3),
	.feedback_stall_in(feedback_stall_in_3)
);

defparam local_bb1_notexitcond3_notexit4_feedback.STALLFREE = 1;
defparam local_bb1_notexitcond3_notexit4_feedback.DATA_WIDTH = 1;
defparam local_bb1_notexitcond3_notexit4_feedback.FIFO_DEPTH = 1;
defparam local_bb1_notexitcond3_notexit4_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb1_notexitcond3_notexit4_feedback.STYLE = "REGULAR";

assign local_bb1_notexitcond3_notexit4_inputs_ready = 1'b1;
assign local_bb1_notexitcond3_notexit4_output_regs_ready = 1'b1;
assign local_bb1_notexit4_stall_in_0 = 1'b0;
assign SFC_1_VALID_1_2_0_stall_in_2 = 1'b0;
assign local_bb1_notexitcond3_notexit4_causedstall = (SFC_1_VALID_1_2_0_NO_SHIFT_REG && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_notexitcond3_notexit4_NO_SHIFT_REG <= 'x;
		local_bb1_notexitcond3_notexit4_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_notexitcond3_notexit4_output_regs_ready)
		begin
			local_bb1_notexitcond3_notexit4_NO_SHIFT_REG <= local_bb1_notexitcond3_notexit4_result;
			local_bb1_notexitcond3_notexit4_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_notexitcond3_notexit4_stall_in))
			begin
				local_bb1_notexitcond3_notexit4_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_pixel_y_03_push4_inc12_inputs_ready;
 reg local_bb1_pixel_y_03_push4_inc12_valid_out_NO_SHIFT_REG;
wire local_bb1_pixel_y_03_push4_inc12_stall_in;
wire local_bb1_pixel_y_03_push4_inc12_output_regs_ready;
wire [31:0] local_bb1_pixel_y_03_push4_inc12_result;
wire local_bb1_pixel_y_03_push4_inc12_fu_valid_out;
wire local_bb1_pixel_y_03_push4_inc12_fu_stall_out;
 reg [31:0] local_bb1_pixel_y_03_push4_inc12_NO_SHIFT_REG;
wire local_bb1_pixel_y_03_push4_inc12_causedstall;

acl_push local_bb1_pixel_y_03_push4_inc12_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_notexit4),
	.predicate(1'b0),
	.data_in(local_bb1_inc12),
	.stall_out(local_bb1_pixel_y_03_push4_inc12_fu_stall_out),
	.valid_in(SFC_1_VALID_1_2_0_NO_SHIFT_REG),
	.valid_out(local_bb1_pixel_y_03_push4_inc12_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_pixel_y_03_push4_inc12_result),
	.feedback_out(feedback_data_out_4),
	.feedback_valid_out(feedback_valid_out_4),
	.feedback_stall_in(feedback_stall_in_4)
);

defparam local_bb1_pixel_y_03_push4_inc12_feedback.STALLFREE = 1;
defparam local_bb1_pixel_y_03_push4_inc12_feedback.DATA_WIDTH = 32;
defparam local_bb1_pixel_y_03_push4_inc12_feedback.FIFO_DEPTH = 2;
defparam local_bb1_pixel_y_03_push4_inc12_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_pixel_y_03_push4_inc12_feedback.STYLE = "REGULAR";

assign local_bb1_pixel_y_03_push4_inc12_inputs_ready = 1'b1;
assign local_bb1_pixel_y_03_push4_inc12_output_regs_ready = 1'b1;
assign local_bb1_inc12_stall_in_1 = 1'b0;
assign local_bb1_notexit4_stall_in_1 = 1'b0;
assign SFC_1_VALID_1_2_0_stall_in_3 = 1'b0;
assign local_bb1_pixel_y_03_push4_inc12_causedstall = (SFC_1_VALID_1_2_0_NO_SHIFT_REG && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_pixel_y_03_push4_inc12_NO_SHIFT_REG <= 'x;
		local_bb1_pixel_y_03_push4_inc12_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_pixel_y_03_push4_inc12_output_regs_ready)
		begin
			local_bb1_pixel_y_03_push4_inc12_NO_SHIFT_REG <= local_bb1_pixel_y_03_push4_inc12_result;
			local_bb1_pixel_y_03_push4_inc12_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_pixel_y_03_push4_inc12_stall_in))
			begin
				local_bb1_pixel_y_03_push4_inc12_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_3to4_bb1_exitcond4_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to4_bb1_exitcond4_0_stall_in_NO_SHIFT_REG;
 logic rnode_3to4_bb1_exitcond4_0_NO_SHIFT_REG;
 logic rnode_3to4_bb1_exitcond4_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to4_bb1_exitcond4_0_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_exitcond4_0_valid_out_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_exitcond4_0_stall_in_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb1_exitcond4_0_stall_out_reg_4_NO_SHIFT_REG;

acl_data_fifo rnode_3to4_bb1_exitcond4_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to4_bb1_exitcond4_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to4_bb1_exitcond4_0_stall_in_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_3to4_bb1_exitcond4_0_valid_out_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_3to4_bb1_exitcond4_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(rnode_2to3_bb1_exitcond4_0_NO_SHIFT_REG),
	.data_out(rnode_3to4_bb1_exitcond4_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_3to4_bb1_exitcond4_0_reg_4_fifo.DEPTH = 1;
defparam rnode_3to4_bb1_exitcond4_0_reg_4_fifo.DATA_WIDTH = 1;
defparam rnode_3to4_bb1_exitcond4_0_reg_4_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to4_bb1_exitcond4_0_reg_4_fifo.IMPL = "shift_reg";

assign rnode_3to4_bb1_exitcond4_0_reg_4_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_2to3_bb1_exitcond4_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb1_exitcond4_0_NO_SHIFT_REG = rnode_3to4_bb1_exitcond4_0_reg_4_NO_SHIFT_REG;
assign rnode_3to4_bb1_exitcond4_0_stall_in_reg_4_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb1_exitcond4_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_3to5_bb1_notexitcond3_notexit4_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to5_bb1_notexitcond3_notexit4_0_stall_in_NO_SHIFT_REG;
 logic rnode_3to5_bb1_notexitcond3_notexit4_0_NO_SHIFT_REG;
 logic rnode_3to5_bb1_notexitcond3_notexit4_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to5_bb1_notexitcond3_notexit4_0_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_notexitcond3_notexit4_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_notexitcond3_notexit4_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_notexitcond3_notexit4_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_3to5_bb1_notexitcond3_notexit4_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to5_bb1_notexitcond3_notexit4_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to5_bb1_notexitcond3_notexit4_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_3to5_bb1_notexitcond3_notexit4_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_3to5_bb1_notexitcond3_notexit4_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(local_bb1_notexitcond3_notexit4_NO_SHIFT_REG),
	.data_out(rnode_3to5_bb1_notexitcond3_notexit4_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_3to5_bb1_notexitcond3_notexit4_0_reg_5_fifo.DEPTH = 2;
defparam rnode_3to5_bb1_notexitcond3_notexit4_0_reg_5_fifo.DATA_WIDTH = 1;
defparam rnode_3to5_bb1_notexitcond3_notexit4_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to5_bb1_notexitcond3_notexit4_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_3to5_bb1_notexitcond3_notexit4_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_notexitcond3_notexit4_stall_in = 1'b0;
assign rnode_3to5_bb1_notexitcond3_notexit4_0_NO_SHIFT_REG = rnode_3to5_bb1_notexitcond3_notexit4_0_reg_5_NO_SHIFT_REG;
assign rnode_3to5_bb1_notexitcond3_notexit4_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb1_notexitcond3_notexit4_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_3to5_bb1_pixel_y_03_push4_inc12_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to5_bb1_pixel_y_03_push4_inc12_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_3to5_bb1_pixel_y_03_push4_inc12_0_NO_SHIFT_REG;
 logic rnode_3to5_bb1_pixel_y_03_push4_inc12_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_3to5_bb1_pixel_y_03_push4_inc12_0_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_pixel_y_03_push4_inc12_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_pixel_y_03_push4_inc12_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb1_pixel_y_03_push4_inc12_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_3to5_bb1_pixel_y_03_push4_inc12_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to5_bb1_pixel_y_03_push4_inc12_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to5_bb1_pixel_y_03_push4_inc12_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_3to5_bb1_pixel_y_03_push4_inc12_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_3to5_bb1_pixel_y_03_push4_inc12_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(local_bb1_pixel_y_03_push4_inc12_NO_SHIFT_REG),
	.data_out(rnode_3to5_bb1_pixel_y_03_push4_inc12_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_3to5_bb1_pixel_y_03_push4_inc12_0_reg_5_fifo.DEPTH = 2;
defparam rnode_3to5_bb1_pixel_y_03_push4_inc12_0_reg_5_fifo.DATA_WIDTH = 32;
defparam rnode_3to5_bb1_pixel_y_03_push4_inc12_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to5_bb1_pixel_y_03_push4_inc12_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_3to5_bb1_pixel_y_03_push4_inc12_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_pixel_y_03_push4_inc12_stall_in = 1'b0;
assign rnode_3to5_bb1_pixel_y_03_push4_inc12_0_NO_SHIFT_REG = rnode_3to5_bb1_pixel_y_03_push4_inc12_0_reg_5_NO_SHIFT_REG;
assign rnode_3to5_bb1_pixel_y_03_push4_inc12_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb1_pixel_y_03_push4_inc12_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb1_exitcond4_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to5_bb1_exitcond4_0_stall_in_NO_SHIFT_REG;
 logic rnode_4to5_bb1_exitcond4_0_NO_SHIFT_REG;
 logic rnode_4to5_bb1_exitcond4_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic rnode_4to5_bb1_exitcond4_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_exitcond4_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_exitcond4_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_exitcond4_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_4to5_bb1_exitcond4_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb1_exitcond4_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb1_exitcond4_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb1_exitcond4_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb1_exitcond4_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(rnode_3to4_bb1_exitcond4_0_NO_SHIFT_REG),
	.data_out(rnode_4to5_bb1_exitcond4_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb1_exitcond4_0_reg_5_fifo.DEPTH = 1;
defparam rnode_4to5_bb1_exitcond4_0_reg_5_fifo.DATA_WIDTH = 1;
defparam rnode_4to5_bb1_exitcond4_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_4to5_bb1_exitcond4_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_4to5_bb1_exitcond4_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_3to4_bb1_exitcond4_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb1_exitcond4_0_NO_SHIFT_REG = rnode_4to5_bb1_exitcond4_0_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb1_exitcond4_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb1_exitcond4_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi3_stall_local;
wire [127:0] local_bb1_c0_exi3;

assign local_bb1_c0_exi3[95:0] = local_bb1_c0_exi2[95:0];
assign local_bb1_c0_exi3[96] = rnode_4to5_bb1_exitcond4_0_NO_SHIFT_REG;
assign local_bb1_c0_exi3[127:97] = local_bb1_c0_exi2[127:97];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi4_valid_out;
wire local_bb1_c0_exi4_stall_in;
wire local_bb1_c0_exi4_inputs_ready;
wire local_bb1_c0_exi4_stall_local;
wire [127:0] local_bb1_c0_exi4;

assign local_bb1_c0_exi4_inputs_ready = (local_bb1_mul4_valid_out_NO_SHIFT_REG & local_bb1_mul7_valid_out_NO_SHIFT_REG & rnode_4to5_bb1_exitcond4_0_valid_out_NO_SHIFT_REG & rnode_3to5_bb1_notexitcond3_notexit4_0_valid_out_NO_SHIFT_REG);
assign local_bb1_c0_exi4[103:0] = local_bb1_c0_exi3[103:0];
assign local_bb1_c0_exi4[104] = rnode_3to5_bb1_notexitcond3_notexit4_0_NO_SHIFT_REG;
assign local_bb1_c0_exi4[127:105] = local_bb1_c0_exi3[127:105];
assign local_bb1_c0_exi4_valid_out = 1'b1;
assign local_bb1_mul4_stall_in = 1'b0;
assign local_bb1_mul7_stall_in = 1'b0;
assign rnode_4to5_bb1_exitcond4_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb1_notexitcond3_notexit4_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements a registered operation.
// 
wire local_bb1_c0_exit_c0_exi4_inputs_ready;
 reg local_bb1_c0_exit_c0_exi4_valid_out_0_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi4_stall_in_0;
 reg local_bb1_c0_exit_c0_exi4_valid_out_1_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi4_stall_in_1;
 reg local_bb1_c0_exit_c0_exi4_valid_out_2_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi4_stall_in_2;
 reg [127:0] local_bb1_c0_exit_c0_exi4_NO_SHIFT_REG;
wire [127:0] local_bb1_c0_exit_c0_exi4_in;
wire local_bb1_c0_exit_c0_exi4_valid;
wire local_bb1_c0_exit_c0_exi4_causedstall;

acl_stall_free_sink local_bb1_c0_exit_c0_exi4_instance (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_bb1_c0_exi4),
	.data_out(local_bb1_c0_exit_c0_exi4_in),
	.input_accepted(local_bb1_c0_enter_c0_eni1_input_accepted),
	.valid_out(local_bb1_c0_exit_c0_exi4_valid),
	.stall_in(~(local_bb1_c0_exit_c0_exi4_output_regs_ready)),
	.stall_entry(local_bb1_c0_exit_c0_exi4_entry_stall),
	.valid_in(local_bb1_c0_exit_c0_exi4_valid_in),
	.IIphases(local_bb1_c0_exit_c0_exi4_phases),
	.inc_pipelined_thread(local_bb1_c0_enter_c0_eni1_inc_pipelined_thread),
	.dec_pipelined_thread(local_bb1_c0_enter_c0_eni1_dec_pipelined_thread)
);

defparam local_bb1_c0_exit_c0_exi4_instance.DATA_WIDTH = 128;
defparam local_bb1_c0_exit_c0_exi4_instance.PIPELINE_DEPTH = 9;
defparam local_bb1_c0_exit_c0_exi4_instance.SHARINGII = 1;
defparam local_bb1_c0_exit_c0_exi4_instance.SCHEDULEII = 1;
defparam local_bb1_c0_exit_c0_exi4_instance.ALWAYS_THROTTLE = 0;

assign local_bb1_c0_exit_c0_exi4_inputs_ready = 1'b1;
assign local_bb1_c0_exit_c0_exi4_output_regs_ready = ((~(local_bb1_c0_exit_c0_exi4_valid_out_0_NO_SHIFT_REG) | ~(local_bb1_c0_exit_c0_exi4_stall_in_0)) & (~(local_bb1_c0_exit_c0_exi4_valid_out_1_NO_SHIFT_REG) | ~(local_bb1_c0_exit_c0_exi4_stall_in_1)) & (~(local_bb1_c0_exit_c0_exi4_valid_out_2_NO_SHIFT_REG) | ~(local_bb1_c0_exit_c0_exi4_stall_in_2)));
assign local_bb1_c0_exit_c0_exi4_valid_in = SFC_1_VALID_4_5_0_NO_SHIFT_REG;
assign local_bb1_c0_exi4_stall_in = 1'b0;
assign SFC_1_VALID_4_5_0_stall_in = 1'b0;
assign rnode_3to5_bb1_keep_going2_acl_pipeline_1_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb1_pixel_y_03_push4_inc12_0_stall_in_NO_SHIFT_REG = 1'b0;
assign local_bb1_c0_exit_c0_exi4_causedstall = (1'b1 && (1'b0 && !(~(local_bb1_c0_exit_c0_exi4_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_exit_c0_exi4_NO_SHIFT_REG <= 'x;
		local_bb1_c0_exit_c0_exi4_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_exit_c0_exi4_valid_out_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_exit_c0_exi4_valid_out_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c0_exit_c0_exi4_output_regs_ready)
		begin
			local_bb1_c0_exit_c0_exi4_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi4_in;
			local_bb1_c0_exit_c0_exi4_valid_out_0_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi4_valid;
			local_bb1_c0_exit_c0_exi4_valid_out_1_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi4_valid;
			local_bb1_c0_exit_c0_exi4_valid_out_2_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi4_valid;
		end
		else
		begin
			if (~(local_bb1_c0_exit_c0_exi4_stall_in_0))
			begin
				local_bb1_c0_exit_c0_exi4_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_exit_c0_exi4_stall_in_1))
			begin
				local_bb1_c0_exit_c0_exi4_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_exit_c0_exi4_stall_in_2))
			begin
				local_bb1_c0_exit_c0_exi4_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_exe1_stall_local;
wire [31:0] local_bb1_c0_exe1;

assign local_bb1_c0_exe1 = local_bb1_c0_exit_c0_exi4_NO_SHIFT_REG[63:32];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exe2_stall_local;
wire [31:0] local_bb1_c0_exe2;

assign local_bb1_c0_exe2 = local_bb1_c0_exit_c0_exi4_NO_SHIFT_REG[95:64];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exe3_valid_out;
wire local_bb1_c0_exe3_stall_in;
wire local_bb1_c0_exe2_valid_out;
wire local_bb1_c0_exe2_stall_in;
wire local_bb1_c0_exe1_valid_out;
wire local_bb1_c0_exe1_stall_in;
wire local_bb1_c0_exe3_inputs_ready;
wire local_bb1_c0_exe3_stall_local;
wire local_bb1_c0_exe3;

assign local_bb1_c0_exe3_inputs_ready = (local_bb1_c0_exit_c0_exi4_valid_out_2_NO_SHIFT_REG & local_bb1_c0_exit_c0_exi4_valid_out_1_NO_SHIFT_REG & local_bb1_c0_exit_c0_exi4_valid_out_0_NO_SHIFT_REG);
assign local_bb1_c0_exe3 = local_bb1_c0_exit_c0_exi4_NO_SHIFT_REG[96];
assign local_bb1_c0_exe3_stall_local = (local_bb1_c0_exe3_stall_in | local_bb1_c0_exe2_stall_in | local_bb1_c0_exe1_stall_in);
assign local_bb1_c0_exe3_valid_out = local_bb1_c0_exe3_inputs_ready;
assign local_bb1_c0_exe2_valid_out = local_bb1_c0_exe3_inputs_ready;
assign local_bb1_c0_exe1_valid_out = local_bb1_c0_exe3_inputs_ready;
assign local_bb1_c0_exit_c0_exi4_stall_in_2 = (local_bb1_c0_exe3_stall_local | ~(local_bb1_c0_exe3_inputs_ready));
assign local_bb1_c0_exit_c0_exi4_stall_in_1 = (local_bb1_c0_exe3_stall_local | ~(local_bb1_c0_exe3_inputs_ready));
assign local_bb1_c0_exit_c0_exi4_stall_in_0 = (local_bb1_c0_exe3_stall_local | ~(local_bb1_c0_exe3_inputs_ready));

// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_bb1_c0_exe1_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb1_c0_exe2_reg_NO_SHIFT_REG;
 reg lvb_bb1_c0_exe3_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb1_c0_exe3_valid_out & local_bb1_c0_exe2_valid_out & local_bb1_c0_exe1_valid_out);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb1_c0_exe3_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb1_c0_exe2_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb1_c0_exe1_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_bb1_c0_exe1 = lvb_bb1_c0_exe1_reg_NO_SHIFT_REG;
assign lvb_bb1_c0_exe2 = lvb_bb1_c0_exe2_reg_NO_SHIFT_REG;
assign lvb_bb1_c0_exe3 = lvb_bb1_c0_exe3_reg_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_bb1_c0_exe1_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_c0_exe2_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_c0_exe3_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_bb1_c0_exe1_reg_NO_SHIFT_REG <= local_bb1_c0_exe1;
			lvb_bb1_c0_exe2_reg_NO_SHIFT_REG <= local_bb1_c0_exe2;
			lvb_bb1_c0_exe3_reg_NO_SHIFT_REG <= local_bb1_c0_exe3;
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
module AOCmm2metersKernel_basic_block_2
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_ratio,
		input [63:0] 		input_in,
		input [63:0] 		input_depth,
		input 		valid_in_0,
		output 		stall_out_0,
		input 		input_forked5_0,
		input [31:0] 		input_mul46_0,
		input [31:0] 		input_mul77_0,
		input 		input_exitcond48_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input 		input_forked5_1,
		input [31:0] 		input_mul46_1,
		input [31:0] 		input_mul77_1,
		input 		input_exitcond48_1,
		output 		valid_out_0,
		input 		stall_in_0,
		output [255:0] 		lvb_bb2_c0_exit16_c0_exi5_0,
		output 		valid_out_1,
		input 		stall_in_1,
		output [255:0] 		lvb_bb2_c0_exit16_c0_exi5_1,
		input [31:0] 		workgroup_size,
		input 		start,
		input 		feedback_valid_in_5,
		output 		feedback_stall_out_5,
		input [63:0] 		feedback_data_in_5,
		input 		feedback_valid_in_6,
		output 		feedback_stall_out_6,
		input [31:0] 		feedback_data_in_6,
		output 		feedback_stall_out_0,
		input 		feedback_valid_in_1,
		output 		feedback_stall_out_1,
		input 		feedback_data_in_1,
		output 		acl_pipelined_valid,
		input 		acl_pipelined_stall,
		output 		acl_pipelined_exiting_valid,
		output 		acl_pipelined_exiting_stall,
		output 		feedback_valid_out_1,
		input 		feedback_stall_in_1,
		output 		feedback_data_out_1,
		output 		feedback_valid_out_5,
		input 		feedback_stall_in_5,
		output [63:0] 		feedback_data_out_5,
		input 		feedback_valid_in_7,
		output 		feedback_stall_out_7,
		input [31:0] 		feedback_data_in_7,
		input 		feedback_valid_in_8,
		output 		feedback_stall_out_8,
		input 		feedback_data_in_8,
		output 		feedback_valid_out_6,
		input 		feedback_stall_in_6,
		output [31:0] 		feedback_data_out_6,
		output 		feedback_valid_out_8,
		input 		feedback_stall_in_8,
		output 		feedback_data_out_8,
		output 		feedback_valid_out_7,
		input 		feedback_stall_in_7,
		output [31:0] 		feedback_data_out_7,
		input [511:0] 		avm_local_bb2_ld__readdata,
		input 		avm_local_bb2_ld__readdatavalid,
		input 		avm_local_bb2_ld__waitrequest,
		output [32:0] 		avm_local_bb2_ld__address,
		output 		avm_local_bb2_ld__read,
		output 		avm_local_bb2_ld__write,
		input 		avm_local_bb2_ld__writeack,
		output [511:0] 		avm_local_bb2_ld__writedata,
		output [63:0] 		avm_local_bb2_ld__byteenable,
		output [4:0] 		avm_local_bb2_ld__burstcount,
		output 		local_bb2_ld__active,
		input 		clock2x,
		input [511:0] 		avm_local_bb2_st_c1_exe1_readdata,
		input 		avm_local_bb2_st_c1_exe1_readdatavalid,
		input 		avm_local_bb2_st_c1_exe1_waitrequest,
		output [32:0] 		avm_local_bb2_st_c1_exe1_address,
		output 		avm_local_bb2_st_c1_exe1_read,
		output 		avm_local_bb2_st_c1_exe1_write,
		input 		avm_local_bb2_st_c1_exe1_writeack,
		output [511:0] 		avm_local_bb2_st_c1_exe1_writedata,
		output [63:0] 		avm_local_bb2_st_c1_exe1_byteenable,
		output [4:0] 		avm_local_bb2_st_c1_exe1_burstcount,
		output 		local_bb2_st_c1_exe1_active
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((valid_in_0 & valid_in_1) & ~((stall_out_0 | stall_out_1)));
assign _exit = ((valid_out_0 & valid_out_1) & ~((stall_in_0 | stall_in_1)));
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
wire merge_node_stall_in_3;
 reg merge_node_valid_out_3_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
 reg input_forked5_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_mul46_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_mul77_0_staging_reg_NO_SHIFT_REG;
 reg input_exitcond48_0_staging_reg_NO_SHIFT_REG;
 reg local_lvm_forked5_NO_SHIFT_REG;
 reg [31:0] local_lvm_mul46_NO_SHIFT_REG;
 reg [31:0] local_lvm_mul77_NO_SHIFT_REG;
 reg local_lvm_exitcond48_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg input_forked5_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_mul46_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_mul77_1_staging_reg_NO_SHIFT_REG;
 reg input_exitcond48_1_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG));
assign stall_out_0 = merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
assign stall_out_1 = merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_0_staging_reg_NO_SHIFT_REG | valid_in_0))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		if ((merge_node_valid_in_1_staging_reg_NO_SHIFT_REG | valid_in_1))
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b1;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
		end
		else
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b0;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_forked5_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_mul46_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_mul77_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_exitcond48_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_forked5_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_mul46_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_mul77_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_exitcond48_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_forked5_0_staging_reg_NO_SHIFT_REG <= input_forked5_0;
				input_mul46_0_staging_reg_NO_SHIFT_REG <= input_mul46_0;
				input_mul77_0_staging_reg_NO_SHIFT_REG <= input_mul77_0;
				input_exitcond48_0_staging_reg_NO_SHIFT_REG <= input_exitcond48_0;
				merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= valid_in_0;
			end
		end
		else
		begin
			merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
		if (((merge_block_selector_NO_SHIFT_REG != 1'b1) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_1_staging_reg_NO_SHIFT_REG))
			begin
				input_forked5_1_staging_reg_NO_SHIFT_REG <= input_forked5_1;
				input_mul46_1_staging_reg_NO_SHIFT_REG <= input_mul46_1;
				input_mul77_1_staging_reg_NO_SHIFT_REG <= input_mul77_1;
				input_exitcond48_1_staging_reg_NO_SHIFT_REG <= input_exitcond48_1;
				merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= valid_in_1;
			end
		end
		else
		begin
			merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
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
				if (merge_node_valid_in_0_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_forked5_NO_SHIFT_REG <= input_forked5_0_staging_reg_NO_SHIFT_REG;
					local_lvm_mul46_NO_SHIFT_REG <= input_mul46_0_staging_reg_NO_SHIFT_REG;
					local_lvm_mul77_NO_SHIFT_REG <= input_mul77_0_staging_reg_NO_SHIFT_REG;
					local_lvm_exitcond48_NO_SHIFT_REG <= input_exitcond48_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_forked5_NO_SHIFT_REG <= input_forked5_0;
					local_lvm_mul46_NO_SHIFT_REG <= input_mul46_0;
					local_lvm_mul77_NO_SHIFT_REG <= input_mul77_0;
					local_lvm_exitcond48_NO_SHIFT_REG <= input_exitcond48_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_forked5_NO_SHIFT_REG <= input_forked5_1_staging_reg_NO_SHIFT_REG;
					local_lvm_mul46_NO_SHIFT_REG <= input_mul46_1_staging_reg_NO_SHIFT_REG;
					local_lvm_mul77_NO_SHIFT_REG <= input_mul77_1_staging_reg_NO_SHIFT_REG;
					local_lvm_exitcond48_NO_SHIFT_REG <= input_exitcond48_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_forked5_NO_SHIFT_REG <= input_forked5_1;
					local_lvm_mul46_NO_SHIFT_REG <= input_mul46_1;
					local_lvm_mul77_NO_SHIFT_REG <= input_mul77_1;
					local_lvm_exitcond48_NO_SHIFT_REG <= input_exitcond48_1;
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
		merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_3_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
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
			if (~(merge_node_stall_in_3))
			begin
				merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
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


// This section implements an unregistered operation.
// 
wire local_bb2_c0_eni19_stall_local;
wire [127:0] local_bb2_c0_eni19;

assign local_bb2_c0_eni19[7:0] = 8'bx;
assign local_bb2_c0_eni19[8] = local_lvm_forked5_NO_SHIFT_REG;
assign local_bb2_c0_eni19[127:9] = 119'bx;

// This section implements an unregistered operation.
// 
wire local_bb2_c0_eni2_stall_local;
wire [127:0] local_bb2_c0_eni2;

assign local_bb2_c0_eni2[31:0] = local_bb2_c0_eni19[31:0];
assign local_bb2_c0_eni2[63:32] = local_lvm_mul46_NO_SHIFT_REG;
assign local_bb2_c0_eni2[127:64] = local_bb2_c0_eni19[127:64];

// This section implements an unregistered operation.
// 
wire local_bb2_c0_eni3_stall_local;
wire [127:0] local_bb2_c0_eni3;

assign local_bb2_c0_eni3[63:0] = local_bb2_c0_eni2[63:0];
assign local_bb2_c0_eni3[95:64] = local_lvm_mul77_NO_SHIFT_REG;
assign local_bb2_c0_eni3[127:96] = local_bb2_c0_eni2[127:96];

// This section implements an unregistered operation.
// 
wire local_bb2_c0_eni4_stall_local;
wire [127:0] local_bb2_c0_eni4;

assign local_bb2_c0_eni4[95:0] = local_bb2_c0_eni3[95:0];
assign local_bb2_c0_eni4[96] = local_lvm_exitcond48_NO_SHIFT_REG;
assign local_bb2_c0_eni4[127:97] = local_bb2_c0_eni3[127:97];

// This section implements an unregistered operation.
// 
wire local_bb2_c0_ene111_valid_out_2;
wire local_bb2_c0_ene111_stall_in_2;
wire local_bb2_c0_ene111_valid_out_3;
wire local_bb2_c0_ene111_stall_in_3;
wire local_bb2_c0_ene3_valid_out;
wire local_bb2_c0_ene3_stall_in;
wire local_bb2_c0_ene4_valid_out;
wire local_bb2_c0_ene4_stall_in;
wire SFC_2_VALID_1_1_0_valid_out_0;
wire SFC_2_VALID_1_1_0_stall_in_0;
wire SFC_2_VALID_1_1_0_valid_out_2;
wire SFC_2_VALID_1_1_0_stall_in_2;
wire SFC_2_VALID_1_1_0_valid_out_4;
wire SFC_2_VALID_1_1_0_stall_in_4;
wire SFC_2_VALID_1_1_0_valid_out_5;
wire SFC_2_VALID_1_1_0_stall_in_5;
wire local_bb2_mul46_pop6_c0_ene2_valid_out_1;
wire local_bb2_mul46_pop6_c0_ene2_stall_in_1;
wire local_bb2_var__valid_out_1;
wire local_bb2_var__stall_in_1;
wire local_bb2_indvars_iv_next_valid_out_1;
wire local_bb2_indvars_iv_next_stall_in_1;
wire local_bb2_mul1_valid_out;
wire local_bb2_mul1_stall_in;
wire local_bb2_exitcond_valid_out_1;
wire local_bb2_exitcond_stall_in_1;
wire local_bb2_notexit_valid_out_0;
wire local_bb2_notexit_stall_in_0;
wire local_bb2_notexit_valid_out_1;
wire local_bb2_notexit_stall_in_1;
wire local_bb2_c0_enter10_c0_eni4_inputs_ready;
wire local_bb2_c0_enter10_c0_eni4_stall_local;
wire local_bb2_c0_enter10_c0_eni4_input_accepted;
wire [127:0] local_bb2_c0_enter10_c0_eni4;
wire local_bb2_c0_exit16_c0_exi5_entry_stall;
wire local_bb2_c0_enter10_c0_eni4_valid_bit;
wire local_bb2_c0_exit16_c0_exi5_output_regs_ready;
wire local_bb2_c0_exit16_c0_exi5_valid_in;
wire local_bb2_c0_exit16_c0_exi5_phases;
wire local_bb2_c0_enter10_c0_eni4_inc_pipelined_thread;
wire local_bb2_c0_enter10_c0_eni4_dec_pipelined_thread;
wire local_bb2_c0_enter10_c0_eni4_fu_stall_out;

assign local_bb2_c0_enter10_c0_eni4_inputs_ready = (merge_node_valid_out_0_NO_SHIFT_REG & merge_node_valid_out_1_NO_SHIFT_REG & merge_node_valid_out_2_NO_SHIFT_REG & merge_node_valid_out_3_NO_SHIFT_REG);
assign local_bb2_c0_enter10_c0_eni4 = local_bb2_c0_eni4;
assign local_bb2_c0_enter10_c0_eni4_input_accepted = (local_bb2_c0_enter10_c0_eni4_inputs_ready && !(local_bb2_c0_exit16_c0_exi5_entry_stall));
assign local_bb2_c0_enter10_c0_eni4_valid_bit = local_bb2_c0_enter10_c0_eni4_input_accepted;
assign local_bb2_c0_enter10_c0_eni4_inc_pipelined_thread = 1'b1;
assign local_bb2_c0_enter10_c0_eni4_dec_pipelined_thread = ~(1'b0);
assign local_bb2_c0_enter10_c0_eni4_fu_stall_out = (~(local_bb2_c0_enter10_c0_eni4_inputs_ready) | local_bb2_c0_exit16_c0_exi5_entry_stall);
assign local_bb2_c0_enter10_c0_eni4_stall_local = (local_bb2_c0_ene111_stall_in_2 | local_bb2_c0_ene111_stall_in_3 | local_bb2_c0_ene3_stall_in | local_bb2_c0_ene4_stall_in | SFC_2_VALID_1_1_0_stall_in_0 | SFC_2_VALID_1_1_0_stall_in_2 | SFC_2_VALID_1_1_0_stall_in_4 | SFC_2_VALID_1_1_0_stall_in_5 | local_bb2_mul46_pop6_c0_ene2_stall_in_1 | local_bb2_var__stall_in_1 | local_bb2_indvars_iv_next_stall_in_1 | local_bb2_mul1_stall_in | local_bb2_exitcond_stall_in_1 | local_bb2_notexit_stall_in_0 | local_bb2_notexit_stall_in_1);
assign local_bb2_c0_ene111_valid_out_2 = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign local_bb2_c0_ene111_valid_out_3 = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign local_bb2_c0_ene3_valid_out = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign local_bb2_c0_ene4_valid_out = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign SFC_2_VALID_1_1_0_valid_out_0 = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign SFC_2_VALID_1_1_0_valid_out_2 = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign SFC_2_VALID_1_1_0_valid_out_4 = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign SFC_2_VALID_1_1_0_valid_out_5 = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign local_bb2_mul46_pop6_c0_ene2_valid_out_1 = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign local_bb2_var__valid_out_1 = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign local_bb2_indvars_iv_next_valid_out_1 = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign local_bb2_mul1_valid_out = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign local_bb2_exitcond_valid_out_1 = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign local_bb2_notexit_valid_out_0 = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign local_bb2_notexit_valid_out_1 = local_bb2_c0_enter10_c0_eni4_inputs_ready;
assign merge_node_stall_in_0 = (local_bb2_c0_enter10_c0_eni4_fu_stall_out | ~(local_bb2_c0_enter10_c0_eni4_inputs_ready));
assign merge_node_stall_in_1 = (local_bb2_c0_enter10_c0_eni4_fu_stall_out | ~(local_bb2_c0_enter10_c0_eni4_inputs_ready));
assign merge_node_stall_in_2 = (local_bb2_c0_enter10_c0_eni4_fu_stall_out | ~(local_bb2_c0_enter10_c0_eni4_inputs_ready));
assign merge_node_stall_in_3 = (local_bb2_c0_enter10_c0_eni4_fu_stall_out | ~(local_bb2_c0_enter10_c0_eni4_inputs_ready));

// This section implements an unregistered operation.
// 
wire local_bb2_c0_ene111_stall_local;
wire local_bb2_c0_ene111;

assign local_bb2_c0_ene111 = local_bb2_c0_enter10_c0_eni4[8];

// This section implements an unregistered operation.
// 
wire local_bb2_c0_ene2_stall_local;
wire [31:0] local_bb2_c0_ene2;

assign local_bb2_c0_ene2 = local_bb2_c0_enter10_c0_eni4[63:32];

// This section implements an unregistered operation.
// 
wire local_bb2_c0_ene3_stall_local;
wire [31:0] local_bb2_c0_ene3;

assign local_bb2_c0_ene3 = local_bb2_c0_enter10_c0_eni4[95:64];

// This section implements an unregistered operation.
// 
wire local_bb2_c0_ene4_stall_local;
wire local_bb2_c0_ene4;

assign local_bb2_c0_ene4 = local_bb2_c0_enter10_c0_eni4[96];

// This section implements an unregistered operation.
// 
wire SFC_2_VALID_1_1_0_stall_local;
wire SFC_2_VALID_1_1_0;

assign SFC_2_VALID_1_1_0 = local_bb2_c0_enter10_c0_eni4_valid_bit;

// This section implements an unregistered operation.
// 
wire local_bb2_indvars_iv_pop5_acl_pop_i64_0_stall_local;
wire [63:0] local_bb2_indvars_iv_pop5_acl_pop_i64_0;
wire local_bb2_indvars_iv_pop5_acl_pop_i64_0_fu_valid_out;
wire local_bb2_indvars_iv_pop5_acl_pop_i64_0_fu_stall_out;

acl_pop local_bb2_indvars_iv_pop5_acl_pop_i64_0_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb2_c0_ene111),
	.predicate(1'b0),
	.data_in(64'h0),
	.stall_out(local_bb2_indvars_iv_pop5_acl_pop_i64_0_fu_stall_out),
	.valid_in(SFC_2_VALID_1_1_0),
	.valid_out(local_bb2_indvars_iv_pop5_acl_pop_i64_0_fu_valid_out),
	.stall_in(local_bb2_indvars_iv_pop5_acl_pop_i64_0_stall_local),
	.data_out(local_bb2_indvars_iv_pop5_acl_pop_i64_0),
	.feedback_in(feedback_data_in_5),
	.feedback_valid_in(feedback_valid_in_5),
	.feedback_stall_out(feedback_stall_out_5)
);

defparam local_bb2_indvars_iv_pop5_acl_pop_i64_0_feedback.COALESCE_DISTANCE = 1;
defparam local_bb2_indvars_iv_pop5_acl_pop_i64_0_feedback.DATA_WIDTH = 64;
defparam local_bb2_indvars_iv_pop5_acl_pop_i64_0_feedback.STYLE = "REGULAR";

assign local_bb2_indvars_iv_pop5_acl_pop_i64_0_stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb2_mul46_pop6_c0_ene2_stall_local;
wire [31:0] local_bb2_mul46_pop6_c0_ene2;
wire local_bb2_mul46_pop6_c0_ene2_fu_valid_out;
wire local_bb2_mul46_pop6_c0_ene2_fu_stall_out;

acl_pop local_bb2_mul46_pop6_c0_ene2_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb2_c0_ene111),
	.predicate(1'b0),
	.data_in(local_bb2_c0_ene2),
	.stall_out(local_bb2_mul46_pop6_c0_ene2_fu_stall_out),
	.valid_in(SFC_2_VALID_1_1_0),
	.valid_out(local_bb2_mul46_pop6_c0_ene2_fu_valid_out),
	.stall_in(local_bb2_mul46_pop6_c0_ene2_stall_local),
	.data_out(local_bb2_mul46_pop6_c0_ene2),
	.feedback_in(feedback_data_in_6),
	.feedback_valid_in(feedback_valid_in_6),
	.feedback_stall_out(feedback_stall_out_6)
);

defparam local_bb2_mul46_pop6_c0_ene2_feedback.COALESCE_DISTANCE = 1;
defparam local_bb2_mul46_pop6_c0_ene2_feedback.DATA_WIDTH = 32;
defparam local_bb2_mul46_pop6_c0_ene2_feedback.STYLE = "REGULAR";

assign local_bb2_mul46_pop6_c0_ene2_stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb2_var__stall_local;
wire [31:0] local_bb2_var_;

assign local_bb2_var_ = local_bb2_indvars_iv_pop5_acl_pop_i64_0[31:0];

// This section implements an unregistered operation.
// 
wire local_bb2_indvars_iv_next_stall_local;
wire [63:0] local_bb2_indvars_iv_next;

assign local_bb2_indvars_iv_next = (local_bb2_indvars_iv_pop5_acl_pop_i64_0 + 64'h1);

// This section implements an unregistered operation.
// 
wire local_bb2_mul1_stall_local;
wire [31:0] local_bb2_mul1;

assign local_bb2_mul1 = (local_bb2_var_ + local_bb2_mul46_pop6_c0_ene2);

// This section implements an unregistered operation.
// 
wire local_bb2_lftr_wideiv_stall_local;
wire [31:0] local_bb2_lftr_wideiv;

assign local_bb2_lftr_wideiv = local_bb2_indvars_iv_next[31:0];

// This section implements an unregistered operation.
// 
wire local_bb2_exitcond_stall_local;
wire local_bb2_exitcond;

assign local_bb2_exitcond = (local_bb2_lftr_wideiv == 32'h140);

// This section implements an unregistered operation.
// 
wire local_bb2_notexit_stall_local;
wire local_bb2_notexit;

assign local_bb2_notexit = (local_bb2_exitcond ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb2_c0_ene111_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene111_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene111_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene111_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene111_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene111_1_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene111_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene111_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene111_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene111_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene111_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb2_c0_ene111_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb2_c0_ene111_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb2_c0_ene111_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb2_c0_ene111_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb2_c0_ene111_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb2_c0_ene111),
	.data_out(rnode_1to2_bb2_c0_ene111_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb2_c0_ene111_0_reg_2_fifo.DEPTH = 1;
defparam rnode_1to2_bb2_c0_ene111_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_bb2_c0_ene111_0_reg_2_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_1to2_bb2_c0_ene111_0_reg_2_fifo.IMPL = "shift_reg";

assign rnode_1to2_bb2_c0_ene111_0_reg_2_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_c0_ene111_stall_in_3 = 1'b0;
assign rnode_1to2_bb2_c0_ene111_0_stall_in_0_reg_2_NO_SHIFT_REG = 1'b0;
assign rnode_1to2_bb2_c0_ene111_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_1to2_bb2_c0_ene111_0_NO_SHIFT_REG = rnode_1to2_bb2_c0_ene111_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_c0_ene111_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_1to2_bb2_c0_ene111_1_NO_SHIFT_REG = rnode_1to2_bb2_c0_ene111_0_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb2_c0_ene3_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb2_c0_ene3_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene3_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb2_c0_ene3_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene3_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene3_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene3_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb2_c0_ene3_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb2_c0_ene3_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb2_c0_ene3_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb2_c0_ene3_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb2_c0_ene3_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb2_c0_ene3),
	.data_out(rnode_1to2_bb2_c0_ene3_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb2_c0_ene3_0_reg_2_fifo.DEPTH = 1;
defparam rnode_1to2_bb2_c0_ene3_0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_bb2_c0_ene3_0_reg_2_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_1to2_bb2_c0_ene3_0_reg_2_fifo.IMPL = "shift_reg";

assign rnode_1to2_bb2_c0_ene3_0_reg_2_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_c0_ene3_stall_in = 1'b0;
assign rnode_1to2_bb2_c0_ene3_0_NO_SHIFT_REG = rnode_1to2_bb2_c0_ene3_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_c0_ene3_0_stall_in_reg_2_NO_SHIFT_REG = 1'b0;
assign rnode_1to2_bb2_c0_ene3_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb2_c0_ene4_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene4_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene4_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene4_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene4_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene4_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene4_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_c0_ene4_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb2_c0_ene4_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb2_c0_ene4_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb2_c0_ene4_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb2_c0_ene4_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb2_c0_ene4_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb2_c0_ene4),
	.data_out(rnode_1to2_bb2_c0_ene4_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb2_c0_ene4_0_reg_2_fifo.DEPTH = 1;
defparam rnode_1to2_bb2_c0_ene4_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_bb2_c0_ene4_0_reg_2_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_1to2_bb2_c0_ene4_0_reg_2_fifo.IMPL = "shift_reg";

assign rnode_1to2_bb2_c0_ene4_0_reg_2_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_c0_ene4_stall_in = 1'b0;
assign rnode_1to2_bb2_c0_ene4_0_NO_SHIFT_REG = rnode_1to2_bb2_c0_ene4_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_c0_ene4_0_stall_in_reg_2_NO_SHIFT_REG = 1'b0;
assign rnode_1to2_bb2_c0_ene4_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire SFC_2_VALID_1_2_0_inputs_ready;
 reg SFC_2_VALID_1_2_0_valid_out_0_NO_SHIFT_REG;
wire SFC_2_VALID_1_2_0_stall_in_0;
 reg SFC_2_VALID_1_2_0_valid_out_1_NO_SHIFT_REG;
wire SFC_2_VALID_1_2_0_stall_in_1;
 reg SFC_2_VALID_1_2_0_valid_out_2_NO_SHIFT_REG;
wire SFC_2_VALID_1_2_0_stall_in_2;
 reg SFC_2_VALID_1_2_0_valid_out_3_NO_SHIFT_REG;
wire SFC_2_VALID_1_2_0_stall_in_3;
 reg SFC_2_VALID_1_2_0_valid_out_4_NO_SHIFT_REG;
wire SFC_2_VALID_1_2_0_stall_in_4;
 reg SFC_2_VALID_1_2_0_valid_out_5_NO_SHIFT_REG;
wire SFC_2_VALID_1_2_0_stall_in_5;
wire SFC_2_VALID_1_2_0_output_regs_ready;
 reg SFC_2_VALID_1_2_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_1_2_0_causedstall;

assign SFC_2_VALID_1_2_0_inputs_ready = 1'b1;
assign SFC_2_VALID_1_2_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_1_1_0_stall_in_0 = 1'b0;
assign SFC_2_VALID_1_2_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_1_2_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_1_2_0_output_regs_ready)
		begin
			SFC_2_VALID_1_2_0_NO_SHIFT_REG <= SFC_2_VALID_1_1_0;
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb2_keep_going_acl_pipeline_1_inputs_ready;
 reg local_bb2_keep_going_acl_pipeline_1_valid_out_NO_SHIFT_REG;
wire local_bb2_keep_going_acl_pipeline_1_stall_in;
wire local_bb2_keep_going_acl_pipeline_1_output_regs_ready;
wire local_bb2_keep_going_acl_pipeline_1_keep_going;
wire local_bb2_keep_going_acl_pipeline_1_fu_valid_out;
wire local_bb2_keep_going_acl_pipeline_1_fu_stall_out;
 reg local_bb2_keep_going_acl_pipeline_1_NO_SHIFT_REG;
wire local_bb2_keep_going_acl_pipeline_1_feedback_pipelined;
wire local_bb2_keep_going_acl_pipeline_1_causedstall;

acl_pipeline local_bb2_keep_going_acl_pipeline_1_pipelined (
	.clock(clock),
	.resetn(resetn),
	.data_in(1'b1),
	.stall_out(local_bb2_keep_going_acl_pipeline_1_fu_stall_out),
	.valid_in(SFC_2_VALID_1_1_0),
	.valid_out(local_bb2_keep_going_acl_pipeline_1_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb2_keep_going_acl_pipeline_1_keep_going),
	.initeration_in(1'b0),
	.initeration_valid_in(1'b0),
	.initeration_stall_out(feedback_stall_out_0),
	.not_exitcond_in(feedback_data_in_1),
	.not_exitcond_valid_in(feedback_valid_in_1),
	.not_exitcond_stall_out(feedback_stall_out_1),
	.pipeline_valid_out(acl_pipelined_valid),
	.pipeline_stall_in(acl_pipelined_stall),
	.exiting_valid_out(acl_pipelined_exiting_valid)
);

defparam local_bb2_keep_going_acl_pipeline_1_pipelined.FIFO_DEPTH = 0;
defparam local_bb2_keep_going_acl_pipeline_1_pipelined.STYLE = "NON_SPECULATIVE";

assign local_bb2_keep_going_acl_pipeline_1_inputs_ready = 1'b1;
assign local_bb2_keep_going_acl_pipeline_1_output_regs_ready = 1'b1;
assign acl_pipelined_exiting_stall = acl_pipelined_stall;
assign local_bb2_c0_ene111_stall_in_2 = 1'b0;
assign SFC_2_VALID_1_1_0_stall_in_2 = 1'b0;
assign local_bb2_keep_going_acl_pipeline_1_causedstall = (SFC_2_VALID_1_1_0 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_keep_going_acl_pipeline_1_NO_SHIFT_REG <= 'x;
		local_bb2_keep_going_acl_pipeline_1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_keep_going_acl_pipeline_1_output_regs_ready)
		begin
			local_bb2_keep_going_acl_pipeline_1_NO_SHIFT_REG <= local_bb2_keep_going_acl_pipeline_1_keep_going;
			local_bb2_keep_going_acl_pipeline_1_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb2_keep_going_acl_pipeline_1_stall_in))
			begin
				local_bb2_keep_going_acl_pipeline_1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb2_mul46_pop6_c0_ene2_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_bb2_mul46_pop6_c0_ene2_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb2_mul46_pop6_c0_ene2_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_mul46_pop6_c0_ene2_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb2_mul46_pop6_c0_ene2_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_mul46_pop6_c0_ene2_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_mul46_pop6_c0_ene2_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_mul46_pop6_c0_ene2_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb2_mul46_pop6_c0_ene2_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb2_mul46_pop6_c0_ene2_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb2_mul46_pop6_c0_ene2_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb2_mul46_pop6_c0_ene2_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb2_mul46_pop6_c0_ene2_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb2_mul46_pop6_c0_ene2),
	.data_out(rnode_1to2_bb2_mul46_pop6_c0_ene2_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb2_mul46_pop6_c0_ene2_0_reg_2_fifo.DEPTH = 1;
defparam rnode_1to2_bb2_mul46_pop6_c0_ene2_0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_bb2_mul46_pop6_c0_ene2_0_reg_2_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_1to2_bb2_mul46_pop6_c0_ene2_0_reg_2_fifo.IMPL = "shift_reg";

assign rnode_1to2_bb2_mul46_pop6_c0_ene2_0_reg_2_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_mul46_pop6_c0_ene2_stall_in_1 = 1'b0;
assign rnode_1to2_bb2_mul46_pop6_c0_ene2_0_NO_SHIFT_REG = rnode_1to2_bb2_mul46_pop6_c0_ene2_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_mul46_pop6_c0_ene2_0_stall_in_reg_2_NO_SHIFT_REG = 1'b0;
assign rnode_1to2_bb2_mul46_pop6_c0_ene2_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb2_var__0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_bb2_var__0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb2_var__0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_var__0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb2_var__0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_var__0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_var__0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_var__0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb2_var__0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb2_var__0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb2_var__0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb2_var__0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb2_var__0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb2_var_),
	.data_out(rnode_1to2_bb2_var__0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb2_var__0_reg_2_fifo.DEPTH = 1;
defparam rnode_1to2_bb2_var__0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_bb2_var__0_reg_2_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_1to2_bb2_var__0_reg_2_fifo.IMPL = "shift_reg";

assign rnode_1to2_bb2_var__0_reg_2_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_var__stall_in_1 = 1'b0;
assign rnode_1to2_bb2_var__0_NO_SHIFT_REG = rnode_1to2_bb2_var__0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_var__0_stall_in_reg_2_NO_SHIFT_REG = 1'b0;
assign rnode_1to2_bb2_var__0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb2_add_inputs_ready;
 reg local_bb2_add_valid_out_NO_SHIFT_REG;
wire local_bb2_add_stall_in;
wire local_bb2_add_output_regs_ready;
wire [31:0] local_bb2_add;
 reg local_bb2_add_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb2_add_valid_pipe_1_NO_SHIFT_REG;
wire local_bb2_add_causedstall;

acl_int_mult int_module_local_bb2_add (
	.clock(clock),
	.dataa(local_bb2_mul1),
	.datab(input_ratio),
	.enable(local_bb2_add_output_regs_ready),
	.result(local_bb2_add)
);

defparam int_module_local_bb2_add.INPUT1_WIDTH = 32;
defparam int_module_local_bb2_add.INPUT2_WIDTH = 32;
defparam int_module_local_bb2_add.OUTPUT_WIDTH = 32;
defparam int_module_local_bb2_add.LATENCY = 3;
defparam int_module_local_bb2_add.SIGNED = 0;

assign local_bb2_add_inputs_ready = 1'b1;
assign local_bb2_add_output_regs_ready = 1'b1;
assign local_bb2_mul1_stall_in = 1'b0;
assign local_bb2_add_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_add_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb2_add_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_add_output_regs_ready)
		begin
			local_bb2_add_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb2_add_valid_pipe_1_NO_SHIFT_REG <= local_bb2_add_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_add_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_add_output_regs_ready)
		begin
			local_bb2_add_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb2_add_stall_in))
			begin
				local_bb2_add_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb2_exitcond_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_bb2_exitcond_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to2_bb2_exitcond_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_exitcond_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_bb2_exitcond_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_exitcond_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_exitcond_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_exitcond_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb2_exitcond_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb2_exitcond_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb2_exitcond_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb2_exitcond_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb2_exitcond_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb2_exitcond),
	.data_out(rnode_1to2_bb2_exitcond_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb2_exitcond_0_reg_2_fifo.DEPTH = 1;
defparam rnode_1to2_bb2_exitcond_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_bb2_exitcond_0_reg_2_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_1to2_bb2_exitcond_0_reg_2_fifo.IMPL = "shift_reg";

assign rnode_1to2_bb2_exitcond_0_reg_2_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_exitcond_stall_in_1 = 1'b0;
assign rnode_1to2_bb2_exitcond_0_NO_SHIFT_REG = rnode_1to2_bb2_exitcond_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_exitcond_0_stall_in_reg_2_NO_SHIFT_REG = 1'b0;
assign rnode_1to2_bb2_exitcond_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb2_notexitcond_notexit_inputs_ready;
 reg local_bb2_notexitcond_notexit_valid_out_0_NO_SHIFT_REG;
wire local_bb2_notexitcond_notexit_stall_in_0;
 reg local_bb2_notexitcond_notexit_valid_out_1_NO_SHIFT_REG;
wire local_bb2_notexitcond_notexit_stall_in_1;
 reg local_bb2_notexitcond_notexit_valid_out_2_NO_SHIFT_REG;
wire local_bb2_notexitcond_notexit_stall_in_2;
 reg local_bb2_notexitcond_notexit_valid_out_3_NO_SHIFT_REG;
wire local_bb2_notexitcond_notexit_stall_in_3;
wire local_bb2_notexitcond_notexit_output_regs_ready;
wire local_bb2_notexitcond_notexit_result;
wire local_bb2_notexitcond_notexit_fu_valid_out;
wire local_bb2_notexitcond_notexit_fu_stall_out;
 reg local_bb2_notexitcond_notexit_NO_SHIFT_REG;
wire local_bb2_notexitcond_notexit_causedstall;

acl_push local_bb2_notexitcond_notexit_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(1'b1),
	.predicate(1'b0),
	.data_in(local_bb2_notexit),
	.stall_out(local_bb2_notexitcond_notexit_fu_stall_out),
	.valid_in(SFC_2_VALID_1_1_0),
	.valid_out(local_bb2_notexitcond_notexit_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb2_notexitcond_notexit_result),
	.feedback_out(feedback_data_out_1),
	.feedback_valid_out(feedback_valid_out_1),
	.feedback_stall_in(feedback_stall_in_1)
);

defparam local_bb2_notexitcond_notexit_feedback.STALLFREE = 1;
defparam local_bb2_notexitcond_notexit_feedback.DATA_WIDTH = 1;
defparam local_bb2_notexitcond_notexit_feedback.FIFO_DEPTH = 0;
defparam local_bb2_notexitcond_notexit_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb2_notexitcond_notexit_feedback.STYLE = "REGULAR";

assign local_bb2_notexitcond_notexit_inputs_ready = 1'b1;
assign local_bb2_notexitcond_notexit_output_regs_ready = 1'b1;
assign local_bb2_notexit_stall_in_0 = 1'b0;
assign SFC_2_VALID_1_1_0_stall_in_4 = 1'b0;
assign local_bb2_notexitcond_notexit_causedstall = (SFC_2_VALID_1_1_0 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_notexitcond_notexit_NO_SHIFT_REG <= 'x;
		local_bb2_notexitcond_notexit_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb2_notexitcond_notexit_valid_out_1_NO_SHIFT_REG <= 1'b0;
		local_bb2_notexitcond_notexit_valid_out_2_NO_SHIFT_REG <= 1'b0;
		local_bb2_notexitcond_notexit_valid_out_3_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_notexitcond_notexit_output_regs_ready)
		begin
			local_bb2_notexitcond_notexit_NO_SHIFT_REG <= local_bb2_notexitcond_notexit_result;
			local_bb2_notexitcond_notexit_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb2_notexitcond_notexit_valid_out_1_NO_SHIFT_REG <= 1'b1;
			local_bb2_notexitcond_notexit_valid_out_2_NO_SHIFT_REG <= 1'b1;
			local_bb2_notexitcond_notexit_valid_out_3_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb2_notexitcond_notexit_stall_in_0))
			begin
				local_bb2_notexitcond_notexit_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb2_notexitcond_notexit_stall_in_1))
			begin
				local_bb2_notexitcond_notexit_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb2_notexitcond_notexit_stall_in_2))
			begin
				local_bb2_notexitcond_notexit_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb2_notexitcond_notexit_stall_in_3))
			begin
				local_bb2_notexitcond_notexit_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb2_indvars_iv_push5_indvars_iv_next_inputs_ready;
 reg local_bb2_indvars_iv_push5_indvars_iv_next_valid_out_NO_SHIFT_REG;
wire local_bb2_indvars_iv_push5_indvars_iv_next_stall_in;
wire local_bb2_indvars_iv_push5_indvars_iv_next_output_regs_ready;
wire [63:0] local_bb2_indvars_iv_push5_indvars_iv_next_result;
wire local_bb2_indvars_iv_push5_indvars_iv_next_fu_valid_out;
wire local_bb2_indvars_iv_push5_indvars_iv_next_fu_stall_out;
 reg [63:0] local_bb2_indvars_iv_push5_indvars_iv_next_NO_SHIFT_REG;
wire local_bb2_indvars_iv_push5_indvars_iv_next_causedstall;

acl_push local_bb2_indvars_iv_push5_indvars_iv_next_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb2_notexit),
	.predicate(1'b0),
	.data_in(local_bb2_indvars_iv_next),
	.stall_out(local_bb2_indvars_iv_push5_indvars_iv_next_fu_stall_out),
	.valid_in(SFC_2_VALID_1_1_0),
	.valid_out(local_bb2_indvars_iv_push5_indvars_iv_next_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb2_indvars_iv_push5_indvars_iv_next_result),
	.feedback_out(feedback_data_out_5),
	.feedback_valid_out(feedback_valid_out_5),
	.feedback_stall_in(feedback_stall_in_5)
);

defparam local_bb2_indvars_iv_push5_indvars_iv_next_feedback.STALLFREE = 1;
defparam local_bb2_indvars_iv_push5_indvars_iv_next_feedback.DATA_WIDTH = 64;
defparam local_bb2_indvars_iv_push5_indvars_iv_next_feedback.FIFO_DEPTH = 1;
defparam local_bb2_indvars_iv_push5_indvars_iv_next_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb2_indvars_iv_push5_indvars_iv_next_feedback.STYLE = "REGULAR";

assign local_bb2_indvars_iv_push5_indvars_iv_next_inputs_ready = 1'b1;
assign local_bb2_indvars_iv_push5_indvars_iv_next_output_regs_ready = 1'b1;
assign local_bb2_indvars_iv_next_stall_in_1 = 1'b0;
assign local_bb2_notexit_stall_in_1 = 1'b0;
assign SFC_2_VALID_1_1_0_stall_in_5 = 1'b0;
assign local_bb2_indvars_iv_push5_indvars_iv_next_causedstall = (SFC_2_VALID_1_1_0 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_indvars_iv_push5_indvars_iv_next_NO_SHIFT_REG <= 'x;
		local_bb2_indvars_iv_push5_indvars_iv_next_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_indvars_iv_push5_indvars_iv_next_output_regs_ready)
		begin
			local_bb2_indvars_iv_push5_indvars_iv_next_NO_SHIFT_REG <= local_bb2_indvars_iv_push5_indvars_iv_next_result;
			local_bb2_indvars_iv_push5_indvars_iv_next_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb2_indvars_iv_push5_indvars_iv_next_stall_in))
			begin
				local_bb2_indvars_iv_push5_indvars_iv_next_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_2_VALID_2_3_0_inputs_ready;
 reg SFC_2_VALID_2_3_0_valid_out_NO_SHIFT_REG;
wire SFC_2_VALID_2_3_0_stall_in;
wire SFC_2_VALID_2_3_0_output_regs_ready;
 reg SFC_2_VALID_2_3_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_2_3_0_causedstall;

assign SFC_2_VALID_2_3_0_inputs_ready = 1'b1;
assign SFC_2_VALID_2_3_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_1_2_0_stall_in_0 = 1'b0;
assign SFC_2_VALID_2_3_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_2_3_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_2_3_0_output_regs_ready)
		begin
			SFC_2_VALID_2_3_0_NO_SHIFT_REG <= SFC_2_VALID_1_2_0_NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb2_mul77_pop7_c0_ene3_stall_local;
wire [31:0] local_bb2_mul77_pop7_c0_ene3;
wire local_bb2_mul77_pop7_c0_ene3_fu_valid_out;
wire local_bb2_mul77_pop7_c0_ene3_fu_stall_out;

acl_pop local_bb2_mul77_pop7_c0_ene3_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_1to2_bb2_c0_ene111_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(rnode_1to2_bb2_c0_ene3_0_NO_SHIFT_REG),
	.stall_out(local_bb2_mul77_pop7_c0_ene3_fu_stall_out),
	.valid_in(SFC_2_VALID_1_2_0_NO_SHIFT_REG),
	.valid_out(local_bb2_mul77_pop7_c0_ene3_fu_valid_out),
	.stall_in(local_bb2_mul77_pop7_c0_ene3_stall_local),
	.data_out(local_bb2_mul77_pop7_c0_ene3),
	.feedback_in(feedback_data_in_7),
	.feedback_valid_in(feedback_valid_in_7),
	.feedback_stall_out(feedback_stall_out_7)
);

defparam local_bb2_mul77_pop7_c0_ene3_feedback.COALESCE_DISTANCE = 1;
defparam local_bb2_mul77_pop7_c0_ene3_feedback.DATA_WIDTH = 32;
defparam local_bb2_mul77_pop7_c0_ene3_feedback.STYLE = "REGULAR";

assign local_bb2_mul77_pop7_c0_ene3_stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb2_exitcond48_pop8_c0_ene4_valid_out_0;
wire local_bb2_exitcond48_pop8_c0_ene4_stall_in_0;
wire local_bb2_exitcond48_pop8_c0_ene4_valid_out_1;
wire local_bb2_exitcond48_pop8_c0_ene4_stall_in_1;
wire local_bb2_exitcond48_pop8_c0_ene4_inputs_ready;
wire local_bb2_exitcond48_pop8_c0_ene4_stall_local;
wire local_bb2_exitcond48_pop8_c0_ene4;
wire local_bb2_exitcond48_pop8_c0_ene4_fu_valid_out;
wire local_bb2_exitcond48_pop8_c0_ene4_fu_stall_out;

acl_pop local_bb2_exitcond48_pop8_c0_ene4_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_1to2_bb2_c0_ene111_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(rnode_1to2_bb2_c0_ene4_0_NO_SHIFT_REG),
	.stall_out(local_bb2_exitcond48_pop8_c0_ene4_fu_stall_out),
	.valid_in(SFC_2_VALID_1_2_0_NO_SHIFT_REG),
	.valid_out(local_bb2_exitcond48_pop8_c0_ene4_fu_valid_out),
	.stall_in(local_bb2_exitcond48_pop8_c0_ene4_stall_local),
	.data_out(local_bb2_exitcond48_pop8_c0_ene4),
	.feedback_in(feedback_data_in_8),
	.feedback_valid_in(feedback_valid_in_8),
	.feedback_stall_out(feedback_stall_out_8)
);

defparam local_bb2_exitcond48_pop8_c0_ene4_feedback.COALESCE_DISTANCE = 1;
defparam local_bb2_exitcond48_pop8_c0_ene4_feedback.DATA_WIDTH = 1;
defparam local_bb2_exitcond48_pop8_c0_ene4_feedback.STYLE = "REGULAR";

assign local_bb2_exitcond48_pop8_c0_ene4_inputs_ready = (SFC_2_VALID_1_2_0_valid_out_2_NO_SHIFT_REG & rnode_1to2_bb2_c0_ene4_0_valid_out_NO_SHIFT_REG & rnode_1to2_bb2_c0_ene111_0_valid_out_1_NO_SHIFT_REG);
assign local_bb2_exitcond48_pop8_c0_ene4_stall_local = 1'b0;
assign local_bb2_exitcond48_pop8_c0_ene4_valid_out_0 = 1'b1;
assign local_bb2_exitcond48_pop8_c0_ene4_valid_out_1 = 1'b1;
assign SFC_2_VALID_1_2_0_stall_in_2 = 1'b0;
assign rnode_1to2_bb2_c0_ene4_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_1to2_bb2_c0_ene111_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_2to3_bb2_keep_going_acl_pipeline_1_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to3_bb2_keep_going_acl_pipeline_1_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to3_bb2_keep_going_acl_pipeline_1_0_NO_SHIFT_REG;
 logic rnode_2to3_bb2_keep_going_acl_pipeline_1_0_reg_3_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to3_bb2_keep_going_acl_pipeline_1_0_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_keep_going_acl_pipeline_1_0_valid_out_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_keep_going_acl_pipeline_1_0_stall_in_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_keep_going_acl_pipeline_1_0_stall_out_reg_3_NO_SHIFT_REG;

acl_data_fifo rnode_2to3_bb2_keep_going_acl_pipeline_1_0_reg_3_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to3_bb2_keep_going_acl_pipeline_1_0_reg_3_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to3_bb2_keep_going_acl_pipeline_1_0_stall_in_reg_3_NO_SHIFT_REG),
	.valid_out(rnode_2to3_bb2_keep_going_acl_pipeline_1_0_valid_out_reg_3_NO_SHIFT_REG),
	.stall_out(rnode_2to3_bb2_keep_going_acl_pipeline_1_0_stall_out_reg_3_NO_SHIFT_REG),
	.data_in(local_bb2_keep_going_acl_pipeline_1_NO_SHIFT_REG),
	.data_out(rnode_2to3_bb2_keep_going_acl_pipeline_1_0_reg_3_NO_SHIFT_REG)
);

defparam rnode_2to3_bb2_keep_going_acl_pipeline_1_0_reg_3_fifo.DEPTH = 1;
defparam rnode_2to3_bb2_keep_going_acl_pipeline_1_0_reg_3_fifo.DATA_WIDTH = 1;
defparam rnode_2to3_bb2_keep_going_acl_pipeline_1_0_reg_3_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_2to3_bb2_keep_going_acl_pipeline_1_0_reg_3_fifo.IMPL = "shift_reg";

assign rnode_2to3_bb2_keep_going_acl_pipeline_1_0_reg_3_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_keep_going_acl_pipeline_1_stall_in = 1'b0;
assign rnode_2to3_bb2_keep_going_acl_pipeline_1_0_NO_SHIFT_REG = rnode_2to3_bb2_keep_going_acl_pipeline_1_0_reg_3_NO_SHIFT_REG;
assign rnode_2to3_bb2_keep_going_acl_pipeline_1_0_stall_in_reg_3_NO_SHIFT_REG = 1'b0;
assign rnode_2to3_bb2_keep_going_acl_pipeline_1_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb2_idxprom_valid_out;
wire local_bb2_idxprom_stall_in;
wire local_bb2_idxprom_inputs_ready;
wire local_bb2_idxprom_stall_local;
wire [63:0] local_bb2_idxprom;

assign local_bb2_idxprom_inputs_ready = local_bb2_add_valid_out_NO_SHIFT_REG;
assign local_bb2_idxprom[63:32] = 32'h0;
assign local_bb2_idxprom[31:0] = local_bb2_add;
assign local_bb2_idxprom_valid_out = 1'b1;
assign local_bb2_add_stall_in = 1'b0;

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_2to5_bb2_exitcond_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to5_bb2_exitcond_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to5_bb2_exitcond_0_NO_SHIFT_REG;
 logic rnode_2to5_bb2_exitcond_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to5_bb2_exitcond_0_reg_5_NO_SHIFT_REG;
 logic rnode_2to5_bb2_exitcond_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_2to5_bb2_exitcond_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_2to5_bb2_exitcond_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_2to5_bb2_exitcond_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to5_bb2_exitcond_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to5_bb2_exitcond_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_2to5_bb2_exitcond_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_2to5_bb2_exitcond_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(rnode_1to2_bb2_exitcond_0_NO_SHIFT_REG),
	.data_out(rnode_2to5_bb2_exitcond_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_2to5_bb2_exitcond_0_reg_5_fifo.DEPTH = 3;
defparam rnode_2to5_bb2_exitcond_0_reg_5_fifo.DATA_WIDTH = 1;
defparam rnode_2to5_bb2_exitcond_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_2to5_bb2_exitcond_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_2to5_bb2_exitcond_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_1to2_bb2_exitcond_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_2to5_bb2_exitcond_0_NO_SHIFT_REG = rnode_2to5_bb2_exitcond_0_reg_5_NO_SHIFT_REG;
assign rnode_2to5_bb2_exitcond_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_2to5_bb2_exitcond_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb2_mul46_push6_mul46_pop6_inputs_ready;
 reg local_bb2_mul46_push6_mul46_pop6_valid_out_NO_SHIFT_REG;
wire local_bb2_mul46_push6_mul46_pop6_stall_in;
wire local_bb2_mul46_push6_mul46_pop6_output_regs_ready;
wire [31:0] local_bb2_mul46_push6_mul46_pop6_result;
wire local_bb2_mul46_push6_mul46_pop6_fu_valid_out;
wire local_bb2_mul46_push6_mul46_pop6_fu_stall_out;
 reg [31:0] local_bb2_mul46_push6_mul46_pop6_NO_SHIFT_REG;
wire local_bb2_mul46_push6_mul46_pop6_causedstall;

acl_push local_bb2_mul46_push6_mul46_pop6_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb2_notexitcond_notexit_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(rnode_1to2_bb2_mul46_pop6_c0_ene2_0_NO_SHIFT_REG),
	.stall_out(local_bb2_mul46_push6_mul46_pop6_fu_stall_out),
	.valid_in(SFC_2_VALID_1_2_0_NO_SHIFT_REG),
	.valid_out(local_bb2_mul46_push6_mul46_pop6_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb2_mul46_push6_mul46_pop6_result),
	.feedback_out(feedback_data_out_6),
	.feedback_valid_out(feedback_valid_out_6),
	.feedback_stall_in(feedback_stall_in_6)
);

defparam local_bb2_mul46_push6_mul46_pop6_feedback.STALLFREE = 1;
defparam local_bb2_mul46_push6_mul46_pop6_feedback.DATA_WIDTH = 32;
defparam local_bb2_mul46_push6_mul46_pop6_feedback.FIFO_DEPTH = 1;
defparam local_bb2_mul46_push6_mul46_pop6_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb2_mul46_push6_mul46_pop6_feedback.STYLE = "REGULAR";

assign local_bb2_mul46_push6_mul46_pop6_inputs_ready = 1'b1;
assign local_bb2_mul46_push6_mul46_pop6_output_regs_ready = 1'b1;
assign local_bb2_notexitcond_notexit_stall_in_1 = 1'b0;
assign SFC_2_VALID_1_2_0_stall_in_4 = 1'b0;
assign rnode_1to2_bb2_mul46_pop6_c0_ene2_0_stall_in_NO_SHIFT_REG = 1'b0;
assign local_bb2_mul46_push6_mul46_pop6_causedstall = (SFC_2_VALID_1_2_0_NO_SHIFT_REG && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_mul46_push6_mul46_pop6_NO_SHIFT_REG <= 'x;
		local_bb2_mul46_push6_mul46_pop6_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_mul46_push6_mul46_pop6_output_regs_ready)
		begin
			local_bb2_mul46_push6_mul46_pop6_NO_SHIFT_REG <= local_bb2_mul46_push6_mul46_pop6_result;
			local_bb2_mul46_push6_mul46_pop6_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb2_mul46_push6_mul46_pop6_stall_in))
			begin
				local_bb2_mul46_push6_mul46_pop6_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_2to3_bb2_notexitcond_notexit_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to3_bb2_notexitcond_notexit_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to3_bb2_notexitcond_notexit_0_NO_SHIFT_REG;
 logic rnode_2to3_bb2_notexitcond_notexit_0_reg_3_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to3_bb2_notexitcond_notexit_0_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_notexitcond_notexit_0_valid_out_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_notexitcond_notexit_0_stall_in_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_notexitcond_notexit_0_stall_out_reg_3_NO_SHIFT_REG;

acl_data_fifo rnode_2to3_bb2_notexitcond_notexit_0_reg_3_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to3_bb2_notexitcond_notexit_0_reg_3_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to3_bb2_notexitcond_notexit_0_stall_in_reg_3_NO_SHIFT_REG),
	.valid_out(rnode_2to3_bb2_notexitcond_notexit_0_valid_out_reg_3_NO_SHIFT_REG),
	.stall_out(rnode_2to3_bb2_notexitcond_notexit_0_stall_out_reg_3_NO_SHIFT_REG),
	.data_in(local_bb2_notexitcond_notexit_NO_SHIFT_REG),
	.data_out(rnode_2to3_bb2_notexitcond_notexit_0_reg_3_NO_SHIFT_REG)
);

defparam rnode_2to3_bb2_notexitcond_notexit_0_reg_3_fifo.DEPTH = 1;
defparam rnode_2to3_bb2_notexitcond_notexit_0_reg_3_fifo.DATA_WIDTH = 1;
defparam rnode_2to3_bb2_notexitcond_notexit_0_reg_3_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_2to3_bb2_notexitcond_notexit_0_reg_3_fifo.IMPL = "shift_reg";

assign rnode_2to3_bb2_notexitcond_notexit_0_reg_3_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_notexitcond_notexit_stall_in_3 = 1'b0;
assign rnode_2to3_bb2_notexitcond_notexit_0_NO_SHIFT_REG = rnode_2to3_bb2_notexitcond_notexit_0_reg_3_NO_SHIFT_REG;
assign rnode_2to3_bb2_notexitcond_notexit_0_stall_in_reg_3_NO_SHIFT_REG = 1'b0;
assign rnode_2to3_bb2_notexitcond_notexit_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_NO_SHIFT_REG;
 logic rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_reg_3_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_valid_out_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_stall_out_reg_3_NO_SHIFT_REG;

acl_data_fifo rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_reg_3_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_reg_3_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_reg_3_NO_SHIFT_REG),
	.valid_out(rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_valid_out_reg_3_NO_SHIFT_REG),
	.stall_out(rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_stall_out_reg_3_NO_SHIFT_REG),
	.data_in(local_bb2_indvars_iv_push5_indvars_iv_next_NO_SHIFT_REG),
	.data_out(rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_reg_3_NO_SHIFT_REG)
);

defparam rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_reg_3_fifo.DEPTH = 1;
defparam rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_reg_3_fifo.DATA_WIDTH = 64;
defparam rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_reg_3_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_reg_3_fifo.IMPL = "shift_reg";

assign rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_reg_3_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_indvars_iv_push5_indvars_iv_next_stall_in = 1'b0;
assign rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_NO_SHIFT_REG = rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_reg_3_NO_SHIFT_REG;
assign rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_reg_3_NO_SHIFT_REG = 1'b0;
assign rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire SFC_2_VALID_3_4_0_inputs_ready;
 reg SFC_2_VALID_3_4_0_valid_out_NO_SHIFT_REG;
wire SFC_2_VALID_3_4_0_stall_in;
wire SFC_2_VALID_3_4_0_output_regs_ready;
 reg SFC_2_VALID_3_4_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_3_4_0_causedstall;

assign SFC_2_VALID_3_4_0_inputs_ready = 1'b1;
assign SFC_2_VALID_3_4_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_2_3_0_stall_in = 1'b0;
assign SFC_2_VALID_3_4_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_3_4_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_3_4_0_output_regs_ready)
		begin
			SFC_2_VALID_3_4_0_NO_SHIFT_REG <= SFC_2_VALID_2_3_0_NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb2_mul77_pop7_c0_ene3_valid_out_1;
wire local_bb2_mul77_pop7_c0_ene3_stall_in_1;
wire local_bb2_add8_valid_out;
wire local_bb2_add8_stall_in;
wire local_bb2_add8_inputs_ready;
wire local_bb2_add8_stall_local;
wire [31:0] local_bb2_add8;

assign local_bb2_add8_inputs_ready = (SFC_2_VALID_1_2_0_valid_out_1_NO_SHIFT_REG & rnode_1to2_bb2_c0_ene3_0_valid_out_NO_SHIFT_REG & rnode_1to2_bb2_c0_ene111_0_valid_out_0_NO_SHIFT_REG & rnode_1to2_bb2_var__0_valid_out_NO_SHIFT_REG);
assign local_bb2_add8 = (rnode_1to2_bb2_var__0_NO_SHIFT_REG + local_bb2_mul77_pop7_c0_ene3);
assign local_bb2_mul77_pop7_c0_ene3_valid_out_1 = 1'b1;
assign local_bb2_add8_valid_out = 1'b1;
assign SFC_2_VALID_1_2_0_stall_in_1 = 1'b0;
assign rnode_1to2_bb2_c0_ene3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_1to2_bb2_c0_ene111_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_1to2_bb2_var__0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements a registered operation.
// 
wire local_bb2_exitcond48_push8_exitcond48_pop8_inputs_ready;
 reg local_bb2_exitcond48_push8_exitcond48_pop8_valid_out_NO_SHIFT_REG;
wire local_bb2_exitcond48_push8_exitcond48_pop8_stall_in;
wire local_bb2_exitcond48_push8_exitcond48_pop8_output_regs_ready;
wire local_bb2_exitcond48_push8_exitcond48_pop8_result;
wire local_bb2_exitcond48_push8_exitcond48_pop8_fu_valid_out;
wire local_bb2_exitcond48_push8_exitcond48_pop8_fu_stall_out;
 reg local_bb2_exitcond48_push8_exitcond48_pop8_NO_SHIFT_REG;
wire local_bb2_exitcond48_push8_exitcond48_pop8_causedstall;

acl_push local_bb2_exitcond48_push8_exitcond48_pop8_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb2_notexitcond_notexit_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb2_exitcond48_pop8_c0_ene4),
	.stall_out(local_bb2_exitcond48_push8_exitcond48_pop8_fu_stall_out),
	.valid_in(SFC_2_VALID_1_2_0_NO_SHIFT_REG),
	.valid_out(local_bb2_exitcond48_push8_exitcond48_pop8_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb2_exitcond48_push8_exitcond48_pop8_result),
	.feedback_out(feedback_data_out_8),
	.feedback_valid_out(feedback_valid_out_8),
	.feedback_stall_in(feedback_stall_in_8)
);

defparam local_bb2_exitcond48_push8_exitcond48_pop8_feedback.STALLFREE = 1;
defparam local_bb2_exitcond48_push8_exitcond48_pop8_feedback.DATA_WIDTH = 1;
defparam local_bb2_exitcond48_push8_exitcond48_pop8_feedback.FIFO_DEPTH = 1;
defparam local_bb2_exitcond48_push8_exitcond48_pop8_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb2_exitcond48_push8_exitcond48_pop8_feedback.STYLE = "REGULAR";

assign local_bb2_exitcond48_push8_exitcond48_pop8_inputs_ready = 1'b1;
assign local_bb2_exitcond48_push8_exitcond48_pop8_output_regs_ready = 1'b1;
assign local_bb2_exitcond48_pop8_c0_ene4_stall_in_0 = 1'b0;
assign local_bb2_notexitcond_notexit_stall_in_2 = 1'b0;
assign SFC_2_VALID_1_2_0_stall_in_5 = 1'b0;
assign local_bb2_exitcond48_push8_exitcond48_pop8_causedstall = (SFC_2_VALID_1_2_0_NO_SHIFT_REG && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_exitcond48_push8_exitcond48_pop8_NO_SHIFT_REG <= 'x;
		local_bb2_exitcond48_push8_exitcond48_pop8_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_exitcond48_push8_exitcond48_pop8_output_regs_ready)
		begin
			local_bb2_exitcond48_push8_exitcond48_pop8_NO_SHIFT_REG <= local_bb2_exitcond48_push8_exitcond48_pop8_result;
			local_bb2_exitcond48_push8_exitcond48_pop8_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb2_exitcond48_push8_exitcond48_pop8_stall_in))
			begin
				local_bb2_exitcond48_push8_exitcond48_pop8_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_NO_SHIFT_REG;
 logic rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_reg_3_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_valid_out_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_stall_in_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_stall_out_reg_3_NO_SHIFT_REG;

acl_data_fifo rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_reg_3_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_reg_3_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_stall_in_reg_3_NO_SHIFT_REG),
	.valid_out(rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_valid_out_reg_3_NO_SHIFT_REG),
	.stall_out(rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_stall_out_reg_3_NO_SHIFT_REG),
	.data_in(local_bb2_exitcond48_pop8_c0_ene4),
	.data_out(rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_reg_3_NO_SHIFT_REG)
);

defparam rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_reg_3_fifo.DEPTH = 1;
defparam rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_reg_3_fifo.DATA_WIDTH = 1;
defparam rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_reg_3_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_reg_3_fifo.IMPL = "shift_reg";

assign rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_reg_3_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_exitcond48_pop8_c0_ene4_stall_in_1 = 1'b0;
assign rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_NO_SHIFT_REG = rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_reg_3_NO_SHIFT_REG;
assign rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_stall_in_reg_3_NO_SHIFT_REG = 1'b0;
assign rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_3to5_bb2_keep_going_acl_pipeline_1_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to5_bb2_keep_going_acl_pipeline_1_0_stall_in_NO_SHIFT_REG;
 logic rnode_3to5_bb2_keep_going_acl_pipeline_1_0_NO_SHIFT_REG;
 logic rnode_3to5_bb2_keep_going_acl_pipeline_1_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to5_bb2_keep_going_acl_pipeline_1_0_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb2_keep_going_acl_pipeline_1_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb2_keep_going_acl_pipeline_1_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb2_keep_going_acl_pipeline_1_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_3to5_bb2_keep_going_acl_pipeline_1_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to5_bb2_keep_going_acl_pipeline_1_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to5_bb2_keep_going_acl_pipeline_1_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_3to5_bb2_keep_going_acl_pipeline_1_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_3to5_bb2_keep_going_acl_pipeline_1_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(rnode_2to3_bb2_keep_going_acl_pipeline_1_0_NO_SHIFT_REG),
	.data_out(rnode_3to5_bb2_keep_going_acl_pipeline_1_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_3to5_bb2_keep_going_acl_pipeline_1_0_reg_5_fifo.DEPTH = 2;
defparam rnode_3to5_bb2_keep_going_acl_pipeline_1_0_reg_5_fifo.DATA_WIDTH = 1;
defparam rnode_3to5_bb2_keep_going_acl_pipeline_1_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to5_bb2_keep_going_acl_pipeline_1_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_3to5_bb2_keep_going_acl_pipeline_1_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_2to3_bb2_keep_going_acl_pipeline_1_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb2_keep_going_acl_pipeline_1_0_NO_SHIFT_REG = rnode_3to5_bb2_keep_going_acl_pipeline_1_0_reg_5_NO_SHIFT_REG;
assign rnode_3to5_bb2_keep_going_acl_pipeline_1_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb2_keep_going_acl_pipeline_1_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb2_idxprom_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to5_bb2_idxprom_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb2_idxprom_0_NO_SHIFT_REG;
 logic rnode_4to5_bb2_idxprom_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb2_idxprom_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_idxprom_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_idxprom_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_idxprom_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_4to5_bb2_idxprom_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb2_idxprom_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb2_idxprom_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb2_idxprom_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb2_idxprom_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in((local_bb2_idxprom & 64'hFFFFFFFF)),
	.data_out(rnode_4to5_bb2_idxprom_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb2_idxprom_0_reg_5_fifo.DEPTH = 1;
defparam rnode_4to5_bb2_idxprom_0_reg_5_fifo.DATA_WIDTH = 64;
defparam rnode_4to5_bb2_idxprom_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_4to5_bb2_idxprom_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_4to5_bb2_idxprom_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_idxprom_stall_in = 1'b0;
assign rnode_4to5_bb2_idxprom_0_NO_SHIFT_REG = rnode_4to5_bb2_idxprom_0_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb2_idxprom_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb2_idxprom_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb2_exitcond_0_valid_out_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond_0_stall_in_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond_0_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb2_exitcond_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb2_exitcond_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb2_exitcond_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb2_exitcond_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb2_exitcond_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(rnode_2to5_bb2_exitcond_0_NO_SHIFT_REG),
	.data_out(rnode_5to6_bb2_exitcond_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb2_exitcond_0_reg_6_fifo.DEPTH = 1;
defparam rnode_5to6_bb2_exitcond_0_reg_6_fifo.DATA_WIDTH = 1;
defparam rnode_5to6_bb2_exitcond_0_reg_6_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_5to6_bb2_exitcond_0_reg_6_fifo.IMPL = "shift_reg";

assign rnode_5to6_bb2_exitcond_0_reg_6_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_2to5_bb2_exitcond_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_exitcond_0_NO_SHIFT_REG = rnode_5to6_bb2_exitcond_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb2_exitcond_0_stall_in_reg_6_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_exitcond_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_3to4_bb2_mul46_push6_mul46_pop6_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to4_bb2_mul46_push6_mul46_pop6_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_3to4_bb2_mul46_push6_mul46_pop6_0_NO_SHIFT_REG;
 logic rnode_3to4_bb2_mul46_push6_mul46_pop6_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_3to4_bb2_mul46_push6_mul46_pop6_0_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb2_mul46_push6_mul46_pop6_0_valid_out_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb2_mul46_push6_mul46_pop6_0_stall_in_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb2_mul46_push6_mul46_pop6_0_stall_out_reg_4_NO_SHIFT_REG;

acl_data_fifo rnode_3to4_bb2_mul46_push6_mul46_pop6_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to4_bb2_mul46_push6_mul46_pop6_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to4_bb2_mul46_push6_mul46_pop6_0_stall_in_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_3to4_bb2_mul46_push6_mul46_pop6_0_valid_out_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_3to4_bb2_mul46_push6_mul46_pop6_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(local_bb2_mul46_push6_mul46_pop6_NO_SHIFT_REG),
	.data_out(rnode_3to4_bb2_mul46_push6_mul46_pop6_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_3to4_bb2_mul46_push6_mul46_pop6_0_reg_4_fifo.DEPTH = 1;
defparam rnode_3to4_bb2_mul46_push6_mul46_pop6_0_reg_4_fifo.DATA_WIDTH = 32;
defparam rnode_3to4_bb2_mul46_push6_mul46_pop6_0_reg_4_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to4_bb2_mul46_push6_mul46_pop6_0_reg_4_fifo.IMPL = "shift_reg";

assign rnode_3to4_bb2_mul46_push6_mul46_pop6_0_reg_4_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_mul46_push6_mul46_pop6_stall_in = 1'b0;
assign rnode_3to4_bb2_mul46_push6_mul46_pop6_0_NO_SHIFT_REG = rnode_3to4_bb2_mul46_push6_mul46_pop6_0_reg_4_NO_SHIFT_REG;
assign rnode_3to4_bb2_mul46_push6_mul46_pop6_0_stall_in_reg_4_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb2_mul46_push6_mul46_pop6_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_3to5_bb2_notexitcond_notexit_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to5_bb2_notexitcond_notexit_0_stall_in_NO_SHIFT_REG;
 logic rnode_3to5_bb2_notexitcond_notexit_0_NO_SHIFT_REG;
 logic rnode_3to5_bb2_notexitcond_notexit_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to5_bb2_notexitcond_notexit_0_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb2_notexitcond_notexit_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb2_notexitcond_notexit_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb2_notexitcond_notexit_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_3to5_bb2_notexitcond_notexit_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to5_bb2_notexitcond_notexit_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to5_bb2_notexitcond_notexit_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_3to5_bb2_notexitcond_notexit_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_3to5_bb2_notexitcond_notexit_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(rnode_2to3_bb2_notexitcond_notexit_0_NO_SHIFT_REG),
	.data_out(rnode_3to5_bb2_notexitcond_notexit_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_3to5_bb2_notexitcond_notexit_0_reg_5_fifo.DEPTH = 2;
defparam rnode_3to5_bb2_notexitcond_notexit_0_reg_5_fifo.DATA_WIDTH = 1;
defparam rnode_3to5_bb2_notexitcond_notexit_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to5_bb2_notexitcond_notexit_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_3to5_bb2_notexitcond_notexit_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_2to3_bb2_notexitcond_notexit_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb2_notexitcond_notexit_0_NO_SHIFT_REG = rnode_3to5_bb2_notexitcond_notexit_0_reg_5_NO_SHIFT_REG;
assign rnode_3to5_bb2_notexitcond_notexit_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb2_notexitcond_notexit_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_NO_SHIFT_REG;
 logic rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_NO_SHIFT_REG),
	.data_out(rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_reg_5_fifo.DEPTH = 2;
defparam rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_reg_5_fifo.DATA_WIDTH = 64;
defparam rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_2to3_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_NO_SHIFT_REG = rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_reg_5_NO_SHIFT_REG;
assign rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire SFC_2_VALID_4_5_0_inputs_ready;
 reg SFC_2_VALID_4_5_0_valid_out_NO_SHIFT_REG;
wire SFC_2_VALID_4_5_0_stall_in;
wire SFC_2_VALID_4_5_0_output_regs_ready;
 reg SFC_2_VALID_4_5_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_4_5_0_causedstall;

assign SFC_2_VALID_4_5_0_inputs_ready = 1'b1;
assign SFC_2_VALID_4_5_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_3_4_0_stall_in = 1'b0;
assign SFC_2_VALID_4_5_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_4_5_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_4_5_0_output_regs_ready)
		begin
			SFC_2_VALID_4_5_0_NO_SHIFT_REG <= SFC_2_VALID_3_4_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb2_mul77_push7_mul77_pop7_inputs_ready;
 reg local_bb2_mul77_push7_mul77_pop7_valid_out_NO_SHIFT_REG;
wire local_bb2_mul77_push7_mul77_pop7_stall_in;
wire local_bb2_mul77_push7_mul77_pop7_output_regs_ready;
wire [31:0] local_bb2_mul77_push7_mul77_pop7_result;
wire local_bb2_mul77_push7_mul77_pop7_fu_valid_out;
wire local_bb2_mul77_push7_mul77_pop7_fu_stall_out;
 reg [31:0] local_bb2_mul77_push7_mul77_pop7_NO_SHIFT_REG;
wire local_bb2_mul77_push7_mul77_pop7_causedstall;

acl_push local_bb2_mul77_push7_mul77_pop7_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb2_notexitcond_notexit_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb2_mul77_pop7_c0_ene3),
	.stall_out(local_bb2_mul77_push7_mul77_pop7_fu_stall_out),
	.valid_in(SFC_2_VALID_1_2_0_NO_SHIFT_REG),
	.valid_out(local_bb2_mul77_push7_mul77_pop7_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb2_mul77_push7_mul77_pop7_result),
	.feedback_out(feedback_data_out_7),
	.feedback_valid_out(feedback_valid_out_7),
	.feedback_stall_in(feedback_stall_in_7)
);

defparam local_bb2_mul77_push7_mul77_pop7_feedback.STALLFREE = 1;
defparam local_bb2_mul77_push7_mul77_pop7_feedback.DATA_WIDTH = 32;
defparam local_bb2_mul77_push7_mul77_pop7_feedback.FIFO_DEPTH = 1;
defparam local_bb2_mul77_push7_mul77_pop7_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb2_mul77_push7_mul77_pop7_feedback.STYLE = "REGULAR";

assign local_bb2_mul77_push7_mul77_pop7_inputs_ready = 1'b1;
assign local_bb2_mul77_push7_mul77_pop7_output_regs_ready = 1'b1;
assign local_bb2_mul77_pop7_c0_ene3_stall_in_1 = 1'b0;
assign local_bb2_notexitcond_notexit_stall_in_0 = 1'b0;
assign SFC_2_VALID_1_2_0_stall_in_3 = 1'b0;
assign local_bb2_mul77_push7_mul77_pop7_causedstall = (SFC_2_VALID_1_2_0_NO_SHIFT_REG && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_mul77_push7_mul77_pop7_NO_SHIFT_REG <= 'x;
		local_bb2_mul77_push7_mul77_pop7_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_mul77_push7_mul77_pop7_output_regs_ready)
		begin
			local_bb2_mul77_push7_mul77_pop7_NO_SHIFT_REG <= local_bb2_mul77_push7_mul77_pop7_result;
			local_bb2_mul77_push7_mul77_pop7_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb2_mul77_push7_mul77_pop7_stall_in))
			begin
				local_bb2_mul77_push7_mul77_pop7_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_2to3_bb2_add8_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to3_bb2_add8_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_2to3_bb2_add8_0_NO_SHIFT_REG;
 logic rnode_2to3_bb2_add8_0_reg_3_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_2to3_bb2_add8_0_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_add8_0_valid_out_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_add8_0_stall_in_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb2_add8_0_stall_out_reg_3_NO_SHIFT_REG;

acl_data_fifo rnode_2to3_bb2_add8_0_reg_3_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to3_bb2_add8_0_reg_3_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to3_bb2_add8_0_stall_in_reg_3_NO_SHIFT_REG),
	.valid_out(rnode_2to3_bb2_add8_0_valid_out_reg_3_NO_SHIFT_REG),
	.stall_out(rnode_2to3_bb2_add8_0_stall_out_reg_3_NO_SHIFT_REG),
	.data_in(local_bb2_add8),
	.data_out(rnode_2to3_bb2_add8_0_reg_3_NO_SHIFT_REG)
);

defparam rnode_2to3_bb2_add8_0_reg_3_fifo.DEPTH = 1;
defparam rnode_2to3_bb2_add8_0_reg_3_fifo.DATA_WIDTH = 32;
defparam rnode_2to3_bb2_add8_0_reg_3_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_2to3_bb2_add8_0_reg_3_fifo.IMPL = "shift_reg";

assign rnode_2to3_bb2_add8_0_reg_3_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_add8_stall_in = 1'b0;
assign rnode_2to3_bb2_add8_0_NO_SHIFT_REG = rnode_2to3_bb2_add8_0_reg_3_NO_SHIFT_REG;
assign rnode_2to3_bb2_add8_0_stall_in_reg_3_NO_SHIFT_REG = 1'b0;
assign rnode_2to3_bb2_add8_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_NO_SHIFT_REG;
 logic rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_NO_SHIFT_REG;
 logic rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_valid_out_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_stall_out_reg_4_NO_SHIFT_REG;

acl_data_fifo rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_valid_out_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(local_bb2_exitcond48_push8_exitcond48_pop8_NO_SHIFT_REG),
	.data_out(rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_reg_4_fifo.DEPTH = 1;
defparam rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_reg_4_fifo.DATA_WIDTH = 1;
defparam rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_reg_4_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_reg_4_fifo.IMPL = "shift_reg";

assign rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_reg_4_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_exitcond48_push8_exitcond48_pop8_stall_in = 1'b0;
assign rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_NO_SHIFT_REG = rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_reg_4_NO_SHIFT_REG;
assign rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_reg_4_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_stall_in_NO_SHIFT_REG;
 logic rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_NO_SHIFT_REG;
 logic rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_NO_SHIFT_REG),
	.data_out(rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_reg_5_fifo.DEPTH = 2;
defparam rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_reg_5_fifo.DATA_WIDTH = 1;
defparam rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_2to3_bb2_exitcond48_pop8_c0_ene4_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_NO_SHIFT_REG = rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_reg_5_NO_SHIFT_REG;
assign rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb2_keep_going_acl_pipeline_1_0_valid_out_NO_SHIFT_REG;
 logic rnode_5to6_bb2_keep_going_acl_pipeline_1_0_stall_in_NO_SHIFT_REG;
 logic rnode_5to6_bb2_keep_going_acl_pipeline_1_0_NO_SHIFT_REG;
 logic rnode_5to6_bb2_keep_going_acl_pipeline_1_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic rnode_5to6_bb2_keep_going_acl_pipeline_1_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_keep_going_acl_pipeline_1_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_keep_going_acl_pipeline_1_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_keep_going_acl_pipeline_1_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb2_keep_going_acl_pipeline_1_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb2_keep_going_acl_pipeline_1_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb2_keep_going_acl_pipeline_1_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb2_keep_going_acl_pipeline_1_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb2_keep_going_acl_pipeline_1_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(rnode_3to5_bb2_keep_going_acl_pipeline_1_0_NO_SHIFT_REG),
	.data_out(rnode_5to6_bb2_keep_going_acl_pipeline_1_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb2_keep_going_acl_pipeline_1_0_reg_6_fifo.DEPTH = 1;
defparam rnode_5to6_bb2_keep_going_acl_pipeline_1_0_reg_6_fifo.DATA_WIDTH = 1;
defparam rnode_5to6_bb2_keep_going_acl_pipeline_1_0_reg_6_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_5to6_bb2_keep_going_acl_pipeline_1_0_reg_6_fifo.IMPL = "shift_reg";

assign rnode_5to6_bb2_keep_going_acl_pipeline_1_0_reg_6_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_3to5_bb2_keep_going_acl_pipeline_1_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_keep_going_acl_pipeline_1_0_NO_SHIFT_REG = rnode_5to6_bb2_keep_going_acl_pipeline_1_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb2_keep_going_acl_pipeline_1_0_stall_in_reg_6_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_keep_going_acl_pipeline_1_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb2_arrayidx_valid_out;
wire local_bb2_arrayidx_stall_in;
wire local_bb2_arrayidx_inputs_ready;
wire local_bb2_arrayidx_stall_local;
wire [63:0] local_bb2_arrayidx;

assign local_bb2_arrayidx_inputs_ready = rnode_4to5_bb2_idxprom_0_valid_out_NO_SHIFT_REG;
assign local_bb2_arrayidx = ((input_in & 64'hFFFFFFFFFFFFFC00) + ((rnode_4to5_bb2_idxprom_0_NO_SHIFT_REG & 64'hFFFFFFFF) << 6'h1));
assign local_bb2_arrayidx_valid_out = 1'b1;
assign rnode_4to5_bb2_idxprom_0_stall_in_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb2_mul46_push6_mul46_pop6_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to5_bb2_mul46_push6_mul46_pop6_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_4to5_bb2_mul46_push6_mul46_pop6_0_NO_SHIFT_REG;
 logic rnode_4to5_bb2_mul46_push6_mul46_pop6_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_4to5_bb2_mul46_push6_mul46_pop6_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_mul46_push6_mul46_pop6_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_mul46_push6_mul46_pop6_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_mul46_push6_mul46_pop6_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_4to5_bb2_mul46_push6_mul46_pop6_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb2_mul46_push6_mul46_pop6_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb2_mul46_push6_mul46_pop6_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb2_mul46_push6_mul46_pop6_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb2_mul46_push6_mul46_pop6_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(rnode_3to4_bb2_mul46_push6_mul46_pop6_0_NO_SHIFT_REG),
	.data_out(rnode_4to5_bb2_mul46_push6_mul46_pop6_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb2_mul46_push6_mul46_pop6_0_reg_5_fifo.DEPTH = 1;
defparam rnode_4to5_bb2_mul46_push6_mul46_pop6_0_reg_5_fifo.DATA_WIDTH = 32;
defparam rnode_4to5_bb2_mul46_push6_mul46_pop6_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_4to5_bb2_mul46_push6_mul46_pop6_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_4to5_bb2_mul46_push6_mul46_pop6_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_3to4_bb2_mul46_push6_mul46_pop6_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb2_mul46_push6_mul46_pop6_0_NO_SHIFT_REG = rnode_4to5_bb2_mul46_push6_mul46_pop6_0_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb2_mul46_push6_mul46_pop6_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb2_mul46_push6_mul46_pop6_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb2_notexitcond_notexit_0_valid_out_NO_SHIFT_REG;
 logic rnode_5to6_bb2_notexitcond_notexit_0_stall_in_NO_SHIFT_REG;
 logic rnode_5to6_bb2_notexitcond_notexit_0_NO_SHIFT_REG;
 logic rnode_5to6_bb2_notexitcond_notexit_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic rnode_5to6_bb2_notexitcond_notexit_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_notexitcond_notexit_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_notexitcond_notexit_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_notexitcond_notexit_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb2_notexitcond_notexit_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb2_notexitcond_notexit_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb2_notexitcond_notexit_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb2_notexitcond_notexit_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb2_notexitcond_notexit_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(rnode_3to5_bb2_notexitcond_notexit_0_NO_SHIFT_REG),
	.data_out(rnode_5to6_bb2_notexitcond_notexit_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb2_notexitcond_notexit_0_reg_6_fifo.DEPTH = 1;
defparam rnode_5to6_bb2_notexitcond_notexit_0_reg_6_fifo.DATA_WIDTH = 1;
defparam rnode_5to6_bb2_notexitcond_notexit_0_reg_6_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_5to6_bb2_notexitcond_notexit_0_reg_6_fifo.IMPL = "shift_reg";

assign rnode_5to6_bb2_notexitcond_notexit_0_reg_6_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_3to5_bb2_notexitcond_notexit_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_notexitcond_notexit_0_NO_SHIFT_REG = rnode_5to6_bb2_notexitcond_notexit_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb2_notexitcond_notexit_0_stall_in_reg_6_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_notexitcond_notexit_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_valid_out_NO_SHIFT_REG;
 logic rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_NO_SHIFT_REG;
 logic rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_NO_SHIFT_REG),
	.data_out(rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_reg_6_fifo.DEPTH = 1;
defparam rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_reg_6_fifo.DATA_WIDTH = 64;
defparam rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_reg_6_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_reg_6_fifo.IMPL = "shift_reg";

assign rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_reg_6_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_3to5_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_NO_SHIFT_REG = rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_reg_6_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire SFC_2_VALID_5_6_0_inputs_ready;
 reg SFC_2_VALID_5_6_0_valid_out_NO_SHIFT_REG;
wire SFC_2_VALID_5_6_0_stall_in;
wire SFC_2_VALID_5_6_0_output_regs_ready;
 reg SFC_2_VALID_5_6_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_5_6_0_causedstall;

assign SFC_2_VALID_5_6_0_inputs_ready = 1'b1;
assign SFC_2_VALID_5_6_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_4_5_0_stall_in = 1'b0;
assign SFC_2_VALID_5_6_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_5_6_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_5_6_0_output_regs_ready)
		begin
			SFC_2_VALID_5_6_0_NO_SHIFT_REG <= SFC_2_VALID_4_5_0_NO_SHIFT_REG;
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_3to4_bb2_mul77_push7_mul77_pop7_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to4_bb2_mul77_push7_mul77_pop7_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_3to4_bb2_mul77_push7_mul77_pop7_0_NO_SHIFT_REG;
 logic rnode_3to4_bb2_mul77_push7_mul77_pop7_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_3to4_bb2_mul77_push7_mul77_pop7_0_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb2_mul77_push7_mul77_pop7_0_valid_out_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb2_mul77_push7_mul77_pop7_0_stall_in_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb2_mul77_push7_mul77_pop7_0_stall_out_reg_4_NO_SHIFT_REG;

acl_data_fifo rnode_3to4_bb2_mul77_push7_mul77_pop7_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to4_bb2_mul77_push7_mul77_pop7_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to4_bb2_mul77_push7_mul77_pop7_0_stall_in_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_3to4_bb2_mul77_push7_mul77_pop7_0_valid_out_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_3to4_bb2_mul77_push7_mul77_pop7_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(local_bb2_mul77_push7_mul77_pop7_NO_SHIFT_REG),
	.data_out(rnode_3to4_bb2_mul77_push7_mul77_pop7_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_3to4_bb2_mul77_push7_mul77_pop7_0_reg_4_fifo.DEPTH = 1;
defparam rnode_3to4_bb2_mul77_push7_mul77_pop7_0_reg_4_fifo.DATA_WIDTH = 32;
defparam rnode_3to4_bb2_mul77_push7_mul77_pop7_0_reg_4_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to4_bb2_mul77_push7_mul77_pop7_0_reg_4_fifo.IMPL = "shift_reg";

assign rnode_3to4_bb2_mul77_push7_mul77_pop7_0_reg_4_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_mul77_push7_mul77_pop7_stall_in = 1'b0;
assign rnode_3to4_bb2_mul77_push7_mul77_pop7_0_NO_SHIFT_REG = rnode_3to4_bb2_mul77_push7_mul77_pop7_0_reg_4_NO_SHIFT_REG;
assign rnode_3to4_bb2_mul77_push7_mul77_pop7_0_stall_in_reg_4_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb2_mul77_push7_mul77_pop7_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_3to4_bb2_add8_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to4_bb2_add8_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_3to4_bb2_add8_0_NO_SHIFT_REG;
 logic rnode_3to4_bb2_add8_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_3to4_bb2_add8_0_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb2_add8_0_valid_out_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb2_add8_0_stall_in_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb2_add8_0_stall_out_reg_4_NO_SHIFT_REG;

acl_data_fifo rnode_3to4_bb2_add8_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to4_bb2_add8_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to4_bb2_add8_0_stall_in_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_3to4_bb2_add8_0_valid_out_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_3to4_bb2_add8_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(rnode_2to3_bb2_add8_0_NO_SHIFT_REG),
	.data_out(rnode_3to4_bb2_add8_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_3to4_bb2_add8_0_reg_4_fifo.DEPTH = 1;
defparam rnode_3to4_bb2_add8_0_reg_4_fifo.DATA_WIDTH = 32;
defparam rnode_3to4_bb2_add8_0_reg_4_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to4_bb2_add8_0_reg_4_fifo.IMPL = "shift_reg";

assign rnode_3to4_bb2_add8_0_reg_4_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_2to3_bb2_add8_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb2_add8_0_NO_SHIFT_REG = rnode_3to4_bb2_add8_0_reg_4_NO_SHIFT_REG;
assign rnode_3to4_bb2_add8_0_stall_in_reg_4_NO_SHIFT_REG = 1'b0;
assign rnode_3to4_bb2_add8_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_NO_SHIFT_REG;
 logic rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_NO_SHIFT_REG;
 logic rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_NO_SHIFT_REG),
	.data_out(rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_reg_5_fifo.DEPTH = 1;
defparam rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_reg_5_fifo.DATA_WIDTH = 1;
defparam rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_3to4_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_NO_SHIFT_REG = rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_valid_out_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_stall_in_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_NO_SHIFT_REG),
	.data_out(rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_reg_6_fifo.DEPTH = 1;
defparam rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_reg_6_fifo.DATA_WIDTH = 1;
defparam rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_reg_6_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_reg_6_fifo.IMPL = "shift_reg";

assign rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_reg_6_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_3to5_bb2_exitcond48_pop8_c0_ene4_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_NO_SHIFT_REG = rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_stall_in_reg_6_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb2_arrayidx_0_valid_out_NO_SHIFT_REG;
 logic rnode_5to6_bb2_arrayidx_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb2_arrayidx_0_NO_SHIFT_REG;
 logic rnode_5to6_bb2_arrayidx_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb2_arrayidx_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_arrayidx_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_arrayidx_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_arrayidx_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb2_arrayidx_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb2_arrayidx_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb2_arrayidx_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb2_arrayidx_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb2_arrayidx_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in((local_bb2_arrayidx & 64'hFFFFFFFFFFFFFFFE)),
	.data_out(rnode_5to6_bb2_arrayidx_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb2_arrayidx_0_reg_6_fifo.DEPTH = 1;
defparam rnode_5to6_bb2_arrayidx_0_reg_6_fifo.DATA_WIDTH = 64;
defparam rnode_5to6_bb2_arrayidx_0_reg_6_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_5to6_bb2_arrayidx_0_reg_6_fifo.IMPL = "shift_reg";

assign rnode_5to6_bb2_arrayidx_0_reg_6_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_arrayidx_stall_in = 1'b0;
assign rnode_5to6_bb2_arrayidx_0_NO_SHIFT_REG = rnode_5to6_bb2_arrayidx_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb2_arrayidx_0_stall_in_reg_6_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_arrayidx_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb2_mul46_push6_mul46_pop6_0_valid_out_NO_SHIFT_REG;
 logic rnode_5to6_bb2_mul46_push6_mul46_pop6_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_5to6_bb2_mul46_push6_mul46_pop6_0_NO_SHIFT_REG;
 logic rnode_5to6_bb2_mul46_push6_mul46_pop6_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_5to6_bb2_mul46_push6_mul46_pop6_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_mul46_push6_mul46_pop6_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_mul46_push6_mul46_pop6_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_mul46_push6_mul46_pop6_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb2_mul46_push6_mul46_pop6_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb2_mul46_push6_mul46_pop6_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb2_mul46_push6_mul46_pop6_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb2_mul46_push6_mul46_pop6_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb2_mul46_push6_mul46_pop6_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(rnode_4to5_bb2_mul46_push6_mul46_pop6_0_NO_SHIFT_REG),
	.data_out(rnode_5to6_bb2_mul46_push6_mul46_pop6_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb2_mul46_push6_mul46_pop6_0_reg_6_fifo.DEPTH = 1;
defparam rnode_5to6_bb2_mul46_push6_mul46_pop6_0_reg_6_fifo.DATA_WIDTH = 32;
defparam rnode_5to6_bb2_mul46_push6_mul46_pop6_0_reg_6_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_5to6_bb2_mul46_push6_mul46_pop6_0_reg_6_fifo.IMPL = "shift_reg";

assign rnode_5to6_bb2_mul46_push6_mul46_pop6_0_reg_6_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_4to5_bb2_mul46_push6_mul46_pop6_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_mul46_push6_mul46_pop6_0_NO_SHIFT_REG = rnode_5to6_bb2_mul46_push6_mul46_pop6_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb2_mul46_push6_mul46_pop6_0_stall_in_reg_6_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_mul46_push6_mul46_pop6_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb2_mul77_push7_mul77_pop7_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to5_bb2_mul77_push7_mul77_pop7_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_4to5_bb2_mul77_push7_mul77_pop7_0_NO_SHIFT_REG;
 logic rnode_4to5_bb2_mul77_push7_mul77_pop7_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_4to5_bb2_mul77_push7_mul77_pop7_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_mul77_push7_mul77_pop7_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_mul77_push7_mul77_pop7_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_mul77_push7_mul77_pop7_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_4to5_bb2_mul77_push7_mul77_pop7_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb2_mul77_push7_mul77_pop7_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb2_mul77_push7_mul77_pop7_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb2_mul77_push7_mul77_pop7_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb2_mul77_push7_mul77_pop7_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(rnode_3to4_bb2_mul77_push7_mul77_pop7_0_NO_SHIFT_REG),
	.data_out(rnode_4to5_bb2_mul77_push7_mul77_pop7_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb2_mul77_push7_mul77_pop7_0_reg_5_fifo.DEPTH = 1;
defparam rnode_4to5_bb2_mul77_push7_mul77_pop7_0_reg_5_fifo.DATA_WIDTH = 32;
defparam rnode_4to5_bb2_mul77_push7_mul77_pop7_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_4to5_bb2_mul77_push7_mul77_pop7_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_4to5_bb2_mul77_push7_mul77_pop7_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_3to4_bb2_mul77_push7_mul77_pop7_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb2_mul77_push7_mul77_pop7_0_NO_SHIFT_REG = rnode_4to5_bb2_mul77_push7_mul77_pop7_0_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb2_mul77_push7_mul77_pop7_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb2_mul77_push7_mul77_pop7_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb2_add8_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to5_bb2_add8_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_4to5_bb2_add8_0_NO_SHIFT_REG;
 logic rnode_4to5_bb2_add8_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_4to5_bb2_add8_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_add8_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_add8_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb2_add8_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_4to5_bb2_add8_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb2_add8_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb2_add8_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb2_add8_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb2_add8_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(rnode_3to4_bb2_add8_0_NO_SHIFT_REG),
	.data_out(rnode_4to5_bb2_add8_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb2_add8_0_reg_5_fifo.DEPTH = 1;
defparam rnode_4to5_bb2_add8_0_reg_5_fifo.DATA_WIDTH = 32;
defparam rnode_4to5_bb2_add8_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_4to5_bb2_add8_0_reg_5_fifo.IMPL = "shift_reg";

assign rnode_4to5_bb2_add8_0_reg_5_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_3to4_bb2_add8_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb2_add8_0_NO_SHIFT_REG = rnode_4to5_bb2_add8_0_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb2_add8_0_stall_in_reg_5_NO_SHIFT_REG = 1'b0;
assign rnode_4to5_bb2_add8_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_valid_out_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_NO_SHIFT_REG),
	.data_out(rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_reg_6_fifo.DEPTH = 1;
defparam rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_reg_6_fifo.DATA_WIDTH = 1;
defparam rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_reg_6_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_reg_6_fifo.IMPL = "shift_reg";

assign rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_reg_6_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_4to5_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_NO_SHIFT_REG = rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_reg_6_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb2_c0_exi112_stall_local;
wire [255:0] local_bb2_c0_exi112;

assign local_bb2_c0_exi112[63:0] = 64'bx;
assign local_bb2_c0_exi112[127:64] = (rnode_5to6_bb2_arrayidx_0_NO_SHIFT_REG & 64'hFFFFFFFFFFFFFFFE);
assign local_bb2_c0_exi112[255:128] = 128'bx;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb2_mul77_push7_mul77_pop7_0_valid_out_NO_SHIFT_REG;
 logic rnode_5to6_bb2_mul77_push7_mul77_pop7_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_5to6_bb2_mul77_push7_mul77_pop7_0_NO_SHIFT_REG;
 logic rnode_5to6_bb2_mul77_push7_mul77_pop7_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_5to6_bb2_mul77_push7_mul77_pop7_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_mul77_push7_mul77_pop7_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_mul77_push7_mul77_pop7_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_mul77_push7_mul77_pop7_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb2_mul77_push7_mul77_pop7_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb2_mul77_push7_mul77_pop7_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb2_mul77_push7_mul77_pop7_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb2_mul77_push7_mul77_pop7_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb2_mul77_push7_mul77_pop7_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(rnode_4to5_bb2_mul77_push7_mul77_pop7_0_NO_SHIFT_REG),
	.data_out(rnode_5to6_bb2_mul77_push7_mul77_pop7_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb2_mul77_push7_mul77_pop7_0_reg_6_fifo.DEPTH = 1;
defparam rnode_5to6_bb2_mul77_push7_mul77_pop7_0_reg_6_fifo.DATA_WIDTH = 32;
defparam rnode_5to6_bb2_mul77_push7_mul77_pop7_0_reg_6_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_5to6_bb2_mul77_push7_mul77_pop7_0_reg_6_fifo.IMPL = "shift_reg";

assign rnode_5to6_bb2_mul77_push7_mul77_pop7_0_reg_6_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_4to5_bb2_mul77_push7_mul77_pop7_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_mul77_push7_mul77_pop7_0_NO_SHIFT_REG = rnode_5to6_bb2_mul77_push7_mul77_pop7_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb2_mul77_push7_mul77_pop7_0_stall_in_reg_6_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_mul77_push7_mul77_pop7_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb2_idxprom9_stall_local;
wire [63:0] local_bb2_idxprom9;

assign local_bb2_idxprom9[63:32] = 32'h0;
assign local_bb2_idxprom9[31:0] = rnode_4to5_bb2_add8_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb2_arrayidx10_valid_out;
wire local_bb2_arrayidx10_stall_in;
wire local_bb2_arrayidx10_inputs_ready;
wire local_bb2_arrayidx10_stall_local;
wire [63:0] local_bb2_arrayidx10;

assign local_bb2_arrayidx10_inputs_ready = rnode_4to5_bb2_add8_0_valid_out_NO_SHIFT_REG;
assign local_bb2_arrayidx10 = ((input_depth & 64'hFFFFFFFFFFFFFC00) + ((local_bb2_idxprom9 & 64'hFFFFFFFF) << 6'h2));
assign local_bb2_arrayidx10_valid_out = 1'b1;
assign rnode_4to5_bb2_add8_0_stall_in_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb2_arrayidx10_0_valid_out_NO_SHIFT_REG;
 logic rnode_5to6_bb2_arrayidx10_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb2_arrayidx10_0_NO_SHIFT_REG;
 logic rnode_5to6_bb2_arrayidx10_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb2_arrayidx10_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_arrayidx10_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_arrayidx10_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb2_arrayidx10_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb2_arrayidx10_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb2_arrayidx10_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb2_arrayidx10_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb2_arrayidx10_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb2_arrayidx10_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in((local_bb2_arrayidx10 & 64'hFFFFFFFFFFFFFFFC)),
	.data_out(rnode_5to6_bb2_arrayidx10_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb2_arrayidx10_0_reg_6_fifo.DEPTH = 1;
defparam rnode_5to6_bb2_arrayidx10_0_reg_6_fifo.DATA_WIDTH = 64;
defparam rnode_5to6_bb2_arrayidx10_0_reg_6_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_5to6_bb2_arrayidx10_0_reg_6_fifo.IMPL = "shift_reg";

assign rnode_5to6_bb2_arrayidx10_0_reg_6_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb2_arrayidx10_stall_in = 1'b0;
assign rnode_5to6_bb2_arrayidx10_0_NO_SHIFT_REG = rnode_5to6_bb2_arrayidx10_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb2_arrayidx10_0_stall_in_reg_6_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_arrayidx10_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb2_c0_exi213_stall_local;
wire [255:0] local_bb2_c0_exi213;

assign local_bb2_c0_exi213[127:0] = local_bb2_c0_exi112[127:0];
assign local_bb2_c0_exi213[191:128] = (rnode_5to6_bb2_arrayidx10_0_NO_SHIFT_REG & 64'hFFFFFFFFFFFFFFFC);
assign local_bb2_c0_exi213[255:192] = local_bb2_c0_exi112[255:192];

// This section implements an unregistered operation.
// 
wire local_bb2_c0_exi314_stall_local;
wire [255:0] local_bb2_c0_exi314;

assign local_bb2_c0_exi314[191:0] = local_bb2_c0_exi213[191:0];
assign local_bb2_c0_exi314[192] = rnode_5to6_bb2_exitcond_0_NO_SHIFT_REG;
assign local_bb2_c0_exi314[255:193] = local_bb2_c0_exi213[255:193];

// This section implements an unregistered operation.
// 
wire local_bb2_c0_exi415_stall_local;
wire [255:0] local_bb2_c0_exi415;

assign local_bb2_c0_exi415[199:0] = local_bb2_c0_exi314[199:0];
assign local_bb2_c0_exi415[200] = rnode_5to6_bb2_notexitcond_notexit_0_NO_SHIFT_REG;
assign local_bb2_c0_exi415[255:201] = local_bb2_c0_exi314[255:201];

// This section implements an unregistered operation.
// 
wire local_bb2_c0_exi5_valid_out;
wire local_bb2_c0_exi5_stall_in;
wire local_bb2_c0_exi5_inputs_ready;
wire local_bb2_c0_exi5_stall_local;
wire [255:0] local_bb2_c0_exi5;

assign local_bb2_c0_exi5_inputs_ready = (rnode_5to6_bb2_notexitcond_notexit_0_valid_out_NO_SHIFT_REG & rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_valid_out_NO_SHIFT_REG & rnode_5to6_bb2_exitcond_0_valid_out_NO_SHIFT_REG & rnode_5to6_bb2_arrayidx_0_valid_out_NO_SHIFT_REG & rnode_5to6_bb2_arrayidx10_0_valid_out_NO_SHIFT_REG);
assign local_bb2_c0_exi5[207:0] = local_bb2_c0_exi415[207:0];
assign local_bb2_c0_exi5[208] = rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_NO_SHIFT_REG;
assign local_bb2_c0_exi5[255:209] = local_bb2_c0_exi415[255:209];
assign local_bb2_c0_exi5_valid_out = 1'b1;
assign rnode_5to6_bb2_notexitcond_notexit_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_exitcond48_pop8_c0_ene4_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_exitcond_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_arrayidx_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_arrayidx10_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements a registered operation.
// 
wire local_bb2_c0_exit16_c0_exi5_inputs_ready;
 reg local_bb2_c0_exit16_c0_exi5_valid_out_0_NO_SHIFT_REG;
wire local_bb2_c0_exit16_c0_exi5_stall_in_0;
 reg local_bb2_c0_exit16_c0_exi5_valid_out_1_NO_SHIFT_REG;
wire local_bb2_c0_exit16_c0_exi5_stall_in_1;
 reg [255:0] local_bb2_c0_exit16_c0_exi5_NO_SHIFT_REG;
wire [255:0] local_bb2_c0_exit16_c0_exi5_in;
wire local_bb2_c0_exit16_c0_exi5_valid;
wire local_bb2_c0_exit16_c0_exi5_causedstall;

acl_stall_free_sink local_bb2_c0_exit16_c0_exi5_instance (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_bb2_c0_exi5),
	.data_out(local_bb2_c0_exit16_c0_exi5_in),
	.input_accepted(local_bb2_c0_enter10_c0_eni4_input_accepted),
	.valid_out(local_bb2_c0_exit16_c0_exi5_valid),
	.stall_in(~(local_bb2_c0_exit16_c0_exi5_output_regs_ready)),
	.stall_entry(local_bb2_c0_exit16_c0_exi5_entry_stall),
	.valid_in(local_bb2_c0_exit16_c0_exi5_valid_in),
	.IIphases(local_bb2_c0_exit16_c0_exi5_phases),
	.inc_pipelined_thread(local_bb2_c0_enter10_c0_eni4_inc_pipelined_thread),
	.dec_pipelined_thread(local_bb2_c0_enter10_c0_eni4_dec_pipelined_thread)
);

defparam local_bb2_c0_exit16_c0_exi5_instance.DATA_WIDTH = 256;
defparam local_bb2_c0_exit16_c0_exi5_instance.PIPELINE_DEPTH = 10;
defparam local_bb2_c0_exit16_c0_exi5_instance.SHARINGII = 1;
defparam local_bb2_c0_exit16_c0_exi5_instance.SCHEDULEII = 1;
defparam local_bb2_c0_exit16_c0_exi5_instance.ALWAYS_THROTTLE = 0;

assign local_bb2_c0_exit16_c0_exi5_inputs_ready = 1'b1;
assign local_bb2_c0_exit16_c0_exi5_output_regs_ready = ((~(local_bb2_c0_exit16_c0_exi5_valid_out_0_NO_SHIFT_REG) | ~(local_bb2_c0_exit16_c0_exi5_stall_in_0)) & (~(local_bb2_c0_exit16_c0_exi5_valid_out_1_NO_SHIFT_REG) | ~(local_bb2_c0_exit16_c0_exi5_stall_in_1)));
assign local_bb2_c0_exit16_c0_exi5_valid_in = SFC_2_VALID_5_6_0_NO_SHIFT_REG;
assign local_bb2_c0_exi5_stall_in = 1'b0;
assign SFC_2_VALID_5_6_0_stall_in = 1'b0;
assign rnode_5to6_bb2_keep_going_acl_pipeline_1_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_indvars_iv_push5_indvars_iv_next_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_mul77_push7_mul77_pop7_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_mul46_push6_mul46_pop6_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb2_exitcond48_push8_exitcond48_pop8_0_stall_in_NO_SHIFT_REG = 1'b0;
assign local_bb2_c0_exit16_c0_exi5_causedstall = (1'b1 && (1'b0 && !(~(local_bb2_c0_exit16_c0_exi5_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_c0_exit16_c0_exi5_NO_SHIFT_REG <= 'x;
		local_bb2_c0_exit16_c0_exi5_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb2_c0_exit16_c0_exi5_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_c0_exit16_c0_exi5_output_regs_ready)
		begin
			local_bb2_c0_exit16_c0_exi5_NO_SHIFT_REG <= local_bb2_c0_exit16_c0_exi5_in;
			local_bb2_c0_exit16_c0_exi5_valid_out_0_NO_SHIFT_REG <= local_bb2_c0_exit16_c0_exi5_valid;
			local_bb2_c0_exit16_c0_exi5_valid_out_1_NO_SHIFT_REG <= local_bb2_c0_exit16_c0_exi5_valid;
		end
		else
		begin
			if (~(local_bb2_c0_exit16_c0_exi5_stall_in_0))
			begin
				local_bb2_c0_exit16_c0_exi5_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb2_c0_exit16_c0_exi5_stall_in_1))
			begin
				local_bb2_c0_exit16_c0_exi5_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb2_c0_exe117_valid_out;
wire local_bb2_c0_exe117_stall_in;
wire local_bb2_c0_exe117_inputs_ready;
wire local_bb2_c0_exe117_stall_local;
wire [63:0] local_bb2_c0_exe117;

assign local_bb2_c0_exe117_inputs_ready = local_bb2_c0_exit16_c0_exi5_valid_out_0_NO_SHIFT_REG;
assign local_bb2_c0_exe117 = local_bb2_c0_exit16_c0_exi5_NO_SHIFT_REG[127:64];
assign local_bb2_c0_exe117_valid_out = local_bb2_c0_exe117_inputs_ready;
assign local_bb2_c0_exe117_stall_local = local_bb2_c0_exe117_stall_in;
assign local_bb2_c0_exit16_c0_exi5_stall_in_0 = (|local_bb2_c0_exe117_stall_local);

// Register node:
//  * latency = 185
//  * capacity = 185
 logic rnode_11to196_bb2_c0_exit16_c0_exi5_0_valid_out_NO_SHIFT_REG;
 logic rnode_11to196_bb2_c0_exit16_c0_exi5_0_stall_in_NO_SHIFT_REG;
 logic [255:0] rnode_11to196_bb2_c0_exit16_c0_exi5_0_NO_SHIFT_REG;
 logic rnode_11to196_bb2_c0_exit16_c0_exi5_0_reg_196_inputs_ready_NO_SHIFT_REG;
 logic [255:0] rnode_11to196_bb2_c0_exit16_c0_exi5_0_reg_196_NO_SHIFT_REG;
 logic rnode_11to196_bb2_c0_exit16_c0_exi5_0_valid_out_reg_196_NO_SHIFT_REG;
 logic rnode_11to196_bb2_c0_exit16_c0_exi5_0_stall_in_reg_196_NO_SHIFT_REG;
 logic rnode_11to196_bb2_c0_exit16_c0_exi5_0_stall_out_reg_196_NO_SHIFT_REG;

acl_data_fifo rnode_11to196_bb2_c0_exit16_c0_exi5_0_reg_196_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_11to196_bb2_c0_exit16_c0_exi5_0_reg_196_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_11to196_bb2_c0_exit16_c0_exi5_0_stall_in_reg_196_NO_SHIFT_REG),
	.valid_out(rnode_11to196_bb2_c0_exit16_c0_exi5_0_valid_out_reg_196_NO_SHIFT_REG),
	.stall_out(rnode_11to196_bb2_c0_exit16_c0_exi5_0_stall_out_reg_196_NO_SHIFT_REG),
	.data_in(local_bb2_c0_exit16_c0_exi5_NO_SHIFT_REG),
	.data_out(rnode_11to196_bb2_c0_exit16_c0_exi5_0_reg_196_NO_SHIFT_REG)
);

defparam rnode_11to196_bb2_c0_exit16_c0_exi5_0_reg_196_fifo.DEPTH = 186;
defparam rnode_11to196_bb2_c0_exit16_c0_exi5_0_reg_196_fifo.DATA_WIDTH = 256;
defparam rnode_11to196_bb2_c0_exit16_c0_exi5_0_reg_196_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_11to196_bb2_c0_exit16_c0_exi5_0_reg_196_fifo.IMPL = "ram";

assign rnode_11to196_bb2_c0_exit16_c0_exi5_0_reg_196_inputs_ready_NO_SHIFT_REG = local_bb2_c0_exit16_c0_exi5_valid_out_1_NO_SHIFT_REG;
assign local_bb2_c0_exit16_c0_exi5_stall_in_1 = rnode_11to196_bb2_c0_exit16_c0_exi5_0_stall_out_reg_196_NO_SHIFT_REG;
assign rnode_11to196_bb2_c0_exit16_c0_exi5_0_NO_SHIFT_REG = rnode_11to196_bb2_c0_exit16_c0_exi5_0_reg_196_NO_SHIFT_REG;
assign rnode_11to196_bb2_c0_exit16_c0_exi5_0_stall_in_reg_196_NO_SHIFT_REG = rnode_11to196_bb2_c0_exit16_c0_exi5_0_stall_in_NO_SHIFT_REG;
assign rnode_11to196_bb2_c0_exit16_c0_exi5_0_valid_out_NO_SHIFT_REG = rnode_11to196_bb2_c0_exit16_c0_exi5_0_valid_out_reg_196_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb2_ld__inputs_ready;
 reg local_bb2_ld__valid_out_NO_SHIFT_REG;
wire local_bb2_ld__stall_in;
wire local_bb2_ld__output_regs_ready;
wire local_bb2_ld__fu_stall_out;
wire local_bb2_ld__fu_valid_out;
wire [15:0] local_bb2_ld__lsu_dataout;
 reg [15:0] local_bb2_ld__NO_SHIFT_REG;
wire local_bb2_ld__causedstall;

lsu_top lsu_local_bb2_ld_ (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb2_ld__fu_stall_out),
	.i_valid(local_bb2_ld__inputs_ready),
	.i_address((local_bb2_c0_exe117 & 64'hFFFFFFFFFFFFFFFE)),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(1'b0),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb2_ld__output_regs_ready)),
	.o_valid(local_bb2_ld__fu_valid_out),
	.o_readdata(local_bb2_ld__lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb2_ld__active),
	.avm_address(avm_local_bb2_ld__address),
	.avm_read(avm_local_bb2_ld__read),
	.avm_readdata(avm_local_bb2_ld__readdata),
	.avm_write(avm_local_bb2_ld__write),
	.avm_writeack(avm_local_bb2_ld__writeack),
	.avm_burstcount(avm_local_bb2_ld__burstcount),
	.avm_writedata(avm_local_bb2_ld__writedata),
	.avm_byteenable(avm_local_bb2_ld__byteenable),
	.avm_waitrequest(avm_local_bb2_ld__waitrequest),
	.avm_readdatavalid(avm_local_bb2_ld__readdatavalid),
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

defparam lsu_local_bb2_ld_.AWIDTH = 33;
defparam lsu_local_bb2_ld_.WIDTH_BYTES = 2;
defparam lsu_local_bb2_ld_.MWIDTH_BYTES = 64;
defparam lsu_local_bb2_ld_.WRITEDATAWIDTH_BYTES = 64;
defparam lsu_local_bb2_ld_.ALIGNMENT_BYTES = 2;
defparam lsu_local_bb2_ld_.READ = 1;
defparam lsu_local_bb2_ld_.ATOMIC = 0;
defparam lsu_local_bb2_ld_.WIDTH = 16;
defparam lsu_local_bb2_ld_.MWIDTH = 512;
defparam lsu_local_bb2_ld_.ATOMIC_WIDTH = 3;
defparam lsu_local_bb2_ld_.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb2_ld_.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb2_ld_.MEMORY_SIDE_MEM_LATENCY = 67;
defparam lsu_local_bb2_ld_.USE_WRITE_ACK = 0;
defparam lsu_local_bb2_ld_.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb2_ld_.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb2_ld_.NUMBER_BANKS = 1;
defparam lsu_local_bb2_ld_.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb2_ld_.INTENDED_DEVICE_FAMILY = "Stratix V";
defparam lsu_local_bb2_ld_.USEINPUTFIFO = 0;
defparam lsu_local_bb2_ld_.USECACHING = 1;
defparam lsu_local_bb2_ld_.CACHESIZE = 1024;
defparam lsu_local_bb2_ld_.USEOUTPUTFIFO = 1;
defparam lsu_local_bb2_ld_.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb2_ld_.HIGH_FMAX = 1;
defparam lsu_local_bb2_ld_.ADDRSPACE = 1;
defparam lsu_local_bb2_ld_.STYLE = "BURST-COALESCED";

assign local_bb2_ld__inputs_ready = local_bb2_c0_exe117_valid_out;
assign local_bb2_ld__output_regs_ready = (&(~(local_bb2_ld__valid_out_NO_SHIFT_REG) | ~(local_bb2_ld__stall_in)));
assign local_bb2_c0_exe117_stall_in = (local_bb2_ld__fu_stall_out | ~(local_bb2_ld__inputs_ready));
assign local_bb2_ld__causedstall = (local_bb2_ld__inputs_ready && (local_bb2_ld__fu_stall_out && !(~(local_bb2_ld__output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_ld__NO_SHIFT_REG <= 'x;
		local_bb2_ld__valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_ld__output_regs_ready)
		begin
			local_bb2_ld__NO_SHIFT_REG <= local_bb2_ld__lsu_dataout;
			local_bb2_ld__valid_out_NO_SHIFT_REG <= local_bb2_ld__fu_valid_out;
		end
		else
		begin
			if (~(local_bb2_ld__stall_in))
			begin
				local_bb2_ld__valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_196to197_bb2_c0_exit16_c0_exi5_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_in_0_NO_SHIFT_REG;
 logic [255:0] rnode_196to197_bb2_c0_exit16_c0_exi5_0_NO_SHIFT_REG;
 logic rnode_196to197_bb2_c0_exit16_c0_exi5_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_in_1_NO_SHIFT_REG;
 logic [255:0] rnode_196to197_bb2_c0_exit16_c0_exi5_1_NO_SHIFT_REG;
 logic rnode_196to197_bb2_c0_exit16_c0_exi5_0_reg_197_inputs_ready_NO_SHIFT_REG;
 logic [255:0] rnode_196to197_bb2_c0_exit16_c0_exi5_0_reg_197_NO_SHIFT_REG;
 logic rnode_196to197_bb2_c0_exit16_c0_exi5_0_valid_out_0_reg_197_NO_SHIFT_REG;
 logic rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_in_0_reg_197_NO_SHIFT_REG;
 logic rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_out_reg_197_NO_SHIFT_REG;
 reg rnode_196to197_bb2_c0_exit16_c0_exi5_0_consumed_0_NO_SHIFT_REG;
 reg rnode_196to197_bb2_c0_exit16_c0_exi5_0_consumed_1_NO_SHIFT_REG;

acl_data_fifo rnode_196to197_bb2_c0_exit16_c0_exi5_0_reg_197_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_196to197_bb2_c0_exit16_c0_exi5_0_reg_197_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_in_0_reg_197_NO_SHIFT_REG),
	.valid_out(rnode_196to197_bb2_c0_exit16_c0_exi5_0_valid_out_0_reg_197_NO_SHIFT_REG),
	.stall_out(rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_out_reg_197_NO_SHIFT_REG),
	.data_in(rnode_11to196_bb2_c0_exit16_c0_exi5_0_NO_SHIFT_REG),
	.data_out(rnode_196to197_bb2_c0_exit16_c0_exi5_0_reg_197_NO_SHIFT_REG)
);

defparam rnode_196to197_bb2_c0_exit16_c0_exi5_0_reg_197_fifo.DEPTH = 2;
defparam rnode_196to197_bb2_c0_exit16_c0_exi5_0_reg_197_fifo.DATA_WIDTH = 256;
defparam rnode_196to197_bb2_c0_exit16_c0_exi5_0_reg_197_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_196to197_bb2_c0_exit16_c0_exi5_0_reg_197_fifo.IMPL = "ll_reg";

assign rnode_196to197_bb2_c0_exit16_c0_exi5_0_reg_197_inputs_ready_NO_SHIFT_REG = rnode_11to196_bb2_c0_exit16_c0_exi5_0_valid_out_NO_SHIFT_REG;
assign rnode_11to196_bb2_c0_exit16_c0_exi5_0_stall_in_NO_SHIFT_REG = rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_out_reg_197_NO_SHIFT_REG;
assign rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_in_0_reg_197_NO_SHIFT_REG = ((rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_in_0_NO_SHIFT_REG & ~(rnode_196to197_bb2_c0_exit16_c0_exi5_0_consumed_0_NO_SHIFT_REG)) | (rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_in_1_NO_SHIFT_REG & ~(rnode_196to197_bb2_c0_exit16_c0_exi5_0_consumed_1_NO_SHIFT_REG)));
assign rnode_196to197_bb2_c0_exit16_c0_exi5_0_valid_out_0_NO_SHIFT_REG = (rnode_196to197_bb2_c0_exit16_c0_exi5_0_valid_out_0_reg_197_NO_SHIFT_REG & ~(rnode_196to197_bb2_c0_exit16_c0_exi5_0_consumed_0_NO_SHIFT_REG));
assign rnode_196to197_bb2_c0_exit16_c0_exi5_0_valid_out_1_NO_SHIFT_REG = (rnode_196to197_bb2_c0_exit16_c0_exi5_0_valid_out_0_reg_197_NO_SHIFT_REG & ~(rnode_196to197_bb2_c0_exit16_c0_exi5_0_consumed_1_NO_SHIFT_REG));
assign rnode_196to197_bb2_c0_exit16_c0_exi5_0_NO_SHIFT_REG = rnode_196to197_bb2_c0_exit16_c0_exi5_0_reg_197_NO_SHIFT_REG;
assign rnode_196to197_bb2_c0_exit16_c0_exi5_1_NO_SHIFT_REG = rnode_196to197_bb2_c0_exit16_c0_exi5_0_reg_197_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rnode_196to197_bb2_c0_exit16_c0_exi5_0_consumed_0_NO_SHIFT_REG <= 1'b0;
		rnode_196to197_bb2_c0_exit16_c0_exi5_0_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rnode_196to197_bb2_c0_exit16_c0_exi5_0_consumed_0_NO_SHIFT_REG <= (rnode_196to197_bb2_c0_exit16_c0_exi5_0_valid_out_0_reg_197_NO_SHIFT_REG & (rnode_196to197_bb2_c0_exit16_c0_exi5_0_consumed_0_NO_SHIFT_REG | ~(rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_in_0_NO_SHIFT_REG)) & rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_in_0_reg_197_NO_SHIFT_REG);
		rnode_196to197_bb2_c0_exit16_c0_exi5_0_consumed_1_NO_SHIFT_REG <= (rnode_196to197_bb2_c0_exit16_c0_exi5_0_valid_out_0_reg_197_NO_SHIFT_REG & (rnode_196to197_bb2_c0_exit16_c0_exi5_0_consumed_1_NO_SHIFT_REG | ~(rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_in_1_NO_SHIFT_REG)) & rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_in_0_reg_197_NO_SHIFT_REG);
	end
end


// This section implements a staging register.
// 
wire rstag_171to171_bb2_ld__valid_out;
wire rstag_171to171_bb2_ld__stall_in;
wire rstag_171to171_bb2_ld__inputs_ready;
wire rstag_171to171_bb2_ld__stall_local;
 reg rstag_171to171_bb2_ld__staging_valid_NO_SHIFT_REG;
wire rstag_171to171_bb2_ld__combined_valid;
 reg [15:0] rstag_171to171_bb2_ld__staging_reg_NO_SHIFT_REG;
wire [15:0] rstag_171to171_bb2_ld_;

assign rstag_171to171_bb2_ld__inputs_ready = local_bb2_ld__valid_out_NO_SHIFT_REG;
assign rstag_171to171_bb2_ld_ = (rstag_171to171_bb2_ld__staging_valid_NO_SHIFT_REG ? rstag_171to171_bb2_ld__staging_reg_NO_SHIFT_REG : local_bb2_ld__NO_SHIFT_REG);
assign rstag_171to171_bb2_ld__combined_valid = (rstag_171to171_bb2_ld__staging_valid_NO_SHIFT_REG | rstag_171to171_bb2_ld__inputs_ready);
assign rstag_171to171_bb2_ld__valid_out = rstag_171to171_bb2_ld__combined_valid;
assign rstag_171to171_bb2_ld__stall_local = rstag_171to171_bb2_ld__stall_in;
assign local_bb2_ld__stall_in = (|rstag_171to171_bb2_ld__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_171to171_bb2_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_171to171_bb2_ld__staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_171to171_bb2_ld__stall_local)
		begin
			if (~(rstag_171to171_bb2_ld__staging_valid_NO_SHIFT_REG))
			begin
				rstag_171to171_bb2_ld__staging_valid_NO_SHIFT_REG <= rstag_171to171_bb2_ld__inputs_ready;
			end
		end
		else
		begin
			rstag_171to171_bb2_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_171to171_bb2_ld__staging_valid_NO_SHIFT_REG))
		begin
			rstag_171to171_bb2_ld__staging_reg_NO_SHIFT_REG <= local_bb2_ld__NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb2_c0_exe218_valid_out;
wire local_bb2_c0_exe218_stall_in;
wire local_bb2_c0_exe218_inputs_ready;
wire local_bb2_c0_exe218_stall_local;
wire [63:0] local_bb2_c0_exe218;

assign local_bb2_c0_exe218_inputs_ready = rnode_196to197_bb2_c0_exit16_c0_exi5_0_valid_out_0_NO_SHIFT_REG;
assign local_bb2_c0_exe218 = rnode_196to197_bb2_c0_exit16_c0_exi5_0_NO_SHIFT_REG[191:128];
assign local_bb2_c0_exe218_valid_out = local_bb2_c0_exe218_inputs_ready;
assign local_bb2_c0_exe218_stall_local = local_bb2_c0_exe218_stall_in;
assign rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_in_0_NO_SHIFT_REG = (|local_bb2_c0_exe218_stall_local);

// Register node:
//  * latency = 4
//  * capacity = 4
 logic rnode_197to201_bb2_c0_exit16_c0_exi5_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_197to201_bb2_c0_exit16_c0_exi5_0_stall_in_0_NO_SHIFT_REG;
 logic [255:0] rnode_197to201_bb2_c0_exit16_c0_exi5_0_NO_SHIFT_REG;
 logic rnode_197to201_bb2_c0_exit16_c0_exi5_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_197to201_bb2_c0_exit16_c0_exi5_0_stall_in_1_NO_SHIFT_REG;
 logic [255:0] rnode_197to201_bb2_c0_exit16_c0_exi5_1_NO_SHIFT_REG;
 logic rnode_197to201_bb2_c0_exit16_c0_exi5_0_reg_201_inputs_ready_NO_SHIFT_REG;
 logic [255:0] rnode_197to201_bb2_c0_exit16_c0_exi5_0_reg_201_NO_SHIFT_REG;
 logic rnode_197to201_bb2_c0_exit16_c0_exi5_0_valid_out_0_reg_201_NO_SHIFT_REG;
 logic rnode_197to201_bb2_c0_exit16_c0_exi5_0_stall_in_0_reg_201_NO_SHIFT_REG;
 logic rnode_197to201_bb2_c0_exit16_c0_exi5_0_stall_out_reg_201_NO_SHIFT_REG;

acl_data_fifo rnode_197to201_bb2_c0_exit16_c0_exi5_0_reg_201_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_197to201_bb2_c0_exit16_c0_exi5_0_reg_201_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_197to201_bb2_c0_exit16_c0_exi5_0_stall_in_0_reg_201_NO_SHIFT_REG),
	.valid_out(rnode_197to201_bb2_c0_exit16_c0_exi5_0_valid_out_0_reg_201_NO_SHIFT_REG),
	.stall_out(rnode_197to201_bb2_c0_exit16_c0_exi5_0_stall_out_reg_201_NO_SHIFT_REG),
	.data_in(rnode_196to197_bb2_c0_exit16_c0_exi5_1_NO_SHIFT_REG),
	.data_out(rnode_197to201_bb2_c0_exit16_c0_exi5_0_reg_201_NO_SHIFT_REG)
);

defparam rnode_197to201_bb2_c0_exit16_c0_exi5_0_reg_201_fifo.DEPTH = 5;
defparam rnode_197to201_bb2_c0_exit16_c0_exi5_0_reg_201_fifo.DATA_WIDTH = 256;
defparam rnode_197to201_bb2_c0_exit16_c0_exi5_0_reg_201_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_197to201_bb2_c0_exit16_c0_exi5_0_reg_201_fifo.IMPL = "ll_reg";

assign rnode_197to201_bb2_c0_exit16_c0_exi5_0_reg_201_inputs_ready_NO_SHIFT_REG = rnode_196to197_bb2_c0_exit16_c0_exi5_0_valid_out_1_NO_SHIFT_REG;
assign rnode_196to197_bb2_c0_exit16_c0_exi5_0_stall_in_1_NO_SHIFT_REG = rnode_197to201_bb2_c0_exit16_c0_exi5_0_stall_out_reg_201_NO_SHIFT_REG;
assign rnode_197to201_bb2_c0_exit16_c0_exi5_0_stall_in_0_reg_201_NO_SHIFT_REG = (rnode_197to201_bb2_c0_exit16_c0_exi5_0_stall_in_0_NO_SHIFT_REG | rnode_197to201_bb2_c0_exit16_c0_exi5_0_stall_in_1_NO_SHIFT_REG);
assign rnode_197to201_bb2_c0_exit16_c0_exi5_0_valid_out_0_NO_SHIFT_REG = rnode_197to201_bb2_c0_exit16_c0_exi5_0_valid_out_0_reg_201_NO_SHIFT_REG;
assign rnode_197to201_bb2_c0_exit16_c0_exi5_0_valid_out_1_NO_SHIFT_REG = rnode_197to201_bb2_c0_exit16_c0_exi5_0_valid_out_0_reg_201_NO_SHIFT_REG;
assign rnode_197to201_bb2_c0_exit16_c0_exi5_0_NO_SHIFT_REG = rnode_197to201_bb2_c0_exit16_c0_exi5_0_reg_201_NO_SHIFT_REG;
assign rnode_197to201_bb2_c0_exit16_c0_exi5_1_NO_SHIFT_REG = rnode_197to201_bb2_c0_exit16_c0_exi5_0_reg_201_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb2_c1_eni1_valid_out;
wire local_bb2_c1_eni1_stall_in;
wire local_bb2_c1_eni1_inputs_ready;
wire local_bb2_c1_eni1_stall_local;
wire [31:0] local_bb2_c1_eni1;

assign local_bb2_c1_eni1_inputs_ready = rstag_171to171_bb2_ld__valid_out;
assign local_bb2_c1_eni1[15:0] = 16'bx;
assign local_bb2_c1_eni1[31:16] = rstag_171to171_bb2_ld_;
assign local_bb2_c1_eni1_valid_out = local_bb2_c1_eni1_inputs_ready;
assign local_bb2_c1_eni1_stall_local = local_bb2_c1_eni1_stall_in;
assign rstag_171to171_bb2_ld__stall_in = (|local_bb2_c1_eni1_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb2_c0_exe319_valid_out;
wire local_bb2_c0_exe319_stall_in;
wire local_bb2_c0_exe319_inputs_ready;
wire local_bb2_c0_exe319_stall_local;
wire local_bb2_c0_exe319;

assign local_bb2_c0_exe319_inputs_ready = rnode_197to201_bb2_c0_exit16_c0_exi5_0_valid_out_0_NO_SHIFT_REG;
assign local_bb2_c0_exe319 = rnode_197to201_bb2_c0_exit16_c0_exi5_0_NO_SHIFT_REG[192];
assign local_bb2_c0_exe319_valid_out = local_bb2_c0_exe319_inputs_ready;
assign local_bb2_c0_exe319_stall_local = local_bb2_c0_exe319_stall_in;
assign rnode_197to201_bb2_c0_exit16_c0_exi5_0_stall_in_0_NO_SHIFT_REG = (|local_bb2_c0_exe319_stall_local);

// This section implements a registered operation.
// 
wire local_bb2_c1_enter_c1_eni1_inputs_ready;
 reg local_bb2_c1_enter_c1_eni1_valid_out_0_NO_SHIFT_REG;
wire local_bb2_c1_enter_c1_eni1_stall_in_0;
 reg local_bb2_c1_enter_c1_eni1_valid_out_1_NO_SHIFT_REG;
wire local_bb2_c1_enter_c1_eni1_stall_in_1;
wire local_bb2_c1_enter_c1_eni1_output_regs_ready;
 reg [31:0] local_bb2_c1_enter_c1_eni1_NO_SHIFT_REG;
wire local_bb2_c1_enter_c1_eni1_input_accepted;
 reg local_bb2_c1_enter_c1_eni1_valid_bit_NO_SHIFT_REG;
wire local_bb2_c1_exit_c1_exi1_entry_stall;
wire local_bb2_c1_exit_c1_exi1_output_regs_ready;
wire [21:0] local_bb2_c1_exit_c1_exi1_valid_bits;
wire local_bb2_c1_exit_c1_exi1_valid_in;
wire local_bb2_c1_exit_c1_exi1_phases;
wire local_bb2_c1_enter_c1_eni1_inc_pipelined_thread;
wire local_bb2_c1_enter_c1_eni1_dec_pipelined_thread;
wire local_bb2_c1_enter_c1_eni1_causedstall;

assign local_bb2_c1_enter_c1_eni1_inputs_ready = local_bb2_c1_eni1_valid_out;
assign local_bb2_c1_enter_c1_eni1_output_regs_ready = 1'b1;
assign local_bb2_c1_enter_c1_eni1_input_accepted = (local_bb2_c1_enter_c1_eni1_inputs_ready && !(local_bb2_c1_exit_c1_exi1_entry_stall));
assign local_bb2_c1_enter_c1_eni1_inc_pipelined_thread = 1'b1;
assign local_bb2_c1_enter_c1_eni1_dec_pipelined_thread = ~(1'b0);
assign local_bb2_c1_eni1_stall_in = ((~(local_bb2_c1_enter_c1_eni1_inputs_ready) | local_bb2_c1_exit_c1_exi1_entry_stall) | ~(1'b1));
assign local_bb2_c1_enter_c1_eni1_causedstall = (1'b1 && ((~(local_bb2_c1_enter_c1_eni1_inputs_ready) | local_bb2_c1_exit_c1_exi1_entry_stall) && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_c1_enter_c1_eni1_valid_bit_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb2_c1_enter_c1_eni1_valid_bit_NO_SHIFT_REG <= local_bb2_c1_enter_c1_eni1_input_accepted;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_c1_enter_c1_eni1_NO_SHIFT_REG <= 'x;
		local_bb2_c1_enter_c1_eni1_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb2_c1_enter_c1_eni1_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_c1_enter_c1_eni1_output_regs_ready)
		begin
			local_bb2_c1_enter_c1_eni1_NO_SHIFT_REG <= local_bb2_c1_eni1;
			local_bb2_c1_enter_c1_eni1_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb2_c1_enter_c1_eni1_valid_out_1_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb2_c1_enter_c1_eni1_stall_in_0))
			begin
				local_bb2_c1_enter_c1_eni1_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb2_c1_enter_c1_eni1_stall_in_1))
			begin
				local_bb2_c1_enter_c1_eni1_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb2_c1_ene1_stall_local;
wire [15:0] local_bb2_c1_ene1;

assign local_bb2_c1_ene1 = local_bb2_c1_enter_c1_eni1_NO_SHIFT_REG[31:16];

// This section implements an unregistered operation.
// 
wire SFC_3_VALID_172_172_0_valid_out;
wire SFC_3_VALID_172_172_0_stall_in;
wire SFC_3_VALID_172_172_0_inputs_ready;
wire SFC_3_VALID_172_172_0_stall_local;
wire SFC_3_VALID_172_172_0;

assign SFC_3_VALID_172_172_0_inputs_ready = local_bb2_c1_enter_c1_eni1_valid_out_1_NO_SHIFT_REG;
assign SFC_3_VALID_172_172_0 = local_bb2_c1_enter_c1_eni1_valid_bit_NO_SHIFT_REG;
assign SFC_3_VALID_172_172_0_valid_out = 1'b1;
assign local_bb2_c1_enter_c1_eni1_stall_in_1 = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb2_conv_valid_out;
wire local_bb2_conv_stall_in;
wire local_bb2_conv_inputs_ready;
wire local_bb2_conv_stall_local;
wire [31:0] local_bb2_conv;

assign local_bb2_conv_inputs_ready = local_bb2_c1_enter_c1_eni1_valid_out_0_NO_SHIFT_REG;
assign local_bb2_conv[31:16] = 16'h0;
assign local_bb2_conv[15:0] = local_bb2_c1_ene1;
assign local_bb2_conv_valid_out = 1'b1;
assign local_bb2_c1_enter_c1_eni1_stall_in_0 = 1'b0;

// This section implements a registered operation.
// 
wire SFC_3_VALID_172_173_0_inputs_ready;
 reg SFC_3_VALID_172_173_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_172_173_0_stall_in;
wire SFC_3_VALID_172_173_0_output_regs_ready;
 reg SFC_3_VALID_172_173_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_172_173_0_causedstall;

assign SFC_3_VALID_172_173_0_inputs_ready = 1'b1;
assign SFC_3_VALID_172_173_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_172_172_0_stall_in = 1'b0;
assign SFC_3_VALID_172_173_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_172_173_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_172_173_0_output_regs_ready)
		begin
			SFC_3_VALID_172_173_0_NO_SHIFT_REG <= SFC_3_VALID_172_172_0;
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb2_conv6_inputs_ready;
 reg local_bb2_conv6_valid_out_NO_SHIFT_REG;
wire local_bb2_conv6_stall_in;
wire local_bb2_conv6_output_regs_ready;
wire [31:0] local_bb2_conv6;
 reg local_bb2_conv6_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb2_conv6_valid_pipe_1_NO_SHIFT_REG;
 reg local_bb2_conv6_valid_pipe_2_NO_SHIFT_REG;
 reg local_bb2_conv6_valid_pipe_3_NO_SHIFT_REG;
 reg local_bb2_conv6_valid_pipe_4_NO_SHIFT_REG;
wire local_bb2_conv6_causedstall;

acl_fp_sitofp fp_module_local_bb2_conv6 (
	.clock(clock),
	.dataa((local_bb2_conv & 32'hFFFF)),
	.enable(local_bb2_conv6_output_regs_ready),
	.result(local_bb2_conv6)
);


assign local_bb2_conv6_inputs_ready = 1'b1;
assign local_bb2_conv6_output_regs_ready = 1'b1;
assign local_bb2_conv_stall_in = 1'b0;
assign local_bb2_conv6_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_conv6_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb2_conv6_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
		local_bb2_conv6_valid_pipe_2_NO_SHIFT_REG <= 1'b0;
		local_bb2_conv6_valid_pipe_3_NO_SHIFT_REG <= 1'b0;
		local_bb2_conv6_valid_pipe_4_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_conv6_output_regs_ready)
		begin
			local_bb2_conv6_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb2_conv6_valid_pipe_1_NO_SHIFT_REG <= local_bb2_conv6_valid_pipe_0_NO_SHIFT_REG;
			local_bb2_conv6_valid_pipe_2_NO_SHIFT_REG <= local_bb2_conv6_valid_pipe_1_NO_SHIFT_REG;
			local_bb2_conv6_valid_pipe_3_NO_SHIFT_REG <= local_bb2_conv6_valid_pipe_2_NO_SHIFT_REG;
			local_bb2_conv6_valid_pipe_4_NO_SHIFT_REG <= local_bb2_conv6_valid_pipe_3_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_conv6_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_conv6_output_regs_ready)
		begin
			local_bb2_conv6_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb2_conv6_stall_in))
			begin
				local_bb2_conv6_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_173_174_0_inputs_ready;
 reg SFC_3_VALID_173_174_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_173_174_0_stall_in;
wire SFC_3_VALID_173_174_0_output_regs_ready;
 reg SFC_3_VALID_173_174_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_173_174_0_causedstall;

assign SFC_3_VALID_173_174_0_inputs_ready = 1'b1;
assign SFC_3_VALID_173_174_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_172_173_0_stall_in = 1'b0;
assign SFC_3_VALID_173_174_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_173_174_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_173_174_0_output_regs_ready)
		begin
			SFC_3_VALID_173_174_0_NO_SHIFT_REG <= SFC_3_VALID_172_173_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb2_div_inputs_ready;
 reg local_bb2_div_valid_out_NO_SHIFT_REG;
wire local_bb2_div_stall_in;
wire local_bb2_div_output_regs_ready;
wire [31:0] local_bb2_div;
 reg local_bb2_div_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb2_div_valid_pipe_1_NO_SHIFT_REG;
 reg local_bb2_div_valid_pipe_2_NO_SHIFT_REG;
 reg local_bb2_div_valid_pipe_3_NO_SHIFT_REG;
 reg local_bb2_div_valid_pipe_4_NO_SHIFT_REG;
 reg local_bb2_div_valid_pipe_5_NO_SHIFT_REG;
 reg local_bb2_div_valid_pipe_6_NO_SHIFT_REG;
 reg local_bb2_div_valid_pipe_7_NO_SHIFT_REG;
 reg local_bb2_div_valid_pipe_8_NO_SHIFT_REG;
 reg local_bb2_div_valid_pipe_9_NO_SHIFT_REG;
 reg local_bb2_div_valid_pipe_10_NO_SHIFT_REG;
 reg local_bb2_div_valid_pipe_11_NO_SHIFT_REG;
 reg local_bb2_div_valid_pipe_12_NO_SHIFT_REG;
wire local_bb2_div_causedstall;

acl_fp_div_s5 fp_module_local_bb2_div (
	.clock(clock),
	.dataa(local_bb2_conv6),
	.datab(32'h447A0000),
	.enable(local_bb2_div_output_regs_ready),
	.result(local_bb2_div)
);


assign local_bb2_div_inputs_ready = 1'b1;
assign local_bb2_div_output_regs_ready = 1'b1;
assign local_bb2_conv6_stall_in = 1'b0;
assign local_bb2_div_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_div_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb2_div_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
		local_bb2_div_valid_pipe_2_NO_SHIFT_REG <= 1'b0;
		local_bb2_div_valid_pipe_3_NO_SHIFT_REG <= 1'b0;
		local_bb2_div_valid_pipe_4_NO_SHIFT_REG <= 1'b0;
		local_bb2_div_valid_pipe_5_NO_SHIFT_REG <= 1'b0;
		local_bb2_div_valid_pipe_6_NO_SHIFT_REG <= 1'b0;
		local_bb2_div_valid_pipe_7_NO_SHIFT_REG <= 1'b0;
		local_bb2_div_valid_pipe_8_NO_SHIFT_REG <= 1'b0;
		local_bb2_div_valid_pipe_9_NO_SHIFT_REG <= 1'b0;
		local_bb2_div_valid_pipe_10_NO_SHIFT_REG <= 1'b0;
		local_bb2_div_valid_pipe_11_NO_SHIFT_REG <= 1'b0;
		local_bb2_div_valid_pipe_12_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_div_output_regs_ready)
		begin
			local_bb2_div_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb2_div_valid_pipe_1_NO_SHIFT_REG <= local_bb2_div_valid_pipe_0_NO_SHIFT_REG;
			local_bb2_div_valid_pipe_2_NO_SHIFT_REG <= local_bb2_div_valid_pipe_1_NO_SHIFT_REG;
			local_bb2_div_valid_pipe_3_NO_SHIFT_REG <= local_bb2_div_valid_pipe_2_NO_SHIFT_REG;
			local_bb2_div_valid_pipe_4_NO_SHIFT_REG <= local_bb2_div_valid_pipe_3_NO_SHIFT_REG;
			local_bb2_div_valid_pipe_5_NO_SHIFT_REG <= local_bb2_div_valid_pipe_4_NO_SHIFT_REG;
			local_bb2_div_valid_pipe_6_NO_SHIFT_REG <= local_bb2_div_valid_pipe_5_NO_SHIFT_REG;
			local_bb2_div_valid_pipe_7_NO_SHIFT_REG <= local_bb2_div_valid_pipe_6_NO_SHIFT_REG;
			local_bb2_div_valid_pipe_8_NO_SHIFT_REG <= local_bb2_div_valid_pipe_7_NO_SHIFT_REG;
			local_bb2_div_valid_pipe_9_NO_SHIFT_REG <= local_bb2_div_valid_pipe_8_NO_SHIFT_REG;
			local_bb2_div_valid_pipe_10_NO_SHIFT_REG <= local_bb2_div_valid_pipe_9_NO_SHIFT_REG;
			local_bb2_div_valid_pipe_11_NO_SHIFT_REG <= local_bb2_div_valid_pipe_10_NO_SHIFT_REG;
			local_bb2_div_valid_pipe_12_NO_SHIFT_REG <= local_bb2_div_valid_pipe_11_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_div_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_div_output_regs_ready)
		begin
			local_bb2_div_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb2_div_stall_in))
			begin
				local_bb2_div_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_174_175_0_inputs_ready;
 reg SFC_3_VALID_174_175_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_174_175_0_stall_in;
wire SFC_3_VALID_174_175_0_output_regs_ready;
 reg SFC_3_VALID_174_175_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_174_175_0_causedstall;

assign SFC_3_VALID_174_175_0_inputs_ready = 1'b1;
assign SFC_3_VALID_174_175_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_173_174_0_stall_in = 1'b0;
assign SFC_3_VALID_174_175_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_174_175_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_174_175_0_output_regs_ready)
		begin
			SFC_3_VALID_174_175_0_NO_SHIFT_REG <= SFC_3_VALID_173_174_0_NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb2_c1_exi1_valid_out;
wire local_bb2_c1_exi1_stall_in;
wire local_bb2_c1_exi1_inputs_ready;
wire local_bb2_c1_exi1_stall_local;
wire [63:0] local_bb2_c1_exi1;

assign local_bb2_c1_exi1_inputs_ready = local_bb2_div_valid_out_NO_SHIFT_REG;
assign local_bb2_c1_exi1[31:0] = 32'bx;
assign local_bb2_c1_exi1[63:32] = local_bb2_div;
assign local_bb2_c1_exi1_valid_out = 1'b1;
assign local_bb2_div_stall_in = 1'b0;

// This section implements a registered operation.
// 
wire SFC_3_VALID_175_176_0_inputs_ready;
 reg SFC_3_VALID_175_176_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_175_176_0_stall_in;
wire SFC_3_VALID_175_176_0_output_regs_ready;
 reg SFC_3_VALID_175_176_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_175_176_0_causedstall;

assign SFC_3_VALID_175_176_0_inputs_ready = 1'b1;
assign SFC_3_VALID_175_176_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_174_175_0_stall_in = 1'b0;
assign SFC_3_VALID_175_176_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_175_176_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_175_176_0_output_regs_ready)
		begin
			SFC_3_VALID_175_176_0_NO_SHIFT_REG <= SFC_3_VALID_174_175_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_176_177_0_inputs_ready;
 reg SFC_3_VALID_176_177_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_176_177_0_stall_in;
wire SFC_3_VALID_176_177_0_output_regs_ready;
 reg SFC_3_VALID_176_177_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_176_177_0_causedstall;

assign SFC_3_VALID_176_177_0_inputs_ready = 1'b1;
assign SFC_3_VALID_176_177_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_175_176_0_stall_in = 1'b0;
assign SFC_3_VALID_176_177_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_176_177_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_176_177_0_output_regs_ready)
		begin
			SFC_3_VALID_176_177_0_NO_SHIFT_REG <= SFC_3_VALID_175_176_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_177_178_0_inputs_ready;
 reg SFC_3_VALID_177_178_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_177_178_0_stall_in;
wire SFC_3_VALID_177_178_0_output_regs_ready;
 reg SFC_3_VALID_177_178_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_177_178_0_causedstall;

assign SFC_3_VALID_177_178_0_inputs_ready = 1'b1;
assign SFC_3_VALID_177_178_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_176_177_0_stall_in = 1'b0;
assign SFC_3_VALID_177_178_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_177_178_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_177_178_0_output_regs_ready)
		begin
			SFC_3_VALID_177_178_0_NO_SHIFT_REG <= SFC_3_VALID_176_177_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_178_179_0_inputs_ready;
 reg SFC_3_VALID_178_179_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_178_179_0_stall_in;
wire SFC_3_VALID_178_179_0_output_regs_ready;
 reg SFC_3_VALID_178_179_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_178_179_0_causedstall;

assign SFC_3_VALID_178_179_0_inputs_ready = 1'b1;
assign SFC_3_VALID_178_179_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_177_178_0_stall_in = 1'b0;
assign SFC_3_VALID_178_179_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_178_179_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_178_179_0_output_regs_ready)
		begin
			SFC_3_VALID_178_179_0_NO_SHIFT_REG <= SFC_3_VALID_177_178_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_179_180_0_inputs_ready;
 reg SFC_3_VALID_179_180_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_179_180_0_stall_in;
wire SFC_3_VALID_179_180_0_output_regs_ready;
 reg SFC_3_VALID_179_180_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_179_180_0_causedstall;

assign SFC_3_VALID_179_180_0_inputs_ready = 1'b1;
assign SFC_3_VALID_179_180_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_178_179_0_stall_in = 1'b0;
assign SFC_3_VALID_179_180_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_179_180_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_179_180_0_output_regs_ready)
		begin
			SFC_3_VALID_179_180_0_NO_SHIFT_REG <= SFC_3_VALID_178_179_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_180_181_0_inputs_ready;
 reg SFC_3_VALID_180_181_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_180_181_0_stall_in;
wire SFC_3_VALID_180_181_0_output_regs_ready;
 reg SFC_3_VALID_180_181_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_180_181_0_causedstall;

assign SFC_3_VALID_180_181_0_inputs_ready = 1'b1;
assign SFC_3_VALID_180_181_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_179_180_0_stall_in = 1'b0;
assign SFC_3_VALID_180_181_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_180_181_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_180_181_0_output_regs_ready)
		begin
			SFC_3_VALID_180_181_0_NO_SHIFT_REG <= SFC_3_VALID_179_180_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_181_182_0_inputs_ready;
 reg SFC_3_VALID_181_182_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_181_182_0_stall_in;
wire SFC_3_VALID_181_182_0_output_regs_ready;
 reg SFC_3_VALID_181_182_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_181_182_0_causedstall;

assign SFC_3_VALID_181_182_0_inputs_ready = 1'b1;
assign SFC_3_VALID_181_182_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_180_181_0_stall_in = 1'b0;
assign SFC_3_VALID_181_182_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_181_182_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_181_182_0_output_regs_ready)
		begin
			SFC_3_VALID_181_182_0_NO_SHIFT_REG <= SFC_3_VALID_180_181_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_182_183_0_inputs_ready;
 reg SFC_3_VALID_182_183_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_182_183_0_stall_in;
wire SFC_3_VALID_182_183_0_output_regs_ready;
 reg SFC_3_VALID_182_183_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_182_183_0_causedstall;

assign SFC_3_VALID_182_183_0_inputs_ready = 1'b1;
assign SFC_3_VALID_182_183_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_181_182_0_stall_in = 1'b0;
assign SFC_3_VALID_182_183_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_182_183_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_182_183_0_output_regs_ready)
		begin
			SFC_3_VALID_182_183_0_NO_SHIFT_REG <= SFC_3_VALID_181_182_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_183_184_0_inputs_ready;
 reg SFC_3_VALID_183_184_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_183_184_0_stall_in;
wire SFC_3_VALID_183_184_0_output_regs_ready;
 reg SFC_3_VALID_183_184_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_183_184_0_causedstall;

assign SFC_3_VALID_183_184_0_inputs_ready = 1'b1;
assign SFC_3_VALID_183_184_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_182_183_0_stall_in = 1'b0;
assign SFC_3_VALID_183_184_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_183_184_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_183_184_0_output_regs_ready)
		begin
			SFC_3_VALID_183_184_0_NO_SHIFT_REG <= SFC_3_VALID_182_183_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_184_185_0_inputs_ready;
 reg SFC_3_VALID_184_185_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_184_185_0_stall_in;
wire SFC_3_VALID_184_185_0_output_regs_ready;
 reg SFC_3_VALID_184_185_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_184_185_0_causedstall;

assign SFC_3_VALID_184_185_0_inputs_ready = 1'b1;
assign SFC_3_VALID_184_185_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_183_184_0_stall_in = 1'b0;
assign SFC_3_VALID_184_185_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_184_185_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_184_185_0_output_regs_ready)
		begin
			SFC_3_VALID_184_185_0_NO_SHIFT_REG <= SFC_3_VALID_183_184_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_185_186_0_inputs_ready;
 reg SFC_3_VALID_185_186_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_185_186_0_stall_in;
wire SFC_3_VALID_185_186_0_output_regs_ready;
 reg SFC_3_VALID_185_186_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_185_186_0_causedstall;

assign SFC_3_VALID_185_186_0_inputs_ready = 1'b1;
assign SFC_3_VALID_185_186_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_184_185_0_stall_in = 1'b0;
assign SFC_3_VALID_185_186_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_185_186_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_185_186_0_output_regs_ready)
		begin
			SFC_3_VALID_185_186_0_NO_SHIFT_REG <= SFC_3_VALID_184_185_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_186_187_0_inputs_ready;
 reg SFC_3_VALID_186_187_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_186_187_0_stall_in;
wire SFC_3_VALID_186_187_0_output_regs_ready;
 reg SFC_3_VALID_186_187_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_186_187_0_causedstall;

assign SFC_3_VALID_186_187_0_inputs_ready = 1'b1;
assign SFC_3_VALID_186_187_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_185_186_0_stall_in = 1'b0;
assign SFC_3_VALID_186_187_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_186_187_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_186_187_0_output_regs_ready)
		begin
			SFC_3_VALID_186_187_0_NO_SHIFT_REG <= SFC_3_VALID_185_186_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_187_188_0_inputs_ready;
 reg SFC_3_VALID_187_188_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_187_188_0_stall_in;
wire SFC_3_VALID_187_188_0_output_regs_ready;
 reg SFC_3_VALID_187_188_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_187_188_0_causedstall;

assign SFC_3_VALID_187_188_0_inputs_ready = 1'b1;
assign SFC_3_VALID_187_188_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_186_187_0_stall_in = 1'b0;
assign SFC_3_VALID_187_188_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_187_188_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_187_188_0_output_regs_ready)
		begin
			SFC_3_VALID_187_188_0_NO_SHIFT_REG <= SFC_3_VALID_186_187_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_188_189_0_inputs_ready;
 reg SFC_3_VALID_188_189_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_188_189_0_stall_in;
wire SFC_3_VALID_188_189_0_output_regs_ready;
 reg SFC_3_VALID_188_189_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_188_189_0_causedstall;

assign SFC_3_VALID_188_189_0_inputs_ready = 1'b1;
assign SFC_3_VALID_188_189_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_187_188_0_stall_in = 1'b0;
assign SFC_3_VALID_188_189_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_188_189_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_188_189_0_output_regs_ready)
		begin
			SFC_3_VALID_188_189_0_NO_SHIFT_REG <= SFC_3_VALID_187_188_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_189_190_0_inputs_ready;
 reg SFC_3_VALID_189_190_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_189_190_0_stall_in;
wire SFC_3_VALID_189_190_0_output_regs_ready;
 reg SFC_3_VALID_189_190_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_189_190_0_causedstall;

assign SFC_3_VALID_189_190_0_inputs_ready = 1'b1;
assign SFC_3_VALID_189_190_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_188_189_0_stall_in = 1'b0;
assign SFC_3_VALID_189_190_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_189_190_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_189_190_0_output_regs_ready)
		begin
			SFC_3_VALID_189_190_0_NO_SHIFT_REG <= SFC_3_VALID_188_189_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_190_191_0_inputs_ready;
 reg SFC_3_VALID_190_191_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_190_191_0_stall_in;
wire SFC_3_VALID_190_191_0_output_regs_ready;
 reg SFC_3_VALID_190_191_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_190_191_0_causedstall;

assign SFC_3_VALID_190_191_0_inputs_ready = 1'b1;
assign SFC_3_VALID_190_191_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_189_190_0_stall_in = 1'b0;
assign SFC_3_VALID_190_191_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_190_191_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_190_191_0_output_regs_ready)
		begin
			SFC_3_VALID_190_191_0_NO_SHIFT_REG <= SFC_3_VALID_189_190_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_3_VALID_191_192_0_inputs_ready;
 reg SFC_3_VALID_191_192_0_valid_out_NO_SHIFT_REG;
wire SFC_3_VALID_191_192_0_stall_in;
wire SFC_3_VALID_191_192_0_output_regs_ready;
 reg SFC_3_VALID_191_192_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_3_VALID_191_192_0_causedstall;

assign SFC_3_VALID_191_192_0_inputs_ready = 1'b1;
assign SFC_3_VALID_191_192_0_output_regs_ready = 1'b1;
assign SFC_3_VALID_190_191_0_stall_in = 1'b0;
assign SFC_3_VALID_191_192_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_3_VALID_191_192_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_3_VALID_191_192_0_output_regs_ready)
		begin
			SFC_3_VALID_191_192_0_NO_SHIFT_REG <= SFC_3_VALID_190_191_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb2_c1_exit_c1_exi1_inputs_ready;
 reg local_bb2_c1_exit_c1_exi1_valid_out_NO_SHIFT_REG;
wire local_bb2_c1_exit_c1_exi1_stall_in;
 reg [63:0] local_bb2_c1_exit_c1_exi1_NO_SHIFT_REG;
wire [63:0] local_bb2_c1_exit_c1_exi1_in;
wire local_bb2_c1_exit_c1_exi1_valid;
wire local_bb2_c1_exit_c1_exi1_causedstall;

acl_stall_free_sink local_bb2_c1_exit_c1_exi1_instance (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_bb2_c1_exi1),
	.data_out(local_bb2_c1_exit_c1_exi1_in),
	.input_accepted(local_bb2_c1_enter_c1_eni1_input_accepted),
	.valid_out(local_bb2_c1_exit_c1_exi1_valid),
	.stall_in(~(local_bb2_c1_exit_c1_exi1_output_regs_ready)),
	.stall_entry(local_bb2_c1_exit_c1_exi1_entry_stall),
	.valid_in(local_bb2_c1_exit_c1_exi1_valid_in),
	.IIphases(local_bb2_c1_exit_c1_exi1_phases),
	.inc_pipelined_thread(local_bb2_c1_enter_c1_eni1_inc_pipelined_thread),
	.dec_pipelined_thread(local_bb2_c1_enter_c1_eni1_dec_pipelined_thread)
);

defparam local_bb2_c1_exit_c1_exi1_instance.DATA_WIDTH = 64;
defparam local_bb2_c1_exit_c1_exi1_instance.PIPELINE_DEPTH = 26;
defparam local_bb2_c1_exit_c1_exi1_instance.SHARINGII = 1;
defparam local_bb2_c1_exit_c1_exi1_instance.SCHEDULEII = 1;
defparam local_bb2_c1_exit_c1_exi1_instance.ALWAYS_THROTTLE = 0;

assign local_bb2_c1_exit_c1_exi1_inputs_ready = 1'b1;
assign local_bb2_c1_exit_c1_exi1_output_regs_ready = (&(~(local_bb2_c1_exit_c1_exi1_valid_out_NO_SHIFT_REG) | ~(local_bb2_c1_exit_c1_exi1_stall_in)));
assign local_bb2_c1_exit_c1_exi1_valid_in = SFC_3_VALID_191_192_0_NO_SHIFT_REG;
assign local_bb2_c1_exi1_stall_in = 1'b0;
assign SFC_3_VALID_191_192_0_stall_in = 1'b0;
assign local_bb2_c1_exit_c1_exi1_causedstall = (1'b1 && (1'b0 && !(~(local_bb2_c1_exit_c1_exi1_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_c1_exit_c1_exi1_NO_SHIFT_REG <= 'x;
		local_bb2_c1_exit_c1_exi1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_c1_exit_c1_exi1_output_regs_ready)
		begin
			local_bb2_c1_exit_c1_exi1_NO_SHIFT_REG <= local_bb2_c1_exit_c1_exi1_in;
			local_bb2_c1_exit_c1_exi1_valid_out_NO_SHIFT_REG <= local_bb2_c1_exit_c1_exi1_valid;
		end
		else
		begin
			if (~(local_bb2_c1_exit_c1_exi1_stall_in))
			begin
				local_bb2_c1_exit_c1_exi1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb2_c1_exe1_valid_out;
wire local_bb2_c1_exe1_stall_in;
wire local_bb2_c1_exe1_inputs_ready;
wire local_bb2_c1_exe1_stall_local;
wire [31:0] local_bb2_c1_exe1;

assign local_bb2_c1_exe1_inputs_ready = local_bb2_c1_exit_c1_exi1_valid_out_NO_SHIFT_REG;
assign local_bb2_c1_exe1 = local_bb2_c1_exit_c1_exi1_NO_SHIFT_REG[63:32];
assign local_bb2_c1_exe1_valid_out = local_bb2_c1_exe1_inputs_ready;
assign local_bb2_c1_exe1_stall_local = local_bb2_c1_exe1_stall_in;
assign local_bb2_c1_exit_c1_exi1_stall_in = (|local_bb2_c1_exe1_stall_local);

// This section implements a registered operation.
// 
wire local_bb2_st_c1_exe1_inputs_ready;
 reg local_bb2_st_c1_exe1_valid_out_NO_SHIFT_REG;
wire local_bb2_st_c1_exe1_stall_in;
wire local_bb2_st_c1_exe1_output_regs_ready;
wire local_bb2_st_c1_exe1_fu_stall_out;
wire local_bb2_st_c1_exe1_fu_valid_out;
wire local_bb2_st_c1_exe1_causedstall;

lsu_top lsu_local_bb2_st_c1_exe1 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb2_st_c1_exe1_fu_stall_out),
	.i_valid(local_bb2_st_c1_exe1_inputs_ready),
	.i_address((local_bb2_c0_exe218 & 64'hFFFFFFFFFFFFFFFC)),
	.i_writedata(local_bb2_c1_exe1),
	.i_cmpdata(),
	.i_predicate(1'b0),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb2_st_c1_exe1_output_regs_ready)),
	.o_valid(local_bb2_st_c1_exe1_fu_valid_out),
	.o_readdata(),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb2_st_c1_exe1_active),
	.avm_address(avm_local_bb2_st_c1_exe1_address),
	.avm_read(avm_local_bb2_st_c1_exe1_read),
	.avm_readdata(avm_local_bb2_st_c1_exe1_readdata),
	.avm_write(avm_local_bb2_st_c1_exe1_write),
	.avm_writeack(avm_local_bb2_st_c1_exe1_writeack),
	.avm_burstcount(avm_local_bb2_st_c1_exe1_burstcount),
	.avm_writedata(avm_local_bb2_st_c1_exe1_writedata),
	.avm_byteenable(avm_local_bb2_st_c1_exe1_byteenable),
	.avm_waitrequest(avm_local_bb2_st_c1_exe1_waitrequest),
	.avm_readdatavalid(avm_local_bb2_st_c1_exe1_readdatavalid),
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

defparam lsu_local_bb2_st_c1_exe1.AWIDTH = 33;
defparam lsu_local_bb2_st_c1_exe1.WIDTH_BYTES = 4;
defparam lsu_local_bb2_st_c1_exe1.MWIDTH_BYTES = 64;
defparam lsu_local_bb2_st_c1_exe1.WRITEDATAWIDTH_BYTES = 64;
defparam lsu_local_bb2_st_c1_exe1.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb2_st_c1_exe1.READ = 0;
defparam lsu_local_bb2_st_c1_exe1.ATOMIC = 0;
defparam lsu_local_bb2_st_c1_exe1.WIDTH = 32;
defparam lsu_local_bb2_st_c1_exe1.MWIDTH = 512;
defparam lsu_local_bb2_st_c1_exe1.ATOMIC_WIDTH = 3;
defparam lsu_local_bb2_st_c1_exe1.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb2_st_c1_exe1.KERNEL_SIDE_MEM_LATENCY = 4;
defparam lsu_local_bb2_st_c1_exe1.MEMORY_SIDE_MEM_LATENCY = 8;
defparam lsu_local_bb2_st_c1_exe1.USE_WRITE_ACK = 0;
defparam lsu_local_bb2_st_c1_exe1.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb2_st_c1_exe1.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb2_st_c1_exe1.NUMBER_BANKS = 1;
defparam lsu_local_bb2_st_c1_exe1.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb2_st_c1_exe1.INTENDED_DEVICE_FAMILY = "Stratix V";
defparam lsu_local_bb2_st_c1_exe1.USEINPUTFIFO = 0;
defparam lsu_local_bb2_st_c1_exe1.USECACHING = 0;
defparam lsu_local_bb2_st_c1_exe1.USEOUTPUTFIFO = 1;
defparam lsu_local_bb2_st_c1_exe1.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb2_st_c1_exe1.HIGH_FMAX = 1;
defparam lsu_local_bb2_st_c1_exe1.ADDRSPACE = 1;
defparam lsu_local_bb2_st_c1_exe1.STYLE = "BURST-COALESCED";
defparam lsu_local_bb2_st_c1_exe1.USE_BYTE_EN = 0;

assign local_bb2_st_c1_exe1_inputs_ready = (local_bb2_c1_exe1_valid_out & local_bb2_c0_exe218_valid_out);
assign local_bb2_st_c1_exe1_output_regs_ready = (&(~(local_bb2_st_c1_exe1_valid_out_NO_SHIFT_REG) | ~(local_bb2_st_c1_exe1_stall_in)));
assign local_bb2_c1_exe1_stall_in = (local_bb2_st_c1_exe1_fu_stall_out | ~(local_bb2_st_c1_exe1_inputs_ready));
assign local_bb2_c0_exe218_stall_in = (local_bb2_st_c1_exe1_fu_stall_out | ~(local_bb2_st_c1_exe1_inputs_ready));
assign local_bb2_st_c1_exe1_causedstall = (local_bb2_st_c1_exe1_inputs_ready && (local_bb2_st_c1_exe1_fu_stall_out && !(~(local_bb2_st_c1_exe1_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_st_c1_exe1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_st_c1_exe1_output_regs_ready)
		begin
			local_bb2_st_c1_exe1_valid_out_NO_SHIFT_REG <= local_bb2_st_c1_exe1_fu_valid_out;
		end
		else
		begin
			if (~(local_bb2_st_c1_exe1_stall_in))
			begin
				local_bb2_st_c1_exe1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_201to201_bb2_st_c1_exe1_valid_out;
wire rstag_201to201_bb2_st_c1_exe1_stall_in;
wire rstag_201to201_bb2_st_c1_exe1_inputs_ready;
wire rstag_201to201_bb2_st_c1_exe1_stall_local;
 reg rstag_201to201_bb2_st_c1_exe1_staging_valid_NO_SHIFT_REG;
wire rstag_201to201_bb2_st_c1_exe1_combined_valid;

assign rstag_201to201_bb2_st_c1_exe1_inputs_ready = local_bb2_st_c1_exe1_valid_out_NO_SHIFT_REG;
assign rstag_201to201_bb2_st_c1_exe1_combined_valid = (rstag_201to201_bb2_st_c1_exe1_staging_valid_NO_SHIFT_REG | rstag_201to201_bb2_st_c1_exe1_inputs_ready);
assign rstag_201to201_bb2_st_c1_exe1_valid_out = rstag_201to201_bb2_st_c1_exe1_combined_valid;
assign rstag_201to201_bb2_st_c1_exe1_stall_local = rstag_201to201_bb2_st_c1_exe1_stall_in;
assign local_bb2_st_c1_exe1_stall_in = (|rstag_201to201_bb2_st_c1_exe1_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_201to201_bb2_st_c1_exe1_staging_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (rstag_201to201_bb2_st_c1_exe1_stall_local)
		begin
			if (~(rstag_201to201_bb2_st_c1_exe1_staging_valid_NO_SHIFT_REG))
			begin
				rstag_201to201_bb2_st_c1_exe1_staging_valid_NO_SHIFT_REG <= rstag_201to201_bb2_st_c1_exe1_inputs_ready;
			end
		end
		else
		begin
			rstag_201to201_bb2_st_c1_exe1_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [255:0] lvb_bb2_c0_exit16_c0_exi5_0_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb2_c0_exe319_valid_out & rnode_197to201_bb2_c0_exit16_c0_exi5_0_valid_out_1_NO_SHIFT_REG & rstag_201to201_bb2_st_c1_exe1_valid_out);
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign local_bb2_c0_exe319_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_197to201_bb2_c0_exit16_c0_exi5_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rstag_201to201_bb2_st_c1_exe1_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_bb2_c0_exit16_c0_exi5_0 = lvb_bb2_c0_exit16_c0_exi5_0_reg_NO_SHIFT_REG;
assign lvb_bb2_c0_exit16_c0_exi5_1 = lvb_bb2_c0_exit16_c0_exi5_0_reg_NO_SHIFT_REG;
assign valid_out_0 = (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG);
assign valid_out_1 = ((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG);
assign combined_branch_stall_in_signal = ((((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_1) | ((~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_0));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		lvb_bb2_c0_exit16_c0_exi5_0_reg_NO_SHIFT_REG <= 'x;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_bb2_c0_exit16_c0_exi5_0_reg_NO_SHIFT_REG <= rnode_197to201_bb2_c0_exit16_c0_exi5_1_NO_SHIFT_REG;
			branch_compare_result_NO_SHIFT_REG <= local_bb2_c0_exe319;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
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
module AOCmm2metersKernel_basic_block_3
	(
		input 		clock,
		input 		resetn,
		input 		valid_in,
		output 		stall_out,
		input [255:0] 		input_c0_exit16_c0_exi5,
		output 		valid_out_0,
		input 		stall_in_0,
		output 		valid_out_1,
		input 		stall_in_1,
		input [31:0] 		workgroup_size,
		input 		start
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((valid_out_0 & valid_out_1) & ~((stall_in_0 | stall_in_1)));
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
 reg [255:0] input_c0_exit16_c0_exi5_staging_reg_NO_SHIFT_REG;
 reg [255:0] local_lvm_c0_exit16_c0_exi5_NO_SHIFT_REG;
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
		input_c0_exit16_c0_exi5_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_c0_exit16_c0_exi5_staging_reg_NO_SHIFT_REG <= input_c0_exit16_c0_exi5;
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
					local_lvm_c0_exit16_c0_exi5_NO_SHIFT_REG <= input_c0_exit16_c0_exi5_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_c0_exit16_c0_exi5_NO_SHIFT_REG <= input_c0_exit16_c0_exi5;
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


// This section implements an unregistered operation.
// 
wire local_bb3_c0_exe5_valid_out;
wire local_bb3_c0_exe5_stall_in;
wire local_bb3_c0_exe5_inputs_ready;
wire local_bb3_c0_exe5_stall_local;
wire local_bb3_c0_exe5;

assign local_bb3_c0_exe5_inputs_ready = merge_node_valid_out_NO_SHIFT_REG;
assign local_bb3_c0_exe5 = local_lvm_c0_exit16_c0_exi5_NO_SHIFT_REG[208];
assign local_bb3_c0_exe5_valid_out = local_bb3_c0_exe5_inputs_ready;
assign local_bb3_c0_exe5_stall_local = local_bb3_c0_exe5_stall_in;
assign merge_node_stall_in = (|local_bb3_c0_exe5_stall_local);

// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;

assign branch_var__inputs_ready = local_bb3_c0_exe5_valid_out;
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign local_bb3_c0_exe5_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign valid_out_0 = (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG);
assign valid_out_1 = ((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG);
assign combined_branch_stall_in_signal = ((((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_1) | ((~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_0));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			branch_compare_result_NO_SHIFT_REG <= local_bb3_c0_exe5;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
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
module AOCmm2metersKernel_basic_block_4
	(
		input 		clock,
		input 		resetn,
		input 		valid_in,
		output 		stall_out,
		output 		valid_out,
		input 		stall_in,
		input [31:0] 		workgroup_size,
		input 		start
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
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
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
wire branch_var__output_regs_ready;

assign branch_var__inputs_ready = merge_node_valid_out_NO_SHIFT_REG;
assign branch_var__output_regs_ready = ~(stall_in);
assign merge_node_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
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
		output 		stall_out,
		input 		valid_in,
		output 		valid_out,
		input 		stall_in,
		input [511:0] 		avm_local_bb2_ld__readdata,
		input 		avm_local_bb2_ld__readdatavalid,
		input 		avm_local_bb2_ld__waitrequest,
		output [32:0] 		avm_local_bb2_ld__address,
		output 		avm_local_bb2_ld__read,
		output 		avm_local_bb2_ld__write,
		input 		avm_local_bb2_ld__writeack,
		output [511:0] 		avm_local_bb2_ld__writedata,
		output [63:0] 		avm_local_bb2_ld__byteenable,
		output [4:0] 		avm_local_bb2_ld__burstcount,
		input [511:0] 		avm_local_bb2_st_c1_exe1_readdata,
		input 		avm_local_bb2_st_c1_exe1_readdatavalid,
		input 		avm_local_bb2_st_c1_exe1_waitrequest,
		output [32:0] 		avm_local_bb2_st_c1_exe1_address,
		output 		avm_local_bb2_st_c1_exe1_read,
		output 		avm_local_bb2_st_c1_exe1_write,
		input 		avm_local_bb2_st_c1_exe1_writeack,
		output [511:0] 		avm_local_bb2_st_c1_exe1_writedata,
		output [63:0] 		avm_local_bb2_st_c1_exe1_byteenable,
		output [4:0] 		avm_local_bb2_st_c1_exe1_burstcount,
		input 		start,
		input [31:0] 		input_inSize_x,
		input [31:0] 		input_depthSize_x,
		input 		clock2x,
		input [31:0] 		input_ratio,
		input [63:0] 		input_in,
		input [63:0] 		input_depth,
		output reg 		has_a_write_pending,
		output reg 		has_a_lsu_active
	);


wire [31:0] workgroup_size;
wire [31:0] cur_cycle;
wire bb_0_stall_out;
wire bb_0_valid_out;
wire bb_1_stall_out_0;
wire bb_1_stall_out_1;
wire bb_1_valid_out;
wire [31:0] bb_1_lvb_bb1_c0_exe1;
wire [31:0] bb_1_lvb_bb1_c0_exe2;
wire bb_1_lvb_bb1_c0_exe3;
wire bb_1_feedback_stall_out_4;
wire bb_1_feedback_stall_out_2;
wire bb_1_feedback_stall_out_3;
wire bb_1_acl_pipelined_valid;
wire bb_1_acl_pipelined_exiting_valid;
wire bb_1_acl_pipelined_exiting_stall;
wire bb_1_feedback_valid_out_3;
wire bb_1_feedback_data_out_3;
wire bb_1_feedback_valid_out_4;
wire [31:0] bb_1_feedback_data_out_4;
wire bb_2_stall_out_0;
wire bb_2_stall_out_1;
wire bb_2_valid_out_0;
wire [255:0] bb_2_lvb_bb2_c0_exit16_c0_exi5_0;
wire bb_2_valid_out_1;
wire [255:0] bb_2_lvb_bb2_c0_exit16_c0_exi5_1;
wire bb_2_feedback_stall_out_5;
wire bb_2_feedback_stall_out_6;
wire bb_2_feedback_stall_out_0;
wire bb_2_feedback_stall_out_1;
wire bb_2_acl_pipelined_valid;
wire bb_2_acl_pipelined_exiting_valid;
wire bb_2_acl_pipelined_exiting_stall;
wire bb_2_feedback_valid_out_1;
wire bb_2_feedback_data_out_1;
wire bb_2_feedback_valid_out_5;
wire [63:0] bb_2_feedback_data_out_5;
wire bb_2_feedback_stall_out_7;
wire bb_2_feedback_stall_out_8;
wire bb_2_feedback_valid_out_6;
wire [31:0] bb_2_feedback_data_out_6;
wire bb_2_feedback_valid_out_8;
wire bb_2_feedback_data_out_8;
wire bb_2_feedback_valid_out_7;
wire [31:0] bb_2_feedback_data_out_7;
wire bb_2_local_bb2_ld__active;
wire bb_2_local_bb2_st_c1_exe1_active;
wire bb_3_stall_out;
wire bb_3_valid_out_0;
wire bb_3_valid_out_1;
wire bb_4_stall_out;
wire bb_4_valid_out;
wire feedback_stall_3;
wire feedback_valid_3;
wire feedback_data_3;
wire feedback_stall_4;
wire feedback_valid_4;
wire [31:0] feedback_data_4;
wire feedback_stall_1;
wire feedback_valid_1;
wire feedback_data_1;
wire feedback_stall_7;
wire feedback_valid_7;
wire [31:0] feedback_data_7;
wire feedback_stall_6;
wire feedback_valid_6;
wire [31:0] feedback_data_6;
wire feedback_stall_5;
wire feedback_valid_5;
wire [63:0] feedback_data_5;
wire feedback_stall_8;
wire feedback_valid_8;
wire feedback_data_8;
wire loop_limiter_1_stall_out;
wire loop_limiter_1_valid_out;
wire writes_pending;
wire [1:0] lsus_active;

AOCmm2metersKernel_basic_block_0 AOCmm2metersKernel_basic_block_0 (
	.clock(clock),
	.resetn(resetn),
	.start(start),
	.valid_in(valid_in),
	.stall_out(bb_0_stall_out),
	.valid_out(bb_0_valid_out),
	.stall_in(bb_1_stall_out_1),
	.workgroup_size(workgroup_size)
);


AOCmm2metersKernel_basic_block_1 AOCmm2metersKernel_basic_block_1 (
	.clock(clock),
	.resetn(resetn),
	.input_inSize_x(input_inSize_x),
	.input_depthSize_x(input_depthSize_x),
	.valid_in_0(bb_1_acl_pipelined_valid),
	.stall_out_0(bb_1_stall_out_0),
	.input_forked_0(1'b0),
	.valid_in_1(bb_0_valid_out),
	.stall_out_1(bb_1_stall_out_1),
	.input_forked_1(1'b1),
	.valid_out(bb_1_valid_out),
	.stall_in(loop_limiter_1_stall_out),
	.lvb_bb1_c0_exe1(bb_1_lvb_bb1_c0_exe1),
	.lvb_bb1_c0_exe2(bb_1_lvb_bb1_c0_exe2),
	.lvb_bb1_c0_exe3(bb_1_lvb_bb1_c0_exe3),
	.workgroup_size(workgroup_size),
	.start(start),
	.feedback_valid_in_4(feedback_valid_4),
	.feedback_stall_out_4(feedback_stall_4),
	.feedback_data_in_4(feedback_data_4),
	.feedback_stall_out_2(bb_1_feedback_stall_out_2),
	.feedback_valid_in_3(feedback_valid_3),
	.feedback_stall_out_3(feedback_stall_3),
	.feedback_data_in_3(feedback_data_3),
	.acl_pipelined_valid(bb_1_acl_pipelined_valid),
	.acl_pipelined_stall(bb_1_stall_out_0),
	.acl_pipelined_exiting_valid(bb_1_acl_pipelined_exiting_valid),
	.acl_pipelined_exiting_stall(bb_1_acl_pipelined_exiting_stall),
	.feedback_valid_out_3(feedback_valid_3),
	.feedback_stall_in_3(feedback_stall_3),
	.feedback_data_out_3(feedback_data_3),
	.feedback_valid_out_4(feedback_valid_4),
	.feedback_stall_in_4(feedback_stall_4),
	.feedback_data_out_4(feedback_data_4)
);


AOCmm2metersKernel_basic_block_2 AOCmm2metersKernel_basic_block_2 (
	.clock(clock),
	.resetn(resetn),
	.input_ratio(input_ratio),
	.input_in(input_in),
	.input_depth(input_depth),
	.valid_in_0(bb_2_acl_pipelined_valid),
	.stall_out_0(bb_2_stall_out_0),
	.input_forked5_0(1'b0),
	.input_mul46_0('x),
	.input_mul77_0('x),
	.input_exitcond48_0('x),
	.valid_in_1(loop_limiter_1_valid_out),
	.stall_out_1(bb_2_stall_out_1),
	.input_forked5_1(1'b1),
	.input_mul46_1(bb_1_lvb_bb1_c0_exe1),
	.input_mul77_1(bb_1_lvb_bb1_c0_exe2),
	.input_exitcond48_1(bb_1_lvb_bb1_c0_exe3),
	.valid_out_0(bb_2_valid_out_0),
	.stall_in_0(bb_3_stall_out),
	.lvb_bb2_c0_exit16_c0_exi5_0(bb_2_lvb_bb2_c0_exit16_c0_exi5_0),
	.valid_out_1(bb_2_valid_out_1),
	.stall_in_1(1'b0),
	.lvb_bb2_c0_exit16_c0_exi5_1(bb_2_lvb_bb2_c0_exit16_c0_exi5_1),
	.workgroup_size(workgroup_size),
	.start(start),
	.feedback_valid_in_5(feedback_valid_5),
	.feedback_stall_out_5(feedback_stall_5),
	.feedback_data_in_5(feedback_data_5),
	.feedback_valid_in_6(feedback_valid_6),
	.feedback_stall_out_6(feedback_stall_6),
	.feedback_data_in_6(feedback_data_6),
	.feedback_stall_out_0(bb_2_feedback_stall_out_0),
	.feedback_valid_in_1(feedback_valid_1),
	.feedback_stall_out_1(feedback_stall_1),
	.feedback_data_in_1(feedback_data_1),
	.acl_pipelined_valid(bb_2_acl_pipelined_valid),
	.acl_pipelined_stall(bb_2_stall_out_0),
	.acl_pipelined_exiting_valid(bb_2_acl_pipelined_exiting_valid),
	.acl_pipelined_exiting_stall(bb_2_acl_pipelined_exiting_stall),
	.feedback_valid_out_1(feedback_valid_1),
	.feedback_stall_in_1(feedback_stall_1),
	.feedback_data_out_1(feedback_data_1),
	.feedback_valid_out_5(feedback_valid_5),
	.feedback_stall_in_5(feedback_stall_5),
	.feedback_data_out_5(feedback_data_5),
	.feedback_valid_in_7(feedback_valid_7),
	.feedback_stall_out_7(feedback_stall_7),
	.feedback_data_in_7(feedback_data_7),
	.feedback_valid_in_8(feedback_valid_8),
	.feedback_stall_out_8(feedback_stall_8),
	.feedback_data_in_8(feedback_data_8),
	.feedback_valid_out_6(feedback_valid_6),
	.feedback_stall_in_6(feedback_stall_6),
	.feedback_data_out_6(feedback_data_6),
	.feedback_valid_out_8(feedback_valid_8),
	.feedback_stall_in_8(feedback_stall_8),
	.feedback_data_out_8(feedback_data_8),
	.feedback_valid_out_7(feedback_valid_7),
	.feedback_stall_in_7(feedback_stall_7),
	.feedback_data_out_7(feedback_data_7),
	.avm_local_bb2_ld__readdata(avm_local_bb2_ld__readdata),
	.avm_local_bb2_ld__readdatavalid(avm_local_bb2_ld__readdatavalid),
	.avm_local_bb2_ld__waitrequest(avm_local_bb2_ld__waitrequest),
	.avm_local_bb2_ld__address(avm_local_bb2_ld__address),
	.avm_local_bb2_ld__read(avm_local_bb2_ld__read),
	.avm_local_bb2_ld__write(avm_local_bb2_ld__write),
	.avm_local_bb2_ld__writeack(avm_local_bb2_ld__writeack),
	.avm_local_bb2_ld__writedata(avm_local_bb2_ld__writedata),
	.avm_local_bb2_ld__byteenable(avm_local_bb2_ld__byteenable),
	.avm_local_bb2_ld__burstcount(avm_local_bb2_ld__burstcount),
	.local_bb2_ld__active(bb_2_local_bb2_ld__active),
	.clock2x(clock2x),
	.avm_local_bb2_st_c1_exe1_readdata(avm_local_bb2_st_c1_exe1_readdata),
	.avm_local_bb2_st_c1_exe1_readdatavalid(avm_local_bb2_st_c1_exe1_readdatavalid),
	.avm_local_bb2_st_c1_exe1_waitrequest(avm_local_bb2_st_c1_exe1_waitrequest),
	.avm_local_bb2_st_c1_exe1_address(avm_local_bb2_st_c1_exe1_address),
	.avm_local_bb2_st_c1_exe1_read(avm_local_bb2_st_c1_exe1_read),
	.avm_local_bb2_st_c1_exe1_write(avm_local_bb2_st_c1_exe1_write),
	.avm_local_bb2_st_c1_exe1_writeack(avm_local_bb2_st_c1_exe1_writeack),
	.avm_local_bb2_st_c1_exe1_writedata(avm_local_bb2_st_c1_exe1_writedata),
	.avm_local_bb2_st_c1_exe1_byteenable(avm_local_bb2_st_c1_exe1_byteenable),
	.avm_local_bb2_st_c1_exe1_burstcount(avm_local_bb2_st_c1_exe1_burstcount),
	.local_bb2_st_c1_exe1_active(bb_2_local_bb2_st_c1_exe1_active)
);


AOCmm2metersKernel_basic_block_3 AOCmm2metersKernel_basic_block_3 (
	.clock(clock),
	.resetn(resetn),
	.valid_in(bb_2_valid_out_0),
	.stall_out(bb_3_stall_out),
	.input_c0_exit16_c0_exi5(bb_2_lvb_bb2_c0_exit16_c0_exi5_0),
	.valid_out_0(bb_3_valid_out_0),
	.stall_in_0(bb_4_stall_out),
	.valid_out_1(bb_3_valid_out_1),
	.stall_in_1(1'b0),
	.workgroup_size(workgroup_size),
	.start(start)
);


AOCmm2metersKernel_basic_block_4 AOCmm2metersKernel_basic_block_4 (
	.clock(clock),
	.resetn(resetn),
	.valid_in(bb_3_valid_out_0),
	.stall_out(bb_4_stall_out),
	.valid_out(bb_4_valid_out),
	.stall_in(stall_in),
	.workgroup_size(workgroup_size),
	.start(start)
);


acl_loop_limiter loop_limiter_1 (
	.clock(clock),
	.resetn(resetn),
	.i_valid(bb_1_valid_out),
	.i_stall(bb_2_stall_out_1),
	.i_valid_exit(bb_2_acl_pipelined_exiting_valid),
	.i_stall_exit(bb_2_acl_pipelined_exiting_stall),
	.o_valid(loop_limiter_1_valid_out),
	.o_stall(loop_limiter_1_stall_out)
);

defparam loop_limiter_1.ENTRY_WIDTH = 1;
defparam loop_limiter_1.EXIT_WIDTH = 1;
defparam loop_limiter_1.THRESHOLD = 1;

AOCmm2metersKernel_sys_cycle_time system_cycle_time_module (
	.clock(clock),
	.resetn(resetn),
	.cur_cycle(cur_cycle)
);


assign workgroup_size = 32'h1;
assign valid_out = bb_4_valid_out;
assign stall_out = bb_0_stall_out;
assign writes_pending = bb_2_local_bb2_st_c1_exe1_active;
assign lsus_active[0] = bb_2_local_bb2_ld__active;
assign lsus_active[1] = bb_2_local_bb2_st_c1_exe1_active;

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
		input [3:0] 		avs_cra_address,
		input [63:0] 		avs_cra_writedata,
		input [7:0] 		avs_cra_byteenable,
		output reg [63:0] 		avs_cra_readdata,
		output reg 		avs_cra_readdatavalid,
		output 		cra_irq,
		input [511:0] 		avm_local_bb2_ld__inst0_readdata,
		input 		avm_local_bb2_ld__inst0_readdatavalid,
		input 		avm_local_bb2_ld__inst0_waitrequest,
		output [32:0] 		avm_local_bb2_ld__inst0_address,
		output 		avm_local_bb2_ld__inst0_read,
		output 		avm_local_bb2_ld__inst0_write,
		input 		avm_local_bb2_ld__inst0_writeack,
		output [511:0] 		avm_local_bb2_ld__inst0_writedata,
		output [63:0] 		avm_local_bb2_ld__inst0_byteenable,
		output [4:0] 		avm_local_bb2_ld__inst0_burstcount,
		input [511:0] 		avm_local_bb2_st_c1_exe1_inst0_readdata,
		input 		avm_local_bb2_st_c1_exe1_inst0_readdatavalid,
		input 		avm_local_bb2_st_c1_exe1_inst0_waitrequest,
		output [32:0] 		avm_local_bb2_st_c1_exe1_inst0_address,
		output 		avm_local_bb2_st_c1_exe1_inst0_read,
		output 		avm_local_bb2_st_c1_exe1_inst0_write,
		input 		avm_local_bb2_st_c1_exe1_inst0_writeack,
		output [511:0] 		avm_local_bb2_st_c1_exe1_inst0_writedata,
		output [63:0] 		avm_local_bb2_st_c1_exe1_inst0_byteenable,
		output [4:0] 		avm_local_bb2_st_c1_exe1_inst0_burstcount
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
 reg [223:0] kernel_arguments_NO_SHIFT_REG;
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
 reg [3:0] cra_addr_st1_NO_SHIFT_REG;
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
		kernel_arguments_NO_SHIFT_REG <= 224'h0;
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
				4'h0:
				begin
					status_NO_SHIFT_REG[31:16] <= 16'h3;
					status_NO_SHIFT_REG[15:0] <= ((status_NO_SHIFT_REG[15:0] & ~(bitenable[15:0])) | (avs_cra_writedata[15:0] & bitenable[15:0]));
				end

				4'h1:
				begin
					profile_ctrl_NO_SHIFT_REG <= ((profile_ctrl_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h3:
				begin
					profile_start_cycle_NO_SHIFT_REG[31:0] <= ((profile_start_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_start_cycle_NO_SHIFT_REG[63:32] <= ((profile_start_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h4:
				begin
					profile_stop_cycle_NO_SHIFT_REG[31:0] <= ((profile_stop_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_stop_cycle_NO_SHIFT_REG[63:32] <= ((profile_stop_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h5:
				begin
					work_dim_NO_SHIFT_REG <= ((work_dim_NO_SHIFT_REG & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					workgroup_size_NO_SHIFT_REG <= ((workgroup_size_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h6:
				begin
					global_size_NO_SHIFT_REG[0] <= ((global_size_NO_SHIFT_REG[0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_size_NO_SHIFT_REG[1] <= ((global_size_NO_SHIFT_REG[1] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h7:
				begin
					global_size_NO_SHIFT_REG[2] <= ((global_size_NO_SHIFT_REG[2] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_NO_SHIFT_REG[0] <= ((num_groups_NO_SHIFT_REG[0] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h8:
				begin
					num_groups_NO_SHIFT_REG[1] <= ((num_groups_NO_SHIFT_REG[1] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_NO_SHIFT_REG[2] <= ((num_groups_NO_SHIFT_REG[2] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h9:
				begin
					local_size_NO_SHIFT_REG[0] <= ((local_size_NO_SHIFT_REG[0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					local_size_NO_SHIFT_REG[1] <= ((local_size_NO_SHIFT_REG[1] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hA:
				begin
					local_size_NO_SHIFT_REG[2] <= ((local_size_NO_SHIFT_REG[2] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_NO_SHIFT_REG[0] <= ((global_offset_NO_SHIFT_REG[0] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hB:
				begin
					global_offset_NO_SHIFT_REG[1] <= ((global_offset_NO_SHIFT_REG[1] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_NO_SHIFT_REG[2] <= ((global_offset_NO_SHIFT_REG[2] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hC:
				begin
					kernel_arguments_NO_SHIFT_REG[31:0] <= ((kernel_arguments_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[63:32] <= ((kernel_arguments_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hD:
				begin
					kernel_arguments_NO_SHIFT_REG[95:64] <= ((kernel_arguments_NO_SHIFT_REG[95:64] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[127:96] <= ((kernel_arguments_NO_SHIFT_REG[127:96] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hE:
				begin
					kernel_arguments_NO_SHIFT_REG[159:128] <= ((kernel_arguments_NO_SHIFT_REG[159:128] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[191:160] <= ((kernel_arguments_NO_SHIFT_REG[191:160] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hF:
				begin
					kernel_arguments_NO_SHIFT_REG[223:192] <= ((kernel_arguments_NO_SHIFT_REG[223:192] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
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
		cra_addr_st1_NO_SHIFT_REG <= 4'h0;
		cra_readdata_st1_NO_SHIFT_REG <= 64'h0;
	end
	else
	begin
		cra_read_st1_NO_SHIFT_REG <= avs_cra_read;
		cra_addr_st1_NO_SHIFT_REG <= avs_cra_address;
		case (avs_cra_address)
			4'h0:
			begin
				cra_readdata_st1_NO_SHIFT_REG[31:0] <= status_NO_SHIFT_REG;
				cra_readdata_st1_NO_SHIFT_REG[63:32] <= 32'h0;
			end

			4'h1:
			begin
				cra_readdata_st1_NO_SHIFT_REG[31:0] <= 'x;
				cra_readdata_st1_NO_SHIFT_REG[63:32] <= 32'h0;
			end

			4'h2:
			begin
				cra_readdata_st1_NO_SHIFT_REG[63:0] <= 64'h0;
			end

			4'h3:
			begin
				cra_readdata_st1_NO_SHIFT_REG[63:0] <= 64'h0;
			end

			4'h4:
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
			4'h2:
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
	.stall_out(stall_out),
	.valid_in(valid_in),
	.valid_out(valid_out),
	.stall_in(stall_in),
	.avm_local_bb2_ld__readdata(avm_local_bb2_ld__inst0_readdata),
	.avm_local_bb2_ld__readdatavalid(avm_local_bb2_ld__inst0_readdatavalid),
	.avm_local_bb2_ld__waitrequest(avm_local_bb2_ld__inst0_waitrequest),
	.avm_local_bb2_ld__address(avm_local_bb2_ld__inst0_address),
	.avm_local_bb2_ld__read(avm_local_bb2_ld__inst0_read),
	.avm_local_bb2_ld__write(avm_local_bb2_ld__inst0_write),
	.avm_local_bb2_ld__writeack(avm_local_bb2_ld__inst0_writeack),
	.avm_local_bb2_ld__writedata(avm_local_bb2_ld__inst0_writedata),
	.avm_local_bb2_ld__byteenable(avm_local_bb2_ld__inst0_byteenable),
	.avm_local_bb2_ld__burstcount(avm_local_bb2_ld__inst0_burstcount),
	.avm_local_bb2_st_c1_exe1_readdata(avm_local_bb2_st_c1_exe1_inst0_readdata),
	.avm_local_bb2_st_c1_exe1_readdatavalid(avm_local_bb2_st_c1_exe1_inst0_readdatavalid),
	.avm_local_bb2_st_c1_exe1_waitrequest(avm_local_bb2_st_c1_exe1_inst0_waitrequest),
	.avm_local_bb2_st_c1_exe1_address(avm_local_bb2_st_c1_exe1_inst0_address),
	.avm_local_bb2_st_c1_exe1_read(avm_local_bb2_st_c1_exe1_inst0_read),
	.avm_local_bb2_st_c1_exe1_write(avm_local_bb2_st_c1_exe1_inst0_write),
	.avm_local_bb2_st_c1_exe1_writeack(avm_local_bb2_st_c1_exe1_inst0_writeack),
	.avm_local_bb2_st_c1_exe1_writedata(avm_local_bb2_st_c1_exe1_inst0_writedata),
	.avm_local_bb2_st_c1_exe1_byteenable(avm_local_bb2_st_c1_exe1_inst0_byteenable),
	.avm_local_bb2_st_c1_exe1_burstcount(avm_local_bb2_st_c1_exe1_inst0_burstcount),
	.start(start_out),
	.input_inSize_x(kernel_arguments_NO_SHIFT_REG[191:160]),
	.input_depthSize_x(kernel_arguments_NO_SHIFT_REG[95:64]),
	.clock2x(clock2x),
	.input_ratio(kernel_arguments_NO_SHIFT_REG[223:192]),
	.input_in(kernel_arguments_NO_SHIFT_REG[159:96]),
	.input_depth(kernel_arguments_NO_SHIFT_REG[63:0]),
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

