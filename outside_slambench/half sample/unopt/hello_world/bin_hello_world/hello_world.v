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
module AOChalfSampleRobustImageKernel_basic_block_0
	(
		input 		clock,
		input 		resetn,
		input 		start,
		input [31:0] 		input_inSize_x,
		input [31:0] 		input_r,
		input [31:0] 		input_inSize_y,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_global_id_1,
		output 		valid_out,
		input 		stall_in,
		output [31:0] 		lvb_bb0_div,
		output [31:0] 		lvb_bb0_add6,
		output 		lvb_bb0_cmp9,
		output [31:0] 		lvb_bb0_sub20,
		output [31:0] 		lvb_bb0_sub22,
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
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_node_stall_in_2;
 reg merge_node_valid_out_2_NO_SHIFT_REG;
wire merge_node_stall_in_3;
 reg merge_node_valid_out_3_NO_SHIFT_REG;
wire merge_node_stall_in_4;
 reg merge_node_valid_out_4_NO_SHIFT_REG;
wire merge_node_stall_in_5;
 reg merge_node_valid_out_5_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_1_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG) | (merge_node_stall_in_5 & merge_node_valid_out_5_NO_SHIFT_REG));
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
		merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_3_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_4_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_5_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
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
			if (~(merge_node_stall_in_4))
			begin
				merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_5))
			begin
				merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
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
wire local_bb0_div_inputs_ready;
 reg local_bb0_div_wii_reg_NO_SHIFT_REG;
 reg local_bb0_div_valid_out_NO_SHIFT_REG;
wire local_bb0_div_stall_in;
wire local_bb0_div_output_regs_ready;
 reg [31:0] local_bb0_div_NO_SHIFT_REG;
wire local_bb0_div_causedstall;

assign local_bb0_div_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb0_div_output_regs_ready = (~(local_bb0_div_wii_reg_NO_SHIFT_REG) & (&(~(local_bb0_div_valid_out_NO_SHIFT_REG) | ~(local_bb0_div_stall_in))));
assign merge_node_stall_in_0 = (~(local_bb0_div_wii_reg_NO_SHIFT_REG) & (~(local_bb0_div_output_regs_ready) | ~(local_bb0_div_inputs_ready)));
assign local_bb0_div_causedstall = (local_bb0_div_inputs_ready && (~(local_bb0_div_output_regs_ready) && !(~(local_bb0_div_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_div_NO_SHIFT_REG <= 'x;
		local_bb0_div_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_div_NO_SHIFT_REG <= 'x;
			local_bb0_div_valid_out_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_div_output_regs_ready)
			begin
				local_bb0_div_NO_SHIFT_REG <= (input_inSize_x >> 32'h1);
				local_bb0_div_valid_out_NO_SHIFT_REG <= local_bb0_div_inputs_ready;
			end
			else
			begin
				if (~(local_bb0_div_stall_in))
				begin
					local_bb0_div_valid_out_NO_SHIFT_REG <= local_bb0_div_wii_reg_NO_SHIFT_REG;
				end
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_div_wii_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_div_wii_reg_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_div_inputs_ready)
			begin
				local_bb0_div_wii_reg_NO_SHIFT_REG <= 1'b1;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb0_add6_inputs_ready;
 reg local_bb0_add6_wii_reg_NO_SHIFT_REG;
 reg local_bb0_add6_valid_out_0_NO_SHIFT_REG;
wire local_bb0_add6_stall_in_0;
 reg local_bb0_add6_valid_out_1_NO_SHIFT_REG;
wire local_bb0_add6_stall_in_1;
wire local_bb0_add6_output_regs_ready;
 reg [31:0] local_bb0_add6_NO_SHIFT_REG;
wire local_bb0_add6_causedstall;

assign local_bb0_add6_inputs_ready = merge_node_valid_out_1_NO_SHIFT_REG;
assign local_bb0_add6_output_regs_ready = (~(local_bb0_add6_wii_reg_NO_SHIFT_REG) & ((~(local_bb0_add6_valid_out_0_NO_SHIFT_REG) | ~(local_bb0_add6_stall_in_0)) & (~(local_bb0_add6_valid_out_1_NO_SHIFT_REG) | ~(local_bb0_add6_stall_in_1))));
assign merge_node_stall_in_1 = (~(local_bb0_add6_wii_reg_NO_SHIFT_REG) & (~(local_bb0_add6_output_regs_ready) | ~(local_bb0_add6_inputs_ready)));
assign local_bb0_add6_causedstall = (local_bb0_add6_inputs_ready && (~(local_bb0_add6_output_regs_ready) && !(~(local_bb0_add6_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_add6_NO_SHIFT_REG <= 'x;
		local_bb0_add6_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb0_add6_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_add6_NO_SHIFT_REG <= 'x;
			local_bb0_add6_valid_out_0_NO_SHIFT_REG <= 1'b0;
			local_bb0_add6_valid_out_1_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_add6_output_regs_ready)
			begin
				local_bb0_add6_NO_SHIFT_REG <= (32'h1 - input_r);
				local_bb0_add6_valid_out_0_NO_SHIFT_REG <= local_bb0_add6_inputs_ready;
				local_bb0_add6_valid_out_1_NO_SHIFT_REG <= local_bb0_add6_inputs_ready;
			end
			else
			begin
				if (~(local_bb0_add6_stall_in_0))
				begin
					local_bb0_add6_valid_out_0_NO_SHIFT_REG <= local_bb0_add6_wii_reg_NO_SHIFT_REG;
				end
				if (~(local_bb0_add6_stall_in_1))
				begin
					local_bb0_add6_valid_out_1_NO_SHIFT_REG <= local_bb0_add6_wii_reg_NO_SHIFT_REG;
				end
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_add6_wii_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_add6_wii_reg_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_add6_inputs_ready)
			begin
				local_bb0_add6_wii_reg_NO_SHIFT_REG <= 1'b1;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb0_sub20_inputs_ready;
 reg local_bb0_sub20_wii_reg_NO_SHIFT_REG;
 reg local_bb0_sub20_valid_out_NO_SHIFT_REG;
wire local_bb0_sub20_stall_in;
wire local_bb0_sub20_output_regs_ready;
 reg [31:0] local_bb0_sub20_NO_SHIFT_REG;
wire local_bb0_sub20_causedstall;

assign local_bb0_sub20_inputs_ready = merge_node_valid_out_3_NO_SHIFT_REG;
assign local_bb0_sub20_output_regs_ready = (~(local_bb0_sub20_wii_reg_NO_SHIFT_REG) & (&(~(local_bb0_sub20_valid_out_NO_SHIFT_REG) | ~(local_bb0_sub20_stall_in))));
assign merge_node_stall_in_3 = (~(local_bb0_sub20_wii_reg_NO_SHIFT_REG) & (~(local_bb0_sub20_output_regs_ready) | ~(local_bb0_sub20_inputs_ready)));
assign local_bb0_sub20_causedstall = (local_bb0_sub20_inputs_ready && (~(local_bb0_sub20_output_regs_ready) && !(~(local_bb0_sub20_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_sub20_NO_SHIFT_REG <= 'x;
		local_bb0_sub20_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_sub20_NO_SHIFT_REG <= 'x;
			local_bb0_sub20_valid_out_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_sub20_output_regs_ready)
			begin
				local_bb0_sub20_NO_SHIFT_REG <= (input_inSize_x + 32'hFFFFFFFF);
				local_bb0_sub20_valid_out_NO_SHIFT_REG <= local_bb0_sub20_inputs_ready;
			end
			else
			begin
				if (~(local_bb0_sub20_stall_in))
				begin
					local_bb0_sub20_valid_out_NO_SHIFT_REG <= local_bb0_sub20_wii_reg_NO_SHIFT_REG;
				end
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_sub20_wii_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_sub20_wii_reg_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_sub20_inputs_ready)
			begin
				local_bb0_sub20_wii_reg_NO_SHIFT_REG <= 1'b1;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb0_sub22_inputs_ready;
 reg local_bb0_sub22_wii_reg_NO_SHIFT_REG;
 reg local_bb0_sub22_valid_out_NO_SHIFT_REG;
wire local_bb0_sub22_stall_in;
wire local_bb0_sub22_output_regs_ready;
 reg [31:0] local_bb0_sub22_NO_SHIFT_REG;
wire local_bb0_sub22_causedstall;

assign local_bb0_sub22_inputs_ready = merge_node_valid_out_4_NO_SHIFT_REG;
assign local_bb0_sub22_output_regs_ready = (~(local_bb0_sub22_wii_reg_NO_SHIFT_REG) & (&(~(local_bb0_sub22_valid_out_NO_SHIFT_REG) | ~(local_bb0_sub22_stall_in))));
assign merge_node_stall_in_4 = (~(local_bb0_sub22_wii_reg_NO_SHIFT_REG) & (~(local_bb0_sub22_output_regs_ready) | ~(local_bb0_sub22_inputs_ready)));
assign local_bb0_sub22_causedstall = (local_bb0_sub22_inputs_ready && (~(local_bb0_sub22_output_regs_ready) && !(~(local_bb0_sub22_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_sub22_NO_SHIFT_REG <= 'x;
		local_bb0_sub22_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_sub22_NO_SHIFT_REG <= 'x;
			local_bb0_sub22_valid_out_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_sub22_output_regs_ready)
			begin
				local_bb0_sub22_NO_SHIFT_REG <= (input_inSize_y + 32'hFFFFFFFF);
				local_bb0_sub22_valid_out_NO_SHIFT_REG <= local_bb0_sub22_inputs_ready;
			end
			else
			begin
				if (~(local_bb0_sub22_stall_in))
				begin
					local_bb0_sub22_valid_out_NO_SHIFT_REG <= local_bb0_sub22_wii_reg_NO_SHIFT_REG;
				end
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_sub22_wii_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_sub22_wii_reg_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_sub22_inputs_ready)
			begin
				local_bb0_sub22_wii_reg_NO_SHIFT_REG <= 1'b1;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb0_cmp9_inputs_ready;
 reg local_bb0_cmp9_wii_reg_NO_SHIFT_REG;
 reg local_bb0_cmp9_valid_out_NO_SHIFT_REG;
wire local_bb0_cmp9_stall_in;
wire local_bb0_cmp9_output_regs_ready;
 reg local_bb0_cmp9_NO_SHIFT_REG;
wire local_bb0_cmp9_causedstall;

assign local_bb0_cmp9_inputs_ready = (local_bb0_add6_valid_out_0_NO_SHIFT_REG & merge_node_valid_out_2_NO_SHIFT_REG);
assign local_bb0_cmp9_output_regs_ready = (~(local_bb0_cmp9_wii_reg_NO_SHIFT_REG) & (&(~(local_bb0_cmp9_valid_out_NO_SHIFT_REG) | ~(local_bb0_cmp9_stall_in))));
assign local_bb0_add6_stall_in_0 = (~(local_bb0_cmp9_wii_reg_NO_SHIFT_REG) & (~(local_bb0_cmp9_output_regs_ready) | ~(local_bb0_cmp9_inputs_ready)));
assign merge_node_stall_in_2 = (~(local_bb0_cmp9_wii_reg_NO_SHIFT_REG) & (~(local_bb0_cmp9_output_regs_ready) | ~(local_bb0_cmp9_inputs_ready)));
assign local_bb0_cmp9_causedstall = (local_bb0_cmp9_inputs_ready && (~(local_bb0_cmp9_output_regs_ready) && !(~(local_bb0_cmp9_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_cmp9_NO_SHIFT_REG <= 'x;
		local_bb0_cmp9_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_cmp9_NO_SHIFT_REG <= 'x;
			local_bb0_cmp9_valid_out_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_cmp9_output_regs_ready)
			begin
				local_bb0_cmp9_NO_SHIFT_REG <= ($signed(local_bb0_add6_NO_SHIFT_REG) > $signed(input_r));
				local_bb0_cmp9_valid_out_NO_SHIFT_REG <= local_bb0_cmp9_inputs_ready;
			end
			else
			begin
				if (~(local_bb0_cmp9_stall_in))
				begin
					local_bb0_cmp9_valid_out_NO_SHIFT_REG <= local_bb0_cmp9_wii_reg_NO_SHIFT_REG;
				end
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_cmp9_wii_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_cmp9_wii_reg_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_cmp9_inputs_ready)
			begin
				local_bb0_cmp9_wii_reg_NO_SHIFT_REG <= 1'b1;
			end
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_bb0_div_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb0_add6_reg_NO_SHIFT_REG;
 reg lvb_bb0_cmp9_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb0_sub20_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb0_sub22_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_1_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb0_sub22_valid_out_NO_SHIFT_REG & local_bb0_sub20_valid_out_NO_SHIFT_REG & local_bb0_cmp9_valid_out_NO_SHIFT_REG & local_bb0_div_valid_out_NO_SHIFT_REG & merge_node_valid_out_5_NO_SHIFT_REG & local_bb0_add6_valid_out_1_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb0_sub22_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb0_sub20_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb0_cmp9_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb0_div_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign merge_node_stall_in_5 = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb0_add6_stall_in_1 = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_bb0_div = lvb_bb0_div_reg_NO_SHIFT_REG;
assign lvb_bb0_add6 = lvb_bb0_add6_reg_NO_SHIFT_REG;
assign lvb_bb0_cmp9 = lvb_bb0_cmp9_reg_NO_SHIFT_REG;
assign lvb_bb0_sub20 = lvb_bb0_sub20_reg_NO_SHIFT_REG;
assign lvb_bb0_sub22 = lvb_bb0_sub22_reg_NO_SHIFT_REG;
assign lvb_input_global_id_0 = lvb_input_global_id_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_1 = lvb_input_global_id_1_reg_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_bb0_div_reg_NO_SHIFT_REG <= 'x;
		lvb_bb0_add6_reg_NO_SHIFT_REG <= 'x;
		lvb_bb0_cmp9_reg_NO_SHIFT_REG <= 'x;
		lvb_bb0_sub20_reg_NO_SHIFT_REG <= 'x;
		lvb_bb0_sub22_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_1_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_bb0_div_reg_NO_SHIFT_REG <= (local_bb0_div_NO_SHIFT_REG & 32'h7FFFFFFF);
			lvb_bb0_add6_reg_NO_SHIFT_REG <= local_bb0_add6_NO_SHIFT_REG;
			lvb_bb0_cmp9_reg_NO_SHIFT_REG <= local_bb0_cmp9_NO_SHIFT_REG;
			lvb_bb0_sub20_reg_NO_SHIFT_REG <= local_bb0_sub20_NO_SHIFT_REG;
			lvb_bb0_sub22_reg_NO_SHIFT_REG <= local_bb0_sub22_NO_SHIFT_REG;
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
module AOChalfSampleRobustImageKernel_basic_block_1
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_inSize_x,
		input [63:0] 		input_in,
		input [31:0] 		input_wii_div,
		input [31:0] 		input_wii_add6,
		input 		input_wii_cmp9,
		input [31:0] 		input_wii_sub20,
		input [31:0] 		input_wii_sub22,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_global_id_1,
		output 		valid_out,
		input 		stall_in,
		output [31:0] 		lvb_bb1_scalarizer_0mul,
		output [31:0] 		lvb_bb1_scalarizer_1mul,
		output [31:0] 		lvb_bb1_ld_,
		output [31:0] 		lvb_input_global_id_0,
		output [31:0] 		lvb_input_global_id_1,
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
		input 		clock2x
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


// This section implements an unregistered operation.
// 
wire local_bb1_scalarizer_1mul_valid_out_0;
wire local_bb1_scalarizer_1mul_stall_in_0;
wire local_bb1_scalarizer_1mul_valid_out_1;
wire local_bb1_scalarizer_1mul_stall_in_1;
wire local_bb1_scalarizer_1mul_inputs_ready;
wire local_bb1_scalarizer_1mul_stall_local;
wire [31:0] local_bb1_scalarizer_1mul;
 reg local_bb1_scalarizer_1mul_consumed_0_NO_SHIFT_REG;
 reg local_bb1_scalarizer_1mul_consumed_1_NO_SHIFT_REG;

assign local_bb1_scalarizer_1mul_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb1_scalarizer_1mul = (local_lvm_input_global_id_1_NO_SHIFT_REG << 32'h1);
assign local_bb1_scalarizer_1mul_stall_local = ((local_bb1_scalarizer_1mul_stall_in_0 & ~(local_bb1_scalarizer_1mul_consumed_0_NO_SHIFT_REG)) | (local_bb1_scalarizer_1mul_stall_in_1 & ~(local_bb1_scalarizer_1mul_consumed_1_NO_SHIFT_REG)));
assign local_bb1_scalarizer_1mul_valid_out_0 = (local_bb1_scalarizer_1mul_inputs_ready & ~(local_bb1_scalarizer_1mul_consumed_0_NO_SHIFT_REG));
assign local_bb1_scalarizer_1mul_valid_out_1 = (local_bb1_scalarizer_1mul_inputs_ready & ~(local_bb1_scalarizer_1mul_consumed_1_NO_SHIFT_REG));
assign merge_node_stall_in_0 = (|local_bb1_scalarizer_1mul_stall_local);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_scalarizer_1mul_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_scalarizer_1mul_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_scalarizer_1mul_consumed_0_NO_SHIFT_REG <= (local_bb1_scalarizer_1mul_inputs_ready & (local_bb1_scalarizer_1mul_consumed_0_NO_SHIFT_REG | ~(local_bb1_scalarizer_1mul_stall_in_0)) & local_bb1_scalarizer_1mul_stall_local);
		local_bb1_scalarizer_1mul_consumed_1_NO_SHIFT_REG <= (local_bb1_scalarizer_1mul_inputs_ready & (local_bb1_scalarizer_1mul_consumed_1_NO_SHIFT_REG | ~(local_bb1_scalarizer_1mul_stall_in_1)) & local_bb1_scalarizer_1mul_stall_local);
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

assign rnode_1to4_input_global_id_0_0_reg_4_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_1_NO_SHIFT_REG;
assign merge_node_stall_in_1 = rnode_1to4_input_global_id_0_0_stall_out_reg_4_NO_SHIFT_REG;
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


// This section implements a registered operation.
// 
wire local_bb1_mul5_inputs_ready;
 reg local_bb1_mul5_valid_out_NO_SHIFT_REG;
wire local_bb1_mul5_stall_in;
wire local_bb1_mul5_output_regs_ready;
wire [31:0] local_bb1_mul5;
 reg local_bb1_mul5_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_mul5_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_mul5_causedstall;
wire [63:0] rci_rcnode_1to165_rc2_input_global_id_1_0_reg_1;

acl_int_mult int_module_local_bb1_mul5 (
	.clock(clock),
	.dataa((local_bb1_scalarizer_1mul & 32'hFFFFFFFE)),
	.datab(input_inSize_x),
	.enable(local_bb1_mul5_output_regs_ready),
	.result(local_bb1_mul5)
);

defparam int_module_local_bb1_mul5.INPUT1_WIDTH = 32;
defparam int_module_local_bb1_mul5.INPUT2_WIDTH = 32;
defparam int_module_local_bb1_mul5.OUTPUT_WIDTH = 32;
defparam int_module_local_bb1_mul5.LATENCY = 3;
defparam int_module_local_bb1_mul5.SIGNED = 0;

assign local_bb1_mul5_inputs_ready = local_bb1_scalarizer_1mul_valid_out_0;
assign local_bb1_mul5_output_regs_ready = (&(~(local_bb1_mul5_valid_out_NO_SHIFT_REG) | ~(local_bb1_mul5_stall_in)));
assign local_bb1_scalarizer_1mul_stall_in_0 = (~(local_bb1_mul5_output_regs_ready) | ~(local_bb1_mul5_inputs_ready));
assign local_bb1_mul5_causedstall = (local_bb1_mul5_inputs_ready && (~(local_bb1_mul5_output_regs_ready) && !(~(local_bb1_mul5_output_regs_ready))));
assign rci_rcnode_1to165_rc2_input_global_id_1_0_reg_1[31:0] = local_lvm_input_global_id_1_NO_SHIFT_REG;
assign rci_rcnode_1to165_rc2_input_global_id_1_0_reg_1[63:32] = (local_bb1_scalarizer_1mul & 32'hFFFFFFFE);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul5_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul5_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul5_output_regs_ready)
		begin
			local_bb1_mul5_valid_pipe_0_NO_SHIFT_REG <= local_bb1_mul5_inputs_ready;
			local_bb1_mul5_valid_pipe_1_NO_SHIFT_REG <= local_bb1_mul5_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul5_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul5_output_regs_ready)
		begin
			local_bb1_mul5_valid_out_NO_SHIFT_REG <= local_bb1_mul5_valid_pipe_1_NO_SHIFT_REG;
		end
		else
		begin
			if (~(local_bb1_mul5_stall_in))
			begin
				local_bb1_mul5_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 164
//  * capacity = 164
 logic rcnode_1to165_rc2_input_global_id_1_0_valid_out_NO_SHIFT_REG;
 logic rcnode_1to165_rc2_input_global_id_1_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rcnode_1to165_rc2_input_global_id_1_0_NO_SHIFT_REG;
 logic rcnode_1to165_rc2_input_global_id_1_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rcnode_1to165_rc2_input_global_id_1_0_reg_165_NO_SHIFT_REG;
 logic rcnode_1to165_rc2_input_global_id_1_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rcnode_1to165_rc2_input_global_id_1_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rcnode_1to165_rc2_input_global_id_1_0_stall_out_0_reg_165_IP_NO_SHIFT_REG;
 logic rcnode_1to165_rc2_input_global_id_1_0_stall_out_0_reg_165_NO_SHIFT_REG;

acl_data_fifo rcnode_1to165_rc2_input_global_id_1_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rcnode_1to165_rc2_input_global_id_1_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rcnode_1to165_rc2_input_global_id_1_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rcnode_1to165_rc2_input_global_id_1_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rcnode_1to165_rc2_input_global_id_1_0_stall_out_0_reg_165_IP_NO_SHIFT_REG),
	.data_in(rci_rcnode_1to165_rc2_input_global_id_1_0_reg_1),
	.data_out(rcnode_1to165_rc2_input_global_id_1_0_reg_165_NO_SHIFT_REG)
);

defparam rcnode_1to165_rc2_input_global_id_1_0_reg_165_fifo.DEPTH = 165;
defparam rcnode_1to165_rc2_input_global_id_1_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rcnode_1to165_rc2_input_global_id_1_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rcnode_1to165_rc2_input_global_id_1_0_reg_165_fifo.IMPL = "ram";

assign rcnode_1to165_rc2_input_global_id_1_0_reg_165_inputs_ready_NO_SHIFT_REG = (merge_node_valid_out_2_NO_SHIFT_REG & local_bb1_scalarizer_1mul_valid_out_1);
assign rcnode_1to165_rc2_input_global_id_1_0_stall_out_0_reg_165_NO_SHIFT_REG = (~(rcnode_1to165_rc2_input_global_id_1_0_reg_165_inputs_ready_NO_SHIFT_REG) | rcnode_1to165_rc2_input_global_id_1_0_stall_out_0_reg_165_IP_NO_SHIFT_REG);
assign merge_node_stall_in_2 = rcnode_1to165_rc2_input_global_id_1_0_stall_out_0_reg_165_NO_SHIFT_REG;
assign local_bb1_scalarizer_1mul_stall_in_1 = rcnode_1to165_rc2_input_global_id_1_0_stall_out_0_reg_165_NO_SHIFT_REG;
assign rcnode_1to165_rc2_input_global_id_1_0_NO_SHIFT_REG = rcnode_1to165_rc2_input_global_id_1_0_reg_165_NO_SHIFT_REG;
assign rcnode_1to165_rc2_input_global_id_1_0_stall_in_reg_165_NO_SHIFT_REG = rcnode_1to165_rc2_input_global_id_1_0_stall_in_NO_SHIFT_REG;
assign rcnode_1to165_rc2_input_global_id_1_0_valid_out_NO_SHIFT_REG = rcnode_1to165_rc2_input_global_id_1_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_scalarizer_0mul_stall_local;
wire [31:0] local_bb1_scalarizer_0mul;

assign local_bb1_scalarizer_0mul = (rnode_1to4_input_global_id_0_0_NO_SHIFT_REG << 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_scalarizer_0mul_valid_out_1;
wire local_bb1_scalarizer_0mul_stall_in_1;
wire local_bb1_add_valid_out;
wire local_bb1_add_stall_in;
wire local_bb1_add_inputs_ready;
wire local_bb1_add_stall_local;
wire [31:0] local_bb1_add;
 reg local_bb1_scalarizer_0mul_consumed_1_NO_SHIFT_REG;
 reg local_bb1_add_consumed_0_NO_SHIFT_REG;
wire [63:0] rci_rcnode_4to165_rc1_input_global_id_0_0_reg_4;

assign local_bb1_add_inputs_ready = (rnode_1to4_input_global_id_0_0_valid_out_0_NO_SHIFT_REG & local_bb1_mul5_valid_out_NO_SHIFT_REG);
assign local_bb1_add = ((local_bb1_mul5 & 32'hFFFFFFFE) + (local_bb1_scalarizer_0mul & 32'hFFFFFFFE));
assign local_bb1_add_stall_local = ((local_bb1_scalarizer_0mul_stall_in_1 & ~(local_bb1_scalarizer_0mul_consumed_1_NO_SHIFT_REG)) | (local_bb1_add_stall_in & ~(local_bb1_add_consumed_0_NO_SHIFT_REG)));
assign local_bb1_scalarizer_0mul_valid_out_1 = (local_bb1_add_inputs_ready & ~(local_bb1_scalarizer_0mul_consumed_1_NO_SHIFT_REG));
assign local_bb1_add_valid_out = (local_bb1_add_inputs_ready & ~(local_bb1_add_consumed_0_NO_SHIFT_REG));
assign rnode_1to4_input_global_id_0_0_stall_in_0_NO_SHIFT_REG = (local_bb1_add_stall_local | ~(local_bb1_add_inputs_ready));
assign local_bb1_mul5_stall_in = (local_bb1_add_stall_local | ~(local_bb1_add_inputs_ready));
assign rci_rcnode_4to165_rc1_input_global_id_0_0_reg_4[31:0] = rnode_1to4_input_global_id_0_1_NO_SHIFT_REG;
assign rci_rcnode_4to165_rc1_input_global_id_0_0_reg_4[63:32] = (local_bb1_scalarizer_0mul & 32'hFFFFFFFE);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_scalarizer_0mul_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_add_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_scalarizer_0mul_consumed_1_NO_SHIFT_REG <= (local_bb1_add_inputs_ready & (local_bb1_scalarizer_0mul_consumed_1_NO_SHIFT_REG | ~(local_bb1_scalarizer_0mul_stall_in_1)) & local_bb1_add_stall_local);
		local_bb1_add_consumed_0_NO_SHIFT_REG <= (local_bb1_add_inputs_ready & (local_bb1_add_consumed_0_NO_SHIFT_REG | ~(local_bb1_add_stall_in)) & local_bb1_add_stall_local);
	end
end


// Register node:
//  * latency = 161
//  * capacity = 161
 logic rcnode_4to165_rc1_input_global_id_0_0_valid_out_NO_SHIFT_REG;
 logic rcnode_4to165_rc1_input_global_id_0_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rcnode_4to165_rc1_input_global_id_0_0_NO_SHIFT_REG;
 logic rcnode_4to165_rc1_input_global_id_0_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rcnode_4to165_rc1_input_global_id_0_0_reg_165_NO_SHIFT_REG;
 logic rcnode_4to165_rc1_input_global_id_0_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rcnode_4to165_rc1_input_global_id_0_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rcnode_4to165_rc1_input_global_id_0_0_stall_out_0_reg_165_IP_NO_SHIFT_REG;
 logic rcnode_4to165_rc1_input_global_id_0_0_stall_out_0_reg_165_NO_SHIFT_REG;

acl_data_fifo rcnode_4to165_rc1_input_global_id_0_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rcnode_4to165_rc1_input_global_id_0_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rcnode_4to165_rc1_input_global_id_0_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rcnode_4to165_rc1_input_global_id_0_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rcnode_4to165_rc1_input_global_id_0_0_stall_out_0_reg_165_IP_NO_SHIFT_REG),
	.data_in(rci_rcnode_4to165_rc1_input_global_id_0_0_reg_4),
	.data_out(rcnode_4to165_rc1_input_global_id_0_0_reg_165_NO_SHIFT_REG)
);

defparam rcnode_4to165_rc1_input_global_id_0_0_reg_165_fifo.DEPTH = 162;
defparam rcnode_4to165_rc1_input_global_id_0_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rcnode_4to165_rc1_input_global_id_0_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rcnode_4to165_rc1_input_global_id_0_0_reg_165_fifo.IMPL = "ram";

assign rcnode_4to165_rc1_input_global_id_0_0_reg_165_inputs_ready_NO_SHIFT_REG = (rnode_1to4_input_global_id_0_0_valid_out_1_NO_SHIFT_REG & local_bb1_scalarizer_0mul_valid_out_1);
assign rcnode_4to165_rc1_input_global_id_0_0_stall_out_0_reg_165_NO_SHIFT_REG = (~(rcnode_4to165_rc1_input_global_id_0_0_reg_165_inputs_ready_NO_SHIFT_REG) | rcnode_4to165_rc1_input_global_id_0_0_stall_out_0_reg_165_IP_NO_SHIFT_REG);
assign rnode_1to4_input_global_id_0_0_stall_in_1_NO_SHIFT_REG = rcnode_4to165_rc1_input_global_id_0_0_stall_out_0_reg_165_NO_SHIFT_REG;
assign local_bb1_scalarizer_0mul_stall_in_1 = rcnode_4to165_rc1_input_global_id_0_0_stall_out_0_reg_165_NO_SHIFT_REG;
assign rcnode_4to165_rc1_input_global_id_0_0_NO_SHIFT_REG = rcnode_4to165_rc1_input_global_id_0_0_reg_165_NO_SHIFT_REG;
assign rcnode_4to165_rc1_input_global_id_0_0_stall_in_reg_165_NO_SHIFT_REG = rcnode_4to165_rc1_input_global_id_0_0_stall_in_NO_SHIFT_REG;
assign rcnode_4to165_rc1_input_global_id_0_0_valid_out_NO_SHIFT_REG = rcnode_4to165_rc1_input_global_id_0_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb1_add_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to5_bb1_add_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_4to5_bb1_add_0_NO_SHIFT_REG;
 logic rnode_4to5_bb1_add_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_4to5_bb1_add_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_add_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_add_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_add_0_stall_out_reg_5_NO_SHIFT_REG;
wire [127:0] rci_rcnode_165to166_rc0_input_global_id_1_0_reg_165;

acl_data_fifo rnode_4to5_bb1_add_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb1_add_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb1_add_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb1_add_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb1_add_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in((local_bb1_add & 32'hFFFFFFFE)),
	.data_out(rnode_4to5_bb1_add_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb1_add_0_reg_5_fifo.DEPTH = 1;
defparam rnode_4to5_bb1_add_0_reg_5_fifo.DATA_WIDTH = 32;
defparam rnode_4to5_bb1_add_0_reg_5_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_4to5_bb1_add_0_reg_5_fifo.IMPL = "ll_reg";

assign rnode_4to5_bb1_add_0_reg_5_inputs_ready_NO_SHIFT_REG = local_bb1_add_valid_out;
assign local_bb1_add_stall_in = rnode_4to5_bb1_add_0_stall_out_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb1_add_0_NO_SHIFT_REG = rnode_4to5_bb1_add_0_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb1_add_0_stall_in_reg_5_NO_SHIFT_REG = rnode_4to5_bb1_add_0_stall_in_NO_SHIFT_REG;
assign rnode_4to5_bb1_add_0_valid_out_NO_SHIFT_REG = rnode_4to5_bb1_add_0_valid_out_reg_5_NO_SHIFT_REG;
assign rci_rcnode_165to166_rc0_input_global_id_1_0_reg_165[31:0] = rcnode_1to165_rc2_input_global_id_1_0_NO_SHIFT_REG[31:0];
assign rci_rcnode_165to166_rc0_input_global_id_1_0_reg_165[63:32] = (rcnode_1to165_rc2_input_global_id_1_0_NO_SHIFT_REG[63:32] & 32'hFFFFFFFE);
assign rci_rcnode_165to166_rc0_input_global_id_1_0_reg_165[95:64] = rcnode_4to165_rc1_input_global_id_0_0_NO_SHIFT_REG[31:0];
assign rci_rcnode_165to166_rc0_input_global_id_1_0_reg_165[127:96] = (rcnode_4to165_rc1_input_global_id_0_0_NO_SHIFT_REG[63:32] & 32'hFFFFFFFE);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rcnode_165to166_rc0_input_global_id_1_0_valid_out_NO_SHIFT_REG;
 logic rcnode_165to166_rc0_input_global_id_1_0_stall_in_NO_SHIFT_REG;
 logic [127:0] rcnode_165to166_rc0_input_global_id_1_0_NO_SHIFT_REG;
 logic rcnode_165to166_rc0_input_global_id_1_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic [127:0] rcnode_165to166_rc0_input_global_id_1_0_reg_166_NO_SHIFT_REG;
 logic rcnode_165to166_rc0_input_global_id_1_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rcnode_165to166_rc0_input_global_id_1_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rcnode_165to166_rc0_input_global_id_1_0_stall_out_0_reg_166_IP_NO_SHIFT_REG;
 logic rcnode_165to166_rc0_input_global_id_1_0_stall_out_0_reg_166_NO_SHIFT_REG;

acl_data_fifo rcnode_165to166_rc0_input_global_id_1_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rcnode_165to166_rc0_input_global_id_1_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rcnode_165to166_rc0_input_global_id_1_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rcnode_165to166_rc0_input_global_id_1_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rcnode_165to166_rc0_input_global_id_1_0_stall_out_0_reg_166_IP_NO_SHIFT_REG),
	.data_in(rci_rcnode_165to166_rc0_input_global_id_1_0_reg_165),
	.data_out(rcnode_165to166_rc0_input_global_id_1_0_reg_166_NO_SHIFT_REG)
);

defparam rcnode_165to166_rc0_input_global_id_1_0_reg_166_fifo.DEPTH = 1;
defparam rcnode_165to166_rc0_input_global_id_1_0_reg_166_fifo.DATA_WIDTH = 128;
defparam rcnode_165to166_rc0_input_global_id_1_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rcnode_165to166_rc0_input_global_id_1_0_reg_166_fifo.IMPL = "ll_reg";

assign rcnode_165to166_rc0_input_global_id_1_0_reg_166_inputs_ready_NO_SHIFT_REG = (rcnode_1to165_rc2_input_global_id_1_0_valid_out_NO_SHIFT_REG & rcnode_4to165_rc1_input_global_id_0_0_valid_out_NO_SHIFT_REG);
assign rcnode_165to166_rc0_input_global_id_1_0_stall_out_0_reg_166_NO_SHIFT_REG = (~(rcnode_165to166_rc0_input_global_id_1_0_reg_166_inputs_ready_NO_SHIFT_REG) | rcnode_165to166_rc0_input_global_id_1_0_stall_out_0_reg_166_IP_NO_SHIFT_REG);
assign rcnode_1to165_rc2_input_global_id_1_0_stall_in_NO_SHIFT_REG = rcnode_165to166_rc0_input_global_id_1_0_stall_out_0_reg_166_NO_SHIFT_REG;
assign rcnode_4to165_rc1_input_global_id_0_0_stall_in_NO_SHIFT_REG = rcnode_165to166_rc0_input_global_id_1_0_stall_out_0_reg_166_NO_SHIFT_REG;
assign rcnode_165to166_rc0_input_global_id_1_0_NO_SHIFT_REG = rcnode_165to166_rc0_input_global_id_1_0_reg_166_NO_SHIFT_REG;
assign rcnode_165to166_rc0_input_global_id_1_0_stall_in_reg_166_NO_SHIFT_REG = rcnode_165to166_rc0_input_global_id_1_0_stall_in_NO_SHIFT_REG;
assign rcnode_165to166_rc0_input_global_id_1_0_valid_out_NO_SHIFT_REG = rcnode_165to166_rc0_input_global_id_1_0_valid_out_reg_166_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_idxprom_stall_local;
wire [63:0] local_bb1_idxprom;

assign local_bb1_idxprom[63:32] = 32'h0;
assign local_bb1_idxprom[31:0] = (rnode_4to5_bb1_add_0_NO_SHIFT_REG & 32'hFFFFFFFE);

// This section implements an unregistered operation.
// 
wire local_bb1_arrayidx_valid_out;
wire local_bb1_arrayidx_stall_in;
wire local_bb1_arrayidx_inputs_ready;
wire local_bb1_arrayidx_stall_local;
wire [63:0] local_bb1_arrayidx;

assign local_bb1_arrayidx_inputs_ready = rnode_4to5_bb1_add_0_valid_out_NO_SHIFT_REG;
assign local_bb1_arrayidx = ((input_in & 64'hFFFFFFFFFFFFFC00) + ((local_bb1_idxprom & 64'hFFFFFFFE) << 6'h2));
assign local_bb1_arrayidx_valid_out = local_bb1_arrayidx_inputs_ready;
assign local_bb1_arrayidx_stall_local = local_bb1_arrayidx_stall_in;
assign rnode_4to5_bb1_add_0_stall_in_NO_SHIFT_REG = (|local_bb1_arrayidx_stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb1_arrayidx_0_valid_out_NO_SHIFT_REG;
 logic rnode_5to6_bb1_arrayidx_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb1_arrayidx_0_NO_SHIFT_REG;
 logic rnode_5to6_bb1_arrayidx_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb1_arrayidx_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_arrayidx_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_arrayidx_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_arrayidx_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb1_arrayidx_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb1_arrayidx_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb1_arrayidx_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb1_arrayidx_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb1_arrayidx_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in((local_bb1_arrayidx & 64'hFFFFFFFFFFFFFFF8)),
	.data_out(rnode_5to6_bb1_arrayidx_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb1_arrayidx_0_reg_6_fifo.DEPTH = 2;
defparam rnode_5to6_bb1_arrayidx_0_reg_6_fifo.DATA_WIDTH = 64;
defparam rnode_5to6_bb1_arrayidx_0_reg_6_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_5to6_bb1_arrayidx_0_reg_6_fifo.IMPL = "ll_reg";

assign rnode_5to6_bb1_arrayidx_0_reg_6_inputs_ready_NO_SHIFT_REG = local_bb1_arrayidx_valid_out;
assign local_bb1_arrayidx_stall_in = rnode_5to6_bb1_arrayidx_0_stall_out_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb1_arrayidx_0_NO_SHIFT_REG = rnode_5to6_bb1_arrayidx_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb1_arrayidx_0_stall_in_reg_6_NO_SHIFT_REG = rnode_5to6_bb1_arrayidx_0_stall_in_NO_SHIFT_REG;
assign rnode_5to6_bb1_arrayidx_0_valid_out_NO_SHIFT_REG = rnode_5to6_bb1_arrayidx_0_valid_out_reg_6_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_ld__inputs_ready;
 reg local_bb1_ld__valid_out_NO_SHIFT_REG;
wire local_bb1_ld__stall_in;
wire local_bb1_ld__output_regs_ready;
wire local_bb1_ld__fu_stall_out;
wire local_bb1_ld__fu_valid_out;
wire [31:0] local_bb1_ld__lsu_dataout;
 reg [31:0] local_bb1_ld__NO_SHIFT_REG;
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
	.i_address((rnode_5to6_bb1_arrayidx_0_NO_SHIFT_REG & 64'hFFFFFFFFFFFFFFF8)),
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
defparam lsu_local_bb1_ld_.WIDTH_BYTES = 4;
defparam lsu_local_bb1_ld_.MWIDTH_BYTES = 64;
defparam lsu_local_bb1_ld_.WRITEDATAWIDTH_BYTES = 64;
defparam lsu_local_bb1_ld_.ALIGNMENT_BYTES = 8;
defparam lsu_local_bb1_ld_.READ = 1;
defparam lsu_local_bb1_ld_.ATOMIC = 0;
defparam lsu_local_bb1_ld_.WIDTH = 32;
defparam lsu_local_bb1_ld_.MWIDTH = 512;
defparam lsu_local_bb1_ld_.ATOMIC_WIDTH = 3;
defparam lsu_local_bb1_ld_.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb1_ld_.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb1_ld_.MEMORY_SIDE_MEM_LATENCY = 99;
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

assign local_bb1_ld__inputs_ready = rnode_5to6_bb1_arrayidx_0_valid_out_NO_SHIFT_REG;
assign local_bb1_ld__output_regs_ready = (&(~(local_bb1_ld__valid_out_NO_SHIFT_REG) | ~(local_bb1_ld__stall_in)));
assign rnode_5to6_bb1_arrayidx_0_stall_in_NO_SHIFT_REG = (local_bb1_ld__fu_stall_out | ~(local_bb1_ld__inputs_ready));
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
wire rstag_166to166_bb1_ld__valid_out;
wire rstag_166to166_bb1_ld__stall_in;
wire rstag_166to166_bb1_ld__inputs_ready;
wire rstag_166to166_bb1_ld__stall_local;
 reg rstag_166to166_bb1_ld__staging_valid_NO_SHIFT_REG;
wire rstag_166to166_bb1_ld__combined_valid;
 reg [31:0] rstag_166to166_bb1_ld__staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_166to166_bb1_ld_;

assign rstag_166to166_bb1_ld__inputs_ready = local_bb1_ld__valid_out_NO_SHIFT_REG;
assign rstag_166to166_bb1_ld_ = (rstag_166to166_bb1_ld__staging_valid_NO_SHIFT_REG ? rstag_166to166_bb1_ld__staging_reg_NO_SHIFT_REG : local_bb1_ld__NO_SHIFT_REG);
assign rstag_166to166_bb1_ld__combined_valid = (rstag_166to166_bb1_ld__staging_valid_NO_SHIFT_REG | rstag_166to166_bb1_ld__inputs_ready);
assign rstag_166to166_bb1_ld__valid_out = rstag_166to166_bb1_ld__combined_valid;
assign rstag_166to166_bb1_ld__stall_local = rstag_166to166_bb1_ld__stall_in;
assign local_bb1_ld__stall_in = (|rstag_166to166_bb1_ld__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_166to166_bb1_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_166to166_bb1_ld__staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_166to166_bb1_ld__stall_local)
		begin
			if (~(rstag_166to166_bb1_ld__staging_valid_NO_SHIFT_REG))
			begin
				rstag_166to166_bb1_ld__staging_valid_NO_SHIFT_REG <= rstag_166to166_bb1_ld__inputs_ready;
			end
		end
		else
		begin
			rstag_166to166_bb1_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_166to166_bb1_ld__staging_valid_NO_SHIFT_REG))
		begin
			rstag_166to166_bb1_ld__staging_reg_NO_SHIFT_REG <= local_bb1_ld__NO_SHIFT_REG;
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_bb1_scalarizer_0mul_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb1_scalarizer_1mul_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb1_ld__reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_1_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (rcnode_165to166_rc0_input_global_id_1_0_valid_out_NO_SHIFT_REG & rstag_166to166_bb1_ld__valid_out);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign rcnode_165to166_rc0_input_global_id_1_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rstag_166to166_bb1_ld__stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_bb1_scalarizer_0mul = lvb_bb1_scalarizer_0mul_reg_NO_SHIFT_REG;
assign lvb_bb1_scalarizer_1mul = lvb_bb1_scalarizer_1mul_reg_NO_SHIFT_REG;
assign lvb_bb1_ld_ = lvb_bb1_ld__reg_NO_SHIFT_REG;
assign lvb_input_global_id_0 = lvb_input_global_id_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_1 = lvb_input_global_id_1_reg_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_bb1_scalarizer_0mul_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_scalarizer_1mul_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_ld__reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_1_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_bb1_scalarizer_0mul_reg_NO_SHIFT_REG <= (rcnode_165to166_rc0_input_global_id_1_0_NO_SHIFT_REG[127:96] & 32'hFFFFFFFE);
			lvb_bb1_scalarizer_1mul_reg_NO_SHIFT_REG <= (rcnode_165to166_rc0_input_global_id_1_0_NO_SHIFT_REG[63:32] & 32'hFFFFFFFE);
			lvb_bb1_ld__reg_NO_SHIFT_REG <= rstag_166to166_bb1_ld_;
			lvb_input_global_id_0_reg_NO_SHIFT_REG <= rcnode_165to166_rc0_input_global_id_1_0_NO_SHIFT_REG[95:64];
			lvb_input_global_id_1_reg_NO_SHIFT_REG <= rcnode_165to166_rc0_input_global_id_1_0_NO_SHIFT_REG[31:0];
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
module AOChalfSampleRobustImageKernel_basic_block_2
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_inSize_x,
		input [31:0] 		input_wii_div,
		input [31:0] 		input_wii_add6,
		input 		input_wii_cmp9,
		input [31:0] 		input_wii_sub20,
		input [31:0] 		input_wii_sub22,
		input 		valid_in_0,
		output 		stall_out_0,
		input [31:0] 		input_scalarizer_0mul_0,
		input [31:0] 		input_scalarizer_1mul_0,
		input [31:0] 		input_ld__0,
		input [31:0] 		input_i_012_0,
		input [31:0] 		input_t_011_0,
		input [31:0] 		input_sum_010_0,
		input [31:0] 		input_global_id_0_0,
		input [31:0] 		input_global_id_1_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input [31:0] 		input_scalarizer_0mul_1,
		input [31:0] 		input_scalarizer_1mul_1,
		input [31:0] 		input_ld__1,
		input [31:0] 		input_i_012_1,
		input [31:0] 		input_t_011_1,
		input [31:0] 		input_sum_010_1,
		input [31:0] 		input_global_id_0_1,
		input [31:0] 		input_global_id_1_1,
		output 		valid_out,
		input 		stall_in,
		output [31:0] 		lvb_scalarizer_0mul,
		output [31:0] 		lvb_scalarizer_1mul,
		output [31:0] 		lvb_ld_,
		output [31:0] 		lvb_i_012,
		output [31:0] 		lvb_t_011,
		output [31:0] 		lvb_sum_010,
		output [31:0] 		lvb_bb2_mul25,
		output [31:0] 		lvb_input_global_id_0,
		output [31:0] 		lvb_input_global_id_1,
		input [31:0] 		workgroup_size,
		input 		start
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
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_scalarizer_0mul_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_scalarizer_1mul_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_i_012_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_t_011_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_sum_010_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_1_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_scalarizer_0mul_NO_SHIFT_REG;
 reg [31:0] local_lvm_scalarizer_1mul_NO_SHIFT_REG;
 reg [31:0] local_lvm_ld__NO_SHIFT_REG;
 reg [31:0] local_lvm_i_012_NO_SHIFT_REG;
 reg [31:0] local_lvm_t_011_NO_SHIFT_REG;
 reg [31:0] local_lvm_sum_010_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_1_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_scalarizer_0mul_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_scalarizer_1mul_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_i_012_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_t_011_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_sum_010_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_1_1_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG));
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
		input_scalarizer_0mul_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_scalarizer_1mul_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__0_staging_reg_NO_SHIFT_REG <= 'x;
		input_i_012_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_t_011_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_sum_010_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_0_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_1_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_scalarizer_0mul_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_scalarizer_1mul_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__1_staging_reg_NO_SHIFT_REG <= 'x;
		input_i_012_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_t_011_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_sum_010_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_0_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_1_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_scalarizer_0mul_0_staging_reg_NO_SHIFT_REG <= input_scalarizer_0mul_0;
				input_scalarizer_1mul_0_staging_reg_NO_SHIFT_REG <= input_scalarizer_1mul_0;
				input_ld__0_staging_reg_NO_SHIFT_REG <= input_ld__0;
				input_i_012_0_staging_reg_NO_SHIFT_REG <= input_i_012_0;
				input_t_011_0_staging_reg_NO_SHIFT_REG <= input_t_011_0;
				input_sum_010_0_staging_reg_NO_SHIFT_REG <= input_sum_010_0;
				input_global_id_0_0_staging_reg_NO_SHIFT_REG <= input_global_id_0_0;
				input_global_id_1_0_staging_reg_NO_SHIFT_REG <= input_global_id_1_0;
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
				input_scalarizer_0mul_1_staging_reg_NO_SHIFT_REG <= input_scalarizer_0mul_1;
				input_scalarizer_1mul_1_staging_reg_NO_SHIFT_REG <= input_scalarizer_1mul_1;
				input_ld__1_staging_reg_NO_SHIFT_REG <= input_ld__1;
				input_i_012_1_staging_reg_NO_SHIFT_REG <= input_i_012_1;
				input_t_011_1_staging_reg_NO_SHIFT_REG <= input_t_011_1;
				input_sum_010_1_staging_reg_NO_SHIFT_REG <= input_sum_010_1;
				input_global_id_0_1_staging_reg_NO_SHIFT_REG <= input_global_id_0_1;
				input_global_id_1_1_staging_reg_NO_SHIFT_REG <= input_global_id_1_1;
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
					local_lvm_scalarizer_0mul_NO_SHIFT_REG <= input_scalarizer_0mul_0_staging_reg_NO_SHIFT_REG;
					local_lvm_scalarizer_1mul_NO_SHIFT_REG <= input_scalarizer_1mul_0_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__0_staging_reg_NO_SHIFT_REG;
					local_lvm_i_012_NO_SHIFT_REG <= input_i_012_0_staging_reg_NO_SHIFT_REG;
					local_lvm_t_011_NO_SHIFT_REG <= input_t_011_0_staging_reg_NO_SHIFT_REG;
					local_lvm_sum_010_NO_SHIFT_REG <= input_sum_010_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_scalarizer_0mul_NO_SHIFT_REG <= input_scalarizer_0mul_0;
					local_lvm_scalarizer_1mul_NO_SHIFT_REG <= input_scalarizer_1mul_0;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__0;
					local_lvm_i_012_NO_SHIFT_REG <= input_i_012_0;
					local_lvm_t_011_NO_SHIFT_REG <= input_t_011_0;
					local_lvm_sum_010_NO_SHIFT_REG <= input_sum_010_0;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_0;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_scalarizer_0mul_NO_SHIFT_REG <= input_scalarizer_0mul_1_staging_reg_NO_SHIFT_REG;
					local_lvm_scalarizer_1mul_NO_SHIFT_REG <= input_scalarizer_1mul_1_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__1_staging_reg_NO_SHIFT_REG;
					local_lvm_i_012_NO_SHIFT_REG <= input_i_012_1_staging_reg_NO_SHIFT_REG;
					local_lvm_t_011_NO_SHIFT_REG <= input_t_011_1_staging_reg_NO_SHIFT_REG;
					local_lvm_sum_010_NO_SHIFT_REG <= input_sum_010_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_scalarizer_0mul_NO_SHIFT_REG <= input_scalarizer_0mul_1;
					local_lvm_scalarizer_1mul_NO_SHIFT_REG <= input_scalarizer_1mul_1;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__1;
					local_lvm_i_012_NO_SHIFT_REG <= input_i_012_1;
					local_lvm_t_011_NO_SHIFT_REG <= input_t_011_1;
					local_lvm_sum_010_NO_SHIFT_REG <= input_sum_010_1;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_1;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_1;
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
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
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
wire local_bb2_add17_valid_out;
wire local_bb2_add17_stall_in;
wire local_bb2_add17_inputs_ready;
wire local_bb2_add17_stall_local;
wire [31:0] local_bb2_add17;
wire [255:0] rci_rcnode_1to6_rc1_scalarizer_0mul_0_reg_1;

assign local_bb2_add17_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb2_add17 = (local_lvm_i_012_NO_SHIFT_REG + (local_lvm_scalarizer_1mul_NO_SHIFT_REG & 32'hFFFFFFFE));
assign local_bb2_add17_valid_out = local_bb2_add17_inputs_ready;
assign local_bb2_add17_stall_local = local_bb2_add17_stall_in;
assign merge_node_stall_in_0 = (|local_bb2_add17_stall_local);
assign rci_rcnode_1to6_rc1_scalarizer_0mul_0_reg_1[31:0] = (local_lvm_scalarizer_0mul_NO_SHIFT_REG & 32'hFFFFFFFE);
assign rci_rcnode_1to6_rc1_scalarizer_0mul_0_reg_1[63:32] = (local_lvm_scalarizer_1mul_NO_SHIFT_REG & 32'hFFFFFFFE);
assign rci_rcnode_1to6_rc1_scalarizer_0mul_0_reg_1[95:64] = local_lvm_ld__NO_SHIFT_REG;
assign rci_rcnode_1to6_rc1_scalarizer_0mul_0_reg_1[127:96] = local_lvm_i_012_NO_SHIFT_REG;
assign rci_rcnode_1to6_rc1_scalarizer_0mul_0_reg_1[159:128] = local_lvm_t_011_NO_SHIFT_REG;
assign rci_rcnode_1to6_rc1_scalarizer_0mul_0_reg_1[191:160] = local_lvm_sum_010_NO_SHIFT_REG;
assign rci_rcnode_1to6_rc1_scalarizer_0mul_0_reg_1[223:192] = local_lvm_input_global_id_0_NO_SHIFT_REG;
assign rci_rcnode_1to6_rc1_scalarizer_0mul_0_reg_1[255:224] = local_lvm_input_global_id_1_NO_SHIFT_REG;

// Register node:
//  * latency = 5
//  * capacity = 5
 logic rcnode_1to6_rc1_scalarizer_0mul_0_valid_out_NO_SHIFT_REG;
 logic rcnode_1to6_rc1_scalarizer_0mul_0_stall_in_NO_SHIFT_REG;
 logic [255:0] rcnode_1to6_rc1_scalarizer_0mul_0_NO_SHIFT_REG;
 logic rcnode_1to6_rc1_scalarizer_0mul_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [255:0] rcnode_1to6_rc1_scalarizer_0mul_0_reg_6_NO_SHIFT_REG;
 logic rcnode_1to6_rc1_scalarizer_0mul_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rcnode_1to6_rc1_scalarizer_0mul_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rcnode_1to6_rc1_scalarizer_0mul_0_stall_out_reg_6_IP_NO_SHIFT_REG;
 logic rcnode_1to6_rc1_scalarizer_0mul_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rcnode_1to6_rc1_scalarizer_0mul_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rcnode_1to6_rc1_scalarizer_0mul_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rcnode_1to6_rc1_scalarizer_0mul_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rcnode_1to6_rc1_scalarizer_0mul_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rcnode_1to6_rc1_scalarizer_0mul_0_stall_out_reg_6_IP_NO_SHIFT_REG),
	.data_in(rci_rcnode_1to6_rc1_scalarizer_0mul_0_reg_1),
	.data_out(rcnode_1to6_rc1_scalarizer_0mul_0_reg_6_NO_SHIFT_REG)
);

defparam rcnode_1to6_rc1_scalarizer_0mul_0_reg_6_fifo.DEPTH = 6;
defparam rcnode_1to6_rc1_scalarizer_0mul_0_reg_6_fifo.DATA_WIDTH = 256;
defparam rcnode_1to6_rc1_scalarizer_0mul_0_reg_6_fifo.ALLOW_FULL_WRITE = 0;
defparam rcnode_1to6_rc1_scalarizer_0mul_0_reg_6_fifo.IMPL = "ll_reg";

assign rcnode_1to6_rc1_scalarizer_0mul_0_reg_6_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_1_NO_SHIFT_REG;
assign rcnode_1to6_rc1_scalarizer_0mul_0_stall_out_reg_6_NO_SHIFT_REG = (~(rcnode_1to6_rc1_scalarizer_0mul_0_reg_6_inputs_ready_NO_SHIFT_REG) | rcnode_1to6_rc1_scalarizer_0mul_0_stall_out_reg_6_IP_NO_SHIFT_REG);
assign merge_node_stall_in_1 = rcnode_1to6_rc1_scalarizer_0mul_0_stall_out_reg_6_NO_SHIFT_REG;
assign rcnode_1to6_rc1_scalarizer_0mul_0_NO_SHIFT_REG = rcnode_1to6_rc1_scalarizer_0mul_0_reg_6_NO_SHIFT_REG;
assign rcnode_1to6_rc1_scalarizer_0mul_0_stall_in_reg_6_NO_SHIFT_REG = rcnode_1to6_rc1_scalarizer_0mul_0_stall_in_NO_SHIFT_REG;
assign rcnode_1to6_rc1_scalarizer_0mul_0_valid_out_NO_SHIFT_REG = rcnode_1to6_rc1_scalarizer_0mul_0_valid_out_reg_6_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb2_add17_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_add17_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb2_add17_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_add17_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_bb2_add17_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb2_add17_1_NO_SHIFT_REG;
 logic rnode_1to2_bb2_add17_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_add17_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb2_add17_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_add17_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb2_add17_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_add17_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_add17_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_add17_0_stall_out_reg_2_NO_SHIFT_REG;
 reg rnode_1to2_bb2_add17_0_consumed_0_NO_SHIFT_REG;
 reg rnode_1to2_bb2_add17_0_consumed_1_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb2_add17_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb2_add17_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb2_add17_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb2_add17_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb2_add17_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb2_add17),
	.data_out(rnode_1to2_bb2_add17_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb2_add17_0_reg_2_fifo.DEPTH = 1;
defparam rnode_1to2_bb2_add17_0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_bb2_add17_0_reg_2_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_1to2_bb2_add17_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb2_add17_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb2_add17_valid_out;
assign local_bb2_add17_stall_in = rnode_1to2_bb2_add17_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_add17_0_stall_in_0_reg_2_NO_SHIFT_REG = ((rnode_1to2_bb2_add17_0_stall_in_0_NO_SHIFT_REG & ~(rnode_1to2_bb2_add17_0_consumed_0_NO_SHIFT_REG)) | (rnode_1to2_bb2_add17_0_stall_in_1_NO_SHIFT_REG & ~(rnode_1to2_bb2_add17_0_consumed_1_NO_SHIFT_REG)) | 1'b0);
assign rnode_1to2_bb2_add17_0_valid_out_0_NO_SHIFT_REG = (rnode_1to2_bb2_add17_0_valid_out_0_reg_2_NO_SHIFT_REG & ~(rnode_1to2_bb2_add17_0_consumed_0_NO_SHIFT_REG));
assign rnode_1to2_bb2_add17_0_valid_out_1_NO_SHIFT_REG = (rnode_1to2_bb2_add17_0_valid_out_0_reg_2_NO_SHIFT_REG & ~(rnode_1to2_bb2_add17_0_consumed_1_NO_SHIFT_REG));
assign rnode_1to2_bb2_add17_0_valid_out_2_NO_SHIFT_REG = rnode_1to2_bb2_add17_0_valid_out_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_add17_0_NO_SHIFT_REG = rnode_1to2_bb2_add17_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_add17_1_NO_SHIFT_REG = rnode_1to2_bb2_add17_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_add17_2_NO_SHIFT_REG = rnode_1to2_bb2_add17_0_reg_2_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rnode_1to2_bb2_add17_0_consumed_0_NO_SHIFT_REG <= 1'b0;
		rnode_1to2_bb2_add17_0_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rnode_1to2_bb2_add17_0_consumed_0_NO_SHIFT_REG <= (rnode_1to2_bb2_add17_0_valid_out_0_reg_2_NO_SHIFT_REG & (rnode_1to2_bb2_add17_0_consumed_0_NO_SHIFT_REG | ~(rnode_1to2_bb2_add17_0_stall_in_0_NO_SHIFT_REG)) & rnode_1to2_bb2_add17_0_stall_in_0_reg_2_NO_SHIFT_REG);
		rnode_1to2_bb2_add17_0_consumed_1_NO_SHIFT_REG <= (rnode_1to2_bb2_add17_0_valid_out_0_reg_2_NO_SHIFT_REG & (rnode_1to2_bb2_add17_0_consumed_1_NO_SHIFT_REG | ~(rnode_1to2_bb2_add17_0_stall_in_1_NO_SHIFT_REG)) & rnode_1to2_bb2_add17_0_stall_in_0_reg_2_NO_SHIFT_REG);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb2_cmp_i1_i_valid_out;
wire local_bb2_cmp_i1_i_stall_in;
wire local_bb2_cmp_i1_i_inputs_ready;
wire local_bb2_cmp_i1_i_stall_local;
wire local_bb2_cmp_i1_i;

assign local_bb2_cmp_i1_i_inputs_ready = rnode_1to2_bb2_add17_0_valid_out_0_NO_SHIFT_REG;
assign local_bb2_cmp_i1_i = ($signed(rnode_1to2_bb2_add17_0_NO_SHIFT_REG) < $signed(32'h0));
assign local_bb2_cmp_i1_i_valid_out = local_bb2_cmp_i1_i_inputs_ready;
assign local_bb2_cmp_i1_i_stall_local = local_bb2_cmp_i1_i_stall_in;
assign rnode_1to2_bb2_add17_0_stall_in_0_NO_SHIFT_REG = (|local_bb2_cmp_i1_i_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb2_cmp1_i3_i_valid_out;
wire local_bb2_cmp1_i3_i_stall_in;
wire local_bb2_cmp1_i3_i_inputs_ready;
wire local_bb2_cmp1_i3_i_stall_local;
wire local_bb2_cmp1_i3_i;
wire [33:0] rci_rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_2;

assign local_bb2_cmp1_i3_i_inputs_ready = rnode_1to2_bb2_add17_0_valid_out_1_NO_SHIFT_REG;
assign local_bb2_cmp1_i3_i = ($signed(rnode_1to2_bb2_add17_1_NO_SHIFT_REG) > $signed(input_wii_sub22));
assign local_bb2_cmp1_i3_i_valid_out = local_bb2_cmp1_i3_i_inputs_ready;
assign local_bb2_cmp1_i3_i_stall_local = local_bb2_cmp1_i3_i_stall_in;
assign rnode_1to2_bb2_add17_0_stall_in_1_NO_SHIFT_REG = (|local_bb2_cmp1_i3_i_stall_local);
assign rci_rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_2[0] = local_bb2_cmp1_i3_i;
assign rci_rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_2[32:1] = rnode_1to2_bb2_add17_2_NO_SHIFT_REG;
assign rci_rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_2[33] = local_bb2_cmp_i1_i;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rcnode_2to3_rc0_bb2_cmp1_i3_i_0_valid_out_0_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_in_0_NO_SHIFT_REG;
 logic [33:0] rcnode_2to3_rc0_bb2_cmp1_i3_i_0_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb2_cmp1_i3_i_0_valid_out_1_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_in_1_NO_SHIFT_REG;
 logic [33:0] rcnode_2to3_rc0_bb2_cmp1_i3_i_1_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_3_inputs_ready_NO_SHIFT_REG;
 logic [33:0] rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_3_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb2_cmp1_i3_i_0_valid_out_0_reg_3_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_in_0_reg_3_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_out_0_reg_3_IP_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_out_0_reg_3_NO_SHIFT_REG;

acl_data_fifo rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_3_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_3_inputs_ready_NO_SHIFT_REG),
	.stall_in(rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_in_0_reg_3_NO_SHIFT_REG),
	.valid_out(rcnode_2to3_rc0_bb2_cmp1_i3_i_0_valid_out_0_reg_3_NO_SHIFT_REG),
	.stall_out(rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_out_0_reg_3_IP_NO_SHIFT_REG),
	.data_in(rci_rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_2),
	.data_out(rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_3_NO_SHIFT_REG)
);

defparam rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_3_fifo.DEPTH = 1;
defparam rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_3_fifo.DATA_WIDTH = 34;
defparam rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_3_fifo.ALLOW_FULL_WRITE = 1;
defparam rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_3_fifo.IMPL = "ll_reg";

assign rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_3_inputs_ready_NO_SHIFT_REG = (local_bb2_cmp1_i3_i_valid_out & rnode_1to2_bb2_add17_0_valid_out_2_NO_SHIFT_REG & local_bb2_cmp_i1_i_valid_out);
assign rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_out_0_reg_3_NO_SHIFT_REG = (~(rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_3_inputs_ready_NO_SHIFT_REG) | rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_out_0_reg_3_IP_NO_SHIFT_REG);
assign local_bb2_cmp1_i3_i_stall_in = rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_out_0_reg_3_NO_SHIFT_REG;
assign rnode_1to2_bb2_add17_0_stall_in_2_NO_SHIFT_REG = rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_out_0_reg_3_NO_SHIFT_REG;
assign local_bb2_cmp_i1_i_stall_in = rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_out_0_reg_3_NO_SHIFT_REG;
assign rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_in_0_reg_3_NO_SHIFT_REG = (rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_in_0_NO_SHIFT_REG | rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_in_1_NO_SHIFT_REG);
assign rcnode_2to3_rc0_bb2_cmp1_i3_i_0_valid_out_0_NO_SHIFT_REG = rcnode_2to3_rc0_bb2_cmp1_i3_i_0_valid_out_0_reg_3_NO_SHIFT_REG;
assign rcnode_2to3_rc0_bb2_cmp1_i3_i_0_valid_out_1_NO_SHIFT_REG = rcnode_2to3_rc0_bb2_cmp1_i3_i_0_valid_out_0_reg_3_NO_SHIFT_REG;
assign rcnode_2to3_rc0_bb2_cmp1_i3_i_0_NO_SHIFT_REG = rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_3_NO_SHIFT_REG;
assign rcnode_2to3_rc0_bb2_cmp1_i3_i_1_NO_SHIFT_REG = rcnode_2to3_rc0_bb2_cmp1_i3_i_0_reg_3_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb2__3_stall_local;
wire [31:0] local_bb2__3;

assign local_bb2__3 = (rcnode_2to3_rc0_bb2_cmp1_i3_i_0_NO_SHIFT_REG[0] ? input_wii_sub22 : rcnode_2to3_rc0_bb2_cmp1_i3_i_0_NO_SHIFT_REG[32:1]);

// This section implements an unregistered operation.
// 
wire local_bb2_cond5_i9_i_valid_out;
wire local_bb2_cond5_i9_i_stall_in;
wire local_bb2_cond5_i9_i_inputs_ready;
wire local_bb2_cond5_i9_i_stall_local;
wire [31:0] local_bb2_cond5_i9_i;

assign local_bb2_cond5_i9_i_inputs_ready = (rcnode_2to3_rc0_bb2_cmp1_i3_i_0_valid_out_0_NO_SHIFT_REG & rcnode_2to3_rc0_bb2_cmp1_i3_i_0_valid_out_1_NO_SHIFT_REG);
assign local_bb2_cond5_i9_i = (rcnode_2to3_rc0_bb2_cmp1_i3_i_0_NO_SHIFT_REG[33] ? 32'h0 : local_bb2__3);
assign local_bb2_cond5_i9_i_valid_out = local_bb2_cond5_i9_i_inputs_ready;
assign local_bb2_cond5_i9_i_stall_local = local_bb2_cond5_i9_i_stall_in;
assign rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_in_0_NO_SHIFT_REG = (local_bb2_cond5_i9_i_stall_local | ~(local_bb2_cond5_i9_i_inputs_ready));
assign rcnode_2to3_rc0_bb2_cmp1_i3_i_0_stall_in_1_NO_SHIFT_REG = (local_bb2_cond5_i9_i_stall_local | ~(local_bb2_cond5_i9_i_inputs_ready));

// This section implements a registered operation.
// 
wire local_bb2_mul25_inputs_ready;
 reg local_bb2_mul25_valid_out_NO_SHIFT_REG;
wire local_bb2_mul25_stall_in;
wire local_bb2_mul25_output_regs_ready;
wire [31:0] local_bb2_mul25;
 reg local_bb2_mul25_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb2_mul25_valid_pipe_1_NO_SHIFT_REG;
wire local_bb2_mul25_causedstall;

acl_int_mult int_module_local_bb2_mul25 (
	.clock(clock),
	.dataa(local_bb2_cond5_i9_i),
	.datab(input_inSize_x),
	.enable(local_bb2_mul25_output_regs_ready),
	.result(local_bb2_mul25)
);

defparam int_module_local_bb2_mul25.INPUT1_WIDTH = 32;
defparam int_module_local_bb2_mul25.INPUT2_WIDTH = 32;
defparam int_module_local_bb2_mul25.OUTPUT_WIDTH = 32;
defparam int_module_local_bb2_mul25.LATENCY = 3;
defparam int_module_local_bb2_mul25.SIGNED = 0;

assign local_bb2_mul25_inputs_ready = local_bb2_cond5_i9_i_valid_out;
assign local_bb2_mul25_output_regs_ready = (&(~(local_bb2_mul25_valid_out_NO_SHIFT_REG) | ~(local_bb2_mul25_stall_in)));
assign local_bb2_cond5_i9_i_stall_in = (~(local_bb2_mul25_output_regs_ready) | ~(local_bb2_mul25_inputs_ready));
assign local_bb2_mul25_causedstall = (local_bb2_mul25_inputs_ready && (~(local_bb2_mul25_output_regs_ready) && !(~(local_bb2_mul25_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_mul25_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb2_mul25_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_mul25_output_regs_ready)
		begin
			local_bb2_mul25_valid_pipe_0_NO_SHIFT_REG <= local_bb2_mul25_inputs_ready;
			local_bb2_mul25_valid_pipe_1_NO_SHIFT_REG <= local_bb2_mul25_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_mul25_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_mul25_output_regs_ready)
		begin
			local_bb2_mul25_valid_out_NO_SHIFT_REG <= local_bb2_mul25_valid_pipe_1_NO_SHIFT_REG;
		end
		else
		begin
			if (~(local_bb2_mul25_stall_in))
			begin
				local_bb2_mul25_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 0
//  * capacity = 2
 logic rnode_6to6_bb2_mul25_0_valid_out_NO_SHIFT_REG;
 logic rnode_6to6_bb2_mul25_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_6to6_bb2_mul25_0_NO_SHIFT_REG;
 logic rnode_6to6_bb2_mul25_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_6to6_bb2_mul25_0_reg_6_NO_SHIFT_REG;
 logic rnode_6to6_bb2_mul25_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_6to6_bb2_mul25_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_6to6_bb2_mul25_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_6to6_bb2_mul25_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_6to6_bb2_mul25_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_6to6_bb2_mul25_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_6to6_bb2_mul25_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_6to6_bb2_mul25_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(local_bb2_mul25),
	.data_out(rnode_6to6_bb2_mul25_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_6to6_bb2_mul25_0_reg_6_fifo.DEPTH = 3;
defparam rnode_6to6_bb2_mul25_0_reg_6_fifo.DATA_WIDTH = 32;
defparam rnode_6to6_bb2_mul25_0_reg_6_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_6to6_bb2_mul25_0_reg_6_fifo.IMPL = "zl_reg";

assign rnode_6to6_bb2_mul25_0_reg_6_inputs_ready_NO_SHIFT_REG = local_bb2_mul25_valid_out_NO_SHIFT_REG;
assign local_bb2_mul25_stall_in = rnode_6to6_bb2_mul25_0_stall_out_reg_6_NO_SHIFT_REG;
assign rnode_6to6_bb2_mul25_0_NO_SHIFT_REG = rnode_6to6_bb2_mul25_0_reg_6_NO_SHIFT_REG;
assign rnode_6to6_bb2_mul25_0_stall_in_reg_6_NO_SHIFT_REG = rnode_6to6_bb2_mul25_0_stall_in_NO_SHIFT_REG;
assign rnode_6to6_bb2_mul25_0_valid_out_NO_SHIFT_REG = rnode_6to6_bb2_mul25_0_valid_out_reg_6_NO_SHIFT_REG;

// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_scalarizer_0mul_reg_NO_SHIFT_REG;
 reg [31:0] lvb_scalarizer_1mul_reg_NO_SHIFT_REG;
 reg [31:0] lvb_ld__reg_NO_SHIFT_REG;
 reg [31:0] lvb_i_012_reg_NO_SHIFT_REG;
 reg [31:0] lvb_t_011_reg_NO_SHIFT_REG;
 reg [31:0] lvb_sum_010_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb2_mul25_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_1_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (rnode_6to6_bb2_mul25_0_valid_out_NO_SHIFT_REG & rcnode_1to6_rc1_scalarizer_0mul_0_valid_out_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign rnode_6to6_bb2_mul25_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rcnode_1to6_rc1_scalarizer_0mul_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_scalarizer_0mul = lvb_scalarizer_0mul_reg_NO_SHIFT_REG;
assign lvb_scalarizer_1mul = lvb_scalarizer_1mul_reg_NO_SHIFT_REG;
assign lvb_ld_ = lvb_ld__reg_NO_SHIFT_REG;
assign lvb_i_012 = lvb_i_012_reg_NO_SHIFT_REG;
assign lvb_t_011 = lvb_t_011_reg_NO_SHIFT_REG;
assign lvb_sum_010 = lvb_sum_010_reg_NO_SHIFT_REG;
assign lvb_bb2_mul25 = lvb_bb2_mul25_reg_NO_SHIFT_REG;
assign lvb_input_global_id_0 = lvb_input_global_id_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_1 = lvb_input_global_id_1_reg_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_scalarizer_0mul_reg_NO_SHIFT_REG <= 'x;
		lvb_scalarizer_1mul_reg_NO_SHIFT_REG <= 'x;
		lvb_ld__reg_NO_SHIFT_REG <= 'x;
		lvb_i_012_reg_NO_SHIFT_REG <= 'x;
		lvb_t_011_reg_NO_SHIFT_REG <= 'x;
		lvb_sum_010_reg_NO_SHIFT_REG <= 'x;
		lvb_bb2_mul25_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_1_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_scalarizer_0mul_reg_NO_SHIFT_REG <= (rcnode_1to6_rc1_scalarizer_0mul_0_NO_SHIFT_REG[31:0] & 32'hFFFFFFFE);
			lvb_scalarizer_1mul_reg_NO_SHIFT_REG <= (rcnode_1to6_rc1_scalarizer_0mul_0_NO_SHIFT_REG[63:32] & 32'hFFFFFFFE);
			lvb_ld__reg_NO_SHIFT_REG <= rcnode_1to6_rc1_scalarizer_0mul_0_NO_SHIFT_REG[95:64];
			lvb_i_012_reg_NO_SHIFT_REG <= rcnode_1to6_rc1_scalarizer_0mul_0_NO_SHIFT_REG[127:96];
			lvb_t_011_reg_NO_SHIFT_REG <= rcnode_1to6_rc1_scalarizer_0mul_0_NO_SHIFT_REG[159:128];
			lvb_sum_010_reg_NO_SHIFT_REG <= rcnode_1to6_rc1_scalarizer_0mul_0_NO_SHIFT_REG[191:160];
			lvb_bb2_mul25_reg_NO_SHIFT_REG <= rnode_6to6_bb2_mul25_0_NO_SHIFT_REG;
			lvb_input_global_id_0_reg_NO_SHIFT_REG <= rcnode_1to6_rc1_scalarizer_0mul_0_NO_SHIFT_REG[223:192];
			lvb_input_global_id_1_reg_NO_SHIFT_REG <= rcnode_1to6_rc1_scalarizer_0mul_0_NO_SHIFT_REG[255:224];
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
module AOChalfSampleRobustImageKernel_basic_block_3
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_r,
		input [63:0] 		input_in,
		input [31:0] 		input_e_d,
		input [31:0] 		input_wii_div,
		input [31:0] 		input_wii_add6,
		input 		input_wii_cmp9,
		input [31:0] 		input_wii_sub20,
		input [31:0] 		input_wii_sub22,
		input 		valid_in_0,
		output 		stall_out_0,
		input [31:0] 		input_scalarizer_0mul_0,
		input [31:0] 		input_scalarizer_1mul_0,
		input [31:0] 		input_ld__0,
		input [31:0] 		input_i_012_0,
		input [31:0] 		input_mul25_0,
		input [31:0] 		input_j_17_0,
		input [31:0] 		input_t_16_0,
		input [31:0] 		input_sum_15_0,
		input [31:0] 		input_global_id_0_0,
		input [31:0] 		input_global_id_1_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input [31:0] 		input_scalarizer_0mul_1,
		input [31:0] 		input_scalarizer_1mul_1,
		input [31:0] 		input_ld__1,
		input [31:0] 		input_i_012_1,
		input [31:0] 		input_mul25_1,
		input [31:0] 		input_j_17_1,
		input [31:0] 		input_t_16_1,
		input [31:0] 		input_sum_15_1,
		input [31:0] 		input_global_id_0_1,
		input [31:0] 		input_global_id_1_1,
		output 		valid_out_0,
		input 		stall_in_0,
		output [31:0] 		lvb_scalarizer_0mul_0,
		output [31:0] 		lvb_scalarizer_1mul_0,
		output [31:0] 		lvb_ld__0,
		output [31:0] 		lvb_i_012_0,
		output [31:0] 		lvb_mul25_0,
		output [31:0] 		lvb_bb3_inc_0,
		output [31:0] 		lvb_bb3_c0_exe1_0,
		output [31:0] 		lvb_bb3_c0_exe2_0,
		output [31:0] 		lvb_input_global_id_0_0,
		output [31:0] 		lvb_input_global_id_1_0,
		output 		valid_out_1,
		input 		stall_in_1,
		output [31:0] 		lvb_scalarizer_0mul_1,
		output [31:0] 		lvb_scalarizer_1mul_1,
		output [31:0] 		lvb_ld__1,
		output [31:0] 		lvb_i_012_1,
		output [31:0] 		lvb_mul25_1,
		output [31:0] 		lvb_bb3_inc_1,
		output [31:0] 		lvb_bb3_c0_exe1_1,
		output [31:0] 		lvb_bb3_c0_exe2_1,
		output [31:0] 		lvb_input_global_id_0_1,
		output [31:0] 		lvb_input_global_id_1_1,
		input [31:0] 		workgroup_size,
		input 		start,
		input [511:0] 		avm_local_bb3_ld__readdata,
		input 		avm_local_bb3_ld__readdatavalid,
		input 		avm_local_bb3_ld__waitrequest,
		output [32:0] 		avm_local_bb3_ld__address,
		output 		avm_local_bb3_ld__read,
		output 		avm_local_bb3_ld__write,
		input 		avm_local_bb3_ld__writeack,
		output [511:0] 		avm_local_bb3_ld__writedata,
		output [63:0] 		avm_local_bb3_ld__byteenable,
		output [4:0] 		avm_local_bb3_ld__burstcount,
		output 		local_bb3_ld__active,
		input 		clock2x
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
wire merge_node_stall_in_4;
 reg merge_node_valid_out_4_NO_SHIFT_REG;
wire merge_node_stall_in_5;
 reg merge_node_valid_out_5_NO_SHIFT_REG;
wire merge_node_stall_in_6;
 reg merge_node_valid_out_6_NO_SHIFT_REG;
wire merge_node_stall_in_7;
 reg merge_node_valid_out_7_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_scalarizer_0mul_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_scalarizer_1mul_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_i_012_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_mul25_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_j_17_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_t_16_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_sum_15_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_1_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_scalarizer_0mul_NO_SHIFT_REG;
 reg [31:0] local_lvm_scalarizer_1mul_NO_SHIFT_REG;
 reg [31:0] local_lvm_ld__NO_SHIFT_REG;
 reg [31:0] local_lvm_i_012_NO_SHIFT_REG;
 reg [31:0] local_lvm_mul25_NO_SHIFT_REG;
 reg [31:0] local_lvm_j_17_NO_SHIFT_REG;
 reg [31:0] local_lvm_t_16_NO_SHIFT_REG;
 reg [31:0] local_lvm_sum_15_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_1_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_scalarizer_0mul_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_scalarizer_1mul_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_i_012_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_mul25_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_j_17_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_t_16_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_sum_15_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_1_1_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG) | (merge_node_stall_in_5 & merge_node_valid_out_5_NO_SHIFT_REG) | (merge_node_stall_in_6 & merge_node_valid_out_6_NO_SHIFT_REG) | (merge_node_stall_in_7 & merge_node_valid_out_7_NO_SHIFT_REG));
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
		input_scalarizer_0mul_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_scalarizer_1mul_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__0_staging_reg_NO_SHIFT_REG <= 'x;
		input_i_012_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_mul25_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_j_17_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_t_16_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_sum_15_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_0_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_1_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_scalarizer_0mul_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_scalarizer_1mul_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__1_staging_reg_NO_SHIFT_REG <= 'x;
		input_i_012_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_mul25_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_j_17_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_t_16_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_sum_15_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_0_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_1_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_scalarizer_0mul_0_staging_reg_NO_SHIFT_REG <= input_scalarizer_0mul_0;
				input_scalarizer_1mul_0_staging_reg_NO_SHIFT_REG <= input_scalarizer_1mul_0;
				input_ld__0_staging_reg_NO_SHIFT_REG <= input_ld__0;
				input_i_012_0_staging_reg_NO_SHIFT_REG <= input_i_012_0;
				input_mul25_0_staging_reg_NO_SHIFT_REG <= input_mul25_0;
				input_j_17_0_staging_reg_NO_SHIFT_REG <= input_j_17_0;
				input_t_16_0_staging_reg_NO_SHIFT_REG <= input_t_16_0;
				input_sum_15_0_staging_reg_NO_SHIFT_REG <= input_sum_15_0;
				input_global_id_0_0_staging_reg_NO_SHIFT_REG <= input_global_id_0_0;
				input_global_id_1_0_staging_reg_NO_SHIFT_REG <= input_global_id_1_0;
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
				input_scalarizer_0mul_1_staging_reg_NO_SHIFT_REG <= input_scalarizer_0mul_1;
				input_scalarizer_1mul_1_staging_reg_NO_SHIFT_REG <= input_scalarizer_1mul_1;
				input_ld__1_staging_reg_NO_SHIFT_REG <= input_ld__1;
				input_i_012_1_staging_reg_NO_SHIFT_REG <= input_i_012_1;
				input_mul25_1_staging_reg_NO_SHIFT_REG <= input_mul25_1;
				input_j_17_1_staging_reg_NO_SHIFT_REG <= input_j_17_1;
				input_t_16_1_staging_reg_NO_SHIFT_REG <= input_t_16_1;
				input_sum_15_1_staging_reg_NO_SHIFT_REG <= input_sum_15_1;
				input_global_id_0_1_staging_reg_NO_SHIFT_REG <= input_global_id_0_1;
				input_global_id_1_1_staging_reg_NO_SHIFT_REG <= input_global_id_1_1;
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
					local_lvm_scalarizer_0mul_NO_SHIFT_REG <= input_scalarizer_0mul_0_staging_reg_NO_SHIFT_REG;
					local_lvm_scalarizer_1mul_NO_SHIFT_REG <= input_scalarizer_1mul_0_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__0_staging_reg_NO_SHIFT_REG;
					local_lvm_i_012_NO_SHIFT_REG <= input_i_012_0_staging_reg_NO_SHIFT_REG;
					local_lvm_mul25_NO_SHIFT_REG <= input_mul25_0_staging_reg_NO_SHIFT_REG;
					local_lvm_j_17_NO_SHIFT_REG <= input_j_17_0_staging_reg_NO_SHIFT_REG;
					local_lvm_t_16_NO_SHIFT_REG <= input_t_16_0_staging_reg_NO_SHIFT_REG;
					local_lvm_sum_15_NO_SHIFT_REG <= input_sum_15_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_scalarizer_0mul_NO_SHIFT_REG <= input_scalarizer_0mul_0;
					local_lvm_scalarizer_1mul_NO_SHIFT_REG <= input_scalarizer_1mul_0;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__0;
					local_lvm_i_012_NO_SHIFT_REG <= input_i_012_0;
					local_lvm_mul25_NO_SHIFT_REG <= input_mul25_0;
					local_lvm_j_17_NO_SHIFT_REG <= input_j_17_0;
					local_lvm_t_16_NO_SHIFT_REG <= input_t_16_0;
					local_lvm_sum_15_NO_SHIFT_REG <= input_sum_15_0;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_0;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_scalarizer_0mul_NO_SHIFT_REG <= input_scalarizer_0mul_1_staging_reg_NO_SHIFT_REG;
					local_lvm_scalarizer_1mul_NO_SHIFT_REG <= input_scalarizer_1mul_1_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__1_staging_reg_NO_SHIFT_REG;
					local_lvm_i_012_NO_SHIFT_REG <= input_i_012_1_staging_reg_NO_SHIFT_REG;
					local_lvm_mul25_NO_SHIFT_REG <= input_mul25_1_staging_reg_NO_SHIFT_REG;
					local_lvm_j_17_NO_SHIFT_REG <= input_j_17_1_staging_reg_NO_SHIFT_REG;
					local_lvm_t_16_NO_SHIFT_REG <= input_t_16_1_staging_reg_NO_SHIFT_REG;
					local_lvm_sum_15_NO_SHIFT_REG <= input_sum_15_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_scalarizer_0mul_NO_SHIFT_REG <= input_scalarizer_0mul_1;
					local_lvm_scalarizer_1mul_NO_SHIFT_REG <= input_scalarizer_1mul_1;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__1;
					local_lvm_i_012_NO_SHIFT_REG <= input_i_012_1;
					local_lvm_mul25_NO_SHIFT_REG <= input_mul25_1;
					local_lvm_j_17_NO_SHIFT_REG <= input_j_17_1;
					local_lvm_t_16_NO_SHIFT_REG <= input_t_16_1;
					local_lvm_sum_15_NO_SHIFT_REG <= input_sum_15_1;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_1;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_1;
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
		merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_6_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_7_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_3_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_4_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_5_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_6_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_7_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
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
			if (~(merge_node_stall_in_4))
			begin
				merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_5))
			begin
				merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_6))
			begin
				merge_node_valid_out_6_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_7))
			begin
				merge_node_valid_out_7_NO_SHIFT_REG <= 1'b0;
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
wire local_bb3_add15_valid_out;
wire local_bb3_add15_stall_in;
wire local_bb3_add15_inputs_ready;
wire local_bb3_add15_stall_local;
wire [31:0] local_bb3_add15;

assign local_bb3_add15_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb3_add15 = (local_lvm_j_17_NO_SHIFT_REG + (local_lvm_scalarizer_0mul_NO_SHIFT_REG & 32'hFFFFFFFE));
assign local_bb3_add15_valid_out = local_bb3_add15_inputs_ready;
assign local_bb3_add15_stall_local = local_bb3_add15_stall_in;
assign merge_node_stall_in_0 = (|local_bb3_add15_stall_local);

// Register node:
//  * latency = 177
//  * capacity = 177
 logic rnode_1to178_j_17_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to178_j_17_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to178_j_17_0_NO_SHIFT_REG;
 logic rnode_1to178_j_17_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to178_j_17_0_reg_178_NO_SHIFT_REG;
 logic rnode_1to178_j_17_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_1to178_j_17_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_1to178_j_17_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_1to178_j_17_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to178_j_17_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to178_j_17_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_1to178_j_17_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_1to178_j_17_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(local_lvm_j_17_NO_SHIFT_REG),
	.data_out(rnode_1to178_j_17_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_1to178_j_17_0_reg_178_fifo.DEPTH = 178;
defparam rnode_1to178_j_17_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_1to178_j_17_0_reg_178_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to178_j_17_0_reg_178_fifo.IMPL = "ram";

assign rnode_1to178_j_17_0_reg_178_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_1_NO_SHIFT_REG;
assign merge_node_stall_in_1 = rnode_1to178_j_17_0_stall_out_reg_178_NO_SHIFT_REG;
assign rnode_1to178_j_17_0_NO_SHIFT_REG = rnode_1to178_j_17_0_reg_178_NO_SHIFT_REG;
assign rnode_1to178_j_17_0_stall_in_reg_178_NO_SHIFT_REG = rnode_1to178_j_17_0_stall_in_NO_SHIFT_REG;
assign rnode_1to178_j_17_0_valid_out_NO_SHIFT_REG = rnode_1to178_j_17_0_valid_out_reg_178_NO_SHIFT_REG;

// Register node:
//  * latency = 4
//  * capacity = 4
 logic rnode_1to5_cmp9_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to5_cmp9_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to5_cmp9_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to5_cmp9_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_1to5_cmp9_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_1to5_cmp9_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_1to5_cmp9_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to5_cmp9_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to5_cmp9_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_1to5_cmp9_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_1to5_cmp9_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(),
	.data_out()
);

defparam rnode_1to5_cmp9_0_reg_5_fifo.DEPTH = 5;
defparam rnode_1to5_cmp9_0_reg_5_fifo.DATA_WIDTH = 0;
defparam rnode_1to5_cmp9_0_reg_5_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to5_cmp9_0_reg_5_fifo.IMPL = "ll_reg";

assign rnode_1to5_cmp9_0_reg_5_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_2_NO_SHIFT_REG;
assign merge_node_stall_in_2 = rnode_1to5_cmp9_0_stall_out_reg_5_NO_SHIFT_REG;
assign rnode_1to5_cmp9_0_stall_in_reg_5_NO_SHIFT_REG = rnode_1to5_cmp9_0_stall_in_NO_SHIFT_REG;
assign rnode_1to5_cmp9_0_valid_out_NO_SHIFT_REG = rnode_1to5_cmp9_0_valid_out_reg_5_NO_SHIFT_REG;

// Register node:
//  * latency = 179
//  * capacity = 179
 logic rnode_1to180_input_global_id_1_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to180_input_global_id_1_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to180_input_global_id_1_0_NO_SHIFT_REG;
 logic rnode_1to180_input_global_id_1_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to180_input_global_id_1_0_reg_180_NO_SHIFT_REG;
 logic rnode_1to180_input_global_id_1_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_1to180_input_global_id_1_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_1to180_input_global_id_1_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_1to180_input_global_id_1_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to180_input_global_id_1_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to180_input_global_id_1_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_1to180_input_global_id_1_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_1to180_input_global_id_1_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(local_lvm_input_global_id_1_NO_SHIFT_REG),
	.data_out(rnode_1to180_input_global_id_1_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_1to180_input_global_id_1_0_reg_180_fifo.DEPTH = 180;
defparam rnode_1to180_input_global_id_1_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_1to180_input_global_id_1_0_reg_180_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to180_input_global_id_1_0_reg_180_fifo.IMPL = "ram";

assign rnode_1to180_input_global_id_1_0_reg_180_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_3_NO_SHIFT_REG;
assign merge_node_stall_in_3 = rnode_1to180_input_global_id_1_0_stall_out_reg_180_NO_SHIFT_REG;
assign rnode_1to180_input_global_id_1_0_NO_SHIFT_REG = rnode_1to180_input_global_id_1_0_reg_180_NO_SHIFT_REG;
assign rnode_1to180_input_global_id_1_0_stall_in_reg_180_NO_SHIFT_REG = rnode_1to180_input_global_id_1_0_stall_in_NO_SHIFT_REG;
assign rnode_1to180_input_global_id_1_0_valid_out_NO_SHIFT_REG = rnode_1to180_input_global_id_1_0_valid_out_reg_180_NO_SHIFT_REG;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_1to3_mul25_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to3_mul25_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_1to3_mul25_0_NO_SHIFT_REG;
 logic rnode_1to3_mul25_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to3_mul25_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_1to3_mul25_1_NO_SHIFT_REG;
 logic rnode_1to3_mul25_0_reg_3_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to3_mul25_0_reg_3_NO_SHIFT_REG;
 logic rnode_1to3_mul25_0_valid_out_0_reg_3_NO_SHIFT_REG;
 logic rnode_1to3_mul25_0_stall_in_0_reg_3_NO_SHIFT_REG;
 logic rnode_1to3_mul25_0_stall_out_reg_3_NO_SHIFT_REG;
 reg rnode_1to3_mul25_0_consumed_0_NO_SHIFT_REG;
 reg rnode_1to3_mul25_0_consumed_1_NO_SHIFT_REG;

acl_data_fifo rnode_1to3_mul25_0_reg_3_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to3_mul25_0_reg_3_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to3_mul25_0_stall_in_0_reg_3_NO_SHIFT_REG),
	.valid_out(rnode_1to3_mul25_0_valid_out_0_reg_3_NO_SHIFT_REG),
	.stall_out(rnode_1to3_mul25_0_stall_out_reg_3_NO_SHIFT_REG),
	.data_in(local_lvm_mul25_NO_SHIFT_REG),
	.data_out(rnode_1to3_mul25_0_reg_3_NO_SHIFT_REG)
);

defparam rnode_1to3_mul25_0_reg_3_fifo.DEPTH = 3;
defparam rnode_1to3_mul25_0_reg_3_fifo.DATA_WIDTH = 32;
defparam rnode_1to3_mul25_0_reg_3_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to3_mul25_0_reg_3_fifo.IMPL = "ll_reg";

assign rnode_1to3_mul25_0_reg_3_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_4_NO_SHIFT_REG;
assign merge_node_stall_in_4 = rnode_1to3_mul25_0_stall_out_reg_3_NO_SHIFT_REG;
assign rnode_1to3_mul25_0_stall_in_0_reg_3_NO_SHIFT_REG = ((rnode_1to3_mul25_0_stall_in_0_NO_SHIFT_REG & ~(rnode_1to3_mul25_0_consumed_0_NO_SHIFT_REG)) | (rnode_1to3_mul25_0_stall_in_1_NO_SHIFT_REG & ~(rnode_1to3_mul25_0_consumed_1_NO_SHIFT_REG)));
assign rnode_1to3_mul25_0_valid_out_0_NO_SHIFT_REG = (rnode_1to3_mul25_0_valid_out_0_reg_3_NO_SHIFT_REG & ~(rnode_1to3_mul25_0_consumed_0_NO_SHIFT_REG));
assign rnode_1to3_mul25_0_valid_out_1_NO_SHIFT_REG = (rnode_1to3_mul25_0_valid_out_0_reg_3_NO_SHIFT_REG & ~(rnode_1to3_mul25_0_consumed_1_NO_SHIFT_REG));
assign rnode_1to3_mul25_0_NO_SHIFT_REG = rnode_1to3_mul25_0_reg_3_NO_SHIFT_REG;
assign rnode_1to3_mul25_1_NO_SHIFT_REG = rnode_1to3_mul25_0_reg_3_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rnode_1to3_mul25_0_consumed_0_NO_SHIFT_REG <= 1'b0;
		rnode_1to3_mul25_0_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rnode_1to3_mul25_0_consumed_0_NO_SHIFT_REG <= (rnode_1to3_mul25_0_valid_out_0_reg_3_NO_SHIFT_REG & (rnode_1to3_mul25_0_consumed_0_NO_SHIFT_REG | ~(rnode_1to3_mul25_0_stall_in_0_NO_SHIFT_REG)) & rnode_1to3_mul25_0_stall_in_0_reg_3_NO_SHIFT_REG);
		rnode_1to3_mul25_0_consumed_1_NO_SHIFT_REG <= (rnode_1to3_mul25_0_valid_out_0_reg_3_NO_SHIFT_REG & (rnode_1to3_mul25_0_consumed_1_NO_SHIFT_REG | ~(rnode_1to3_mul25_0_stall_in_1_NO_SHIFT_REG)) & rnode_1to3_mul25_0_stall_in_0_reg_3_NO_SHIFT_REG);
	end
end


// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_ld__0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_ld__0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_ld__0_NO_SHIFT_REG;
 logic rnode_1to164_ld__0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_ld__0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_ld__0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_ld__0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_ld__0_stall_out_reg_164_NO_SHIFT_REG;
wire [63:0] rci_rcnode_1to164_rc6_sum_15_0_reg_1;

acl_data_fifo rnode_1to164_ld__0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_ld__0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_ld__0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_ld__0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_ld__0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_ld__NO_SHIFT_REG),
	.data_out(rnode_1to164_ld__0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_ld__0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_ld__0_reg_164_fifo.DATA_WIDTH = 32;
defparam rnode_1to164_ld__0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_ld__0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_ld__0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_5_NO_SHIFT_REG;
assign merge_node_stall_in_5 = rnode_1to164_ld__0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_ld__0_NO_SHIFT_REG = rnode_1to164_ld__0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_ld__0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_ld__0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_ld__0_valid_out_NO_SHIFT_REG = rnode_1to164_ld__0_valid_out_reg_164_NO_SHIFT_REG;
assign rci_rcnode_1to164_rc6_sum_15_0_reg_1[31:0] = local_lvm_sum_15_NO_SHIFT_REG;
assign rci_rcnode_1to164_rc6_sum_15_0_reg_1[63:32] = local_lvm_t_16_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rcnode_1to164_rc6_sum_15_0_valid_out_NO_SHIFT_REG;
 logic rcnode_1to164_rc6_sum_15_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rcnode_1to164_rc6_sum_15_0_NO_SHIFT_REG;
 logic rcnode_1to164_rc6_sum_15_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rcnode_1to164_rc6_sum_15_0_reg_164_NO_SHIFT_REG;
 logic rcnode_1to164_rc6_sum_15_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rcnode_1to164_rc6_sum_15_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rcnode_1to164_rc6_sum_15_0_stall_out_reg_164_IP_NO_SHIFT_REG;
 logic rcnode_1to164_rc6_sum_15_0_stall_out_reg_164_NO_SHIFT_REG;
wire [127:0] rci_rcnode_1to180_rc7_scalarizer_0mul_0_reg_1;

acl_data_fifo rcnode_1to164_rc6_sum_15_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rcnode_1to164_rc6_sum_15_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rcnode_1to164_rc6_sum_15_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rcnode_1to164_rc6_sum_15_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rcnode_1to164_rc6_sum_15_0_stall_out_reg_164_IP_NO_SHIFT_REG),
	.data_in(rci_rcnode_1to164_rc6_sum_15_0_reg_1),
	.data_out(rcnode_1to164_rc6_sum_15_0_reg_164_NO_SHIFT_REG)
);

defparam rcnode_1to164_rc6_sum_15_0_reg_164_fifo.DEPTH = 164;
defparam rcnode_1to164_rc6_sum_15_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rcnode_1to164_rc6_sum_15_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rcnode_1to164_rc6_sum_15_0_reg_164_fifo.IMPL = "ram";

assign rcnode_1to164_rc6_sum_15_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_6_NO_SHIFT_REG;
assign rcnode_1to164_rc6_sum_15_0_stall_out_reg_164_NO_SHIFT_REG = (~(rcnode_1to164_rc6_sum_15_0_reg_164_inputs_ready_NO_SHIFT_REG) | rcnode_1to164_rc6_sum_15_0_stall_out_reg_164_IP_NO_SHIFT_REG);
assign merge_node_stall_in_6 = rcnode_1to164_rc6_sum_15_0_stall_out_reg_164_NO_SHIFT_REG;
assign rcnode_1to164_rc6_sum_15_0_NO_SHIFT_REG = rcnode_1to164_rc6_sum_15_0_reg_164_NO_SHIFT_REG;
assign rcnode_1to164_rc6_sum_15_0_stall_in_reg_164_NO_SHIFT_REG = rcnode_1to164_rc6_sum_15_0_stall_in_NO_SHIFT_REG;
assign rcnode_1to164_rc6_sum_15_0_valid_out_NO_SHIFT_REG = rcnode_1to164_rc6_sum_15_0_valid_out_reg_164_NO_SHIFT_REG;
assign rci_rcnode_1to180_rc7_scalarizer_0mul_0_reg_1[31:0] = (local_lvm_scalarizer_0mul_NO_SHIFT_REG & 32'hFFFFFFFE);
assign rci_rcnode_1to180_rc7_scalarizer_0mul_0_reg_1[63:32] = (local_lvm_scalarizer_1mul_NO_SHIFT_REG & 32'hFFFFFFFE);
assign rci_rcnode_1to180_rc7_scalarizer_0mul_0_reg_1[95:64] = local_lvm_i_012_NO_SHIFT_REG;
assign rci_rcnode_1to180_rc7_scalarizer_0mul_0_reg_1[127:96] = local_lvm_input_global_id_0_NO_SHIFT_REG;

// Register node:
//  * latency = 179
//  * capacity = 179
 logic rcnode_1to180_rc7_scalarizer_0mul_0_valid_out_NO_SHIFT_REG;
 logic rcnode_1to180_rc7_scalarizer_0mul_0_stall_in_NO_SHIFT_REG;
 logic [127:0] rcnode_1to180_rc7_scalarizer_0mul_0_NO_SHIFT_REG;
 logic rcnode_1to180_rc7_scalarizer_0mul_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [127:0] rcnode_1to180_rc7_scalarizer_0mul_0_reg_180_NO_SHIFT_REG;
 logic rcnode_1to180_rc7_scalarizer_0mul_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rcnode_1to180_rc7_scalarizer_0mul_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rcnode_1to180_rc7_scalarizer_0mul_0_stall_out_reg_180_IP_NO_SHIFT_REG;
 logic rcnode_1to180_rc7_scalarizer_0mul_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rcnode_1to180_rc7_scalarizer_0mul_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rcnode_1to180_rc7_scalarizer_0mul_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rcnode_1to180_rc7_scalarizer_0mul_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rcnode_1to180_rc7_scalarizer_0mul_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rcnode_1to180_rc7_scalarizer_0mul_0_stall_out_reg_180_IP_NO_SHIFT_REG),
	.data_in(rci_rcnode_1to180_rc7_scalarizer_0mul_0_reg_1),
	.data_out(rcnode_1to180_rc7_scalarizer_0mul_0_reg_180_NO_SHIFT_REG)
);

defparam rcnode_1to180_rc7_scalarizer_0mul_0_reg_180_fifo.DEPTH = 180;
defparam rcnode_1to180_rc7_scalarizer_0mul_0_reg_180_fifo.DATA_WIDTH = 128;
defparam rcnode_1to180_rc7_scalarizer_0mul_0_reg_180_fifo.ALLOW_FULL_WRITE = 0;
defparam rcnode_1to180_rc7_scalarizer_0mul_0_reg_180_fifo.IMPL = "ram";

assign rcnode_1to180_rc7_scalarizer_0mul_0_reg_180_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_7_NO_SHIFT_REG;
assign rcnode_1to180_rc7_scalarizer_0mul_0_stall_out_reg_180_NO_SHIFT_REG = (~(rcnode_1to180_rc7_scalarizer_0mul_0_reg_180_inputs_ready_NO_SHIFT_REG) | rcnode_1to180_rc7_scalarizer_0mul_0_stall_out_reg_180_IP_NO_SHIFT_REG);
assign merge_node_stall_in_7 = rcnode_1to180_rc7_scalarizer_0mul_0_stall_out_reg_180_NO_SHIFT_REG;
assign rcnode_1to180_rc7_scalarizer_0mul_0_NO_SHIFT_REG = rcnode_1to180_rc7_scalarizer_0mul_0_reg_180_NO_SHIFT_REG;
assign rcnode_1to180_rc7_scalarizer_0mul_0_stall_in_reg_180_NO_SHIFT_REG = rcnode_1to180_rc7_scalarizer_0mul_0_stall_in_NO_SHIFT_REG;
assign rcnode_1to180_rc7_scalarizer_0mul_0_valid_out_NO_SHIFT_REG = rcnode_1to180_rc7_scalarizer_0mul_0_valid_out_reg_180_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb3_add15_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_bb3_add15_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb3_add15_0_NO_SHIFT_REG;
 logic rnode_1to2_bb3_add15_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_bb3_add15_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb3_add15_1_NO_SHIFT_REG;
 logic rnode_1to2_bb3_add15_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_1to2_bb3_add15_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb3_add15_2_NO_SHIFT_REG;
 logic rnode_1to2_bb3_add15_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb3_add15_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb3_add15_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb3_add15_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb3_add15_0_stall_out_reg_2_NO_SHIFT_REG;
 reg rnode_1to2_bb3_add15_0_consumed_0_NO_SHIFT_REG;
 reg rnode_1to2_bb3_add15_0_consumed_1_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb3_add15_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb3_add15_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb3_add15_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb3_add15_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb3_add15_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb3_add15),
	.data_out(rnode_1to2_bb3_add15_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb3_add15_0_reg_2_fifo.DEPTH = 1;
defparam rnode_1to2_bb3_add15_0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_bb3_add15_0_reg_2_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_1to2_bb3_add15_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb3_add15_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb3_add15_valid_out;
assign local_bb3_add15_stall_in = rnode_1to2_bb3_add15_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb3_add15_0_stall_in_0_reg_2_NO_SHIFT_REG = ((rnode_1to2_bb3_add15_0_stall_in_0_NO_SHIFT_REG & ~(rnode_1to2_bb3_add15_0_consumed_0_NO_SHIFT_REG)) | (rnode_1to2_bb3_add15_0_stall_in_1_NO_SHIFT_REG & ~(rnode_1to2_bb3_add15_0_consumed_1_NO_SHIFT_REG)) | 1'b0);
assign rnode_1to2_bb3_add15_0_valid_out_0_NO_SHIFT_REG = (rnode_1to2_bb3_add15_0_valid_out_0_reg_2_NO_SHIFT_REG & ~(rnode_1to2_bb3_add15_0_consumed_0_NO_SHIFT_REG));
assign rnode_1to2_bb3_add15_0_valid_out_1_NO_SHIFT_REG = (rnode_1to2_bb3_add15_0_valid_out_0_reg_2_NO_SHIFT_REG & ~(rnode_1to2_bb3_add15_0_consumed_1_NO_SHIFT_REG));
assign rnode_1to2_bb3_add15_0_valid_out_2_NO_SHIFT_REG = rnode_1to2_bb3_add15_0_valid_out_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb3_add15_0_NO_SHIFT_REG = rnode_1to2_bb3_add15_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb3_add15_1_NO_SHIFT_REG = rnode_1to2_bb3_add15_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb3_add15_2_NO_SHIFT_REG = rnode_1to2_bb3_add15_0_reg_2_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rnode_1to2_bb3_add15_0_consumed_0_NO_SHIFT_REG <= 1'b0;
		rnode_1to2_bb3_add15_0_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rnode_1to2_bb3_add15_0_consumed_0_NO_SHIFT_REG <= (rnode_1to2_bb3_add15_0_valid_out_0_reg_2_NO_SHIFT_REG & (rnode_1to2_bb3_add15_0_consumed_0_NO_SHIFT_REG | ~(rnode_1to2_bb3_add15_0_stall_in_0_NO_SHIFT_REG)) & rnode_1to2_bb3_add15_0_stall_in_0_reg_2_NO_SHIFT_REG);
		rnode_1to2_bb3_add15_0_consumed_1_NO_SHIFT_REG <= (rnode_1to2_bb3_add15_0_valid_out_0_reg_2_NO_SHIFT_REG & (rnode_1to2_bb3_add15_0_consumed_1_NO_SHIFT_REG | ~(rnode_1to2_bb3_add15_0_stall_in_1_NO_SHIFT_REG)) & rnode_1to2_bb3_add15_0_stall_in_0_reg_2_NO_SHIFT_REG);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_j_17_0_valid_out_NO_SHIFT_REG;
 logic rnode_178to179_j_17_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_j_17_0_NO_SHIFT_REG;
 logic rnode_178to179_j_17_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_j_17_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_j_17_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_j_17_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_j_17_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_j_17_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_j_17_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_j_17_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_j_17_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_j_17_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_1to178_j_17_0_NO_SHIFT_REG),
	.data_out(rnode_178to179_j_17_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_j_17_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_j_17_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_178to179_j_17_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_j_17_0_reg_179_fifo.IMPL = "ll_reg";

assign rnode_178to179_j_17_0_reg_179_inputs_ready_NO_SHIFT_REG = rnode_1to178_j_17_0_valid_out_NO_SHIFT_REG;
assign rnode_1to178_j_17_0_stall_in_NO_SHIFT_REG = rnode_178to179_j_17_0_stall_out_reg_179_NO_SHIFT_REG;
assign rnode_178to179_j_17_0_NO_SHIFT_REG = rnode_178to179_j_17_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_j_17_0_stall_in_reg_179_NO_SHIFT_REG = rnode_178to179_j_17_0_stall_in_NO_SHIFT_REG;
assign rnode_178to179_j_17_0_valid_out_NO_SHIFT_REG = rnode_178to179_j_17_0_valid_out_reg_179_NO_SHIFT_REG;

// Register node:
//  * latency = 177
//  * capacity = 177
 logic rnode_3to180_mul25_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to180_mul25_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_3to180_mul25_0_NO_SHIFT_REG;
 logic rnode_3to180_mul25_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_3to180_mul25_0_reg_180_NO_SHIFT_REG;
 logic rnode_3to180_mul25_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_3to180_mul25_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_3to180_mul25_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_3to180_mul25_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to180_mul25_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to180_mul25_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_3to180_mul25_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_3to180_mul25_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_1to3_mul25_1_NO_SHIFT_REG),
	.data_out(rnode_3to180_mul25_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_3to180_mul25_0_reg_180_fifo.DEPTH = 178;
defparam rnode_3to180_mul25_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_3to180_mul25_0_reg_180_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_3to180_mul25_0_reg_180_fifo.IMPL = "ram";

assign rnode_3to180_mul25_0_reg_180_inputs_ready_NO_SHIFT_REG = rnode_1to3_mul25_0_valid_out_1_NO_SHIFT_REG;
assign rnode_1to3_mul25_0_stall_in_1_NO_SHIFT_REG = rnode_3to180_mul25_0_stall_out_reg_180_NO_SHIFT_REG;
assign rnode_3to180_mul25_0_NO_SHIFT_REG = rnode_3to180_mul25_0_reg_180_NO_SHIFT_REG;
assign rnode_3to180_mul25_0_stall_in_reg_180_NO_SHIFT_REG = rnode_3to180_mul25_0_stall_in_NO_SHIFT_REG;
assign rnode_3to180_mul25_0_valid_out_NO_SHIFT_REG = rnode_3to180_mul25_0_valid_out_reg_180_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_ld__0_valid_out_0_NO_SHIFT_REG;
 logic rnode_164to165_ld__0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_ld__0_NO_SHIFT_REG;
 logic rnode_164to165_ld__0_valid_out_1_NO_SHIFT_REG;
 logic rnode_164to165_ld__0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_ld__1_NO_SHIFT_REG;
 logic rnode_164to165_ld__0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_ld__0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_ld__0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_ld__0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_ld__0_stall_out_reg_165_NO_SHIFT_REG;
 reg rnode_164to165_ld__0_consumed_0_NO_SHIFT_REG;
 reg rnode_164to165_ld__0_consumed_1_NO_SHIFT_REG;
wire [63:0] rci_rcnode_164to165_rc0_sum_15_0_reg_164;

acl_data_fifo rnode_164to165_ld__0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_ld__0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_ld__0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_ld__0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_ld__0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_ld__0_NO_SHIFT_REG),
	.data_out(rnode_164to165_ld__0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_ld__0_reg_165_fifo.DEPTH = 1;
defparam rnode_164to165_ld__0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_164to165_ld__0_reg_165_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_164to165_ld__0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_ld__0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_ld__0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_ld__0_stall_in_NO_SHIFT_REG = rnode_164to165_ld__0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_ld__0_stall_in_0_reg_165_NO_SHIFT_REG = ((rnode_164to165_ld__0_stall_in_0_NO_SHIFT_REG & ~(rnode_164to165_ld__0_consumed_0_NO_SHIFT_REG)) | (rnode_164to165_ld__0_stall_in_1_NO_SHIFT_REG & ~(rnode_164to165_ld__0_consumed_1_NO_SHIFT_REG)));
assign rnode_164to165_ld__0_valid_out_0_NO_SHIFT_REG = (rnode_164to165_ld__0_valid_out_0_reg_165_NO_SHIFT_REG & ~(rnode_164to165_ld__0_consumed_0_NO_SHIFT_REG));
assign rnode_164to165_ld__0_valid_out_1_NO_SHIFT_REG = (rnode_164to165_ld__0_valid_out_0_reg_165_NO_SHIFT_REG & ~(rnode_164to165_ld__0_consumed_1_NO_SHIFT_REG));
assign rnode_164to165_ld__0_NO_SHIFT_REG = rnode_164to165_ld__0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_ld__1_NO_SHIFT_REG = rnode_164to165_ld__0_reg_165_NO_SHIFT_REG;
assign rci_rcnode_164to165_rc0_sum_15_0_reg_164[31:0] = rcnode_1to164_rc6_sum_15_0_NO_SHIFT_REG[31:0];
assign rci_rcnode_164to165_rc0_sum_15_0_reg_164[63:32] = rcnode_1to164_rc6_sum_15_0_NO_SHIFT_REG[63:32];

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rnode_164to165_ld__0_consumed_0_NO_SHIFT_REG <= 1'b0;
		rnode_164to165_ld__0_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rnode_164to165_ld__0_consumed_0_NO_SHIFT_REG <= (rnode_164to165_ld__0_valid_out_0_reg_165_NO_SHIFT_REG & (rnode_164to165_ld__0_consumed_0_NO_SHIFT_REG | ~(rnode_164to165_ld__0_stall_in_0_NO_SHIFT_REG)) & rnode_164to165_ld__0_stall_in_0_reg_165_NO_SHIFT_REG);
		rnode_164to165_ld__0_consumed_1_NO_SHIFT_REG <= (rnode_164to165_ld__0_valid_out_0_reg_165_NO_SHIFT_REG & (rnode_164to165_ld__0_consumed_1_NO_SHIFT_REG | ~(rnode_164to165_ld__0_stall_in_1_NO_SHIFT_REG)) & rnode_164to165_ld__0_stall_in_0_reg_165_NO_SHIFT_REG);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rcnode_164to165_rc0_sum_15_0_valid_out_0_NO_SHIFT_REG;
 logic rcnode_164to165_rc0_sum_15_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rcnode_164to165_rc0_sum_15_0_NO_SHIFT_REG;
 logic rcnode_164to165_rc0_sum_15_0_valid_out_1_NO_SHIFT_REG;
 logic rcnode_164to165_rc0_sum_15_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rcnode_164to165_rc0_sum_15_1_NO_SHIFT_REG;
 logic rcnode_164to165_rc0_sum_15_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rcnode_164to165_rc0_sum_15_0_reg_165_NO_SHIFT_REG;
 logic rcnode_164to165_rc0_sum_15_0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rcnode_164to165_rc0_sum_15_0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rcnode_164to165_rc0_sum_15_0_stall_out_reg_165_IP_NO_SHIFT_REG;
 logic rcnode_164to165_rc0_sum_15_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rcnode_164to165_rc0_sum_15_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rcnode_164to165_rc0_sum_15_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rcnode_164to165_rc0_sum_15_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rcnode_164to165_rc0_sum_15_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rcnode_164to165_rc0_sum_15_0_stall_out_reg_165_IP_NO_SHIFT_REG),
	.data_in(rci_rcnode_164to165_rc0_sum_15_0_reg_164),
	.data_out(rcnode_164to165_rc0_sum_15_0_reg_165_NO_SHIFT_REG)
);

defparam rcnode_164to165_rc0_sum_15_0_reg_165_fifo.DEPTH = 1;
defparam rcnode_164to165_rc0_sum_15_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rcnode_164to165_rc0_sum_15_0_reg_165_fifo.ALLOW_FULL_WRITE = 1;
defparam rcnode_164to165_rc0_sum_15_0_reg_165_fifo.IMPL = "ll_reg";

assign rcnode_164to165_rc0_sum_15_0_reg_165_inputs_ready_NO_SHIFT_REG = rcnode_1to164_rc6_sum_15_0_valid_out_NO_SHIFT_REG;
assign rcnode_164to165_rc0_sum_15_0_stall_out_reg_165_NO_SHIFT_REG = (~(rcnode_164to165_rc0_sum_15_0_reg_165_inputs_ready_NO_SHIFT_REG) | rcnode_164to165_rc0_sum_15_0_stall_out_reg_165_IP_NO_SHIFT_REG);
assign rcnode_1to164_rc6_sum_15_0_stall_in_NO_SHIFT_REG = rcnode_164to165_rc0_sum_15_0_stall_out_reg_165_NO_SHIFT_REG;
assign rcnode_164to165_rc0_sum_15_0_stall_in_0_reg_165_NO_SHIFT_REG = (rcnode_164to165_rc0_sum_15_0_stall_in_0_NO_SHIFT_REG | rcnode_164to165_rc0_sum_15_0_stall_in_1_NO_SHIFT_REG);
assign rcnode_164to165_rc0_sum_15_0_valid_out_0_NO_SHIFT_REG = rcnode_164to165_rc0_sum_15_0_valid_out_0_reg_165_NO_SHIFT_REG;
assign rcnode_164to165_rc0_sum_15_0_valid_out_1_NO_SHIFT_REG = rcnode_164to165_rc0_sum_15_0_valid_out_0_reg_165_NO_SHIFT_REG;
assign rcnode_164to165_rc0_sum_15_0_NO_SHIFT_REG = rcnode_164to165_rc0_sum_15_0_reg_165_NO_SHIFT_REG;
assign rcnode_164to165_rc0_sum_15_1_NO_SHIFT_REG = rcnode_164to165_rc0_sum_15_0_reg_165_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_cmp_i_i_valid_out;
wire local_bb3_cmp_i_i_stall_in;
wire local_bb3_cmp_i_i_inputs_ready;
wire local_bb3_cmp_i_i_stall_local;
wire local_bb3_cmp_i_i;

assign local_bb3_cmp_i_i_inputs_ready = rnode_1to2_bb3_add15_0_valid_out_0_NO_SHIFT_REG;
assign local_bb3_cmp_i_i = ($signed(rnode_1to2_bb3_add15_0_NO_SHIFT_REG) < $signed(32'h0));
assign local_bb3_cmp_i_i_valid_out = local_bb3_cmp_i_i_inputs_ready;
assign local_bb3_cmp_i_i_stall_local = local_bb3_cmp_i_i_stall_in;
assign rnode_1to2_bb3_add15_0_stall_in_0_NO_SHIFT_REG = (|local_bb3_cmp_i_i_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp1_i_i_valid_out;
wire local_bb3_cmp1_i_i_stall_in;
wire local_bb3_cmp1_i_i_inputs_ready;
wire local_bb3_cmp1_i_i_stall_local;
wire local_bb3_cmp1_i_i;

assign local_bb3_cmp1_i_i_inputs_ready = rnode_1to2_bb3_add15_0_valid_out_1_NO_SHIFT_REG;
assign local_bb3_cmp1_i_i = ($signed(rnode_1to2_bb3_add15_1_NO_SHIFT_REG) > $signed(input_wii_sub20));
assign local_bb3_cmp1_i_i_valid_out = local_bb3_cmp1_i_i_inputs_ready;
assign local_bb3_cmp1_i_i_stall_local = local_bb3_cmp1_i_i_stall_in;
assign rnode_1to2_bb3_add15_0_stall_in_1_NO_SHIFT_REG = (|local_bb3_cmp1_i_i_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb3_inc_valid_out;
wire local_bb3_inc_stall_in;
wire local_bb3_inc_inputs_ready;
wire local_bb3_inc_stall_local;
wire [31:0] local_bb3_inc;

assign local_bb3_inc_inputs_ready = rnode_178to179_j_17_0_valid_out_NO_SHIFT_REG;
assign local_bb3_inc = (rnode_178to179_j_17_0_NO_SHIFT_REG + 32'h1);
assign local_bb3_inc_valid_out = local_bb3_inc_inputs_ready;
assign local_bb3_inc_stall_local = local_bb3_inc_stall_in;
assign rnode_178to179_j_17_0_stall_in_NO_SHIFT_REG = (|local_bb3_inc_stall_local);

// Register node:
//  * latency = 15
//  * capacity = 15
 logic rnode_165to180_ld__0_valid_out_NO_SHIFT_REG;
 logic rnode_165to180_ld__0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_165to180_ld__0_NO_SHIFT_REG;
 logic rnode_165to180_ld__0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_165to180_ld__0_reg_180_NO_SHIFT_REG;
 logic rnode_165to180_ld__0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_165to180_ld__0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_165to180_ld__0_stall_out_reg_180_NO_SHIFT_REG;
wire [33:0] rci_rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_2;

acl_data_fifo rnode_165to180_ld__0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to180_ld__0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to180_ld__0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_165to180_ld__0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_165to180_ld__0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_164to165_ld__1_NO_SHIFT_REG),
	.data_out(rnode_165to180_ld__0_reg_180_NO_SHIFT_REG)
);

defparam rnode_165to180_ld__0_reg_180_fifo.DEPTH = 16;
defparam rnode_165to180_ld__0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_165to180_ld__0_reg_180_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_165to180_ld__0_reg_180_fifo.IMPL = "ram";

assign rnode_165to180_ld__0_reg_180_inputs_ready_NO_SHIFT_REG = rnode_164to165_ld__0_valid_out_1_NO_SHIFT_REG;
assign rnode_164to165_ld__0_stall_in_1_NO_SHIFT_REG = rnode_165to180_ld__0_stall_out_reg_180_NO_SHIFT_REG;
assign rnode_165to180_ld__0_NO_SHIFT_REG = rnode_165to180_ld__0_reg_180_NO_SHIFT_REG;
assign rnode_165to180_ld__0_stall_in_reg_180_NO_SHIFT_REG = rnode_165to180_ld__0_stall_in_NO_SHIFT_REG;
assign rnode_165to180_ld__0_valid_out_NO_SHIFT_REG = rnode_165to180_ld__0_valid_out_reg_180_NO_SHIFT_REG;
assign rci_rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_2[0] = local_bb3_cmp1_i_i;
assign rci_rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_2[32:1] = rnode_1to2_bb3_add15_2_NO_SHIFT_REG;
assign rci_rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_2[33] = local_bb3_cmp_i_i;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rcnode_2to3_rc0_bb3_cmp1_i_i_0_valid_out_0_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_in_0_NO_SHIFT_REG;
 logic [33:0] rcnode_2to3_rc0_bb3_cmp1_i_i_0_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb3_cmp1_i_i_0_valid_out_1_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_in_1_NO_SHIFT_REG;
 logic [33:0] rcnode_2to3_rc0_bb3_cmp1_i_i_1_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_3_inputs_ready_NO_SHIFT_REG;
 logic [33:0] rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_3_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb3_cmp1_i_i_0_valid_out_0_reg_3_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_in_0_reg_3_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_out_0_reg_3_IP_NO_SHIFT_REG;
 logic rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_out_0_reg_3_NO_SHIFT_REG;

acl_data_fifo rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_3_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_3_inputs_ready_NO_SHIFT_REG),
	.stall_in(rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_in_0_reg_3_NO_SHIFT_REG),
	.valid_out(rcnode_2to3_rc0_bb3_cmp1_i_i_0_valid_out_0_reg_3_NO_SHIFT_REG),
	.stall_out(rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_out_0_reg_3_IP_NO_SHIFT_REG),
	.data_in(rci_rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_2),
	.data_out(rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_3_NO_SHIFT_REG)
);

defparam rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_3_fifo.DEPTH = 1;
defparam rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_3_fifo.DATA_WIDTH = 34;
defparam rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_3_fifo.ALLOW_FULL_WRITE = 1;
defparam rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_3_fifo.IMPL = "ll_reg";

assign rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_3_inputs_ready_NO_SHIFT_REG = (local_bb3_cmp1_i_i_valid_out & rnode_1to2_bb3_add15_0_valid_out_2_NO_SHIFT_REG & local_bb3_cmp_i_i_valid_out);
assign rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_out_0_reg_3_NO_SHIFT_REG = (~(rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_3_inputs_ready_NO_SHIFT_REG) | rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_out_0_reg_3_IP_NO_SHIFT_REG);
assign local_bb3_cmp1_i_i_stall_in = rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_out_0_reg_3_NO_SHIFT_REG;
assign rnode_1to2_bb3_add15_0_stall_in_2_NO_SHIFT_REG = rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_out_0_reg_3_NO_SHIFT_REG;
assign local_bb3_cmp_i_i_stall_in = rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_out_0_reg_3_NO_SHIFT_REG;
assign rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_in_0_reg_3_NO_SHIFT_REG = (rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_in_0_NO_SHIFT_REG | rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_in_1_NO_SHIFT_REG);
assign rcnode_2to3_rc0_bb3_cmp1_i_i_0_valid_out_0_NO_SHIFT_REG = rcnode_2to3_rc0_bb3_cmp1_i_i_0_valid_out_0_reg_3_NO_SHIFT_REG;
assign rcnode_2to3_rc0_bb3_cmp1_i_i_0_valid_out_1_NO_SHIFT_REG = rcnode_2to3_rc0_bb3_cmp1_i_i_0_valid_out_0_reg_3_NO_SHIFT_REG;
assign rcnode_2to3_rc0_bb3_cmp1_i_i_0_NO_SHIFT_REG = rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_3_NO_SHIFT_REG;
assign rcnode_2to3_rc0_bb3_cmp1_i_i_1_NO_SHIFT_REG = rcnode_2to3_rc0_bb3_cmp1_i_i_0_reg_3_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb3_inc_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_179to180_bb3_inc_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb3_inc_0_NO_SHIFT_REG;
 logic rnode_179to180_bb3_inc_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_179to180_bb3_inc_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb3_inc_1_NO_SHIFT_REG;
 logic rnode_179to180_bb3_inc_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb3_inc_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb3_inc_0_valid_out_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb3_inc_0_stall_in_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb3_inc_0_stall_out_reg_180_NO_SHIFT_REG;
 reg rnode_179to180_bb3_inc_0_consumed_0_NO_SHIFT_REG;
 reg rnode_179to180_bb3_inc_0_consumed_1_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb3_inc_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb3_inc_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb3_inc_0_stall_in_0_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb3_inc_0_valid_out_0_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb3_inc_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(local_bb3_inc),
	.data_out(rnode_179to180_bb3_inc_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb3_inc_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb3_inc_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb3_inc_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb3_inc_0_reg_180_fifo.IMPL = "ll_reg";

assign rnode_179to180_bb3_inc_0_reg_180_inputs_ready_NO_SHIFT_REG = local_bb3_inc_valid_out;
assign local_bb3_inc_stall_in = rnode_179to180_bb3_inc_0_stall_out_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb3_inc_0_stall_in_0_reg_180_NO_SHIFT_REG = ((rnode_179to180_bb3_inc_0_stall_in_0_NO_SHIFT_REG & ~(rnode_179to180_bb3_inc_0_consumed_0_NO_SHIFT_REG)) | (rnode_179to180_bb3_inc_0_stall_in_1_NO_SHIFT_REG & ~(rnode_179to180_bb3_inc_0_consumed_1_NO_SHIFT_REG)));
assign rnode_179to180_bb3_inc_0_valid_out_0_NO_SHIFT_REG = (rnode_179to180_bb3_inc_0_valid_out_0_reg_180_NO_SHIFT_REG & ~(rnode_179to180_bb3_inc_0_consumed_0_NO_SHIFT_REG));
assign rnode_179to180_bb3_inc_0_valid_out_1_NO_SHIFT_REG = (rnode_179to180_bb3_inc_0_valid_out_0_reg_180_NO_SHIFT_REG & ~(rnode_179to180_bb3_inc_0_consumed_1_NO_SHIFT_REG));
assign rnode_179to180_bb3_inc_0_NO_SHIFT_REG = rnode_179to180_bb3_inc_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb3_inc_1_NO_SHIFT_REG = rnode_179to180_bb3_inc_0_reg_180_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rnode_179to180_bb3_inc_0_consumed_0_NO_SHIFT_REG <= 1'b0;
		rnode_179to180_bb3_inc_0_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rnode_179to180_bb3_inc_0_consumed_0_NO_SHIFT_REG <= (rnode_179to180_bb3_inc_0_valid_out_0_reg_180_NO_SHIFT_REG & (rnode_179to180_bb3_inc_0_consumed_0_NO_SHIFT_REG | ~(rnode_179to180_bb3_inc_0_stall_in_0_NO_SHIFT_REG)) & rnode_179to180_bb3_inc_0_stall_in_0_reg_180_NO_SHIFT_REG);
		rnode_179to180_bb3_inc_0_consumed_1_NO_SHIFT_REG <= (rnode_179to180_bb3_inc_0_valid_out_0_reg_180_NO_SHIFT_REG & (rnode_179to180_bb3_inc_0_consumed_1_NO_SHIFT_REG | ~(rnode_179to180_bb3_inc_0_stall_in_1_NO_SHIFT_REG)) & rnode_179to180_bb3_inc_0_stall_in_0_reg_180_NO_SHIFT_REG);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb3___stall_local;
wire [31:0] local_bb3__;

assign local_bb3__ = (rcnode_2to3_rc0_bb3_cmp1_i_i_0_NO_SHIFT_REG[0] ? input_wii_sub20 : rcnode_2to3_rc0_bb3_cmp1_i_i_0_NO_SHIFT_REG[32:1]);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp11_valid_out;
wire local_bb3_cmp11_stall_in;
wire local_bb3_cmp11_inputs_ready;
wire local_bb3_cmp11_stall_local;
wire local_bb3_cmp11;
wire [255:0] rci_rcnode_180to181_rc1_bb3_inc_0_reg_180;

assign local_bb3_cmp11_inputs_ready = rnode_179to180_bb3_inc_0_valid_out_0_NO_SHIFT_REG;
assign local_bb3_cmp11 = ($signed(rnode_179to180_bb3_inc_0_NO_SHIFT_REG) > $signed(input_r));
assign local_bb3_cmp11_valid_out = local_bb3_cmp11_inputs_ready;
assign local_bb3_cmp11_stall_local = local_bb3_cmp11_stall_in;
assign rnode_179to180_bb3_inc_0_stall_in_0_NO_SHIFT_REG = (|local_bb3_cmp11_stall_local);
assign rci_rcnode_180to181_rc1_bb3_inc_0_reg_180[31:0] = rnode_179to180_bb3_inc_1_NO_SHIFT_REG;
assign rci_rcnode_180to181_rc1_bb3_inc_0_reg_180[63:32] = (rcnode_1to180_rc7_scalarizer_0mul_0_NO_SHIFT_REG[31:0] & 32'hFFFFFFFE);
assign rci_rcnode_180to181_rc1_bb3_inc_0_reg_180[95:64] = (rcnode_1to180_rc7_scalarizer_0mul_0_NO_SHIFT_REG[63:32] & 32'hFFFFFFFE);
assign rci_rcnode_180to181_rc1_bb3_inc_0_reg_180[127:96] = rcnode_1to180_rc7_scalarizer_0mul_0_NO_SHIFT_REG[95:64];
assign rci_rcnode_180to181_rc1_bb3_inc_0_reg_180[159:128] = rcnode_1to180_rc7_scalarizer_0mul_0_NO_SHIFT_REG[127:96];
assign rci_rcnode_180to181_rc1_bb3_inc_0_reg_180[191:160] = rnode_1to180_input_global_id_1_0_NO_SHIFT_REG;
assign rci_rcnode_180to181_rc1_bb3_inc_0_reg_180[223:192] = rnode_3to180_mul25_0_NO_SHIFT_REG;
assign rci_rcnode_180to181_rc1_bb3_inc_0_reg_180[255:224] = rnode_165to180_ld__0_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rcnode_180to181_rc1_bb3_inc_0_valid_out_NO_SHIFT_REG;
 logic rcnode_180to181_rc1_bb3_inc_0_stall_in_NO_SHIFT_REG;
 logic [255:0] rcnode_180to181_rc1_bb3_inc_0_NO_SHIFT_REG;
 logic rcnode_180to181_rc1_bb3_inc_0_reg_181_inputs_ready_NO_SHIFT_REG;
 logic [255:0] rcnode_180to181_rc1_bb3_inc_0_reg_181_NO_SHIFT_REG;
 logic rcnode_180to181_rc1_bb3_inc_0_valid_out_reg_181_NO_SHIFT_REG;
 logic rcnode_180to181_rc1_bb3_inc_0_stall_in_reg_181_NO_SHIFT_REG;
 logic rcnode_180to181_rc1_bb3_inc_0_stall_out_0_reg_181_IP_NO_SHIFT_REG;
 logic rcnode_180to181_rc1_bb3_inc_0_stall_out_0_reg_181_NO_SHIFT_REG;

acl_data_fifo rcnode_180to181_rc1_bb3_inc_0_reg_181_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rcnode_180to181_rc1_bb3_inc_0_reg_181_inputs_ready_NO_SHIFT_REG),
	.stall_in(rcnode_180to181_rc1_bb3_inc_0_stall_in_reg_181_NO_SHIFT_REG),
	.valid_out(rcnode_180to181_rc1_bb3_inc_0_valid_out_reg_181_NO_SHIFT_REG),
	.stall_out(rcnode_180to181_rc1_bb3_inc_0_stall_out_0_reg_181_IP_NO_SHIFT_REG),
	.data_in(rci_rcnode_180to181_rc1_bb3_inc_0_reg_180),
	.data_out(rcnode_180to181_rc1_bb3_inc_0_reg_181_NO_SHIFT_REG)
);

defparam rcnode_180to181_rc1_bb3_inc_0_reg_181_fifo.DEPTH = 1;
defparam rcnode_180to181_rc1_bb3_inc_0_reg_181_fifo.DATA_WIDTH = 256;
defparam rcnode_180to181_rc1_bb3_inc_0_reg_181_fifo.ALLOW_FULL_WRITE = 1;
defparam rcnode_180to181_rc1_bb3_inc_0_reg_181_fifo.IMPL = "ll_reg";

assign rcnode_180to181_rc1_bb3_inc_0_reg_181_inputs_ready_NO_SHIFT_REG = (rnode_179to180_bb3_inc_0_valid_out_1_NO_SHIFT_REG & rnode_1to180_input_global_id_1_0_valid_out_NO_SHIFT_REG & rnode_3to180_mul25_0_valid_out_NO_SHIFT_REG & rnode_165to180_ld__0_valid_out_NO_SHIFT_REG & rcnode_1to180_rc7_scalarizer_0mul_0_valid_out_NO_SHIFT_REG);
assign rcnode_180to181_rc1_bb3_inc_0_stall_out_0_reg_181_NO_SHIFT_REG = (~(rcnode_180to181_rc1_bb3_inc_0_reg_181_inputs_ready_NO_SHIFT_REG) | rcnode_180to181_rc1_bb3_inc_0_stall_out_0_reg_181_IP_NO_SHIFT_REG);
assign rnode_179to180_bb3_inc_0_stall_in_1_NO_SHIFT_REG = rcnode_180to181_rc1_bb3_inc_0_stall_out_0_reg_181_NO_SHIFT_REG;
assign rnode_1to180_input_global_id_1_0_stall_in_NO_SHIFT_REG = rcnode_180to181_rc1_bb3_inc_0_stall_out_0_reg_181_NO_SHIFT_REG;
assign rnode_3to180_mul25_0_stall_in_NO_SHIFT_REG = rcnode_180to181_rc1_bb3_inc_0_stall_out_0_reg_181_NO_SHIFT_REG;
assign rnode_165to180_ld__0_stall_in_NO_SHIFT_REG = rcnode_180to181_rc1_bb3_inc_0_stall_out_0_reg_181_NO_SHIFT_REG;
assign rcnode_1to180_rc7_scalarizer_0mul_0_stall_in_NO_SHIFT_REG = rcnode_180to181_rc1_bb3_inc_0_stall_out_0_reg_181_NO_SHIFT_REG;
assign rcnode_180to181_rc1_bb3_inc_0_NO_SHIFT_REG = rcnode_180to181_rc1_bb3_inc_0_reg_181_NO_SHIFT_REG;
assign rcnode_180to181_rc1_bb3_inc_0_stall_in_reg_181_NO_SHIFT_REG = rcnode_180to181_rc1_bb3_inc_0_stall_in_NO_SHIFT_REG;
assign rcnode_180to181_rc1_bb3_inc_0_valid_out_NO_SHIFT_REG = rcnode_180to181_rc1_bb3_inc_0_valid_out_reg_181_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3___u0_stall_local;
wire [31:0] local_bb3___u0;

assign local_bb3___u0 = (rcnode_2to3_rc0_bb3_cmp1_i_i_0_NO_SHIFT_REG[33] ? 32'h0 : local_bb3__);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_180to181_bb3_cmp11_0_valid_out_NO_SHIFT_REG;
 logic rnode_180to181_bb3_cmp11_0_stall_in_NO_SHIFT_REG;
 logic rnode_180to181_bb3_cmp11_0_NO_SHIFT_REG;
 logic rnode_180to181_bb3_cmp11_0_reg_181_inputs_ready_NO_SHIFT_REG;
 logic rnode_180to181_bb3_cmp11_0_reg_181_NO_SHIFT_REG;
 logic rnode_180to181_bb3_cmp11_0_valid_out_reg_181_NO_SHIFT_REG;
 logic rnode_180to181_bb3_cmp11_0_stall_in_reg_181_NO_SHIFT_REG;
 logic rnode_180to181_bb3_cmp11_0_stall_out_reg_181_NO_SHIFT_REG;

acl_data_fifo rnode_180to181_bb3_cmp11_0_reg_181_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_180to181_bb3_cmp11_0_reg_181_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_180to181_bb3_cmp11_0_stall_in_reg_181_NO_SHIFT_REG),
	.valid_out(rnode_180to181_bb3_cmp11_0_valid_out_reg_181_NO_SHIFT_REG),
	.stall_out(rnode_180to181_bb3_cmp11_0_stall_out_reg_181_NO_SHIFT_REG),
	.data_in(local_bb3_cmp11),
	.data_out(rnode_180to181_bb3_cmp11_0_reg_181_NO_SHIFT_REG)
);

defparam rnode_180to181_bb3_cmp11_0_reg_181_fifo.DEPTH = 1;
defparam rnode_180to181_bb3_cmp11_0_reg_181_fifo.DATA_WIDTH = 1;
defparam rnode_180to181_bb3_cmp11_0_reg_181_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_180to181_bb3_cmp11_0_reg_181_fifo.IMPL = "ll_reg";

assign rnode_180to181_bb3_cmp11_0_reg_181_inputs_ready_NO_SHIFT_REG = local_bb3_cmp11_valid_out;
assign local_bb3_cmp11_stall_in = rnode_180to181_bb3_cmp11_0_stall_out_reg_181_NO_SHIFT_REG;
assign rnode_180to181_bb3_cmp11_0_NO_SHIFT_REG = rnode_180to181_bb3_cmp11_0_reg_181_NO_SHIFT_REG;
assign rnode_180to181_bb3_cmp11_0_stall_in_reg_181_NO_SHIFT_REG = rnode_180to181_bb3_cmp11_0_stall_in_NO_SHIFT_REG;
assign rnode_180to181_bb3_cmp11_0_valid_out_NO_SHIFT_REG = rnode_180to181_bb3_cmp11_0_valid_out_reg_181_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_add26_valid_out;
wire local_bb3_add26_stall_in;
wire local_bb3_add26_inputs_ready;
wire local_bb3_add26_stall_local;
wire [31:0] local_bb3_add26;

assign local_bb3_add26_inputs_ready = (rnode_1to3_mul25_0_valid_out_0_NO_SHIFT_REG & rcnode_2to3_rc0_bb3_cmp1_i_i_0_valid_out_0_NO_SHIFT_REG & rcnode_2to3_rc0_bb3_cmp1_i_i_0_valid_out_1_NO_SHIFT_REG);
assign local_bb3_add26 = (rnode_1to3_mul25_0_NO_SHIFT_REG + local_bb3___u0);
assign local_bb3_add26_valid_out = local_bb3_add26_inputs_ready;
assign local_bb3_add26_stall_local = local_bb3_add26_stall_in;
assign rnode_1to3_mul25_0_stall_in_0_NO_SHIFT_REG = (local_bb3_add26_stall_local | ~(local_bb3_add26_inputs_ready));
assign rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_in_0_NO_SHIFT_REG = (local_bb3_add26_stall_local | ~(local_bb3_add26_inputs_ready));
assign rcnode_2to3_rc0_bb3_cmp1_i_i_0_stall_in_1_NO_SHIFT_REG = (local_bb3_add26_stall_local | ~(local_bb3_add26_inputs_ready));

// This section implements an unregistered operation.
// 
wire local_bb3_var__valid_out;
wire local_bb3_var__stall_in;
wire local_bb3_var__inputs_ready;
wire local_bb3_var__stall_local;
wire local_bb3_var_;

assign local_bb3_var__inputs_ready = rnode_180to181_bb3_cmp11_0_valid_out_NO_SHIFT_REG;
assign local_bb3_var_ = (input_wii_cmp9 | rnode_180to181_bb3_cmp11_0_NO_SHIFT_REG);
assign local_bb3_var__valid_out = local_bb3_var__inputs_ready;
assign local_bb3_var__stall_local = local_bb3_var__stall_in;
assign rnode_180to181_bb3_cmp11_0_stall_in_NO_SHIFT_REG = (|local_bb3_var__stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_3to4_bb3_add26_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to4_bb3_add26_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_3to4_bb3_add26_0_NO_SHIFT_REG;
 logic rnode_3to4_bb3_add26_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_3to4_bb3_add26_0_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb3_add26_0_valid_out_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb3_add26_0_stall_in_reg_4_NO_SHIFT_REG;
 logic rnode_3to4_bb3_add26_0_stall_out_reg_4_NO_SHIFT_REG;

acl_data_fifo rnode_3to4_bb3_add26_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to4_bb3_add26_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to4_bb3_add26_0_stall_in_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_3to4_bb3_add26_0_valid_out_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_3to4_bb3_add26_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(local_bb3_add26),
	.data_out(rnode_3to4_bb3_add26_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_3to4_bb3_add26_0_reg_4_fifo.DEPTH = 1;
defparam rnode_3to4_bb3_add26_0_reg_4_fifo.DATA_WIDTH = 32;
defparam rnode_3to4_bb3_add26_0_reg_4_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_3to4_bb3_add26_0_reg_4_fifo.IMPL = "ll_reg";

assign rnode_3to4_bb3_add26_0_reg_4_inputs_ready_NO_SHIFT_REG = local_bb3_add26_valid_out;
assign local_bb3_add26_stall_in = rnode_3to4_bb3_add26_0_stall_out_reg_4_NO_SHIFT_REG;
assign rnode_3to4_bb3_add26_0_NO_SHIFT_REG = rnode_3to4_bb3_add26_0_reg_4_NO_SHIFT_REG;
assign rnode_3to4_bb3_add26_0_stall_in_reg_4_NO_SHIFT_REG = rnode_3to4_bb3_add26_0_stall_in_NO_SHIFT_REG;
assign rnode_3to4_bb3_add26_0_valid_out_NO_SHIFT_REG = rnode_3to4_bb3_add26_0_valid_out_reg_4_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_idxprom27_stall_local;
wire [63:0] local_bb3_idxprom27;

assign local_bb3_idxprom27[63:32] = 32'h0;
assign local_bb3_idxprom27[31:0] = rnode_3to4_bb3_add26_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_arrayidx28_valid_out;
wire local_bb3_arrayidx28_stall_in;
wire local_bb3_arrayidx28_inputs_ready;
wire local_bb3_arrayidx28_stall_local;
wire [63:0] local_bb3_arrayidx28;

assign local_bb3_arrayidx28_inputs_ready = rnode_3to4_bb3_add26_0_valid_out_NO_SHIFT_REG;
assign local_bb3_arrayidx28 = ((input_in & 64'hFFFFFFFFFFFFFC00) + ((local_bb3_idxprom27 & 64'hFFFFFFFF) << 6'h2));
assign local_bb3_arrayidx28_valid_out = local_bb3_arrayidx28_inputs_ready;
assign local_bb3_arrayidx28_stall_local = local_bb3_arrayidx28_stall_in;
assign rnode_3to4_bb3_add26_0_stall_in_NO_SHIFT_REG = (|local_bb3_arrayidx28_stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb3_arrayidx28_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to5_bb3_arrayidx28_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb3_arrayidx28_0_NO_SHIFT_REG;
 logic rnode_4to5_bb3_arrayidx28_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb3_arrayidx28_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb3_arrayidx28_0_valid_out_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb3_arrayidx28_0_stall_in_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb3_arrayidx28_0_stall_out_reg_5_NO_SHIFT_REG;

acl_data_fifo rnode_4to5_bb3_arrayidx28_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb3_arrayidx28_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb3_arrayidx28_0_stall_in_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb3_arrayidx28_0_valid_out_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb3_arrayidx28_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in((local_bb3_arrayidx28 & 64'hFFFFFFFFFFFFFFFC)),
	.data_out(rnode_4to5_bb3_arrayidx28_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb3_arrayidx28_0_reg_5_fifo.DEPTH = 2;
defparam rnode_4to5_bb3_arrayidx28_0_reg_5_fifo.DATA_WIDTH = 64;
defparam rnode_4to5_bb3_arrayidx28_0_reg_5_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_4to5_bb3_arrayidx28_0_reg_5_fifo.IMPL = "ll_reg";

assign rnode_4to5_bb3_arrayidx28_0_reg_5_inputs_ready_NO_SHIFT_REG = local_bb3_arrayidx28_valid_out;
assign local_bb3_arrayidx28_stall_in = rnode_4to5_bb3_arrayidx28_0_stall_out_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb3_arrayidx28_0_NO_SHIFT_REG = rnode_4to5_bb3_arrayidx28_0_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb3_arrayidx28_0_stall_in_reg_5_NO_SHIFT_REG = rnode_4to5_bb3_arrayidx28_0_stall_in_NO_SHIFT_REG;
assign rnode_4to5_bb3_arrayidx28_0_valid_out_NO_SHIFT_REG = rnode_4to5_bb3_arrayidx28_0_valid_out_reg_5_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb3_ld__inputs_ready;
 reg local_bb3_ld__valid_out_NO_SHIFT_REG;
wire local_bb3_ld__stall_in;
wire local_bb3_ld__output_regs_ready;
wire local_bb3_ld__fu_stall_out;
wire local_bb3_ld__fu_valid_out;
wire [31:0] local_bb3_ld__lsu_dataout;
 reg [31:0] local_bb3_ld__NO_SHIFT_REG;
wire local_bb3_ld__causedstall;

lsu_top lsu_local_bb3_ld_ (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb3_ld__fu_stall_out),
	.i_valid(local_bb3_ld__inputs_ready),
	.i_address((rnode_4to5_bb3_arrayidx28_0_NO_SHIFT_REG & 64'hFFFFFFFFFFFFFFFC)),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(input_wii_cmp9),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb3_ld__output_regs_ready)),
	.o_valid(local_bb3_ld__fu_valid_out),
	.o_readdata(local_bb3_ld__lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb3_ld__active),
	.avm_address(avm_local_bb3_ld__address),
	.avm_read(avm_local_bb3_ld__read),
	.avm_readdata(avm_local_bb3_ld__readdata),
	.avm_write(avm_local_bb3_ld__write),
	.avm_writeack(avm_local_bb3_ld__writeack),
	.avm_burstcount(avm_local_bb3_ld__burstcount),
	.avm_writedata(avm_local_bb3_ld__writedata),
	.avm_byteenable(avm_local_bb3_ld__byteenable),
	.avm_waitrequest(avm_local_bb3_ld__waitrequest),
	.avm_readdatavalid(avm_local_bb3_ld__readdatavalid),
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

defparam lsu_local_bb3_ld_.AWIDTH = 33;
defparam lsu_local_bb3_ld_.WIDTH_BYTES = 4;
defparam lsu_local_bb3_ld_.MWIDTH_BYTES = 64;
defparam lsu_local_bb3_ld_.WRITEDATAWIDTH_BYTES = 64;
defparam lsu_local_bb3_ld_.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb3_ld_.READ = 1;
defparam lsu_local_bb3_ld_.ATOMIC = 0;
defparam lsu_local_bb3_ld_.WIDTH = 32;
defparam lsu_local_bb3_ld_.MWIDTH = 512;
defparam lsu_local_bb3_ld_.ATOMIC_WIDTH = 3;
defparam lsu_local_bb3_ld_.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb3_ld_.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb3_ld_.MEMORY_SIDE_MEM_LATENCY = 99;
defparam lsu_local_bb3_ld_.USE_WRITE_ACK = 0;
defparam lsu_local_bb3_ld_.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb3_ld_.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb3_ld_.NUMBER_BANKS = 1;
defparam lsu_local_bb3_ld_.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb3_ld_.INTENDED_DEVICE_FAMILY = "Stratix V";
defparam lsu_local_bb3_ld_.USEINPUTFIFO = 0;
defparam lsu_local_bb3_ld_.USECACHING = 0;
defparam lsu_local_bb3_ld_.USEOUTPUTFIFO = 1;
defparam lsu_local_bb3_ld_.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb3_ld_.HIGH_FMAX = 1;
defparam lsu_local_bb3_ld_.ADDRSPACE = 1;
defparam lsu_local_bb3_ld_.STYLE = "BURST-COALESCED";

assign local_bb3_ld__inputs_ready = (rnode_4to5_bb3_arrayidx28_0_valid_out_NO_SHIFT_REG & rnode_1to5_cmp9_0_valid_out_NO_SHIFT_REG);
assign local_bb3_ld__output_regs_ready = (&(~(local_bb3_ld__valid_out_NO_SHIFT_REG) | ~(local_bb3_ld__stall_in)));
assign rnode_4to5_bb3_arrayidx28_0_stall_in_NO_SHIFT_REG = (local_bb3_ld__fu_stall_out | ~(local_bb3_ld__inputs_ready));
assign rnode_1to5_cmp9_0_stall_in_NO_SHIFT_REG = (local_bb3_ld__fu_stall_out | ~(local_bb3_ld__inputs_ready));
assign local_bb3_ld__causedstall = (local_bb3_ld__inputs_ready && (local_bb3_ld__fu_stall_out && !(~(local_bb3_ld__output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_ld__NO_SHIFT_REG <= 'x;
		local_bb3_ld__valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_ld__output_regs_ready)
		begin
			local_bb3_ld__NO_SHIFT_REG <= local_bb3_ld__lsu_dataout;
			local_bb3_ld__valid_out_NO_SHIFT_REG <= local_bb3_ld__fu_valid_out;
		end
		else
		begin
			if (~(local_bb3_ld__stall_in))
			begin
				local_bb3_ld__valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_165to165_bb3_ld__valid_out;
wire rstag_165to165_bb3_ld__stall_in;
wire rstag_165to165_bb3_ld__inputs_ready;
wire rstag_165to165_bb3_ld__stall_local;
 reg rstag_165to165_bb3_ld__staging_valid_NO_SHIFT_REG;
wire rstag_165to165_bb3_ld__combined_valid;
 reg [31:0] rstag_165to165_bb3_ld__staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_165to165_bb3_ld_;

assign rstag_165to165_bb3_ld__inputs_ready = local_bb3_ld__valid_out_NO_SHIFT_REG;
assign rstag_165to165_bb3_ld_ = (rstag_165to165_bb3_ld__staging_valid_NO_SHIFT_REG ? rstag_165to165_bb3_ld__staging_reg_NO_SHIFT_REG : local_bb3_ld__NO_SHIFT_REG);
assign rstag_165to165_bb3_ld__combined_valid = (rstag_165to165_bb3_ld__staging_valid_NO_SHIFT_REG | rstag_165to165_bb3_ld__inputs_ready);
assign rstag_165to165_bb3_ld__valid_out = rstag_165to165_bb3_ld__combined_valid;
assign rstag_165to165_bb3_ld__stall_local = rstag_165to165_bb3_ld__stall_in;
assign local_bb3_ld__stall_in = (|rstag_165to165_bb3_ld__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_165to165_bb3_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_165to165_bb3_ld__staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_165to165_bb3_ld__stall_local)
		begin
			if (~(rstag_165to165_bb3_ld__staging_valid_NO_SHIFT_REG))
			begin
				rstag_165to165_bb3_ld__staging_valid_NO_SHIFT_REG <= rstag_165to165_bb3_ld__inputs_ready;
			end
		end
		else
		begin
			rstag_165to165_bb3_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_165to165_bb3_ld__staging_valid_NO_SHIFT_REG))
		begin
			rstag_165to165_bb3_ld__staging_reg_NO_SHIFT_REG <= local_bb3_ld__NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb3_c0_eni1_stall_local;
wire [159:0] local_bb3_c0_eni1;

assign local_bb3_c0_eni1[31:0] = 32'bx;
assign local_bb3_c0_eni1[63:32] = rstag_165to165_bb3_ld_;
assign local_bb3_c0_eni1[159:64] = 96'bx;

// This section implements an unregistered operation.
// 
wire local_bb3_c0_eni2_stall_local;
wire [159:0] local_bb3_c0_eni2;

assign local_bb3_c0_eni2[63:0] = local_bb3_c0_eni1[63:0];
assign local_bb3_c0_eni2[95:64] = rnode_164to165_ld__0_NO_SHIFT_REG;
assign local_bb3_c0_eni2[159:96] = local_bb3_c0_eni1[159:96];

// This section implements an unregistered operation.
// 
wire local_bb3_c0_eni3_stall_local;
wire [159:0] local_bb3_c0_eni3;

assign local_bb3_c0_eni3[95:0] = local_bb3_c0_eni2[95:0];
assign local_bb3_c0_eni3[127:96] = rcnode_164to165_rc0_sum_15_0_NO_SHIFT_REG[31:0];
assign local_bb3_c0_eni3[159:128] = local_bb3_c0_eni2[159:128];

// This section implements an unregistered operation.
// 
wire local_bb3_c0_eni4_valid_out;
wire local_bb3_c0_eni4_stall_in;
wire local_bb3_c0_eni4_inputs_ready;
wire local_bb3_c0_eni4_stall_local;
wire [159:0] local_bb3_c0_eni4;

assign local_bb3_c0_eni4_inputs_ready = (rnode_164to165_ld__0_valid_out_0_NO_SHIFT_REG & rcnode_164to165_rc0_sum_15_0_valid_out_0_NO_SHIFT_REG & rcnode_164to165_rc0_sum_15_0_valid_out_1_NO_SHIFT_REG & rstag_165to165_bb3_ld__valid_out);
assign local_bb3_c0_eni4[127:0] = local_bb3_c0_eni3[127:0];
assign local_bb3_c0_eni4[159:128] = rcnode_164to165_rc0_sum_15_0_NO_SHIFT_REG[63:32];
assign local_bb3_c0_eni4_valid_out = local_bb3_c0_eni4_inputs_ready;
assign local_bb3_c0_eni4_stall_local = local_bb3_c0_eni4_stall_in;
assign rnode_164to165_ld__0_stall_in_0_NO_SHIFT_REG = (local_bb3_c0_eni4_stall_local | ~(local_bb3_c0_eni4_inputs_ready));
assign rcnode_164to165_rc0_sum_15_0_stall_in_0_NO_SHIFT_REG = (local_bb3_c0_eni4_stall_local | ~(local_bb3_c0_eni4_inputs_ready));
assign rcnode_164to165_rc0_sum_15_0_stall_in_1_NO_SHIFT_REG = (local_bb3_c0_eni4_stall_local | ~(local_bb3_c0_eni4_inputs_ready));
assign rstag_165to165_bb3_ld__stall_in = (local_bb3_c0_eni4_stall_local | ~(local_bb3_c0_eni4_inputs_ready));

// This section implements a registered operation.
// 
wire local_bb3_c0_enter_c0_eni4_inputs_ready;
 reg local_bb3_c0_enter_c0_eni4_valid_out_0_NO_SHIFT_REG;
wire local_bb3_c0_enter_c0_eni4_stall_in_0;
 reg local_bb3_c0_enter_c0_eni4_valid_out_1_NO_SHIFT_REG;
wire local_bb3_c0_enter_c0_eni4_stall_in_1;
 reg local_bb3_c0_enter_c0_eni4_valid_out_2_NO_SHIFT_REG;
wire local_bb3_c0_enter_c0_eni4_stall_in_2;
 reg local_bb3_c0_enter_c0_eni4_valid_out_3_NO_SHIFT_REG;
wire local_bb3_c0_enter_c0_eni4_stall_in_3;
 reg local_bb3_c0_enter_c0_eni4_valid_out_4_NO_SHIFT_REG;
wire local_bb3_c0_enter_c0_eni4_stall_in_4;
wire local_bb3_c0_enter_c0_eni4_output_regs_ready;
 reg [159:0] local_bb3_c0_enter_c0_eni4_NO_SHIFT_REG;
wire local_bb3_c0_enter_c0_eni4_input_accepted;
 reg local_bb3_c0_enter_c0_eni4_valid_bit_NO_SHIFT_REG;
wire local_bb3_c0_exit_c0_exi2_entry_stall;
wire local_bb3_c0_exit_c0_exi2_output_regs_ready;
wire [11:0] local_bb3_c0_exit_c0_exi2_valid_bits;
wire local_bb3_c0_exit_c0_exi2_valid_in;
wire local_bb3_c0_exit_c0_exi2_phases;
wire local_bb3_c0_enter_c0_eni4_inc_pipelined_thread;
wire local_bb3_c0_enter_c0_eni4_dec_pipelined_thread;
wire local_bb3_c0_enter_c0_eni4_causedstall;

assign local_bb3_c0_enter_c0_eni4_inputs_ready = local_bb3_c0_eni4_valid_out;
assign local_bb3_c0_enter_c0_eni4_output_regs_ready = 1'b1;
assign local_bb3_c0_enter_c0_eni4_input_accepted = (local_bb3_c0_enter_c0_eni4_inputs_ready && !(local_bb3_c0_exit_c0_exi2_entry_stall));
assign local_bb3_c0_enter_c0_eni4_inc_pipelined_thread = 1'b1;
assign local_bb3_c0_enter_c0_eni4_dec_pipelined_thread = ~(1'b0);
assign local_bb3_c0_eni4_stall_in = ((~(local_bb3_c0_enter_c0_eni4_inputs_ready) | local_bb3_c0_exit_c0_exi2_entry_stall) | ~(1'b1));
assign local_bb3_c0_enter_c0_eni4_causedstall = (1'b1 && ((~(local_bb3_c0_enter_c0_eni4_inputs_ready) | local_bb3_c0_exit_c0_exi2_entry_stall) && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_c0_enter_c0_eni4_valid_bit_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb3_c0_enter_c0_eni4_valid_bit_NO_SHIFT_REG <= local_bb3_c0_enter_c0_eni4_input_accepted;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_c0_enter_c0_eni4_NO_SHIFT_REG <= 'x;
		local_bb3_c0_enter_c0_eni4_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb3_c0_enter_c0_eni4_valid_out_1_NO_SHIFT_REG <= 1'b0;
		local_bb3_c0_enter_c0_eni4_valid_out_2_NO_SHIFT_REG <= 1'b0;
		local_bb3_c0_enter_c0_eni4_valid_out_3_NO_SHIFT_REG <= 1'b0;
		local_bb3_c0_enter_c0_eni4_valid_out_4_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_c0_enter_c0_eni4_output_regs_ready)
		begin
			local_bb3_c0_enter_c0_eni4_NO_SHIFT_REG <= local_bb3_c0_eni4;
			local_bb3_c0_enter_c0_eni4_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb3_c0_enter_c0_eni4_valid_out_1_NO_SHIFT_REG <= 1'b1;
			local_bb3_c0_enter_c0_eni4_valid_out_2_NO_SHIFT_REG <= 1'b1;
			local_bb3_c0_enter_c0_eni4_valid_out_3_NO_SHIFT_REG <= 1'b1;
			local_bb3_c0_enter_c0_eni4_valid_out_4_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb3_c0_enter_c0_eni4_stall_in_0))
			begin
				local_bb3_c0_enter_c0_eni4_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb3_c0_enter_c0_eni4_stall_in_1))
			begin
				local_bb3_c0_enter_c0_eni4_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb3_c0_enter_c0_eni4_stall_in_2))
			begin
				local_bb3_c0_enter_c0_eni4_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb3_c0_enter_c0_eni4_stall_in_3))
			begin
				local_bb3_c0_enter_c0_eni4_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb3_c0_enter_c0_eni4_stall_in_4))
			begin
				local_bb3_c0_enter_c0_eni4_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb3_c0_ene1_stall_local;
wire [31:0] local_bb3_c0_ene1;

assign local_bb3_c0_ene1 = local_bb3_c0_enter_c0_eni4_NO_SHIFT_REG[63:32];

// This section implements an unregistered operation.
// 
wire local_bb3_c0_ene2_stall_local;
wire [31:0] local_bb3_c0_ene2;

assign local_bb3_c0_ene2 = local_bb3_c0_enter_c0_eni4_NO_SHIFT_REG[95:64];

// This section implements an unregistered operation.
// 
wire local_bb3_c0_ene3_valid_out;
wire local_bb3_c0_ene3_stall_in;
wire local_bb3_c0_ene3_inputs_ready;
wire local_bb3_c0_ene3_stall_local;
wire [31:0] local_bb3_c0_ene3;

assign local_bb3_c0_ene3_inputs_ready = local_bb3_c0_enter_c0_eni4_valid_out_2_NO_SHIFT_REG;
assign local_bb3_c0_ene3 = local_bb3_c0_enter_c0_eni4_NO_SHIFT_REG[127:96];
assign local_bb3_c0_ene3_valid_out = 1'b1;
assign local_bb3_c0_enter_c0_eni4_stall_in_2 = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_c0_ene4_stall_local;
wire [31:0] local_bb3_c0_ene4;

assign local_bb3_c0_ene4 = local_bb3_c0_enter_c0_eni4_NO_SHIFT_REG[159:128];

// This section implements an unregistered operation.
// 
wire SFC_1_VALID_166_166_0_valid_out;
wire SFC_1_VALID_166_166_0_stall_in;
wire SFC_1_VALID_166_166_0_inputs_ready;
wire SFC_1_VALID_166_166_0_stall_local;
wire SFC_1_VALID_166_166_0;

assign SFC_1_VALID_166_166_0_inputs_ready = local_bb3_c0_enter_c0_eni4_valid_out_4_NO_SHIFT_REG;
assign SFC_1_VALID_166_166_0 = local_bb3_c0_enter_c0_eni4_valid_bit_NO_SHIFT_REG;
assign SFC_1_VALID_166_166_0_valid_out = 1'b1;
assign local_bb3_c0_enter_c0_eni4_stall_in_4 = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_var__u1_stall_local;
wire [31:0] local_bb3_var__u1;

assign local_bb3_var__u1 = local_bb3_c0_ene1;

// This section implements an unregistered operation.
// 
wire local_bb3_var__u2_stall_local;
wire [31:0] local_bb3_var__u2;

assign local_bb3_var__u2 = local_bb3_c0_ene1;

// This section implements an unregistered operation.
// 
wire local_bb3_var__u3_stall_local;
wire [31:0] local_bb3_var__u3;

assign local_bb3_var__u3 = local_bb3_c0_ene2;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_166to168_bb3_c0_ene3_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to168_bb3_c0_ene3_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_166to168_bb3_c0_ene3_0_NO_SHIFT_REG;
 logic rnode_166to168_bb3_c0_ene3_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to168_bb3_c0_ene3_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_166to168_bb3_c0_ene3_1_NO_SHIFT_REG;
 logic rnode_166to168_bb3_c0_ene3_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_166to168_bb3_c0_ene3_0_reg_168_NO_SHIFT_REG;
 logic rnode_166to168_bb3_c0_ene3_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_166to168_bb3_c0_ene3_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_166to168_bb3_c0_ene3_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_166to168_bb3_c0_ene3_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to168_bb3_c0_ene3_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to168_bb3_c0_ene3_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_166to168_bb3_c0_ene3_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_166to168_bb3_c0_ene3_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb3_c0_ene3),
	.data_out(rnode_166to168_bb3_c0_ene3_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_166to168_bb3_c0_ene3_0_reg_168_fifo.DEPTH = 2;
defparam rnode_166to168_bb3_c0_ene3_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_166to168_bb3_c0_ene3_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to168_bb3_c0_ene3_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_166to168_bb3_c0_ene3_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_c0_ene3_stall_in = 1'b0;
assign rnode_166to168_bb3_c0_ene3_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_166to168_bb3_c0_ene3_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to168_bb3_c0_ene3_0_NO_SHIFT_REG = rnode_166to168_bb3_c0_ene3_0_reg_168_NO_SHIFT_REG;
assign rnode_166to168_bb3_c0_ene3_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to168_bb3_c0_ene3_1_NO_SHIFT_REG = rnode_166to168_bb3_c0_ene3_0_reg_168_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_var__u4_stall_local;
wire [31:0] local_bb3_var__u4;

assign local_bb3_var__u4 = local_bb3_c0_ene4;

// This section implements a registered operation.
// 
wire SFC_1_VALID_166_167_0_inputs_ready;
 reg SFC_1_VALID_166_167_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_166_167_0_stall_in;
wire SFC_1_VALID_166_167_0_output_regs_ready;
 reg SFC_1_VALID_166_167_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_166_167_0_causedstall;

assign SFC_1_VALID_166_167_0_inputs_ready = 1'b1;
assign SFC_1_VALID_166_167_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_166_166_0_stall_in = 1'b0;
assign SFC_1_VALID_166_167_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_166_167_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_166_167_0_output_regs_ready)
		begin
			SFC_1_VALID_166_167_0_NO_SHIFT_REG <= SFC_1_VALID_166_166_0;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb3_and2_i_stall_local;
wire [31:0] local_bb3_and2_i;

assign local_bb3_and2_i = (local_bb3_var__u1 >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb3_and12_i_stall_local;
wire [31:0] local_bb3_and12_i;

assign local_bb3_and12_i = (local_bb3_var__u1 & 32'hFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and_i2_stall_local;
wire [31:0] local_bb3_and_i2;

assign local_bb3_and_i2 = (local_bb3_var__u2 >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb3_and10_i8_stall_local;
wire [31:0] local_bb3_and10_i8;

assign local_bb3_and10_i8 = (local_bb3_var__u2 & 32'hFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_xor_i_stall_local;
wire [31:0] local_bb3_xor_i;

assign local_bb3_xor_i = (local_bb3_var__u3 ^ 32'h80000000);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u5_stall_local;
wire [31:0] local_bb3_var__u5;

assign local_bb3_var__u5 = rnode_166to168_bb3_c0_ene3_0_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_c0_ene3_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb3_c0_ene3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_c0_ene3_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_c0_ene3_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_c0_ene3_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_c0_ene3_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_c0_ene3_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_c0_ene3_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_c0_ene3_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_c0_ene3_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_c0_ene3_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_c0_ene3_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_c0_ene3_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(rnode_166to168_bb3_c0_ene3_1_NO_SHIFT_REG),
	.data_out(rnode_168to169_bb3_c0_ene3_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_c0_ene3_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_c0_ene3_0_reg_169_fifo.DATA_WIDTH = 32;
defparam rnode_168to169_bb3_c0_ene3_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_c0_ene3_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_c0_ene3_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to168_bb3_c0_ene3_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_c0_ene3_0_NO_SHIFT_REG = rnode_168to169_bb3_c0_ene3_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_c0_ene3_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_c0_ene3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_and2_i4_stall_local;
wire [31:0] local_bb3_and2_i4;

assign local_bb3_and2_i4 = (local_bb3_var__u4 >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb3_and12_i9_stall_local;
wire [31:0] local_bb3_and12_i9;

assign local_bb3_and12_i9 = (local_bb3_var__u4 & 32'hFFFF);

// This section implements a registered operation.
// 
wire SFC_1_VALID_167_168_0_inputs_ready;
 reg SFC_1_VALID_167_168_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_167_168_0_stall_in;
wire SFC_1_VALID_167_168_0_output_regs_ready;
 reg SFC_1_VALID_167_168_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_167_168_0_causedstall;

assign SFC_1_VALID_167_168_0_inputs_ready = 1'b1;
assign SFC_1_VALID_167_168_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_166_167_0_stall_in = 1'b0;
assign SFC_1_VALID_167_168_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_167_168_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_167_168_0_output_regs_ready)
		begin
			SFC_1_VALID_167_168_0_NO_SHIFT_REG <= SFC_1_VALID_166_167_0_NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb3_shr3_i_stall_local;
wire [31:0] local_bb3_shr3_i;

assign local_bb3_shr3_i = ((local_bb3_and2_i & 32'hFFFF) & 32'h7FFF);

// This section implements an unregistered operation.
// 
wire local_bb3_shr_i3_stall_local;
wire [31:0] local_bb3_shr_i3;

assign local_bb3_shr_i3 = ((local_bb3_and_i2 & 32'hFFFF) & 32'h7FFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and_i_stall_local;
wire [31:0] local_bb3_and_i;

assign local_bb3_and_i = (local_bb3_xor_i >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb3_and10_i_stall_local;
wire [31:0] local_bb3_and10_i;

assign local_bb3_and10_i = (local_bb3_xor_i & 32'hFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_shr3_i99_stall_local;
wire [31:0] local_bb3_shr3_i99;

assign local_bb3_shr3_i99 = (local_bb3_var__u5 & 32'h7F800000);

// Register node:
//  * latency = 6
//  * capacity = 6
 logic rnode_169to175_bb3_c0_ene3_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to175_bb3_c0_ene3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to175_bb3_c0_ene3_0_NO_SHIFT_REG;
 logic rnode_169to175_bb3_c0_ene3_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to175_bb3_c0_ene3_0_reg_175_NO_SHIFT_REG;
 logic rnode_169to175_bb3_c0_ene3_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_169to175_bb3_c0_ene3_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_169to175_bb3_c0_ene3_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_169to175_bb3_c0_ene3_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to175_bb3_c0_ene3_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to175_bb3_c0_ene3_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_169to175_bb3_c0_ene3_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_169to175_bb3_c0_ene3_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(rnode_168to169_bb3_c0_ene3_0_NO_SHIFT_REG),
	.data_out(rnode_169to175_bb3_c0_ene3_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_169to175_bb3_c0_ene3_0_reg_175_fifo.DEPTH = 6;
defparam rnode_169to175_bb3_c0_ene3_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_169to175_bb3_c0_ene3_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to175_bb3_c0_ene3_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_169to175_bb3_c0_ene3_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_c0_ene3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to175_bb3_c0_ene3_0_NO_SHIFT_REG = rnode_169to175_bb3_c0_ene3_0_reg_175_NO_SHIFT_REG;
assign rnode_169to175_bb3_c0_ene3_0_stall_in_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_169to175_bb3_c0_ene3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_shr3_i5_stall_local;
wire [31:0] local_bb3_shr3_i5;

assign local_bb3_shr3_i5 = ((local_bb3_and2_i4 & 32'hFFFF) & 32'h7FFF);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp13_i10_stall_local;
wire local_bb3_cmp13_i10;

assign local_bb3_cmp13_i10 = ((local_bb3_and10_i8 & 32'hFFFF) > (local_bb3_and12_i9 & 32'hFFFF));

// This section implements a registered operation.
// 
wire SFC_1_VALID_168_169_0_inputs_ready;
 reg SFC_1_VALID_168_169_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_168_169_0_stall_in;
wire SFC_1_VALID_168_169_0_output_regs_ready;
 reg SFC_1_VALID_168_169_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_168_169_0_causedstall;

assign SFC_1_VALID_168_169_0_inputs_ready = 1'b1;
assign SFC_1_VALID_168_169_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_167_168_0_stall_in = 1'b0;
assign SFC_1_VALID_168_169_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_168_169_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_168_169_0_output_regs_ready)
		begin
			SFC_1_VALID_168_169_0_NO_SHIFT_REG <= SFC_1_VALID_167_168_0_NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb3_shr_i_stall_local;
wire [31:0] local_bb3_shr_i;

assign local_bb3_shr_i = ((local_bb3_and_i & 32'hFFFF) & 32'h7FFF);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp13_i_stall_local;
wire local_bb3_cmp13_i;

assign local_bb3_cmp13_i = ((local_bb3_and10_i & 32'hFFFF) > (local_bb3_and12_i & 32'hFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3_var__u5_valid_out_1;
wire local_bb3_var__u5_stall_in_1;
wire local_bb3_cmp_i100_valid_out;
wire local_bb3_cmp_i100_stall_in;
wire local_bb3_cmp_i100_inputs_ready;
wire local_bb3_cmp_i100_stall_local;
wire local_bb3_cmp_i100;

assign local_bb3_cmp_i100_inputs_ready = rnode_166to168_bb3_c0_ene3_0_valid_out_0_NO_SHIFT_REG;
assign local_bb3_cmp_i100 = ((local_bb3_shr3_i99 & 32'h7F800000) < 32'h3F800000);
assign local_bb3_var__u5_valid_out_1 = 1'b1;
assign local_bb3_cmp_i100_valid_out = 1'b1;
assign rnode_166to168_bb3_c0_ene3_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb3_c0_ene3_0_valid_out_NO_SHIFT_REG;
 logic rnode_175to176_bb3_c0_ene3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb3_c0_ene3_0_NO_SHIFT_REG;
 logic rnode_175to176_bb3_c0_ene3_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb3_c0_ene3_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb3_c0_ene3_0_valid_out_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb3_c0_ene3_0_stall_in_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb3_c0_ene3_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb3_c0_ene3_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb3_c0_ene3_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb3_c0_ene3_0_stall_in_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb3_c0_ene3_0_valid_out_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb3_c0_ene3_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(rnode_169to175_bb3_c0_ene3_0_NO_SHIFT_REG),
	.data_out(rnode_175to176_bb3_c0_ene3_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb3_c0_ene3_0_reg_176_fifo.DEPTH = 1;
defparam rnode_175to176_bb3_c0_ene3_0_reg_176_fifo.DATA_WIDTH = 32;
defparam rnode_175to176_bb3_c0_ene3_0_reg_176_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to176_bb3_c0_ene3_0_reg_176_fifo.IMPL = "shift_reg";

assign rnode_175to176_bb3_c0_ene3_0_reg_176_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to175_bb3_c0_ene3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb3_c0_ene3_0_NO_SHIFT_REG = rnode_175to176_bb3_c0_ene3_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb3_c0_ene3_0_stall_in_reg_176_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb3_c0_ene3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_cmp_i6_stall_local;
wire local_bb3_cmp_i6;

assign local_bb3_cmp_i6 = ((local_bb3_shr_i3 & 32'h7FFF) > (local_bb3_shr3_i5 & 32'h7FFF));

// This section implements an unregistered operation.
// 
wire local_bb3_cmp8_i7_stall_local;
wire local_bb3_cmp8_i7;

assign local_bb3_cmp8_i7 = ((local_bb3_shr_i3 & 32'h7FFF) == (local_bb3_shr3_i5 & 32'h7FFF));

// This section implements a registered operation.
// 
wire SFC_1_VALID_169_170_0_inputs_ready;
 reg SFC_1_VALID_169_170_0_valid_out_NO_SHIFT_REG;
wire SFC_1_VALID_169_170_0_stall_in;
wire SFC_1_VALID_169_170_0_output_regs_ready;
 reg SFC_1_VALID_169_170_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_1_VALID_169_170_0_causedstall;

assign SFC_1_VALID_169_170_0_inputs_ready = 1'b1;
assign SFC_1_VALID_169_170_0_output_regs_ready = 1'b1;
assign SFC_1_VALID_168_169_0_stall_in = 1'b0;
assign SFC_1_VALID_169_170_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_1_VALID_169_170_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_1_VALID_169_170_0_output_regs_ready)
		begin
			SFC_1_VALID_169_170_0_NO_SHIFT_REG <= SFC_1_VALID_168_169_0_NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb3_cmp_i_stall_local;
wire local_bb3_cmp_i;

assign local_bb3_cmp_i = ((local_bb3_shr_i & 32'h7FFF) > (local_bb3_shr3_i & 32'h7FFF));

// This section implements an unregistered operation.
// 
wire local_bb3_cmp8_i_stall_local;
wire local_bb3_cmp8_i;

assign local_bb3_cmp8_i = ((local_bb3_shr_i & 32'h7FFF) == (local_bb3_shr3_i & 32'h7FFF));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_var__u5_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_var__u5_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_var__u5_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_var__u5_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_var__u5_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_var__u5_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_var__u5_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_var__u5_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_var__u5_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_var__u5_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_var__u5_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_var__u5_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_var__u5_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_var__u5_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_var__u5_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_var__u5_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb3_var__u5),
	.data_out(rnode_168to169_bb3_var__u5_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_var__u5_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_var__u5_0_reg_169_fifo.DATA_WIDTH = 32;
defparam rnode_168to169_bb3_var__u5_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_var__u5_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_var__u5_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_var__u5_stall_in_1 = 1'b0;
assign rnode_168to169_bb3_var__u5_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_var__u5_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_var__u5_0_NO_SHIFT_REG = rnode_168to169_bb3_var__u5_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_var__u5_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_var__u5_1_NO_SHIFT_REG = rnode_168to169_bb3_var__u5_0_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_cmp_i100_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp_i100_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp_i100_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp_i100_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp_i100_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp_i100_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp_i100_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp_i100_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp_i100_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp_i100_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp_i100_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_cmp_i100_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_cmp_i100_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_cmp_i100_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_cmp_i100_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_cmp_i100_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb3_cmp_i100),
	.data_out(rnode_168to169_bb3_cmp_i100_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_cmp_i100_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_cmp_i100_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb3_cmp_i100_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_cmp_i100_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_cmp_i100_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_cmp_i100_stall_in = 1'b0;
assign rnode_168to169_bb3_cmp_i100_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_cmp_i100_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_cmp_i100_0_NO_SHIFT_REG = rnode_168to169_bb3_cmp_i100_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_cmp_i100_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_cmp_i100_1_NO_SHIFT_REG = rnode_168to169_bb3_cmp_i100_0_reg_169_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3___i11_stall_local;
wire local_bb3___i11;

assign local_bb3___i11 = (local_bb3_cmp8_i7 & local_bb3_cmp13_i10);

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
assign SFC_1_VALID_169_170_0_stall_in = 1'b0;
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
			SFC_1_VALID_170_171_0_NO_SHIFT_REG <= SFC_1_VALID_169_170_0_NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb3___i_stall_local;
wire local_bb3___i;

assign local_bb3___i = (local_bb3_cmp8_i & local_bb3_cmp13_i);

// This section implements an unregistered operation.
// 
wire local_bb3__22_i106_stall_local;
wire [31:0] local_bb3__22_i106;

assign local_bb3__22_i106 = (rnode_168to169_bb3_cmp_i100_0_NO_SHIFT_REG ? rnode_168to169_bb3_var__u5_0_NO_SHIFT_REG : 32'h3F800000);

// This section implements an unregistered operation.
// 
wire local_bb3__23_i107_stall_local;
wire [31:0] local_bb3__23_i107;

assign local_bb3__23_i107 = (rnode_168to169_bb3_cmp_i100_1_NO_SHIFT_REG ? 32'h3F800000 : rnode_168to169_bb3_var__u5_1_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3__21_i12_stall_local;
wire local_bb3__21_i12;

assign local_bb3__21_i12 = (local_bb3_cmp_i6 | local_bb3___i11);

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


// This section implements an unregistered operation.
// 
wire local_bb3_var__u1_valid_out_2;
wire local_bb3_var__u1_stall_in_2;
wire local_bb3_var__u2_valid_out_2;
wire local_bb3_var__u2_stall_in_2;
wire local_bb3_c0_ene4_valid_out_1;
wire local_bb3_c0_ene4_stall_in_1;
wire local_bb3_var__u4_valid_out_2;
wire local_bb3_var__u4_stall_in_2;
wire local_bb3_xor_i_valid_out_2;
wire local_bb3_xor_i_stall_in_2;
wire local_bb3__21_i_valid_out;
wire local_bb3__21_i_stall_in;
wire local_bb3__21_i12_valid_out;
wire local_bb3__21_i12_stall_in;
wire local_bb3__21_i_inputs_ready;
wire local_bb3__21_i_stall_local;
wire local_bb3__21_i;

assign local_bb3__21_i_inputs_ready = (local_bb3_c0_enter_c0_eni4_valid_out_0_NO_SHIFT_REG & local_bb3_c0_enter_c0_eni4_valid_out_3_NO_SHIFT_REG & local_bb3_c0_enter_c0_eni4_valid_out_1_NO_SHIFT_REG);
assign local_bb3__21_i = (local_bb3_cmp_i | local_bb3___i);
assign local_bb3_var__u1_valid_out_2 = 1'b1;
assign local_bb3_var__u2_valid_out_2 = 1'b1;
assign local_bb3_c0_ene4_valid_out_1 = 1'b1;
assign local_bb3_var__u4_valid_out_2 = 1'b1;
assign local_bb3_xor_i_valid_out_2 = 1'b1;
assign local_bb3__21_i_valid_out = 1'b1;
assign local_bb3__21_i12_valid_out = 1'b1;
assign local_bb3_c0_enter_c0_eni4_stall_in_0 = 1'b0;
assign local_bb3_c0_enter_c0_eni4_stall_in_3 = 1'b0;
assign local_bb3_c0_enter_c0_eni4_stall_in_1 = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_shr18_i110_stall_local;
wire [31:0] local_bb3_shr18_i110;

assign local_bb3_shr18_i110 = (local_bb3__22_i106 >> 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb3_shr16_i108_stall_local;
wire [31:0] local_bb3_shr16_i108;

assign local_bb3_shr16_i108 = (local_bb3__23_i107 >> 32'h17);

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


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb3_var__u1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u1_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb3_var__u1_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u1_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb3_var__u1_1_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u1_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb3_var__u1_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u1_0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u1_0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u1_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb3_var__u1_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb3_var__u1_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb3_var__u1_0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb3_var__u1_0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb3_var__u1_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb3_var__u1),
	.data_out(rnode_166to167_bb3_var__u1_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb3_var__u1_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb3_var__u1_0_reg_167_fifo.DATA_WIDTH = 32;
defparam rnode_166to167_bb3_var__u1_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb3_var__u1_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb3_var__u1_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_var__u1_stall_in_2 = 1'b0;
assign rnode_166to167_bb3_var__u1_0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3_var__u1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb3_var__u1_0_NO_SHIFT_REG = rnode_166to167_bb3_var__u1_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb3_var__u1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb3_var__u1_1_NO_SHIFT_REG = rnode_166to167_bb3_var__u1_0_reg_167_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb3_var__u2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u2_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb3_var__u2_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u2_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb3_var__u2_1_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u2_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb3_var__u2_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u2_0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u2_0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u2_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb3_var__u2_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb3_var__u2_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb3_var__u2_0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb3_var__u2_0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb3_var__u2_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb3_var__u2),
	.data_out(rnode_166to167_bb3_var__u2_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb3_var__u2_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb3_var__u2_0_reg_167_fifo.DATA_WIDTH = 32;
defparam rnode_166to167_bb3_var__u2_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb3_var__u2_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb3_var__u2_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_var__u2_stall_in_2 = 1'b0;
assign rnode_166to167_bb3_var__u2_0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3_var__u2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb3_var__u2_0_NO_SHIFT_REG = rnode_166to167_bb3_var__u2_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb3_var__u2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb3_var__u2_1_NO_SHIFT_REG = rnode_166to167_bb3_var__u2_0_reg_167_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb3_c0_ene4_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb3_c0_ene4_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb3_c0_ene4_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3_c0_ene4_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb3_c0_ene4_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_c0_ene4_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_c0_ene4_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_c0_ene4_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb3_c0_ene4_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb3_c0_ene4_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb3_c0_ene4_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb3_c0_ene4_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb3_c0_ene4_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb3_c0_ene4),
	.data_out(rnode_166to167_bb3_c0_ene4_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb3_c0_ene4_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb3_c0_ene4_0_reg_167_fifo.DATA_WIDTH = 32;
defparam rnode_166to167_bb3_c0_ene4_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb3_c0_ene4_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb3_c0_ene4_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_c0_ene4_stall_in_1 = 1'b0;
assign rnode_166to167_bb3_c0_ene4_0_NO_SHIFT_REG = rnode_166to167_bb3_c0_ene4_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb3_c0_ene4_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3_c0_ene4_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb3_var__u4_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u4_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb3_var__u4_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u4_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u4_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb3_var__u4_1_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u4_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb3_var__u4_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u4_0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u4_0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_var__u4_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb3_var__u4_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb3_var__u4_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb3_var__u4_0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb3_var__u4_0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb3_var__u4_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb3_var__u4),
	.data_out(rnode_166to167_bb3_var__u4_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb3_var__u4_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb3_var__u4_0_reg_167_fifo.DATA_WIDTH = 32;
defparam rnode_166to167_bb3_var__u4_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb3_var__u4_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb3_var__u4_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_var__u4_stall_in_2 = 1'b0;
assign rnode_166to167_bb3_var__u4_0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3_var__u4_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb3_var__u4_0_NO_SHIFT_REG = rnode_166to167_bb3_var__u4_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb3_var__u4_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb3_var__u4_1_NO_SHIFT_REG = rnode_166to167_bb3_var__u4_0_reg_167_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb3_xor_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3_xor_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb3_xor_i_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3_xor_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb3_xor_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb3_xor_i_1_NO_SHIFT_REG;
 logic rnode_166to167_bb3_xor_i_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb3_xor_i_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_xor_i_0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_xor_i_0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3_xor_i_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb3_xor_i_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb3_xor_i_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb3_xor_i_0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb3_xor_i_0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb3_xor_i_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb3_xor_i),
	.data_out(rnode_166to167_bb3_xor_i_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb3_xor_i_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb3_xor_i_0_reg_167_fifo.DATA_WIDTH = 32;
defparam rnode_166to167_bb3_xor_i_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb3_xor_i_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb3_xor_i_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_xor_i_stall_in_2 = 1'b0;
assign rnode_166to167_bb3_xor_i_0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3_xor_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb3_xor_i_0_NO_SHIFT_REG = rnode_166to167_bb3_xor_i_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb3_xor_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb3_xor_i_1_NO_SHIFT_REG = rnode_166to167_bb3_xor_i_0_reg_167_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb3__21_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i_1_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i_0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i_0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb3__21_i_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb3__21_i_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb3__21_i_0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb3__21_i_0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb3__21_i_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb3__21_i),
	.data_out(rnode_166to167_bb3__21_i_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb3__21_i_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb3__21_i_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb3__21_i_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb3__21_i_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb3__21_i_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__21_i_stall_in = 1'b0;
assign rnode_166to167_bb3__21_i_0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3__21_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb3__21_i_0_NO_SHIFT_REG = rnode_166to167_bb3__21_i_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb3__21_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb3__21_i_1_NO_SHIFT_REG = rnode_166to167_bb3__21_i_0_reg_167_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb3__21_i12_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i12_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i12_0_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i12_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i12_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i12_1_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i12_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i12_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i12_0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i12_0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb3__21_i12_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb3__21_i12_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb3__21_i12_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb3__21_i12_0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb3__21_i12_0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb3__21_i12_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb3__21_i12),
	.data_out(rnode_166to167_bb3__21_i12_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb3__21_i12_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb3__21_i12_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb3__21_i12_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb3__21_i12_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb3__21_i12_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__21_i12_stall_in = 1'b0;
assign rnode_166to167_bb3__21_i12_0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3__21_i12_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb3__21_i12_0_NO_SHIFT_REG = rnode_166to167_bb3__21_i12_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb3__21_i12_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb3__21_i12_1_NO_SHIFT_REG = rnode_166to167_bb3__21_i12_0_reg_167_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_and19_i111_stall_local;
wire [31:0] local_bb3_and19_i111;

assign local_bb3_and19_i111 = ((local_bb3_shr18_i110 & 32'h1FF) & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb3_sub_i140_stall_local;
wire [31:0] local_bb3_sub_i140;

assign local_bb3_sub_i140 = ((local_bb3_shr16_i108 & 32'h1FF) - (local_bb3_shr18_i110 & 32'h1FF));

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


// Register node:
//  * latency = 8
//  * capacity = 8
 logic rnode_167to175_bb3_c0_ene4_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to175_bb3_c0_ene4_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_167to175_bb3_c0_ene4_0_NO_SHIFT_REG;
 logic rnode_167to175_bb3_c0_ene4_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to175_bb3_c0_ene4_0_reg_175_NO_SHIFT_REG;
 logic rnode_167to175_bb3_c0_ene4_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_167to175_bb3_c0_ene4_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_167to175_bb3_c0_ene4_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_167to175_bb3_c0_ene4_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to175_bb3_c0_ene4_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to175_bb3_c0_ene4_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_167to175_bb3_c0_ene4_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_167to175_bb3_c0_ene4_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb3_c0_ene4_0_NO_SHIFT_REG),
	.data_out(rnode_167to175_bb3_c0_ene4_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_167to175_bb3_c0_ene4_0_reg_175_fifo.DEPTH = 8;
defparam rnode_167to175_bb3_c0_ene4_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_167to175_bb3_c0_ene4_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to175_bb3_c0_ene4_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_167to175_bb3_c0_ene4_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb3_c0_ene4_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to175_bb3_c0_ene4_0_NO_SHIFT_REG = rnode_167to175_bb3_c0_ene4_0_reg_175_NO_SHIFT_REG;
assign rnode_167to175_bb3_c0_ene4_0_stall_in_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_167to175_bb3_c0_ene4_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3__22_i_stall_local;
wire [31:0] local_bb3__22_i;

assign local_bb3__22_i = (rnode_166to167_bb3__21_i_0_NO_SHIFT_REG ? rnode_166to167_bb3_var__u1_0_NO_SHIFT_REG : rnode_166to167_bb3_xor_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3__23_i_stall_local;
wire [31:0] local_bb3__23_i;

assign local_bb3__23_i = (rnode_166to167_bb3__21_i_1_NO_SHIFT_REG ? rnode_166to167_bb3_xor_i_1_NO_SHIFT_REG : rnode_166to167_bb3_var__u1_1_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3__22_i13_stall_local;
wire [31:0] local_bb3__22_i13;

assign local_bb3__22_i13 = (rnode_166to167_bb3__21_i12_0_NO_SHIFT_REG ? rnode_166to167_bb3_var__u4_0_NO_SHIFT_REG : rnode_166to167_bb3_var__u2_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3__23_i14_stall_local;
wire [31:0] local_bb3__23_i14;

assign local_bb3__23_i14 = (rnode_166to167_bb3__21_i12_1_NO_SHIFT_REG ? rnode_166to167_bb3_var__u2_1_NO_SHIFT_REG : rnode_166to167_bb3_var__u4_1_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot23_i115_stall_local;
wire local_bb3_lnot23_i115;

assign local_bb3_lnot23_i115 = ((local_bb3_and19_i111 & 32'hFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp27_i117_stall_local;
wire local_bb3_cmp27_i117;

assign local_bb3_cmp27_i117 = ((local_bb3_and19_i111 & 32'hFF) == 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and68_i141_stall_local;
wire [31:0] local_bb3_and68_i141;

assign local_bb3_and68_i141 = (local_bb3_sub_i140 & 32'hFF);

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


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb3_c0_ene4_0_valid_out_NO_SHIFT_REG;
 logic rnode_175to176_bb3_c0_ene4_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb3_c0_ene4_0_NO_SHIFT_REG;
 logic rnode_175to176_bb3_c0_ene4_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb3_c0_ene4_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb3_c0_ene4_0_valid_out_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb3_c0_ene4_0_stall_in_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb3_c0_ene4_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb3_c0_ene4_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb3_c0_ene4_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb3_c0_ene4_0_stall_in_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb3_c0_ene4_0_valid_out_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb3_c0_ene4_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(rnode_167to175_bb3_c0_ene4_0_NO_SHIFT_REG),
	.data_out(rnode_175to176_bb3_c0_ene4_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb3_c0_ene4_0_reg_176_fifo.DEPTH = 1;
defparam rnode_175to176_bb3_c0_ene4_0_reg_176_fifo.DATA_WIDTH = 32;
defparam rnode_175to176_bb3_c0_ene4_0_reg_176_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to176_bb3_c0_ene4_0_reg_176_fifo.IMPL = "shift_reg";

assign rnode_175to176_bb3_c0_ene4_0_reg_176_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to175_bb3_c0_ene4_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb3_c0_ene4_0_NO_SHIFT_REG = rnode_175to176_bb3_c0_ene4_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb3_c0_ene4_0_stall_in_reg_176_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb3_c0_ene4_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_shr18_i_stall_local;
wire [31:0] local_bb3_shr18_i;

assign local_bb3_shr18_i = (local_bb3__22_i >> 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb3_shr16_i_stall_local;
wire [31:0] local_bb3_shr16_i;

assign local_bb3_shr16_i = (local_bb3__23_i >> 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb3_shr18_i17_stall_local;
wire [31:0] local_bb3_shr18_i17;

assign local_bb3_shr18_i17 = (local_bb3__22_i13 >> 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb3_shr16_i15_stall_local;
wire [31:0] local_bb3_shr16_i15;

assign local_bb3_shr16_i15 = (local_bb3__23_i14 >> 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp69_i142_stall_local;
wire local_bb3_cmp69_i142;

assign local_bb3_cmp69_i142 = ((local_bb3_and68_i141 & 32'hFF) > 32'h1F);

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


// This section implements an unregistered operation.
// 
wire local_bb3_and19_i_stall_local;
wire [31:0] local_bb3_and19_i;

assign local_bb3_and19_i = ((local_bb3_shr18_i & 32'h1FF) & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb3_sub_i_stall_local;
wire [31:0] local_bb3_sub_i;

assign local_bb3_sub_i = ((local_bb3_shr16_i & 32'h1FF) - (local_bb3_shr18_i & 32'h1FF));

// This section implements an unregistered operation.
// 
wire local_bb3_and19_i18_stall_local;
wire [31:0] local_bb3_and19_i18;

assign local_bb3_and19_i18 = ((local_bb3_shr18_i17 & 32'h1FF) & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb3_sub_i44_stall_local;
wire [31:0] local_bb3_sub_i44;

assign local_bb3_sub_i44 = ((local_bb3_shr16_i15 & 32'h1FF) - (local_bb3_shr18_i17 & 32'h1FF));

// This section implements an unregistered operation.
// 
wire local_bb3__22_i106_valid_out_1;
wire local_bb3__22_i106_stall_in_1;
wire local_bb3__23_i107_valid_out_1;
wire local_bb3__23_i107_stall_in_1;
wire local_bb3_shr16_i108_valid_out_1;
wire local_bb3_shr16_i108_stall_in_1;
wire local_bb3_lnot23_i115_valid_out;
wire local_bb3_lnot23_i115_stall_in;
wire local_bb3_cmp27_i117_valid_out;
wire local_bb3_cmp27_i117_stall_in;
wire local_bb3_align_0_i143_valid_out;
wire local_bb3_align_0_i143_stall_in;
wire local_bb3_align_0_i143_inputs_ready;
wire local_bb3_align_0_i143_stall_local;
wire [31:0] local_bb3_align_0_i143;

assign local_bb3_align_0_i143_inputs_ready = (rnode_168to169_bb3_cmp_i100_0_valid_out_0_NO_SHIFT_REG & rnode_168to169_bb3_var__u5_0_valid_out_0_NO_SHIFT_REG & rnode_168to169_bb3_cmp_i100_0_valid_out_1_NO_SHIFT_REG & rnode_168to169_bb3_var__u5_0_valid_out_1_NO_SHIFT_REG);
assign local_bb3_align_0_i143 = (local_bb3_cmp69_i142 ? 32'h1F : (local_bb3_and68_i141 & 32'hFF));
assign local_bb3__22_i106_valid_out_1 = 1'b1;
assign local_bb3__23_i107_valid_out_1 = 1'b1;
assign local_bb3_shr16_i108_valid_out_1 = 1'b1;
assign local_bb3_lnot23_i115_valid_out = 1'b1;
assign local_bb3_cmp27_i117_valid_out = 1'b1;
assign local_bb3_align_0_i143_valid_out = 1'b1;
assign rnode_168to169_bb3_cmp_i100_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_var__u5_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_cmp_i100_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_var__u5_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_lnot23_i_stall_local;
wire local_bb3_lnot23_i;

assign local_bb3_lnot23_i = ((local_bb3_and19_i & 32'hFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp27_i_stall_local;
wire local_bb3_cmp27_i;

assign local_bb3_cmp27_i = ((local_bb3_and19_i & 32'hFF) == 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and69_i_stall_local;
wire [31:0] local_bb3_and69_i;

assign local_bb3_and69_i = (local_bb3_sub_i & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot23_i22_stall_local;
wire local_bb3_lnot23_i22;

assign local_bb3_lnot23_i22 = ((local_bb3_and19_i18 & 32'hFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp27_i24_stall_local;
wire local_bb3_cmp27_i24;

assign local_bb3_cmp27_i24 = ((local_bb3_and19_i18 & 32'hFF) == 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and68_i_stall_local;
wire [31:0] local_bb3_and68_i;

assign local_bb3_and68_i = (local_bb3_sub_i44 & 32'hFF);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb3__22_i106_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3__22_i106_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3__22_i106_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3__22_i106_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb3__22_i106_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3__22_i106_1_NO_SHIFT_REG;
 logic rnode_169to170_bb3__22_i106_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3__22_i106_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3__22_i106_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3__22_i106_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3__22_i106_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb3__22_i106_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb3__22_i106_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb3__22_i106_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb3__22_i106_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb3__22_i106_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb3__22_i106),
	.data_out(rnode_169to170_bb3__22_i106_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb3__22_i106_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb3__22_i106_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb3__22_i106_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb3__22_i106_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb3__22_i106_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__22_i106_stall_in_1 = 1'b0;
assign rnode_169to170_bb3__22_i106_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3__22_i106_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3__22_i106_0_NO_SHIFT_REG = rnode_169to170_bb3__22_i106_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3__22_i106_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3__22_i106_1_NO_SHIFT_REG = rnode_169to170_bb3__22_i106_0_reg_170_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb3__23_i107_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3__23_i107_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3__23_i107_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3__23_i107_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb3__23_i107_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3__23_i107_1_NO_SHIFT_REG;
 logic rnode_169to170_bb3__23_i107_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_169to170_bb3__23_i107_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3__23_i107_2_NO_SHIFT_REG;
 logic rnode_169to170_bb3__23_i107_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3__23_i107_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3__23_i107_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3__23_i107_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3__23_i107_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb3__23_i107_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb3__23_i107_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb3__23_i107_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb3__23_i107_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb3__23_i107_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb3__23_i107),
	.data_out(rnode_169to170_bb3__23_i107_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb3__23_i107_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb3__23_i107_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb3__23_i107_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb3__23_i107_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb3__23_i107_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__23_i107_stall_in_1 = 1'b0;
assign rnode_169to170_bb3__23_i107_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3__23_i107_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3__23_i107_0_NO_SHIFT_REG = rnode_169to170_bb3__23_i107_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3__23_i107_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3__23_i107_1_NO_SHIFT_REG = rnode_169to170_bb3__23_i107_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3__23_i107_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3__23_i107_2_NO_SHIFT_REG = rnode_169to170_bb3__23_i107_0_reg_170_NO_SHIFT_REG;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb3_shr16_i108_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i108_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_shr16_i108_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i108_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i108_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_shr16_i108_1_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i108_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_shr16_i108_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i108_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i108_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i108_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb3_shr16_i108_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb3_shr16_i108_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb3_shr16_i108_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb3_shr16_i108_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb3_shr16_i108_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((local_bb3_shr16_i108 & 32'h1FF)),
	.data_out(rnode_169to171_bb3_shr16_i108_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb3_shr16_i108_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb3_shr16_i108_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_169to171_bb3_shr16_i108_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb3_shr16_i108_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb3_shr16_i108_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_shr16_i108_stall_in_1 = 1'b0;
assign rnode_169to171_bb3_shr16_i108_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_shr16_i108_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to171_bb3_shr16_i108_0_NO_SHIFT_REG = rnode_169to171_bb3_shr16_i108_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb3_shr16_i108_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to171_bb3_shr16_i108_1_NO_SHIFT_REG = rnode_169to171_bb3_shr16_i108_0_reg_171_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb3_lnot23_i115_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb3_lnot23_i115_0_stall_in_NO_SHIFT_REG;
 logic rnode_169to170_bb3_lnot23_i115_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3_lnot23_i115_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb3_lnot23_i115_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_lnot23_i115_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_lnot23_i115_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_lnot23_i115_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb3_lnot23_i115_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb3_lnot23_i115_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb3_lnot23_i115_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb3_lnot23_i115_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb3_lnot23_i115_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb3_lnot23_i115),
	.data_out(rnode_169to170_bb3_lnot23_i115_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb3_lnot23_i115_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb3_lnot23_i115_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb3_lnot23_i115_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb3_lnot23_i115_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb3_lnot23_i115_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_lnot23_i115_stall_in = 1'b0;
assign rnode_169to170_bb3_lnot23_i115_0_NO_SHIFT_REG = rnode_169to170_bb3_lnot23_i115_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3_lnot23_i115_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3_lnot23_i115_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb3_cmp27_i117_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp27_i117_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp27_i117_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp27_i117_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp27_i117_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp27_i117_1_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp27_i117_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp27_i117_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp27_i117_2_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp27_i117_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp27_i117_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp27_i117_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp27_i117_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp27_i117_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb3_cmp27_i117_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb3_cmp27_i117_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb3_cmp27_i117_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb3_cmp27_i117_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb3_cmp27_i117_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb3_cmp27_i117),
	.data_out(rnode_169to171_bb3_cmp27_i117_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb3_cmp27_i117_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb3_cmp27_i117_0_reg_171_fifo.DATA_WIDTH = 1;
defparam rnode_169to171_bb3_cmp27_i117_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb3_cmp27_i117_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb3_cmp27_i117_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_cmp27_i117_stall_in = 1'b0;
assign rnode_169to171_bb3_cmp27_i117_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_cmp27_i117_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to171_bb3_cmp27_i117_0_NO_SHIFT_REG = rnode_169to171_bb3_cmp27_i117_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb3_cmp27_i117_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to171_bb3_cmp27_i117_1_NO_SHIFT_REG = rnode_169to171_bb3_cmp27_i117_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb3_cmp27_i117_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_169to171_bb3_cmp27_i117_2_NO_SHIFT_REG = rnode_169to171_bb3_cmp27_i117_0_reg_171_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb3_align_0_i143_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3_align_0_i143_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_align_0_i143_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3_align_0_i143_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb3_align_0_i143_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_align_0_i143_1_NO_SHIFT_REG;
 logic rnode_169to170_bb3_align_0_i143_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_169to170_bb3_align_0_i143_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_align_0_i143_2_NO_SHIFT_REG;
 logic rnode_169to170_bb3_align_0_i143_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_169to170_bb3_align_0_i143_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_align_0_i143_3_NO_SHIFT_REG;
 logic rnode_169to170_bb3_align_0_i143_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_169to170_bb3_align_0_i143_0_stall_in_4_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_align_0_i143_4_NO_SHIFT_REG;
 logic rnode_169to170_bb3_align_0_i143_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_align_0_i143_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_align_0_i143_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_align_0_i143_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_align_0_i143_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb3_align_0_i143_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb3_align_0_i143_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb3_align_0_i143_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb3_align_0_i143_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb3_align_0_i143_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in((local_bb3_align_0_i143 & 32'hFF)),
	.data_out(rnode_169to170_bb3_align_0_i143_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb3_align_0_i143_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb3_align_0_i143_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb3_align_0_i143_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb3_align_0_i143_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb3_align_0_i143_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_align_0_i143_stall_in = 1'b0;
assign rnode_169to170_bb3_align_0_i143_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3_align_0_i143_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_align_0_i143_0_NO_SHIFT_REG = rnode_169to170_bb3_align_0_i143_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3_align_0_i143_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_align_0_i143_1_NO_SHIFT_REG = rnode_169to170_bb3_align_0_i143_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3_align_0_i143_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_align_0_i143_2_NO_SHIFT_REG = rnode_169to170_bb3_align_0_i143_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3_align_0_i143_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_align_0_i143_3_NO_SHIFT_REG = rnode_169to170_bb3_align_0_i143_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3_align_0_i143_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_align_0_i143_4_NO_SHIFT_REG = rnode_169to170_bb3_align_0_i143_0_reg_170_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_cmp70_i_stall_local;
wire local_bb3_cmp70_i;

assign local_bb3_cmp70_i = ((local_bb3_and69_i & 32'hFF) > 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp69_i_stall_local;
wire local_bb3_cmp69_i;

assign local_bb3_cmp69_i = ((local_bb3_and68_i & 32'hFF) > 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb3_and21_i113_stall_local;
wire [31:0] local_bb3_and21_i113;

assign local_bb3_and21_i113 = (rnode_169to170_bb3__22_i106_0_NO_SHIFT_REG & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and20_i112_valid_out;
wire local_bb3_and20_i112_stall_in;
wire local_bb3_and20_i112_inputs_ready;
wire local_bb3_and20_i112_stall_local;
wire [31:0] local_bb3_and20_i112;

assign local_bb3_and20_i112_inputs_ready = rnode_169to170_bb3__23_i107_0_valid_out_0_NO_SHIFT_REG;
assign local_bb3_and20_i112 = (rnode_169to170_bb3__23_i107_0_NO_SHIFT_REG & 32'h7FFFFF);
assign local_bb3_and20_i112_valid_out = 1'b1;
assign rnode_169to170_bb3__23_i107_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and35_i118_valid_out;
wire local_bb3_and35_i118_stall_in;
wire local_bb3_and35_i118_inputs_ready;
wire local_bb3_and35_i118_stall_local;
wire [31:0] local_bb3_and35_i118;

assign local_bb3_and35_i118_inputs_ready = rnode_169to170_bb3__23_i107_0_valid_out_1_NO_SHIFT_REG;
assign local_bb3_and35_i118 = (rnode_169to170_bb3__23_i107_1_NO_SHIFT_REG & 32'h80000000);
assign local_bb3_and35_i118_valid_out = 1'b1;
assign rnode_169to170_bb3__23_i107_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_xor_i119_stall_local;
wire [31:0] local_bb3_xor_i119;

assign local_bb3_xor_i119 = (rnode_169to170_bb3__23_i107_2_NO_SHIFT_REG ^ rnode_169to170_bb3__22_i106_1_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_and17_i109_stall_local;
wire [31:0] local_bb3_and17_i109;

assign local_bb3_and17_i109 = ((rnode_169to171_bb3_shr16_i108_0_NO_SHIFT_REG & 32'h1FF) & 32'hFF);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_171to173_bb3_shr16_i108_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to173_bb3_shr16_i108_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to173_bb3_shr16_i108_0_NO_SHIFT_REG;
 logic rnode_171to173_bb3_shr16_i108_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to173_bb3_shr16_i108_0_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_shr16_i108_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_shr16_i108_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_shr16_i108_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_171to173_bb3_shr16_i108_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to173_bb3_shr16_i108_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to173_bb3_shr16_i108_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_171to173_bb3_shr16_i108_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_171to173_bb3_shr16_i108_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in((rnode_169to171_bb3_shr16_i108_1_NO_SHIFT_REG & 32'h1FF)),
	.data_out(rnode_171to173_bb3_shr16_i108_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_171to173_bb3_shr16_i108_0_reg_173_fifo.DEPTH = 2;
defparam rnode_171to173_bb3_shr16_i108_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_171to173_bb3_shr16_i108_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to173_bb3_shr16_i108_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_171to173_bb3_shr16_i108_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to171_bb3_shr16_i108_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_171to173_bb3_shr16_i108_0_NO_SHIFT_REG = rnode_171to173_bb3_shr16_i108_0_reg_173_NO_SHIFT_REG;
assign rnode_171to173_bb3_shr16_i108_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_171to173_bb3_shr16_i108_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_and93_i151_stall_local;
wire [31:0] local_bb3_and93_i151;

assign local_bb3_and93_i151 = ((rnode_169to170_bb3_align_0_i143_0_NO_SHIFT_REG & 32'hFF) & 32'h1C);

// This section implements an unregistered operation.
// 
wire local_bb3_and95_i153_stall_local;
wire [31:0] local_bb3_and95_i153;

assign local_bb3_and95_i153 = ((rnode_169to170_bb3_align_0_i143_1_NO_SHIFT_REG & 32'hFF) & 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb3_and115_i169_stall_local;
wire [31:0] local_bb3_and115_i169;

assign local_bb3_and115_i169 = ((rnode_169to170_bb3_align_0_i143_2_NO_SHIFT_REG & 32'hFF) & 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb3_and130_i175_stall_local;
wire [31:0] local_bb3_and130_i175;

assign local_bb3_and130_i175 = ((rnode_169to170_bb3_align_0_i143_3_NO_SHIFT_REG & 32'hFF) & 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb3_and149_i180_stall_local;
wire [31:0] local_bb3_and149_i180;

assign local_bb3_and149_i180 = ((rnode_169to170_bb3_align_0_i143_4_NO_SHIFT_REG & 32'hFF) & 32'h3);

// This section implements an unregistered operation.
// 
wire local_bb3_align_0_i_stall_local;
wire [31:0] local_bb3_align_0_i;

assign local_bb3_align_0_i = (local_bb3_cmp70_i ? 32'h1F : (local_bb3_and69_i & 32'hFF));

// This section implements an unregistered operation.
// 
wire local_bb3_align_0_i45_stall_local;
wire [31:0] local_bb3_align_0_i45;

assign local_bb3_align_0_i45 = (local_bb3_cmp69_i ? 32'h1F : (local_bb3_and68_i & 32'hFF));

// This section implements an unregistered operation.
// 
wire local_bb3_lnot33_not_i124_stall_local;
wire local_bb3_lnot33_not_i124;

assign local_bb3_lnot33_not_i124 = ((local_bb3_and21_i113 & 32'h7FFFFF) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_or64_i137_stall_local;
wire [31:0] local_bb3_or64_i137;

assign local_bb3_or64_i137 = ((local_bb3_and21_i113 & 32'h7FFFFF) << 32'h3);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3_and20_i112_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and20_i112_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and20_i112_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and20_i112_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and20_i112_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and20_i112_1_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and20_i112_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and20_i112_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and20_i112_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and20_i112_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and20_i112_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3_and20_i112_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3_and20_i112_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3_and20_i112_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3_and20_i112_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3_and20_i112_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((local_bb3_and20_i112 & 32'h7FFFFF)),
	.data_out(rnode_170to171_bb3_and20_i112_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3_and20_i112_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3_and20_i112_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_170to171_bb3_and20_i112_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3_and20_i112_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3_and20_i112_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and20_i112_stall_in = 1'b0;
assign rnode_170to171_bb3_and20_i112_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and20_i112_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3_and20_i112_0_NO_SHIFT_REG = rnode_170to171_bb3_and20_i112_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_and20_i112_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3_and20_i112_1_NO_SHIFT_REG = rnode_170to171_bb3_and20_i112_0_reg_171_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3_and35_i118_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and35_i118_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and35_i118_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and35_i118_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and35_i118_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and35_i118_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and35_i118_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and35_i118_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3_and35_i118_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3_and35_i118_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3_and35_i118_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3_and35_i118_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3_and35_i118_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((local_bb3_and35_i118 & 32'h80000000)),
	.data_out(rnode_170to171_bb3_and35_i118_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3_and35_i118_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3_and35_i118_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_170to171_bb3_and35_i118_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3_and35_i118_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3_and35_i118_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and35_i118_stall_in = 1'b0;
assign rnode_170to171_bb3_and35_i118_0_NO_SHIFT_REG = rnode_170to171_bb3_and35_i118_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_and35_i118_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and35_i118_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_cmp37_i120_stall_local;
wire local_bb3_cmp37_i120;

assign local_bb3_cmp37_i120 = ($signed(local_bb3_xor_i119) < $signed(32'h0));

// This section implements an unregistered operation.
// 
wire local_bb3_xor_lobit_i193_stall_local;
wire [31:0] local_bb3_xor_lobit_i193;

assign local_bb3_xor_lobit_i193 = ($signed(local_bb3_xor_i119) >>> 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb3_and36_lobit_i195_stall_local;
wire [31:0] local_bb3_and36_lobit_i195;

assign local_bb3_and36_lobit_i195 = (local_bb3_xor_i119 >> 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot_i114_stall_local;
wire local_bb3_lnot_i114;

assign local_bb3_lnot_i114 = ((local_bb3_and17_i109 & 32'hFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp25_i116_stall_local;
wire local_bb3_cmp25_i116;

assign local_bb3_cmp25_i116 = ((local_bb3_and17_i109 & 32'hFF) == 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp96_i154_stall_local;
wire local_bb3_cmp96_i154;

assign local_bb3_cmp96_i154 = ((local_bb3_and95_i153 & 32'h10) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp116_i170_stall_local;
wire local_bb3_cmp116_i170;

assign local_bb3_cmp116_i170 = ((local_bb3_and115_i169 & 32'h8) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp131_not_i177_stall_local;
wire local_bb3_cmp131_not_i177;

assign local_bb3_cmp131_not_i177 = ((local_bb3_and130_i175 & 32'h4) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_Pivot20_i182_stall_local;
wire local_bb3_Pivot20_i182;

assign local_bb3_Pivot20_i182 = ((local_bb3_and149_i180 & 32'h3) < 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb3_SwitchLeaf_i183_stall_local;
wire local_bb3_SwitchLeaf_i183;

assign local_bb3_SwitchLeaf_i183 = ((local_bb3_and149_i180 & 32'h3) == 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_and94_i_stall_local;
wire [31:0] local_bb3_and94_i;

assign local_bb3_and94_i = ((local_bb3_align_0_i & 32'hFF) & 32'h1C);

// This section implements an unregistered operation.
// 
wire local_bb3_and96_i_stall_local;
wire [31:0] local_bb3_and96_i;

assign local_bb3_and96_i = ((local_bb3_align_0_i & 32'hFF) & 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb3_and116_i_stall_local;
wire [31:0] local_bb3_and116_i;

assign local_bb3_and116_i = ((local_bb3_align_0_i & 32'hFF) & 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb3_and131_i_stall_local;
wire [31:0] local_bb3_and131_i;

assign local_bb3_and131_i = ((local_bb3_align_0_i & 32'hFF) & 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb3__22_i_valid_out_1;
wire local_bb3__22_i_stall_in_1;
wire local_bb3__23_i_valid_out_1;
wire local_bb3__23_i_stall_in_1;
wire local_bb3_shr16_i_valid_out_1;
wire local_bb3_shr16_i_stall_in_1;
wire local_bb3_lnot23_i_valid_out;
wire local_bb3_lnot23_i_stall_in;
wire local_bb3_cmp27_i_valid_out;
wire local_bb3_cmp27_i_stall_in;
wire local_bb3_and94_i_valid_out;
wire local_bb3_and94_i_stall_in;
wire local_bb3_and96_i_valid_out;
wire local_bb3_and96_i_stall_in;
wire local_bb3_and116_i_valid_out;
wire local_bb3_and116_i_stall_in;
wire local_bb3_and131_i_valid_out;
wire local_bb3_and131_i_stall_in;
wire local_bb3_and150_i_valid_out;
wire local_bb3_and150_i_stall_in;
wire local_bb3_and150_i_inputs_ready;
wire local_bb3_and150_i_stall_local;
wire [31:0] local_bb3_and150_i;

assign local_bb3_and150_i_inputs_ready = (rnode_166to167_bb3__21_i_0_valid_out_0_NO_SHIFT_REG & rnode_166to167_bb3_var__u1_0_valid_out_0_NO_SHIFT_REG & rnode_166to167_bb3_xor_i_0_valid_out_0_NO_SHIFT_REG & rnode_166to167_bb3__21_i_0_valid_out_1_NO_SHIFT_REG & rnode_166to167_bb3_xor_i_0_valid_out_1_NO_SHIFT_REG & rnode_166to167_bb3_var__u1_0_valid_out_1_NO_SHIFT_REG);
assign local_bb3_and150_i = ((local_bb3_align_0_i & 32'hFF) & 32'h3);
assign local_bb3__22_i_valid_out_1 = 1'b1;
assign local_bb3__23_i_valid_out_1 = 1'b1;
assign local_bb3_shr16_i_valid_out_1 = 1'b1;
assign local_bb3_lnot23_i_valid_out = 1'b1;
assign local_bb3_cmp27_i_valid_out = 1'b1;
assign local_bb3_and94_i_valid_out = 1'b1;
assign local_bb3_and96_i_valid_out = 1'b1;
assign local_bb3_and116_i_valid_out = 1'b1;
assign local_bb3_and131_i_valid_out = 1'b1;
assign local_bb3_and150_i_valid_out = 1'b1;
assign rnode_166to167_bb3__21_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3_var__u1_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3_xor_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3__21_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3_xor_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3_var__u1_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and93_i_stall_local;
wire [31:0] local_bb3_and93_i;

assign local_bb3_and93_i = ((local_bb3_align_0_i45 & 32'hFF) & 32'h1C);

// This section implements an unregistered operation.
// 
wire local_bb3_and95_i_stall_local;
wire [31:0] local_bb3_and95_i;

assign local_bb3_and95_i = ((local_bb3_align_0_i45 & 32'hFF) & 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb3_and115_i_stall_local;
wire [31:0] local_bb3_and115_i;

assign local_bb3_and115_i = ((local_bb3_align_0_i45 & 32'hFF) & 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb3_and130_i_stall_local;
wire [31:0] local_bb3_and130_i;

assign local_bb3_and130_i = ((local_bb3_align_0_i45 & 32'hFF) & 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb3__22_i13_valid_out_1;
wire local_bb3__22_i13_stall_in_1;
wire local_bb3__23_i14_valid_out_1;
wire local_bb3__23_i14_stall_in_1;
wire local_bb3_shr16_i15_valid_out_1;
wire local_bb3_shr16_i15_stall_in_1;
wire local_bb3_lnot23_i22_valid_out;
wire local_bb3_lnot23_i22_stall_in;
wire local_bb3_cmp27_i24_valid_out;
wire local_bb3_cmp27_i24_stall_in;
wire local_bb3_and93_i_valid_out;
wire local_bb3_and93_i_stall_in;
wire local_bb3_and95_i_valid_out;
wire local_bb3_and95_i_stall_in;
wire local_bb3_and115_i_valid_out;
wire local_bb3_and115_i_stall_in;
wire local_bb3_and130_i_valid_out;
wire local_bb3_and130_i_stall_in;
wire local_bb3_and149_i_valid_out;
wire local_bb3_and149_i_stall_in;
wire local_bb3_and149_i_inputs_ready;
wire local_bb3_and149_i_stall_local;
wire [31:0] local_bb3_and149_i;

assign local_bb3_and149_i_inputs_ready = (rnode_166to167_bb3__21_i12_0_valid_out_0_NO_SHIFT_REG & rnode_166to167_bb3_var__u4_0_valid_out_0_NO_SHIFT_REG & rnode_166to167_bb3_var__u2_0_valid_out_0_NO_SHIFT_REG & rnode_166to167_bb3__21_i12_0_valid_out_1_NO_SHIFT_REG & rnode_166to167_bb3_var__u2_0_valid_out_1_NO_SHIFT_REG & rnode_166to167_bb3_var__u4_0_valid_out_1_NO_SHIFT_REG);
assign local_bb3_and149_i = ((local_bb3_align_0_i45 & 32'hFF) & 32'h3);
assign local_bb3__22_i13_valid_out_1 = 1'b1;
assign local_bb3__23_i14_valid_out_1 = 1'b1;
assign local_bb3_shr16_i15_valid_out_1 = 1'b1;
assign local_bb3_lnot23_i22_valid_out = 1'b1;
assign local_bb3_cmp27_i24_valid_out = 1'b1;
assign local_bb3_and93_i_valid_out = 1'b1;
assign local_bb3_and95_i_valid_out = 1'b1;
assign local_bb3_and115_i_valid_out = 1'b1;
assign local_bb3_and130_i_valid_out = 1'b1;
assign local_bb3_and149_i_valid_out = 1'b1;
assign rnode_166to167_bb3__21_i12_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3_var__u4_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3_var__u2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3__21_i12_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3_var__u2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb3_var__u4_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_shl65_i138_stall_local;
wire [31:0] local_bb3_shl65_i138;

assign local_bb3_shl65_i138 = ((local_bb3_or64_i137 & 32'h3FFFFF8) | 32'h4000000);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot30_i122_stall_local;
wire local_bb3_lnot30_i122;

assign local_bb3_lnot30_i122 = ((rnode_170to171_bb3_and20_i112_0_NO_SHIFT_REG & 32'h7FFFFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_or_i134_stall_local;
wire [31:0] local_bb3_or_i134;

assign local_bb3_or_i134 = ((rnode_170to171_bb3_and20_i112_1_NO_SHIFT_REG & 32'h7FFFFF) << 32'h3);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_171to173_bb3_and35_i118_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and35_i118_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to173_bb3_and35_i118_0_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and35_i118_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to173_bb3_and35_i118_0_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and35_i118_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and35_i118_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and35_i118_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_171to173_bb3_and35_i118_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to173_bb3_and35_i118_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to173_bb3_and35_i118_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_171to173_bb3_and35_i118_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_171to173_bb3_and35_i118_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in((rnode_170to171_bb3_and35_i118_0_NO_SHIFT_REG & 32'h80000000)),
	.data_out(rnode_171to173_bb3_and35_i118_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_171to173_bb3_and35_i118_0_reg_173_fifo.DEPTH = 2;
defparam rnode_171to173_bb3_and35_i118_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_171to173_bb3_and35_i118_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to173_bb3_and35_i118_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_171to173_bb3_and35_i118_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3_and35_i118_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to173_bb3_and35_i118_0_NO_SHIFT_REG = rnode_171to173_bb3_and35_i118_0_reg_173_NO_SHIFT_REG;
assign rnode_171to173_bb3_and35_i118_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_171to173_bb3_and35_i118_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_cmp25_not_i121_stall_local;
wire local_bb3_cmp25_not_i121;

assign local_bb3_cmp25_not_i121 = (local_bb3_cmp25_i116 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u6_stall_local;
wire local_bb3_var__u6;

assign local_bb3_var__u6 = (local_bb3_cmp25_i116 | rnode_169to171_bb3_cmp27_i117_2_NO_SHIFT_REG);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3__22_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3__22_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3__22_i_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3__22_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb3__22_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3__22_i_1_NO_SHIFT_REG;
 logic rnode_167to168_bb3__22_i_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3__22_i_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3__22_i_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3__22_i_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3__22_i_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3__22_i_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3__22_i_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3__22_i_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3__22_i_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3__22_i_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb3__22_i),
	.data_out(rnode_167to168_bb3__22_i_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3__22_i_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3__22_i_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb3__22_i_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3__22_i_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3__22_i_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__22_i_stall_in_1 = 1'b0;
assign rnode_167to168_bb3__22_i_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3__22_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3__22_i_0_NO_SHIFT_REG = rnode_167to168_bb3__22_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3__22_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3__22_i_1_NO_SHIFT_REG = rnode_167to168_bb3__22_i_0_reg_168_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3__23_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3__23_i_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3__23_i_1_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3__23_i_2_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3__23_i_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3__23_i_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3__23_i_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3__23_i_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3__23_i_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3__23_i_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb3__23_i),
	.data_out(rnode_167to168_bb3__23_i_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3__23_i_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3__23_i_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb3__23_i_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3__23_i_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3__23_i_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__23_i_stall_in_1 = 1'b0;
assign rnode_167to168_bb3__23_i_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3__23_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3__23_i_0_NO_SHIFT_REG = rnode_167to168_bb3__23_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3__23_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3__23_i_1_NO_SHIFT_REG = rnode_167to168_bb3__23_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3__23_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3__23_i_2_NO_SHIFT_REG = rnode_167to168_bb3__23_i_0_reg_168_NO_SHIFT_REG;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_167to169_bb3_shr16_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to169_bb3_shr16_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_167to169_bb3_shr16_i_0_NO_SHIFT_REG;
 logic rnode_167to169_bb3_shr16_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to169_bb3_shr16_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_167to169_bb3_shr16_i_1_NO_SHIFT_REG;
 logic rnode_167to169_bb3_shr16_i_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to169_bb3_shr16_i_0_reg_169_NO_SHIFT_REG;
 logic rnode_167to169_bb3_shr16_i_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_167to169_bb3_shr16_i_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_167to169_bb3_shr16_i_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_167to169_bb3_shr16_i_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to169_bb3_shr16_i_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to169_bb3_shr16_i_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_167to169_bb3_shr16_i_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_167to169_bb3_shr16_i_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in((local_bb3_shr16_i & 32'h1FF)),
	.data_out(rnode_167to169_bb3_shr16_i_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_167to169_bb3_shr16_i_0_reg_169_fifo.DEPTH = 2;
defparam rnode_167to169_bb3_shr16_i_0_reg_169_fifo.DATA_WIDTH = 32;
defparam rnode_167to169_bb3_shr16_i_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to169_bb3_shr16_i_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_167to169_bb3_shr16_i_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_shr16_i_stall_in_1 = 1'b0;
assign rnode_167to169_bb3_shr16_i_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_167to169_bb3_shr16_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to169_bb3_shr16_i_0_NO_SHIFT_REG = rnode_167to169_bb3_shr16_i_0_reg_169_NO_SHIFT_REG;
assign rnode_167to169_bb3_shr16_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to169_bb3_shr16_i_1_NO_SHIFT_REG = rnode_167to169_bb3_shr16_i_0_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3_lnot23_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb3_lnot23_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_167to168_bb3_lnot23_i_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3_lnot23_i_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic rnode_167to168_bb3_lnot23_i_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_lnot23_i_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_lnot23_i_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_lnot23_i_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3_lnot23_i_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3_lnot23_i_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3_lnot23_i_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3_lnot23_i_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3_lnot23_i_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb3_lnot23_i),
	.data_out(rnode_167to168_bb3_lnot23_i_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3_lnot23_i_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3_lnot23_i_0_reg_168_fifo.DATA_WIDTH = 1;
defparam rnode_167to168_bb3_lnot23_i_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3_lnot23_i_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3_lnot23_i_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_lnot23_i_stall_in = 1'b0;
assign rnode_167to168_bb3_lnot23_i_0_NO_SHIFT_REG = rnode_167to168_bb3_lnot23_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3_lnot23_i_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_lnot23_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_167to169_bb3_cmp27_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i_0_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i_1_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i_2_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i_0_reg_169_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_167to169_bb3_cmp27_i_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to169_bb3_cmp27_i_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to169_bb3_cmp27_i_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_167to169_bb3_cmp27_i_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_167to169_bb3_cmp27_i_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb3_cmp27_i),
	.data_out(rnode_167to169_bb3_cmp27_i_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_167to169_bb3_cmp27_i_0_reg_169_fifo.DEPTH = 2;
defparam rnode_167to169_bb3_cmp27_i_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_167to169_bb3_cmp27_i_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to169_bb3_cmp27_i_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_167to169_bb3_cmp27_i_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_cmp27_i_stall_in = 1'b0;
assign rnode_167to169_bb3_cmp27_i_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_167to169_bb3_cmp27_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to169_bb3_cmp27_i_0_NO_SHIFT_REG = rnode_167to169_bb3_cmp27_i_0_reg_169_NO_SHIFT_REG;
assign rnode_167to169_bb3_cmp27_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to169_bb3_cmp27_i_1_NO_SHIFT_REG = rnode_167to169_bb3_cmp27_i_0_reg_169_NO_SHIFT_REG;
assign rnode_167to169_bb3_cmp27_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_167to169_bb3_cmp27_i_2_NO_SHIFT_REG = rnode_167to169_bb3_cmp27_i_0_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3_and94_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and94_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and94_i_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and94_i_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and94_i_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and94_i_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and94_i_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and94_i_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3_and94_i_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3_and94_i_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3_and94_i_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3_and94_i_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3_and94_i_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in((local_bb3_and94_i & 32'h1C)),
	.data_out(rnode_167to168_bb3_and94_i_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3_and94_i_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3_and94_i_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb3_and94_i_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3_and94_i_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3_and94_i_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and94_i_stall_in = 1'b0;
assign rnode_167to168_bb3_and94_i_0_NO_SHIFT_REG = rnode_167to168_bb3_and94_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3_and94_i_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and94_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3_and96_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and96_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and96_i_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and96_i_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and96_i_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and96_i_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and96_i_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and96_i_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3_and96_i_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3_and96_i_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3_and96_i_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3_and96_i_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3_and96_i_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in((local_bb3_and96_i & 32'h10)),
	.data_out(rnode_167to168_bb3_and96_i_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3_and96_i_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3_and96_i_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb3_and96_i_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3_and96_i_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3_and96_i_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and96_i_stall_in = 1'b0;
assign rnode_167to168_bb3_and96_i_0_NO_SHIFT_REG = rnode_167to168_bb3_and96_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3_and96_i_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and96_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3_and116_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and116_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and116_i_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and116_i_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and116_i_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and116_i_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and116_i_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and116_i_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3_and116_i_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3_and116_i_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3_and116_i_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3_and116_i_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3_and116_i_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in((local_bb3_and116_i & 32'h8)),
	.data_out(rnode_167to168_bb3_and116_i_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3_and116_i_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3_and116_i_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb3_and116_i_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3_and116_i_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3_and116_i_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and116_i_stall_in = 1'b0;
assign rnode_167to168_bb3_and116_i_0_NO_SHIFT_REG = rnode_167to168_bb3_and116_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3_and116_i_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and116_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3_and131_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and131_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and131_i_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and131_i_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and131_i_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and131_i_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and131_i_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and131_i_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3_and131_i_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3_and131_i_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3_and131_i_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3_and131_i_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3_and131_i_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in((local_bb3_and131_i & 32'h4)),
	.data_out(rnode_167to168_bb3_and131_i_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3_and131_i_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3_and131_i_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb3_and131_i_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3_and131_i_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3_and131_i_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and131_i_stall_in = 1'b0;
assign rnode_167to168_bb3_and131_i_0_NO_SHIFT_REG = rnode_167to168_bb3_and131_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3_and131_i_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and131_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3_and150_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and150_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and150_i_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and150_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and150_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and150_i_1_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and150_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and150_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and150_i_2_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and150_i_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and150_i_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and150_i_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and150_i_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and150_i_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3_and150_i_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3_and150_i_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3_and150_i_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3_and150_i_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3_and150_i_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in((local_bb3_and150_i & 32'h3)),
	.data_out(rnode_167to168_bb3_and150_i_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3_and150_i_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3_and150_i_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb3_and150_i_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3_and150_i_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3_and150_i_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and150_i_stall_in = 1'b0;
assign rnode_167to168_bb3_and150_i_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and150_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3_and150_i_0_NO_SHIFT_REG = rnode_167to168_bb3_and150_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3_and150_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3_and150_i_1_NO_SHIFT_REG = rnode_167to168_bb3_and150_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3_and150_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3_and150_i_2_NO_SHIFT_REG = rnode_167to168_bb3_and150_i_0_reg_168_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3__22_i13_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3__22_i13_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3__22_i13_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3__22_i13_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb3__22_i13_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3__22_i13_1_NO_SHIFT_REG;
 logic rnode_167to168_bb3__22_i13_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3__22_i13_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3__22_i13_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3__22_i13_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3__22_i13_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3__22_i13_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3__22_i13_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3__22_i13_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3__22_i13_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3__22_i13_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb3__22_i13),
	.data_out(rnode_167to168_bb3__22_i13_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3__22_i13_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3__22_i13_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb3__22_i13_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3__22_i13_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3__22_i13_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__22_i13_stall_in_1 = 1'b0;
assign rnode_167to168_bb3__22_i13_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3__22_i13_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3__22_i13_0_NO_SHIFT_REG = rnode_167to168_bb3__22_i13_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3__22_i13_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3__22_i13_1_NO_SHIFT_REG = rnode_167to168_bb3__22_i13_0_reg_168_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3__23_i14_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i14_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3__23_i14_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i14_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i14_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3__23_i14_1_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i14_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i14_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3__23_i14_2_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i14_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3__23_i14_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i14_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i14_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3__23_i14_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3__23_i14_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3__23_i14_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3__23_i14_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3__23_i14_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3__23_i14_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb3__23_i14),
	.data_out(rnode_167to168_bb3__23_i14_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3__23_i14_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3__23_i14_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb3__23_i14_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3__23_i14_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3__23_i14_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__23_i14_stall_in_1 = 1'b0;
assign rnode_167to168_bb3__23_i14_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3__23_i14_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3__23_i14_0_NO_SHIFT_REG = rnode_167to168_bb3__23_i14_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3__23_i14_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3__23_i14_1_NO_SHIFT_REG = rnode_167to168_bb3__23_i14_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3__23_i14_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3__23_i14_2_NO_SHIFT_REG = rnode_167to168_bb3__23_i14_0_reg_168_NO_SHIFT_REG;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_167to169_bb3_shr16_i15_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to169_bb3_shr16_i15_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_167to169_bb3_shr16_i15_0_NO_SHIFT_REG;
 logic rnode_167to169_bb3_shr16_i15_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to169_bb3_shr16_i15_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_167to169_bb3_shr16_i15_1_NO_SHIFT_REG;
 logic rnode_167to169_bb3_shr16_i15_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to169_bb3_shr16_i15_0_reg_169_NO_SHIFT_REG;
 logic rnode_167to169_bb3_shr16_i15_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_167to169_bb3_shr16_i15_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_167to169_bb3_shr16_i15_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_167to169_bb3_shr16_i15_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to169_bb3_shr16_i15_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to169_bb3_shr16_i15_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_167to169_bb3_shr16_i15_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_167to169_bb3_shr16_i15_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in((local_bb3_shr16_i15 & 32'h1FF)),
	.data_out(rnode_167to169_bb3_shr16_i15_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_167to169_bb3_shr16_i15_0_reg_169_fifo.DEPTH = 2;
defparam rnode_167to169_bb3_shr16_i15_0_reg_169_fifo.DATA_WIDTH = 32;
defparam rnode_167to169_bb3_shr16_i15_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to169_bb3_shr16_i15_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_167to169_bb3_shr16_i15_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_shr16_i15_stall_in_1 = 1'b0;
assign rnode_167to169_bb3_shr16_i15_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_167to169_bb3_shr16_i15_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to169_bb3_shr16_i15_0_NO_SHIFT_REG = rnode_167to169_bb3_shr16_i15_0_reg_169_NO_SHIFT_REG;
assign rnode_167to169_bb3_shr16_i15_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to169_bb3_shr16_i15_1_NO_SHIFT_REG = rnode_167to169_bb3_shr16_i15_0_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3_lnot23_i22_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb3_lnot23_i22_0_stall_in_NO_SHIFT_REG;
 logic rnode_167to168_bb3_lnot23_i22_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3_lnot23_i22_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic rnode_167to168_bb3_lnot23_i22_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_lnot23_i22_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_lnot23_i22_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_lnot23_i22_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3_lnot23_i22_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3_lnot23_i22_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3_lnot23_i22_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3_lnot23_i22_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3_lnot23_i22_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb3_lnot23_i22),
	.data_out(rnode_167to168_bb3_lnot23_i22_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3_lnot23_i22_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3_lnot23_i22_0_reg_168_fifo.DATA_WIDTH = 1;
defparam rnode_167to168_bb3_lnot23_i22_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3_lnot23_i22_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3_lnot23_i22_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_lnot23_i22_stall_in = 1'b0;
assign rnode_167to168_bb3_lnot23_i22_0_NO_SHIFT_REG = rnode_167to168_bb3_lnot23_i22_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3_lnot23_i22_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_lnot23_i22_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_167to169_bb3_cmp27_i24_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i24_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i24_0_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i24_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i24_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i24_1_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i24_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i24_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i24_2_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i24_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i24_0_reg_169_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i24_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i24_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_167to169_bb3_cmp27_i24_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_167to169_bb3_cmp27_i24_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to169_bb3_cmp27_i24_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to169_bb3_cmp27_i24_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_167to169_bb3_cmp27_i24_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_167to169_bb3_cmp27_i24_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb3_cmp27_i24),
	.data_out(rnode_167to169_bb3_cmp27_i24_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_167to169_bb3_cmp27_i24_0_reg_169_fifo.DEPTH = 2;
defparam rnode_167to169_bb3_cmp27_i24_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_167to169_bb3_cmp27_i24_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to169_bb3_cmp27_i24_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_167to169_bb3_cmp27_i24_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_cmp27_i24_stall_in = 1'b0;
assign rnode_167to169_bb3_cmp27_i24_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_167to169_bb3_cmp27_i24_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to169_bb3_cmp27_i24_0_NO_SHIFT_REG = rnode_167to169_bb3_cmp27_i24_0_reg_169_NO_SHIFT_REG;
assign rnode_167to169_bb3_cmp27_i24_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to169_bb3_cmp27_i24_1_NO_SHIFT_REG = rnode_167to169_bb3_cmp27_i24_0_reg_169_NO_SHIFT_REG;
assign rnode_167to169_bb3_cmp27_i24_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_167to169_bb3_cmp27_i24_2_NO_SHIFT_REG = rnode_167to169_bb3_cmp27_i24_0_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3_and93_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and93_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and93_i_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and93_i_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and93_i_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and93_i_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and93_i_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and93_i_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3_and93_i_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3_and93_i_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3_and93_i_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3_and93_i_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3_and93_i_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in((local_bb3_and93_i & 32'h1C)),
	.data_out(rnode_167to168_bb3_and93_i_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3_and93_i_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3_and93_i_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb3_and93_i_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3_and93_i_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3_and93_i_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and93_i_stall_in = 1'b0;
assign rnode_167to168_bb3_and93_i_0_NO_SHIFT_REG = rnode_167to168_bb3_and93_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3_and93_i_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and93_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3_and95_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and95_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and95_i_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and95_i_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and95_i_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and95_i_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and95_i_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and95_i_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3_and95_i_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3_and95_i_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3_and95_i_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3_and95_i_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3_and95_i_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in((local_bb3_and95_i & 32'h10)),
	.data_out(rnode_167to168_bb3_and95_i_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3_and95_i_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3_and95_i_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb3_and95_i_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3_and95_i_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3_and95_i_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and95_i_stall_in = 1'b0;
assign rnode_167to168_bb3_and95_i_0_NO_SHIFT_REG = rnode_167to168_bb3_and95_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3_and95_i_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and95_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3_and115_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and115_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and115_i_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and115_i_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and115_i_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and115_i_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and115_i_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and115_i_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3_and115_i_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3_and115_i_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3_and115_i_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3_and115_i_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3_and115_i_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in((local_bb3_and115_i & 32'h8)),
	.data_out(rnode_167to168_bb3_and115_i_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3_and115_i_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3_and115_i_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb3_and115_i_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3_and115_i_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3_and115_i_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and115_i_stall_in = 1'b0;
assign rnode_167to168_bb3_and115_i_0_NO_SHIFT_REG = rnode_167to168_bb3_and115_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3_and115_i_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and115_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3_and130_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and130_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and130_i_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and130_i_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and130_i_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and130_i_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and130_i_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and130_i_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3_and130_i_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3_and130_i_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3_and130_i_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3_and130_i_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3_and130_i_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in((local_bb3_and130_i & 32'h4)),
	.data_out(rnode_167to168_bb3_and130_i_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3_and130_i_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3_and130_i_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb3_and130_i_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3_and130_i_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3_and130_i_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and130_i_stall_in = 1'b0;
assign rnode_167to168_bb3_and130_i_0_NO_SHIFT_REG = rnode_167to168_bb3_and130_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3_and130_i_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and130_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb3_and149_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and149_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and149_i_0_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and149_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and149_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and149_i_1_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and149_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and149_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and149_i_2_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and149_i_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb3_and149_i_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and149_i_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and149_i_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb3_and149_i_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb3_and149_i_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb3_and149_i_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb3_and149_i_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb3_and149_i_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb3_and149_i_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in((local_bb3_and149_i & 32'h3)),
	.data_out(rnode_167to168_bb3_and149_i_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb3_and149_i_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb3_and149_i_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb3_and149_i_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb3_and149_i_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb3_and149_i_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and149_i_stall_in = 1'b0;
assign rnode_167to168_bb3_and149_i_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and149_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3_and149_i_0_NO_SHIFT_REG = rnode_167to168_bb3_and149_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3_and149_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3_and149_i_1_NO_SHIFT_REG = rnode_167to168_bb3_and149_i_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb3_and149_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb3_and149_i_2_NO_SHIFT_REG = rnode_167to168_bb3_and149_i_0_reg_168_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3__28_i139_stall_local;
wire [31:0] local_bb3__28_i139;

assign local_bb3__28_i139 = (rnode_169to170_bb3_lnot23_i115_0_NO_SHIFT_REG ? 32'h0 : ((local_bb3_shl65_i138 & 32'h7FFFFF8) | 32'h4000000));

// This section implements an unregistered operation.
// 
wire local_bb3_lnot30_not_i126_stall_local;
wire local_bb3_lnot30_not_i126;

assign local_bb3_lnot30_not_i126 = (local_bb3_lnot30_i122 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb3_shl_i135_stall_local;
wire [31:0] local_bb3_shl_i135;

assign local_bb3_shl_i135 = ((local_bb3_or_i134 & 32'h3FFFFF8) | 32'h4000000);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb3_and35_i118_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb3_and35_i118_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb3_and35_i118_0_NO_SHIFT_REG;
 logic rnode_173to174_bb3_and35_i118_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb3_and35_i118_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_and35_i118_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_and35_i118_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_and35_i118_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb3_and35_i118_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb3_and35_i118_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb3_and35_i118_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb3_and35_i118_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb3_and35_i118_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in((rnode_171to173_bb3_and35_i118_0_NO_SHIFT_REG & 32'h80000000)),
	.data_out(rnode_173to174_bb3_and35_i118_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb3_and35_i118_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb3_and35_i118_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb3_and35_i118_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb3_and35_i118_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb3_and35_i118_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_171to173_bb3_and35_i118_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3_and35_i118_0_NO_SHIFT_REG = rnode_173to174_bb3_and35_i118_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb3_and35_i118_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3_and35_i118_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_or_cond_i123_stall_local;
wire local_bb3_or_cond_i123;

assign local_bb3_or_cond_i123 = (local_bb3_lnot30_i122 | local_bb3_cmp25_not_i121);

// This section implements an unregistered operation.
// 
wire local_bb3_and21_i_stall_local;
wire [31:0] local_bb3_and21_i;

assign local_bb3_and21_i = (rnode_167to168_bb3__22_i_0_NO_SHIFT_REG & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and20_i_valid_out;
wire local_bb3_and20_i_stall_in;
wire local_bb3_and20_i_inputs_ready;
wire local_bb3_and20_i_stall_local;
wire [31:0] local_bb3_and20_i;

assign local_bb3_and20_i_inputs_ready = rnode_167to168_bb3__23_i_0_valid_out_0_NO_SHIFT_REG;
assign local_bb3_and20_i = (rnode_167to168_bb3__23_i_0_NO_SHIFT_REG & 32'h7FFFFF);
assign local_bb3_and20_i_valid_out = 1'b1;
assign rnode_167to168_bb3__23_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and35_i_valid_out;
wire local_bb3_and35_i_stall_in;
wire local_bb3_and35_i_inputs_ready;
wire local_bb3_and35_i_stall_local;
wire [31:0] local_bb3_and35_i;

assign local_bb3_and35_i_inputs_ready = rnode_167to168_bb3__23_i_0_valid_out_1_NO_SHIFT_REG;
assign local_bb3_and35_i = (rnode_167to168_bb3__23_i_1_NO_SHIFT_REG & 32'h80000000);
assign local_bb3_and35_i_valid_out = 1'b1;
assign rnode_167to168_bb3__23_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_xor36_i_stall_local;
wire [31:0] local_bb3_xor36_i;

assign local_bb3_xor36_i = (rnode_167to168_bb3__23_i_2_NO_SHIFT_REG ^ rnode_167to168_bb3__22_i_1_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_and17_i_stall_local;
wire [31:0] local_bb3_and17_i;

assign local_bb3_and17_i = ((rnode_167to169_bb3_shr16_i_0_NO_SHIFT_REG & 32'h1FF) & 32'hFF);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb3_shr16_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_shr16_i_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_shr16_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb3_shr16_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb3_shr16_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb3_shr16_i_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb3_shr16_i_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb3_shr16_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((rnode_167to169_bb3_shr16_i_1_NO_SHIFT_REG & 32'h1FF)),
	.data_out(rnode_169to171_bb3_shr16_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb3_shr16_i_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb3_shr16_i_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_169to171_bb3_shr16_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb3_shr16_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb3_shr16_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to169_bb3_shr16_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_shr16_i_0_NO_SHIFT_REG = rnode_169to171_bb3_shr16_i_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb3_shr16_i_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_shr16_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_cmp97_i_stall_local;
wire local_bb3_cmp97_i;

assign local_bb3_cmp97_i = ((rnode_167to168_bb3_and96_i_0_NO_SHIFT_REG & 32'h10) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp117_i_stall_local;
wire local_bb3_cmp117_i;

assign local_bb3_cmp117_i = ((rnode_167to168_bb3_and116_i_0_NO_SHIFT_REG & 32'h8) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp132_not_i_stall_local;
wire local_bb3_cmp132_not_i;

assign local_bb3_cmp132_not_i = ((rnode_167to168_bb3_and131_i_0_NO_SHIFT_REG & 32'h4) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_Pivot20_i_stall_local;
wire local_bb3_Pivot20_i;

assign local_bb3_Pivot20_i = ((rnode_167to168_bb3_and150_i_1_NO_SHIFT_REG & 32'h3) < 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb3_SwitchLeaf_i_stall_local;
wire local_bb3_SwitchLeaf_i;

assign local_bb3_SwitchLeaf_i = ((rnode_167to168_bb3_and150_i_2_NO_SHIFT_REG & 32'h3) == 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_and21_i20_stall_local;
wire [31:0] local_bb3_and21_i20;

assign local_bb3_and21_i20 = (rnode_167to168_bb3__22_i13_0_NO_SHIFT_REG & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and20_i19_valid_out;
wire local_bb3_and20_i19_stall_in;
wire local_bb3_and20_i19_inputs_ready;
wire local_bb3_and20_i19_stall_local;
wire [31:0] local_bb3_and20_i19;

assign local_bb3_and20_i19_inputs_ready = rnode_167to168_bb3__23_i14_0_valid_out_0_NO_SHIFT_REG;
assign local_bb3_and20_i19 = (rnode_167to168_bb3__23_i14_0_NO_SHIFT_REG & 32'h7FFFFF);
assign local_bb3_and20_i19_valid_out = 1'b1;
assign rnode_167to168_bb3__23_i14_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and35_i25_valid_out;
wire local_bb3_and35_i25_stall_in;
wire local_bb3_and35_i25_inputs_ready;
wire local_bb3_and35_i25_stall_local;
wire [31:0] local_bb3_and35_i25;

assign local_bb3_and35_i25_inputs_ready = rnode_167to168_bb3__23_i14_0_valid_out_1_NO_SHIFT_REG;
assign local_bb3_and35_i25 = (rnode_167to168_bb3__23_i14_1_NO_SHIFT_REG & 32'h80000000);
assign local_bb3_and35_i25_valid_out = 1'b1;
assign rnode_167to168_bb3__23_i14_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_xor_i26_stall_local;
wire [31:0] local_bb3_xor_i26;

assign local_bb3_xor_i26 = (rnode_167to168_bb3__23_i14_2_NO_SHIFT_REG ^ rnode_167to168_bb3__22_i13_1_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_and17_i16_stall_local;
wire [31:0] local_bb3_and17_i16;

assign local_bb3_and17_i16 = ((rnode_167to169_bb3_shr16_i15_0_NO_SHIFT_REG & 32'h1FF) & 32'hFF);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb3_shr16_i15_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i15_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_shr16_i15_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i15_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_shr16_i15_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i15_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i15_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_shr16_i15_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb3_shr16_i15_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb3_shr16_i15_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb3_shr16_i15_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb3_shr16_i15_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb3_shr16_i15_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((rnode_167to169_bb3_shr16_i15_1_NO_SHIFT_REG & 32'h1FF)),
	.data_out(rnode_169to171_bb3_shr16_i15_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb3_shr16_i15_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb3_shr16_i15_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_169to171_bb3_shr16_i15_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb3_shr16_i15_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb3_shr16_i15_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to169_bb3_shr16_i15_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_shr16_i15_0_NO_SHIFT_REG = rnode_169to171_bb3_shr16_i15_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb3_shr16_i15_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_shr16_i15_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_cmp96_i_stall_local;
wire local_bb3_cmp96_i;

assign local_bb3_cmp96_i = ((rnode_167to168_bb3_and95_i_0_NO_SHIFT_REG & 32'h10) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp116_i_stall_local;
wire local_bb3_cmp116_i;

assign local_bb3_cmp116_i = ((rnode_167to168_bb3_and115_i_0_NO_SHIFT_REG & 32'h8) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp131_not_i_stall_local;
wire local_bb3_cmp131_not_i;

assign local_bb3_cmp131_not_i = ((rnode_167to168_bb3_and130_i_0_NO_SHIFT_REG & 32'h4) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_Pivot20_i54_stall_local;
wire local_bb3_Pivot20_i54;

assign local_bb3_Pivot20_i54 = ((rnode_167to168_bb3_and149_i_1_NO_SHIFT_REG & 32'h3) < 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb3_SwitchLeaf_i55_stall_local;
wire local_bb3_SwitchLeaf_i55;

assign local_bb3_SwitchLeaf_i55 = ((rnode_167to168_bb3_and149_i_2_NO_SHIFT_REG & 32'h3) == 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_and72_i144_stall_local;
wire [31:0] local_bb3_and72_i144;

assign local_bb3_and72_i144 = ((local_bb3__28_i139 & 32'h7FFFFF8) >> 32'h3);

// This section implements an unregistered operation.
// 
wire local_bb3_and75_i147_stall_local;
wire [31:0] local_bb3_and75_i147;

assign local_bb3_and75_i147 = ((local_bb3__28_i139 & 32'h7FFFFF8) & 32'hF0);

// This section implements an unregistered operation.
// 
wire local_bb3_and78_i149_stall_local;
wire [31:0] local_bb3_and78_i149;

assign local_bb3_and78_i149 = ((local_bb3__28_i139 & 32'h7FFFFF8) & 32'hF00);

// This section implements an unregistered operation.
// 
wire local_bb3_shr94_i152_stall_local;
wire [31:0] local_bb3_shr94_i152;

assign local_bb3_shr94_i152 = ((local_bb3__28_i139 & 32'h7FFFFF8) >> (local_bb3_and93_i151 & 32'h1C));

// This section implements an unregistered operation.
// 
wire local_bb3_and90_i155_stall_local;
wire [31:0] local_bb3_and90_i155;

assign local_bb3_and90_i155 = ((local_bb3__28_i139 & 32'h7FFFFF8) & 32'h7000000);

// This section implements an unregistered operation.
// 
wire local_bb3_and87_i156_stall_local;
wire [31:0] local_bb3_and87_i156;

assign local_bb3_and87_i156 = ((local_bb3__28_i139 & 32'h7FFFFF8) & 32'hF00000);

// This section implements an unregistered operation.
// 
wire local_bb3_and84_i157_stall_local;
wire [31:0] local_bb3_and84_i157;

assign local_bb3_and84_i157 = ((local_bb3__28_i139 & 32'h7FFFFF8) & 32'hF0000);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u7_stall_local;
wire [31:0] local_bb3_var__u7;

assign local_bb3_var__u7 = ((local_bb3__28_i139 & 32'h7FFFFF8) & 32'hFFF8);

// This section implements an unregistered operation.
// 
wire local_bb3_or_cond_not_i127_stall_local;
wire local_bb3_or_cond_not_i127;

assign local_bb3_or_cond_not_i127 = (local_bb3_cmp25_i116 & local_bb3_lnot30_not_i126);

// This section implements an unregistered operation.
// 
wire local_bb3__27_i136_stall_local;
wire [31:0] local_bb3__27_i136;

assign local_bb3__27_i136 = (local_bb3_lnot_i114 ? 32'h0 : ((local_bb3_shl_i135 & 32'h7FFFFF8) | 32'h4000000));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_8_i131_stall_local;
wire local_bb3_reduction_8_i131;

assign local_bb3_reduction_8_i131 = (rnode_169to171_bb3_cmp27_i117_1_NO_SHIFT_REG & local_bb3_or_cond_i123);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot33_not_i_stall_local;
wire local_bb3_lnot33_not_i;

assign local_bb3_lnot33_not_i = ((local_bb3_and21_i & 32'h7FFFFF) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_or65_i_stall_local;
wire [31:0] local_bb3_or65_i;

assign local_bb3_or65_i = ((local_bb3_and21_i & 32'h7FFFFF) << 32'h3);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_and20_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and20_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_and20_i_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and20_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and20_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_and20_i_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and20_i_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_and20_i_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and20_i_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and20_i_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and20_i_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_and20_i_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_and20_i_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_and20_i_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_and20_i_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_and20_i_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in((local_bb3_and20_i & 32'h7FFFFF)),
	.data_out(rnode_168to169_bb3_and20_i_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_and20_i_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_and20_i_0_reg_169_fifo.DATA_WIDTH = 32;
defparam rnode_168to169_bb3_and20_i_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_and20_i_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_and20_i_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and20_i_stall_in = 1'b0;
assign rnode_168to169_bb3_and20_i_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_and20_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_and20_i_0_NO_SHIFT_REG = rnode_168to169_bb3_and20_i_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_and20_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_and20_i_1_NO_SHIFT_REG = rnode_168to169_bb3_and20_i_0_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_and35_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and35_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_and35_i_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and35_i_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_and35_i_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and35_i_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and35_i_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and35_i_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_and35_i_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_and35_i_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_and35_i_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_and35_i_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_and35_i_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in((local_bb3_and35_i & 32'h80000000)),
	.data_out(rnode_168to169_bb3_and35_i_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_and35_i_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_and35_i_0_reg_169_fifo.DATA_WIDTH = 32;
defparam rnode_168to169_bb3_and35_i_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_and35_i_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_and35_i_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and35_i_stall_in = 1'b0;
assign rnode_168to169_bb3_and35_i_0_NO_SHIFT_REG = rnode_168to169_bb3_and35_i_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_and35_i_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_and35_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_cmp38_i_stall_local;
wire local_bb3_cmp38_i;

assign local_bb3_cmp38_i = ($signed(local_bb3_xor36_i) < $signed(32'h0));

// This section implements an unregistered operation.
// 
wire local_bb3_xor36_lobit_i_stall_local;
wire [31:0] local_bb3_xor36_lobit_i;

assign local_bb3_xor36_lobit_i = ($signed(local_bb3_xor36_i) >>> 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb3_and37_lobit_i_stall_local;
wire [31:0] local_bb3_and37_lobit_i;

assign local_bb3_and37_lobit_i = (local_bb3_xor36_i >> 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot_i_stall_local;
wire local_bb3_lnot_i;

assign local_bb3_lnot_i = ((local_bb3_and17_i & 32'hFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp25_i_stall_local;
wire local_bb3_cmp25_i;

assign local_bb3_cmp25_i = ((local_bb3_and17_i & 32'hFF) == 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot33_not_i30_stall_local;
wire local_bb3_lnot33_not_i30;

assign local_bb3_lnot33_not_i30 = ((local_bb3_and21_i20 & 32'h7FFFFF) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_or64_i_stall_local;
wire [31:0] local_bb3_or64_i;

assign local_bb3_or64_i = ((local_bb3_and21_i20 & 32'h7FFFFF) << 32'h3);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_and20_i19_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and20_i19_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_and20_i19_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and20_i19_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and20_i19_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_and20_i19_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and20_i19_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_and20_i19_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and20_i19_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and20_i19_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and20_i19_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_and20_i19_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_and20_i19_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_and20_i19_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_and20_i19_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_and20_i19_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in((local_bb3_and20_i19 & 32'h7FFFFF)),
	.data_out(rnode_168to169_bb3_and20_i19_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_and20_i19_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_and20_i19_0_reg_169_fifo.DATA_WIDTH = 32;
defparam rnode_168to169_bb3_and20_i19_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_and20_i19_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_and20_i19_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and20_i19_stall_in = 1'b0;
assign rnode_168to169_bb3_and20_i19_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_and20_i19_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_and20_i19_0_NO_SHIFT_REG = rnode_168to169_bb3_and20_i19_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_and20_i19_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_and20_i19_1_NO_SHIFT_REG = rnode_168to169_bb3_and20_i19_0_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_and35_i25_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and35_i25_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_and35_i25_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and35_i25_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_and35_i25_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and35_i25_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and35_i25_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and35_i25_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_and35_i25_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_and35_i25_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_and35_i25_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_and35_i25_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_and35_i25_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in((local_bb3_and35_i25 & 32'h80000000)),
	.data_out(rnode_168to169_bb3_and35_i25_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_and35_i25_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_and35_i25_0_reg_169_fifo.DATA_WIDTH = 32;
defparam rnode_168to169_bb3_and35_i25_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_and35_i25_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_and35_i25_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and35_i25_stall_in = 1'b0;
assign rnode_168to169_bb3_and35_i25_0_NO_SHIFT_REG = rnode_168to169_bb3_and35_i25_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_and35_i25_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_and35_i25_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_cmp37_i_stall_local;
wire local_bb3_cmp37_i;

assign local_bb3_cmp37_i = ($signed(local_bb3_xor_i26) < $signed(32'h0));

// This section implements an unregistered operation.
// 
wire local_bb3_xor_lobit_i_stall_local;
wire [31:0] local_bb3_xor_lobit_i;

assign local_bb3_xor_lobit_i = ($signed(local_bb3_xor_i26) >>> 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb3_and36_lobit_i_stall_local;
wire [31:0] local_bb3_and36_lobit_i;

assign local_bb3_and36_lobit_i = (local_bb3_xor_i26 >> 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot_i21_stall_local;
wire local_bb3_lnot_i21;

assign local_bb3_lnot_i21 = ((local_bb3_and17_i16 & 32'hFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp25_i23_stall_local;
wire local_bb3_cmp25_i23;

assign local_bb3_cmp25_i23 = ((local_bb3_and17_i16 & 32'hFF) == 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and72_tr_i145_stall_local;
wire [7:0] local_bb3_and72_tr_i145;
wire [31:0] local_bb3_and72_tr_i145$ps;

assign local_bb3_and72_tr_i145$ps = (local_bb3_and72_i144 & 32'hFFFFFF);
assign local_bb3_and72_tr_i145 = local_bb3_and72_tr_i145$ps[7:0];

// This section implements an unregistered operation.
// 
wire local_bb3_cmp76_i148_stall_local;
wire local_bb3_cmp76_i148;

assign local_bb3_cmp76_i148 = ((local_bb3_and75_i147 & 32'hF0) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp79_i150_stall_local;
wire local_bb3_cmp79_i150;

assign local_bb3_cmp79_i150 = ((local_bb3_and78_i149 & 32'hF00) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_and142_i179_stall_local;
wire [31:0] local_bb3_and142_i179;

assign local_bb3_and142_i179 = (local_bb3_shr94_i152 >> 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_shr150_i181_stall_local;
wire [31:0] local_bb3_shr150_i181;

assign local_bb3_shr150_i181 = (local_bb3_shr94_i152 >> (local_bb3_and149_i180 & 32'h3));

// This section implements an unregistered operation.
// 
wire local_bb3_var__u8_stall_local;
wire [31:0] local_bb3_var__u8;

assign local_bb3_var__u8 = (local_bb3_shr94_i152 & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_and146_i184_stall_local;
wire [31:0] local_bb3_and146_i184;

assign local_bb3_and146_i184 = (local_bb3_shr94_i152 >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp91_i158_stall_local;
wire local_bb3_cmp91_i158;

assign local_bb3_cmp91_i158 = ((local_bb3_and90_i155 & 32'h7000000) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp88_i159_stall_local;
wire local_bb3_cmp88_i159;

assign local_bb3_cmp88_i159 = ((local_bb3_and87_i156 & 32'hF00000) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp85_i160_stall_local;
wire local_bb3_cmp85_i160;

assign local_bb3_cmp85_i160 = ((local_bb3_and84_i157 & 32'hF0000) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u9_stall_local;
wire local_bb3_var__u9;

assign local_bb3_var__u9 = ((local_bb3_var__u7 & 32'hFFF8) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_shl66_i_stall_local;
wire [31:0] local_bb3_shl66_i;

assign local_bb3_shl66_i = ((local_bb3_or65_i & 32'h3FFFFF8) | 32'h4000000);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot30_i_stall_local;
wire local_bb3_lnot30_i;

assign local_bb3_lnot30_i = ((rnode_168to169_bb3_and20_i_0_NO_SHIFT_REG & 32'h7FFFFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_or_i_stall_local;
wire [31:0] local_bb3_or_i;

assign local_bb3_or_i = ((rnode_168to169_bb3_and20_i_1_NO_SHIFT_REG & 32'h7FFFFF) << 32'h3);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb3_and35_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and35_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_and35_i_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and35_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_and35_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and35_i_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and35_i_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and35_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb3_and35_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb3_and35_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb3_and35_i_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb3_and35_i_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb3_and35_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((rnode_168to169_bb3_and35_i_0_NO_SHIFT_REG & 32'h80000000)),
	.data_out(rnode_169to171_bb3_and35_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb3_and35_i_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb3_and35_i_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_169to171_bb3_and35_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb3_and35_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb3_and35_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_and35_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_and35_i_0_NO_SHIFT_REG = rnode_169to171_bb3_and35_i_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb3_and35_i_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_and35_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_cmp25_not_i_stall_local;
wire local_bb3_cmp25_not_i;

assign local_bb3_cmp25_not_i = (local_bb3_cmp25_i ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u10_stall_local;
wire local_bb3_var__u10;

assign local_bb3_var__u10 = (local_bb3_cmp25_i | rnode_167to169_bb3_cmp27_i_2_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_shl65_i_stall_local;
wire [31:0] local_bb3_shl65_i;

assign local_bb3_shl65_i = ((local_bb3_or64_i & 32'h3FFFFF8) | 32'h4000000);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot30_i28_stall_local;
wire local_bb3_lnot30_i28;

assign local_bb3_lnot30_i28 = ((rnode_168to169_bb3_and20_i19_0_NO_SHIFT_REG & 32'h7FFFFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_or_i40_stall_local;
wire [31:0] local_bb3_or_i40;

assign local_bb3_or_i40 = ((rnode_168to169_bb3_and20_i19_1_NO_SHIFT_REG & 32'h7FFFFF) << 32'h3);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb3_and35_i25_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and35_i25_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_and35_i25_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and35_i25_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_and35_i25_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and35_i25_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and35_i25_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and35_i25_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb3_and35_i25_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb3_and35_i25_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb3_and35_i25_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb3_and35_i25_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb3_and35_i25_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((rnode_168to169_bb3_and35_i25_0_NO_SHIFT_REG & 32'h80000000)),
	.data_out(rnode_169to171_bb3_and35_i25_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb3_and35_i25_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb3_and35_i25_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_169to171_bb3_and35_i25_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb3_and35_i25_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb3_and35_i25_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_and35_i25_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_and35_i25_0_NO_SHIFT_REG = rnode_169to171_bb3_and35_i25_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb3_and35_i25_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_and35_i25_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_cmp25_not_i27_stall_local;
wire local_bb3_cmp25_not_i27;

assign local_bb3_cmp25_not_i27 = (local_bb3_cmp25_i23 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u11_stall_local;
wire local_bb3_var__u11;

assign local_bb3_var__u11 = (local_bb3_cmp25_i23 | rnode_167to169_bb3_cmp27_i24_2_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_frombool74_i146_stall_local;
wire [7:0] local_bb3_frombool74_i146;

assign local_bb3_frombool74_i146 = (local_bb3_and72_tr_i145 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u12_stall_local;
wire [31:0] local_bb3_var__u12;

assign local_bb3_var__u12 = ((local_bb3_and146_i184 & 32'h3FFFFFFF) | local_bb3_shr94_i152);

// This section implements an unregistered operation.
// 
wire local_bb3__31_v_i166_stall_local;
wire local_bb3__31_v_i166;

assign local_bb3__31_v_i166 = (local_bb3_cmp96_i154 ? local_bb3_cmp79_i150 : local_bb3_cmp91_i158);

// This section implements an unregistered operation.
// 
wire local_bb3__30_v_i164_stall_local;
wire local_bb3__30_v_i164;

assign local_bb3__30_v_i164 = (local_bb3_cmp96_i154 ? local_bb3_cmp76_i148 : local_bb3_cmp88_i159);

// This section implements an unregistered operation.
// 
wire local_bb3_frombool109_i162_stall_local;
wire [7:0] local_bb3_frombool109_i162;

assign local_bb3_frombool109_i162[7:1] = 7'h0;
assign local_bb3_frombool109_i162[0] = local_bb3_cmp85_i160;

// This section implements an unregistered operation.
// 
wire local_bb3_or107_i161_stall_local;
wire [31:0] local_bb3_or107_i161;

assign local_bb3_or107_i161[31:1] = 31'h0;
assign local_bb3_or107_i161[0] = local_bb3_var__u9;

// This section implements an unregistered operation.
// 
wire local_bb3__28_i_stall_local;
wire [31:0] local_bb3__28_i;

assign local_bb3__28_i = (rnode_167to168_bb3_lnot23_i_0_NO_SHIFT_REG ? 32'h0 : ((local_bb3_shl66_i & 32'h7FFFFF8) | 32'h4000000));

// This section implements an unregistered operation.
// 
wire local_bb3_lnot30_not_i_stall_local;
wire local_bb3_lnot30_not_i;

assign local_bb3_lnot30_not_i = (local_bb3_lnot30_i ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb3_shl_i_stall_local;
wire [31:0] local_bb3_shl_i;

assign local_bb3_shl_i = ((local_bb3_or_i & 32'h3FFFFF8) | 32'h4000000);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3_and35_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and35_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_and35_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and35_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_and35_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and35_i_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and35_i_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and35_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3_and35_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3_and35_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3_and35_i_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3_and35_i_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3_and35_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in((rnode_169to171_bb3_and35_i_0_NO_SHIFT_REG & 32'h80000000)),
	.data_out(rnode_171to172_bb3_and35_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3_and35_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3_and35_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb3_and35_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3_and35_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3_and35_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to171_bb3_and35_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_and35_i_0_NO_SHIFT_REG = rnode_171to172_bb3_and35_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3_and35_i_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_and35_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_or_cond_i_stall_local;
wire local_bb3_or_cond_i;

assign local_bb3_or_cond_i = (local_bb3_lnot30_i | local_bb3_cmp25_not_i);

// This section implements an unregistered operation.
// 
wire local_bb3__28_i43_stall_local;
wire [31:0] local_bb3__28_i43;

assign local_bb3__28_i43 = (rnode_167to168_bb3_lnot23_i22_0_NO_SHIFT_REG ? 32'h0 : ((local_bb3_shl65_i & 32'h7FFFFF8) | 32'h4000000));

// This section implements an unregistered operation.
// 
wire local_bb3_lnot30_not_i32_stall_local;
wire local_bb3_lnot30_not_i32;

assign local_bb3_lnot30_not_i32 = (local_bb3_lnot30_i28 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb3_shl_i41_stall_local;
wire [31:0] local_bb3_shl_i41;

assign local_bb3_shl_i41 = ((local_bb3_or_i40 & 32'h3FFFFF8) | 32'h4000000);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3_and35_i25_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and35_i25_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_and35_i25_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and35_i25_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_and35_i25_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and35_i25_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and35_i25_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and35_i25_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3_and35_i25_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3_and35_i25_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3_and35_i25_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3_and35_i25_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3_and35_i25_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in((rnode_169to171_bb3_and35_i25_0_NO_SHIFT_REG & 32'h80000000)),
	.data_out(rnode_171to172_bb3_and35_i25_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3_and35_i25_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3_and35_i25_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb3_and35_i25_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3_and35_i25_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3_and35_i25_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to171_bb3_and35_i25_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_and35_i25_0_NO_SHIFT_REG = rnode_171to172_bb3_and35_i25_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3_and35_i25_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_and35_i25_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_or_cond_i29_stall_local;
wire local_bb3_or_cond_i29;

assign local_bb3_or_cond_i29 = (local_bb3_lnot30_i28 | local_bb3_cmp25_not_i27);

// This section implements an unregistered operation.
// 
wire local_bb3_or1596_i185_stall_local;
wire [31:0] local_bb3_or1596_i185;

assign local_bb3_or1596_i185 = (local_bb3_var__u12 | (local_bb3_and142_i179 & 32'h7FFFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3__31_i167_stall_local;
wire [7:0] local_bb3__31_i167;

assign local_bb3__31_i167[7:1] = 7'h0;
assign local_bb3__31_i167[0] = local_bb3__31_v_i166;

// This section implements an unregistered operation.
// 
wire local_bb3__30_i165_stall_local;
wire [7:0] local_bb3__30_i165;

assign local_bb3__30_i165[7:1] = 7'h0;
assign local_bb3__30_i165[0] = local_bb3__30_v_i164;

// This section implements an unregistered operation.
// 
wire local_bb3__29_i163_stall_local;
wire [7:0] local_bb3__29_i163;

assign local_bb3__29_i163 = (local_bb3_cmp96_i154 ? (local_bb3_frombool74_i146 & 8'h1) : (local_bb3_frombool109_i162 & 8'h1));

// This section implements an unregistered operation.
// 
wire local_bb3__32_i168_stall_local;
wire [31:0] local_bb3__32_i168;

assign local_bb3__32_i168 = (local_bb3_cmp96_i154 ? 32'h0 : (local_bb3_or107_i161 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_and73_i_stall_local;
wire [31:0] local_bb3_and73_i;

assign local_bb3_and73_i = ((local_bb3__28_i & 32'h7FFFFF8) >> 32'h3);

// This section implements an unregistered operation.
// 
wire local_bb3_and76_i_stall_local;
wire [31:0] local_bb3_and76_i;

assign local_bb3_and76_i = ((local_bb3__28_i & 32'h7FFFFF8) & 32'hF0);

// This section implements an unregistered operation.
// 
wire local_bb3_and79_i_stall_local;
wire [31:0] local_bb3_and79_i;

assign local_bb3_and79_i = ((local_bb3__28_i & 32'h7FFFFF8) & 32'hF00);

// This section implements an unregistered operation.
// 
wire local_bb3_shr95_i_stall_local;
wire [31:0] local_bb3_shr95_i;

assign local_bb3_shr95_i = ((local_bb3__28_i & 32'h7FFFFF8) >> (rnode_167to168_bb3_and94_i_0_NO_SHIFT_REG & 32'h1C));

// This section implements an unregistered operation.
// 
wire local_bb3_and91_i_stall_local;
wire [31:0] local_bb3_and91_i;

assign local_bb3_and91_i = ((local_bb3__28_i & 32'h7FFFFF8) & 32'h7000000);

// This section implements an unregistered operation.
// 
wire local_bb3_and88_i_stall_local;
wire [31:0] local_bb3_and88_i;

assign local_bb3_and88_i = ((local_bb3__28_i & 32'h7FFFFF8) & 32'hF00000);

// This section implements an unregistered operation.
// 
wire local_bb3_and85_i_stall_local;
wire [31:0] local_bb3_and85_i;

assign local_bb3_and85_i = ((local_bb3__28_i & 32'h7FFFFF8) & 32'hF0000);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u13_stall_local;
wire [31:0] local_bb3_var__u13;

assign local_bb3_var__u13 = ((local_bb3__28_i & 32'h7FFFFF8) & 32'hFFF8);

// This section implements an unregistered operation.
// 
wire local_bb3_or_cond_not_i_stall_local;
wire local_bb3_or_cond_not_i;

assign local_bb3_or_cond_not_i = (local_bb3_cmp25_i & local_bb3_lnot30_not_i);

// This section implements an unregistered operation.
// 
wire local_bb3__27_i_stall_local;
wire [31:0] local_bb3__27_i;

assign local_bb3__27_i = (local_bb3_lnot_i ? 32'h0 : ((local_bb3_shl_i & 32'h7FFFFF8) | 32'h4000000));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_8_i_stall_local;
wire local_bb3_reduction_8_i;

assign local_bb3_reduction_8_i = (rnode_167to169_bb3_cmp27_i_1_NO_SHIFT_REG & local_bb3_or_cond_i);

// This section implements an unregistered operation.
// 
wire local_bb3_and72_i_stall_local;
wire [31:0] local_bb3_and72_i;

assign local_bb3_and72_i = ((local_bb3__28_i43 & 32'h7FFFFF8) >> 32'h3);

// This section implements an unregistered operation.
// 
wire local_bb3_and75_i_stall_local;
wire [31:0] local_bb3_and75_i;

assign local_bb3_and75_i = ((local_bb3__28_i43 & 32'h7FFFFF8) & 32'hF0);

// This section implements an unregistered operation.
// 
wire local_bb3_and78_i_stall_local;
wire [31:0] local_bb3_and78_i;

assign local_bb3_and78_i = ((local_bb3__28_i43 & 32'h7FFFFF8) & 32'hF00);

// This section implements an unregistered operation.
// 
wire local_bb3_shr94_i_stall_local;
wire [31:0] local_bb3_shr94_i;

assign local_bb3_shr94_i = ((local_bb3__28_i43 & 32'h7FFFFF8) >> (rnode_167to168_bb3_and93_i_0_NO_SHIFT_REG & 32'h1C));

// This section implements an unregistered operation.
// 
wire local_bb3_and90_i_stall_local;
wire [31:0] local_bb3_and90_i;

assign local_bb3_and90_i = ((local_bb3__28_i43 & 32'h7FFFFF8) & 32'h7000000);

// This section implements an unregistered operation.
// 
wire local_bb3_and87_i_stall_local;
wire [31:0] local_bb3_and87_i;

assign local_bb3_and87_i = ((local_bb3__28_i43 & 32'h7FFFFF8) & 32'hF00000);

// This section implements an unregistered operation.
// 
wire local_bb3_and84_i_stall_local;
wire [31:0] local_bb3_and84_i;

assign local_bb3_and84_i = ((local_bb3__28_i43 & 32'h7FFFFF8) & 32'hF0000);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u14_stall_local;
wire [31:0] local_bb3_var__u14;

assign local_bb3_var__u14 = ((local_bb3__28_i43 & 32'h7FFFFF8) & 32'hFFF8);

// This section implements an unregistered operation.
// 
wire local_bb3_or_cond_not_i33_stall_local;
wire local_bb3_or_cond_not_i33;

assign local_bb3_or_cond_not_i33 = (local_bb3_cmp25_i23 & local_bb3_lnot30_not_i32);

// This section implements an unregistered operation.
// 
wire local_bb3__27_i42_stall_local;
wire [31:0] local_bb3__27_i42;

assign local_bb3__27_i42 = (local_bb3_lnot_i21 ? 32'h0 : ((local_bb3_shl_i41 & 32'h7FFFFF8) | 32'h4000000));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_8_i37_stall_local;
wire local_bb3_reduction_8_i37;

assign local_bb3_reduction_8_i37 = (rnode_167to169_bb3_cmp27_i24_1_NO_SHIFT_REG & local_bb3_or_cond_i29);

// This section implements an unregistered operation.
// 
wire local_bb3_or162_i186_stall_local;
wire [31:0] local_bb3_or162_i186;

assign local_bb3_or162_i186 = (local_bb3_or1596_i185 & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_or1237_i171_stall_local;
wire [7:0] local_bb3_or1237_i171;

assign local_bb3_or1237_i171 = ((local_bb3__30_i165 & 8'h1) | (local_bb3__29_i163 & 8'h1));

// This section implements an unregistered operation.
// 
wire local_bb3__33_i173_stall_local;
wire [7:0] local_bb3__33_i173;

assign local_bb3__33_i173 = (local_bb3_cmp116_i170 ? (local_bb3__29_i163 & 8'h1) : (local_bb3__31_i167 & 8'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_and73_tr_i_stall_local;
wire [7:0] local_bb3_and73_tr_i;
wire [31:0] local_bb3_and73_tr_i$ps;

assign local_bb3_and73_tr_i$ps = (local_bb3_and73_i & 32'hFFFFFF);
assign local_bb3_and73_tr_i = local_bb3_and73_tr_i$ps[7:0];

// This section implements an unregistered operation.
// 
wire local_bb3_cmp77_i_stall_local;
wire local_bb3_cmp77_i;

assign local_bb3_cmp77_i = ((local_bb3_and76_i & 32'hF0) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp80_i_stall_local;
wire local_bb3_cmp80_i;

assign local_bb3_cmp80_i = ((local_bb3_and79_i & 32'hF00) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_and143_i_stall_local;
wire [31:0] local_bb3_and143_i;

assign local_bb3_and143_i = (local_bb3_shr95_i >> 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_shr151_i_stall_local;
wire [31:0] local_bb3_shr151_i;

assign local_bb3_shr151_i = (local_bb3_shr95_i >> (rnode_167to168_bb3_and150_i_0_NO_SHIFT_REG & 32'h3));

// This section implements an unregistered operation.
// 
wire local_bb3_var__u15_stall_local;
wire [31:0] local_bb3_var__u15;

assign local_bb3_var__u15 = (local_bb3_shr95_i & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_and147_i_stall_local;
wire [31:0] local_bb3_and147_i;

assign local_bb3_and147_i = (local_bb3_shr95_i >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp92_i_stall_local;
wire local_bb3_cmp92_i;

assign local_bb3_cmp92_i = ((local_bb3_and91_i & 32'h7000000) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp89_i_stall_local;
wire local_bb3_cmp89_i;

assign local_bb3_cmp89_i = ((local_bb3_and88_i & 32'hF00000) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp86_i_stall_local;
wire local_bb3_cmp86_i;

assign local_bb3_cmp86_i = ((local_bb3_and85_i & 32'hF0000) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u16_stall_local;
wire local_bb3_var__u16;

assign local_bb3_var__u16 = ((local_bb3_var__u13 & 32'hFFF8) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_and72_tr_i_stall_local;
wire [7:0] local_bb3_and72_tr_i;
wire [31:0] local_bb3_and72_tr_i$ps;

assign local_bb3_and72_tr_i$ps = (local_bb3_and72_i & 32'hFFFFFF);
assign local_bb3_and72_tr_i = local_bb3_and72_tr_i$ps[7:0];

// This section implements an unregistered operation.
// 
wire local_bb3_cmp76_i_stall_local;
wire local_bb3_cmp76_i;

assign local_bb3_cmp76_i = ((local_bb3_and75_i & 32'hF0) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp79_i_stall_local;
wire local_bb3_cmp79_i;

assign local_bb3_cmp79_i = ((local_bb3_and78_i & 32'hF00) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_and142_i_stall_local;
wire [31:0] local_bb3_and142_i;

assign local_bb3_and142_i = (local_bb3_shr94_i >> 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_shr150_i_stall_local;
wire [31:0] local_bb3_shr150_i;

assign local_bb3_shr150_i = (local_bb3_shr94_i >> (rnode_167to168_bb3_and149_i_0_NO_SHIFT_REG & 32'h3));

// This section implements an unregistered operation.
// 
wire local_bb3_var__u17_stall_local;
wire [31:0] local_bb3_var__u17;

assign local_bb3_var__u17 = (local_bb3_shr94_i & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_and146_i_stall_local;
wire [31:0] local_bb3_and146_i;

assign local_bb3_and146_i = (local_bb3_shr94_i >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp91_i_stall_local;
wire local_bb3_cmp91_i;

assign local_bb3_cmp91_i = ((local_bb3_and90_i & 32'h7000000) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp88_i_stall_local;
wire local_bb3_cmp88_i;

assign local_bb3_cmp88_i = ((local_bb3_and87_i & 32'hF00000) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp85_i_stall_local;
wire local_bb3_cmp85_i;

assign local_bb3_cmp85_i = ((local_bb3_and84_i & 32'hF0000) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u18_stall_local;
wire local_bb3_var__u18;

assign local_bb3_var__u18 = ((local_bb3_var__u14 & 32'hFFF8) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3__37_v_i187_stall_local;
wire [31:0] local_bb3__37_v_i187;

assign local_bb3__37_v_i187 = (local_bb3_Pivot20_i182 ? 32'h0 : (local_bb3_or162_i186 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_or123_i172_stall_local;
wire [31:0] local_bb3_or123_i172;

assign local_bb3_or123_i172[31:8] = 24'h0;
assign local_bb3_or123_i172[7:0] = (local_bb3_or1237_i171 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u19_stall_local;
wire [7:0] local_bb3_var__u19;

assign local_bb3_var__u19 = ((local_bb3__33_i173 & 8'h1) & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_frombool75_i_stall_local;
wire [7:0] local_bb3_frombool75_i;

assign local_bb3_frombool75_i = (local_bb3_and73_tr_i & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u20_stall_local;
wire [31:0] local_bb3_var__u20;

assign local_bb3_var__u20 = ((local_bb3_and147_i & 32'h3FFFFFFF) | local_bb3_shr95_i);

// This section implements an unregistered operation.
// 
wire local_bb3__31_v_i_stall_local;
wire local_bb3__31_v_i;

assign local_bb3__31_v_i = (local_bb3_cmp97_i ? local_bb3_cmp80_i : local_bb3_cmp92_i);

// This section implements an unregistered operation.
// 
wire local_bb3__30_v_i_stall_local;
wire local_bb3__30_v_i;

assign local_bb3__30_v_i = (local_bb3_cmp97_i ? local_bb3_cmp77_i : local_bb3_cmp89_i);

// This section implements an unregistered operation.
// 
wire local_bb3_frombool110_i_stall_local;
wire [7:0] local_bb3_frombool110_i;

assign local_bb3_frombool110_i[7:1] = 7'h0;
assign local_bb3_frombool110_i[0] = local_bb3_cmp86_i;

// This section implements an unregistered operation.
// 
wire local_bb3_or108_i_stall_local;
wire [31:0] local_bb3_or108_i;

assign local_bb3_or108_i[31:1] = 31'h0;
assign local_bb3_or108_i[0] = local_bb3_var__u16;

// This section implements an unregistered operation.
// 
wire local_bb3_frombool74_i_stall_local;
wire [7:0] local_bb3_frombool74_i;

assign local_bb3_frombool74_i = (local_bb3_and72_tr_i & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u21_stall_local;
wire [31:0] local_bb3_var__u21;

assign local_bb3_var__u21 = ((local_bb3_and146_i & 32'h3FFFFFFF) | local_bb3_shr94_i);

// This section implements an unregistered operation.
// 
wire local_bb3__31_v_i49_stall_local;
wire local_bb3__31_v_i49;

assign local_bb3__31_v_i49 = (local_bb3_cmp96_i ? local_bb3_cmp79_i : local_bb3_cmp91_i);

// This section implements an unregistered operation.
// 
wire local_bb3__30_v_i47_stall_local;
wire local_bb3__30_v_i47;

assign local_bb3__30_v_i47 = (local_bb3_cmp96_i ? local_bb3_cmp76_i : local_bb3_cmp88_i);

// This section implements an unregistered operation.
// 
wire local_bb3_frombool109_i_stall_local;
wire [7:0] local_bb3_frombool109_i;

assign local_bb3_frombool109_i[7:1] = 7'h0;
assign local_bb3_frombool109_i[0] = local_bb3_cmp85_i;

// This section implements an unregistered operation.
// 
wire local_bb3_or107_i_stall_local;
wire [31:0] local_bb3_or107_i;

assign local_bb3_or107_i[31:1] = 31'h0;
assign local_bb3_or107_i[0] = local_bb3_var__u18;

// This section implements an unregistered operation.
// 
wire local_bb3__39_v_i188_stall_local;
wire [31:0] local_bb3__39_v_i188;

assign local_bb3__39_v_i188 = (local_bb3_SwitchLeaf_i183 ? (local_bb3_var__u8 & 32'h1) : (local_bb3__37_v_i187 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_or124_i174_stall_local;
wire [31:0] local_bb3_or124_i174;

assign local_bb3_or124_i174 = (local_bb3_cmp116_i170 ? 32'h0 : (local_bb3_or123_i172 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_conv135_i176_stall_local;
wire [31:0] local_bb3_conv135_i176;

assign local_bb3_conv135_i176[31:8] = 24'h0;
assign local_bb3_conv135_i176[7:0] = (local_bb3_var__u19 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_or1606_i_stall_local;
wire [31:0] local_bb3_or1606_i;

assign local_bb3_or1606_i = (local_bb3_var__u20 | (local_bb3_and143_i & 32'h7FFFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3__31_i_stall_local;
wire [7:0] local_bb3__31_i;

assign local_bb3__31_i[7:1] = 7'h0;
assign local_bb3__31_i[0] = local_bb3__31_v_i;

// This section implements an unregistered operation.
// 
wire local_bb3__30_i_stall_local;
wire [7:0] local_bb3__30_i;

assign local_bb3__30_i[7:1] = 7'h0;
assign local_bb3__30_i[0] = local_bb3__30_v_i;

// This section implements an unregistered operation.
// 
wire local_bb3__29_i_stall_local;
wire [7:0] local_bb3__29_i;

assign local_bb3__29_i = (local_bb3_cmp97_i ? (local_bb3_frombool75_i & 8'h1) : (local_bb3_frombool110_i & 8'h1));

// This section implements an unregistered operation.
// 
wire local_bb3__32_i_stall_local;
wire [31:0] local_bb3__32_i;

assign local_bb3__32_i = (local_bb3_cmp97_i ? 32'h0 : (local_bb3_or108_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_or1596_i_stall_local;
wire [31:0] local_bb3_or1596_i;

assign local_bb3_or1596_i = (local_bb3_var__u21 | (local_bb3_and142_i & 32'h7FFFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3__31_i50_stall_local;
wire [7:0] local_bb3__31_i50;

assign local_bb3__31_i50[7:1] = 7'h0;
assign local_bb3__31_i50[0] = local_bb3__31_v_i49;

// This section implements an unregistered operation.
// 
wire local_bb3__30_i48_stall_local;
wire [7:0] local_bb3__30_i48;

assign local_bb3__30_i48[7:1] = 7'h0;
assign local_bb3__30_i48[0] = local_bb3__30_v_i47;

// This section implements an unregistered operation.
// 
wire local_bb3__29_i46_stall_local;
wire [7:0] local_bb3__29_i46;

assign local_bb3__29_i46 = (local_bb3_cmp96_i ? (local_bb3_frombool74_i & 8'h1) : (local_bb3_frombool109_i & 8'h1));

// This section implements an unregistered operation.
// 
wire local_bb3__32_i51_stall_local;
wire [31:0] local_bb3__32_i51;

assign local_bb3__32_i51 = (local_bb3_cmp96_i ? 32'h0 : (local_bb3_or107_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_3_i189_stall_local;
wire [31:0] local_bb3_reduction_3_i189;

assign local_bb3_reduction_3_i189 = ((local_bb3__32_i168 & 32'h1) | (local_bb3_or124_i174 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_or136_i178_stall_local;
wire [31:0] local_bb3_or136_i178;

assign local_bb3_or136_i178 = (local_bb3_cmp131_not_i177 ? (local_bb3_conv135_i176 & 32'h1) : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_or163_i_stall_local;
wire [31:0] local_bb3_or163_i;

assign local_bb3_or163_i = (local_bb3_or1606_i & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_or1247_i_stall_local;
wire [7:0] local_bb3_or1247_i;

assign local_bb3_or1247_i = ((local_bb3__30_i & 8'h1) | (local_bb3__29_i & 8'h1));

// This section implements an unregistered operation.
// 
wire local_bb3__33_i_stall_local;
wire [7:0] local_bb3__33_i;

assign local_bb3__33_i = (local_bb3_cmp117_i ? (local_bb3__29_i & 8'h1) : (local_bb3__31_i & 8'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_or162_i_stall_local;
wire [31:0] local_bb3_or162_i;

assign local_bb3_or162_i = (local_bb3_or1596_i & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_or1237_i_stall_local;
wire [7:0] local_bb3_or1237_i;

assign local_bb3_or1237_i = ((local_bb3__30_i48 & 8'h1) | (local_bb3__29_i46 & 8'h1));

// This section implements an unregistered operation.
// 
wire local_bb3__33_i52_stall_local;
wire [7:0] local_bb3__33_i52;

assign local_bb3__33_i52 = (local_bb3_cmp116_i ? (local_bb3__29_i46 & 8'h1) : (local_bb3__31_i50 & 8'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_5_i191_stall_local;
wire [31:0] local_bb3_reduction_5_i191;

assign local_bb3_reduction_5_i191 = (local_bb3_shr150_i181 | (local_bb3_reduction_3_i189 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_4_i190_stall_local;
wire [31:0] local_bb3_reduction_4_i190;

assign local_bb3_reduction_4_i190 = ((local_bb3_or136_i178 & 32'h1) | (local_bb3__39_v_i188 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3__37_v_i_stall_local;
wire [31:0] local_bb3__37_v_i;

assign local_bb3__37_v_i = (local_bb3_Pivot20_i ? 32'h0 : (local_bb3_or163_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_or124_i_stall_local;
wire [31:0] local_bb3_or124_i;

assign local_bb3_or124_i[31:8] = 24'h0;
assign local_bb3_or124_i[7:0] = (local_bb3_or1247_i & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u22_stall_local;
wire [7:0] local_bb3_var__u22;

assign local_bb3_var__u22 = ((local_bb3__33_i & 8'h1) & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb3__37_v_i56_stall_local;
wire [31:0] local_bb3__37_v_i56;

assign local_bb3__37_v_i56 = (local_bb3_Pivot20_i54 ? 32'h0 : (local_bb3_or162_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_or123_i_stall_local;
wire [31:0] local_bb3_or123_i;

assign local_bb3_or123_i[31:8] = 24'h0;
assign local_bb3_or123_i[7:0] = (local_bb3_or1237_i & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u23_stall_local;
wire [7:0] local_bb3_var__u23;

assign local_bb3_var__u23 = ((local_bb3__33_i52 & 8'h1) & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_6_i192_stall_local;
wire [31:0] local_bb3_reduction_6_i192;

assign local_bb3_reduction_6_i192 = ((local_bb3_reduction_4_i190 & 32'h1) | local_bb3_reduction_5_i191);

// This section implements an unregistered operation.
// 
wire local_bb3__39_v_i_stall_local;
wire [31:0] local_bb3__39_v_i;

assign local_bb3__39_v_i = (local_bb3_SwitchLeaf_i ? (local_bb3_var__u15 & 32'h1) : (local_bb3__37_v_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_or125_i_stall_local;
wire [31:0] local_bb3_or125_i;

assign local_bb3_or125_i = (local_bb3_cmp117_i ? 32'h0 : (local_bb3_or124_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_conv136_i_stall_local;
wire [31:0] local_bb3_conv136_i;

assign local_bb3_conv136_i[31:8] = 24'h0;
assign local_bb3_conv136_i[7:0] = (local_bb3_var__u22 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb3__39_v_i57_stall_local;
wire [31:0] local_bb3__39_v_i57;

assign local_bb3__39_v_i57 = (local_bb3_SwitchLeaf_i55 ? (local_bb3_var__u17 & 32'h1) : (local_bb3__37_v_i56 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_or124_i53_stall_local;
wire [31:0] local_bb3_or124_i53;

assign local_bb3_or124_i53 = (local_bb3_cmp116_i ? 32'h0 : (local_bb3_or123_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_conv135_i_stall_local;
wire [31:0] local_bb3_conv135_i;

assign local_bb3_conv135_i[31:8] = 24'h0;
assign local_bb3_conv135_i[7:0] = (local_bb3_var__u23 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot33_not_i124_valid_out;
wire local_bb3_lnot33_not_i124_stall_in;
wire local_bb3_cmp37_i120_valid_out;
wire local_bb3_cmp37_i120_stall_in;
wire local_bb3_and36_lobit_i195_valid_out;
wire local_bb3_and36_lobit_i195_stall_in;
wire local_bb3_xor188_i194_valid_out;
wire local_bb3_xor188_i194_stall_in;
wire local_bb3_xor188_i194_inputs_ready;
wire local_bb3_xor188_i194_stall_local;
wire [31:0] local_bb3_xor188_i194;

assign local_bb3_xor188_i194_inputs_ready = (rnode_169to170_bb3__22_i106_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb3_lnot23_i115_0_valid_out_NO_SHIFT_REG & rnode_169to170_bb3_align_0_i143_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb3_align_0_i143_0_valid_out_4_NO_SHIFT_REG & rnode_169to170_bb3_align_0_i143_0_valid_out_1_NO_SHIFT_REG & rnode_169to170_bb3_align_0_i143_0_valid_out_2_NO_SHIFT_REG & rnode_169to170_bb3_align_0_i143_0_valid_out_3_NO_SHIFT_REG & rnode_169to170_bb3__23_i107_0_valid_out_2_NO_SHIFT_REG & rnode_169to170_bb3__22_i106_0_valid_out_1_NO_SHIFT_REG);
assign local_bb3_xor188_i194 = (local_bb3_reduction_6_i192 ^ local_bb3_xor_lobit_i193);
assign local_bb3_lnot33_not_i124_valid_out = 1'b1;
assign local_bb3_cmp37_i120_valid_out = 1'b1;
assign local_bb3_and36_lobit_i195_valid_out = 1'b1;
assign local_bb3_xor188_i194_valid_out = 1'b1;
assign rnode_169to170_bb3__22_i106_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3_lnot23_i115_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3_align_0_i143_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3_align_0_i143_0_stall_in_4_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3_align_0_i143_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3_align_0_i143_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3_align_0_i143_0_stall_in_3_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3__23_i107_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3__22_i106_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_3_i_stall_local;
wire [31:0] local_bb3_reduction_3_i;

assign local_bb3_reduction_3_i = ((local_bb3__32_i & 32'h1) | (local_bb3_or125_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_or137_i_stall_local;
wire [31:0] local_bb3_or137_i;

assign local_bb3_or137_i = (local_bb3_cmp132_not_i ? (local_bb3_conv136_i & 32'h1) : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_3_i58_stall_local;
wire [31:0] local_bb3_reduction_3_i58;

assign local_bb3_reduction_3_i58 = ((local_bb3__32_i51 & 32'h1) | (local_bb3_or124_i53 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_or136_i_stall_local;
wire [31:0] local_bb3_or136_i;

assign local_bb3_or136_i = (local_bb3_cmp131_not_i ? (local_bb3_conv135_i & 32'h1) : 32'h0);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3_lnot33_not_i124_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb3_lnot33_not_i124_0_stall_in_NO_SHIFT_REG;
 logic rnode_170to171_bb3_lnot33_not_i124_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_lnot33_not_i124_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to171_bb3_lnot33_not_i124_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_lnot33_not_i124_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_lnot33_not_i124_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_lnot33_not_i124_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3_lnot33_not_i124_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3_lnot33_not_i124_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3_lnot33_not_i124_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3_lnot33_not_i124_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3_lnot33_not_i124_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb3_lnot33_not_i124),
	.data_out(rnode_170to171_bb3_lnot33_not_i124_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3_lnot33_not_i124_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3_lnot33_not_i124_0_reg_171_fifo.DATA_WIDTH = 1;
defparam rnode_170to171_bb3_lnot33_not_i124_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3_lnot33_not_i124_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3_lnot33_not_i124_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_lnot33_not_i124_stall_in = 1'b0;
assign rnode_170to171_bb3_lnot33_not_i124_0_NO_SHIFT_REG = rnode_170to171_bb3_lnot33_not_i124_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_lnot33_not_i124_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_lnot33_not_i124_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3_cmp37_i120_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_cmp37_i120_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_cmp37_i120_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_cmp37_i120_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_170to171_bb3_cmp37_i120_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_170to171_bb3_cmp37_i120_1_NO_SHIFT_REG;
 logic rnode_170to171_bb3_cmp37_i120_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to171_bb3_cmp37_i120_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_cmp37_i120_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_cmp37_i120_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_cmp37_i120_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3_cmp37_i120_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3_cmp37_i120_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3_cmp37_i120_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3_cmp37_i120_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3_cmp37_i120_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb3_cmp37_i120),
	.data_out(rnode_170to171_bb3_cmp37_i120_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3_cmp37_i120_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3_cmp37_i120_0_reg_171_fifo.DATA_WIDTH = 1;
defparam rnode_170to171_bb3_cmp37_i120_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3_cmp37_i120_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3_cmp37_i120_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_cmp37_i120_stall_in = 1'b0;
assign rnode_170to171_bb3_cmp37_i120_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_cmp37_i120_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3_cmp37_i120_0_NO_SHIFT_REG = rnode_170to171_bb3_cmp37_i120_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_cmp37_i120_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3_cmp37_i120_1_NO_SHIFT_REG = rnode_170to171_bb3_cmp37_i120_0_reg_171_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3_and36_lobit_i195_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and36_lobit_i195_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and36_lobit_i195_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and36_lobit_i195_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and36_lobit_i195_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and36_lobit_i195_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and36_lobit_i195_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and36_lobit_i195_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3_and36_lobit_i195_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3_and36_lobit_i195_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3_and36_lobit_i195_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3_and36_lobit_i195_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3_and36_lobit_i195_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((local_bb3_and36_lobit_i195 & 32'h1)),
	.data_out(rnode_170to171_bb3_and36_lobit_i195_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3_and36_lobit_i195_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3_and36_lobit_i195_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_170to171_bb3_and36_lobit_i195_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3_and36_lobit_i195_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3_and36_lobit_i195_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and36_lobit_i195_stall_in = 1'b0;
assign rnode_170to171_bb3_and36_lobit_i195_0_NO_SHIFT_REG = rnode_170to171_bb3_and36_lobit_i195_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_and36_lobit_i195_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and36_lobit_i195_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3_xor188_i194_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb3_xor188_i194_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_xor188_i194_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_xor188_i194_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_xor188_i194_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_xor188_i194_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_xor188_i194_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_xor188_i194_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3_xor188_i194_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3_xor188_i194_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3_xor188_i194_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3_xor188_i194_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3_xor188_i194_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb3_xor188_i194),
	.data_out(rnode_170to171_bb3_xor188_i194_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3_xor188_i194_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3_xor188_i194_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_170to171_bb3_xor188_i194_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3_xor188_i194_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3_xor188_i194_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_xor188_i194_stall_in = 1'b0;
assign rnode_170to171_bb3_xor188_i194_0_NO_SHIFT_REG = rnode_170to171_bb3_xor188_i194_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_xor188_i194_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_xor188_i194_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_5_i_stall_local;
wire [31:0] local_bb3_reduction_5_i;

assign local_bb3_reduction_5_i = (local_bb3_shr151_i | (local_bb3_reduction_3_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_4_i_stall_local;
wire [31:0] local_bb3_reduction_4_i;

assign local_bb3_reduction_4_i = ((local_bb3_or137_i & 32'h1) | (local_bb3__39_v_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_5_i60_stall_local;
wire [31:0] local_bb3_reduction_5_i60;

assign local_bb3_reduction_5_i60 = (local_bb3_shr150_i | (local_bb3_reduction_3_i58 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_4_i59_stall_local;
wire [31:0] local_bb3_reduction_4_i59;

assign local_bb3_reduction_4_i59 = ((local_bb3_or136_i & 32'h1) | (local_bb3__39_v_i57 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_brmerge_not_i125_stall_local;
wire local_bb3_brmerge_not_i125;

assign local_bb3_brmerge_not_i125 = (rnode_169to171_bb3_cmp27_i117_0_NO_SHIFT_REG & rnode_170to171_bb3_lnot33_not_i124_0_NO_SHIFT_REG);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_171to173_bb3_cmp37_i120_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to173_bb3_cmp37_i120_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_171to173_bb3_cmp37_i120_0_NO_SHIFT_REG;
 logic rnode_171to173_bb3_cmp37_i120_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to173_bb3_cmp37_i120_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_171to173_bb3_cmp37_i120_1_NO_SHIFT_REG;
 logic rnode_171to173_bb3_cmp37_i120_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_171to173_bb3_cmp37_i120_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_171to173_bb3_cmp37_i120_2_NO_SHIFT_REG;
 logic rnode_171to173_bb3_cmp37_i120_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_171to173_bb3_cmp37_i120_0_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_cmp37_i120_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_cmp37_i120_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_cmp37_i120_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_171to173_bb3_cmp37_i120_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to173_bb3_cmp37_i120_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to173_bb3_cmp37_i120_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_171to173_bb3_cmp37_i120_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_171to173_bb3_cmp37_i120_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(rnode_170to171_bb3_cmp37_i120_1_NO_SHIFT_REG),
	.data_out(rnode_171to173_bb3_cmp37_i120_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_171to173_bb3_cmp37_i120_0_reg_173_fifo.DEPTH = 2;
defparam rnode_171to173_bb3_cmp37_i120_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_171to173_bb3_cmp37_i120_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to173_bb3_cmp37_i120_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_171to173_bb3_cmp37_i120_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3_cmp37_i120_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_171to173_bb3_cmp37_i120_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_171to173_bb3_cmp37_i120_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to173_bb3_cmp37_i120_0_NO_SHIFT_REG = rnode_171to173_bb3_cmp37_i120_0_reg_173_NO_SHIFT_REG;
assign rnode_171to173_bb3_cmp37_i120_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to173_bb3_cmp37_i120_1_NO_SHIFT_REG = rnode_171to173_bb3_cmp37_i120_0_reg_173_NO_SHIFT_REG;
assign rnode_171to173_bb3_cmp37_i120_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_171to173_bb3_cmp37_i120_2_NO_SHIFT_REG = rnode_171to173_bb3_cmp37_i120_0_reg_173_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_add_i196_stall_local;
wire [31:0] local_bb3_add_i196;

assign local_bb3_add_i196 = ((local_bb3__27_i136 & 32'h7FFFFF8) | (rnode_170to171_bb3_and36_lobit_i195_0_NO_SHIFT_REG & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_6_i_stall_local;
wire [31:0] local_bb3_reduction_6_i;

assign local_bb3_reduction_6_i = ((local_bb3_reduction_4_i & 32'h1) | local_bb3_reduction_5_i);

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_6_i61_stall_local;
wire [31:0] local_bb3_reduction_6_i61;

assign local_bb3_reduction_6_i61 = ((local_bb3_reduction_4_i59 & 32'h1) | local_bb3_reduction_5_i60);

// This section implements an unregistered operation.
// 
wire local_bb3__24_i128_stall_local;
wire local_bb3__24_i128;

assign local_bb3__24_i128 = (local_bb3_or_cond_not_i127 | local_bb3_brmerge_not_i125);

// This section implements an unregistered operation.
// 
wire local_bb3_brmerge_not_not_i129_stall_local;
wire local_bb3_brmerge_not_not_i129;

assign local_bb3_brmerge_not_not_i129 = (local_bb3_brmerge_not_i125 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb3_not_cmp37_i226_stall_local;
wire local_bb3_not_cmp37_i226;

assign local_bb3_not_cmp37_i226 = (rnode_171to173_bb3_cmp37_i120_1_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb3_add192_i197_stall_local;
wire [31:0] local_bb3_add192_i197;

assign local_bb3_add192_i197 = ((local_bb3_add_i196 & 32'h7FFFFF9) + rnode_170to171_bb3_xor188_i194_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot33_not_i_valid_out;
wire local_bb3_lnot33_not_i_stall_in;
wire local_bb3_cmp38_i_valid_out;
wire local_bb3_cmp38_i_stall_in;
wire local_bb3_and37_lobit_i_valid_out;
wire local_bb3_and37_lobit_i_stall_in;
wire local_bb3_xor189_i_valid_out;
wire local_bb3_xor189_i_stall_in;
wire local_bb3_xor189_i_inputs_ready;
wire local_bb3_xor189_i_stall_local;
wire [31:0] local_bb3_xor189_i;

assign local_bb3_xor189_i_inputs_ready = (rnode_167to168_bb3__22_i_0_valid_out_0_NO_SHIFT_REG & rnode_167to168_bb3_lnot23_i_0_valid_out_NO_SHIFT_REG & rnode_167to168_bb3_and94_i_0_valid_out_NO_SHIFT_REG & rnode_167to168_bb3_and150_i_0_valid_out_0_NO_SHIFT_REG & rnode_167to168_bb3_and96_i_0_valid_out_NO_SHIFT_REG & rnode_167to168_bb3_and150_i_0_valid_out_2_NO_SHIFT_REG & rnode_167to168_bb3_and116_i_0_valid_out_NO_SHIFT_REG & rnode_167to168_bb3_and131_i_0_valid_out_NO_SHIFT_REG & rnode_167to168_bb3_and150_i_0_valid_out_1_NO_SHIFT_REG & rnode_167to168_bb3__23_i_0_valid_out_2_NO_SHIFT_REG & rnode_167to168_bb3__22_i_0_valid_out_1_NO_SHIFT_REG);
assign local_bb3_xor189_i = (local_bb3_reduction_6_i ^ local_bb3_xor36_lobit_i);
assign local_bb3_lnot33_not_i_valid_out = 1'b1;
assign local_bb3_cmp38_i_valid_out = 1'b1;
assign local_bb3_and37_lobit_i_valid_out = 1'b1;
assign local_bb3_xor189_i_valid_out = 1'b1;
assign rnode_167to168_bb3__22_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_lnot23_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and94_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and150_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and96_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and150_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and116_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and131_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and150_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3__23_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3__22_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_lnot33_not_i30_valid_out;
wire local_bb3_lnot33_not_i30_stall_in;
wire local_bb3_cmp37_i_valid_out;
wire local_bb3_cmp37_i_stall_in;
wire local_bb3_and36_lobit_i_valid_out;
wire local_bb3_and36_lobit_i_stall_in;
wire local_bb3_xor188_i_valid_out;
wire local_bb3_xor188_i_stall_in;
wire local_bb3_xor188_i_inputs_ready;
wire local_bb3_xor188_i_stall_local;
wire [31:0] local_bb3_xor188_i;

assign local_bb3_xor188_i_inputs_ready = (rnode_167to168_bb3__22_i13_0_valid_out_0_NO_SHIFT_REG & rnode_167to168_bb3_lnot23_i22_0_valid_out_NO_SHIFT_REG & rnode_167to168_bb3_and93_i_0_valid_out_NO_SHIFT_REG & rnode_167to168_bb3_and149_i_0_valid_out_0_NO_SHIFT_REG & rnode_167to168_bb3_and95_i_0_valid_out_NO_SHIFT_REG & rnode_167to168_bb3_and149_i_0_valid_out_2_NO_SHIFT_REG & rnode_167to168_bb3_and115_i_0_valid_out_NO_SHIFT_REG & rnode_167to168_bb3_and130_i_0_valid_out_NO_SHIFT_REG & rnode_167to168_bb3_and149_i_0_valid_out_1_NO_SHIFT_REG & rnode_167to168_bb3__23_i14_0_valid_out_2_NO_SHIFT_REG & rnode_167to168_bb3__22_i13_0_valid_out_1_NO_SHIFT_REG);
assign local_bb3_xor188_i = (local_bb3_reduction_6_i61 ^ local_bb3_xor_lobit_i);
assign local_bb3_lnot33_not_i30_valid_out = 1'b1;
assign local_bb3_cmp37_i_valid_out = 1'b1;
assign local_bb3_and36_lobit_i_valid_out = 1'b1;
assign local_bb3_xor188_i_valid_out = 1'b1;
assign rnode_167to168_bb3__22_i13_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_lnot23_i22_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and93_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and149_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and95_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and149_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and115_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and130_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3_and149_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3__23_i14_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb3__22_i13_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_7_i130_stall_local;
wire local_bb3_reduction_7_i130;

assign local_bb3_reduction_7_i130 = (local_bb3_cmp25_i116 & local_bb3_brmerge_not_not_i129);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_lnot33_not_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb3_lnot33_not_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_168to169_bb3_lnot33_not_i_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_lnot33_not_i_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb3_lnot33_not_i_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_lnot33_not_i_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_lnot33_not_i_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_lnot33_not_i_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_lnot33_not_i_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_lnot33_not_i_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_lnot33_not_i_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_lnot33_not_i_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_lnot33_not_i_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb3_lnot33_not_i),
	.data_out(rnode_168to169_bb3_lnot33_not_i_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_lnot33_not_i_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_lnot33_not_i_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb3_lnot33_not_i_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_lnot33_not_i_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_lnot33_not_i_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_lnot33_not_i_stall_in = 1'b0;
assign rnode_168to169_bb3_lnot33_not_i_0_NO_SHIFT_REG = rnode_168to169_bb3_lnot33_not_i_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_lnot33_not_i_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_lnot33_not_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_cmp38_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp38_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp38_i_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp38_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp38_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp38_i_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp38_i_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp38_i_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp38_i_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp38_i_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp38_i_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_cmp38_i_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_cmp38_i_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_cmp38_i_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_cmp38_i_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_cmp38_i_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb3_cmp38_i),
	.data_out(rnode_168to169_bb3_cmp38_i_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_cmp38_i_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_cmp38_i_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb3_cmp38_i_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_cmp38_i_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_cmp38_i_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_cmp38_i_stall_in = 1'b0;
assign rnode_168to169_bb3_cmp38_i_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_cmp38_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_cmp38_i_0_NO_SHIFT_REG = rnode_168to169_bb3_cmp38_i_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_cmp38_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_cmp38_i_1_NO_SHIFT_REG = rnode_168to169_bb3_cmp38_i_0_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_and37_lobit_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and37_lobit_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_and37_lobit_i_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and37_lobit_i_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_and37_lobit_i_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and37_lobit_i_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and37_lobit_i_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and37_lobit_i_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_and37_lobit_i_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_and37_lobit_i_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_and37_lobit_i_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_and37_lobit_i_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_and37_lobit_i_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in((local_bb3_and37_lobit_i & 32'h1)),
	.data_out(rnode_168to169_bb3_and37_lobit_i_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_and37_lobit_i_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_and37_lobit_i_0_reg_169_fifo.DATA_WIDTH = 32;
defparam rnode_168to169_bb3_and37_lobit_i_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_and37_lobit_i_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_and37_lobit_i_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and37_lobit_i_stall_in = 1'b0;
assign rnode_168to169_bb3_and37_lobit_i_0_NO_SHIFT_REG = rnode_168to169_bb3_and37_lobit_i_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_and37_lobit_i_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_and37_lobit_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_xor189_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb3_xor189_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_xor189_i_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_xor189_i_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_xor189_i_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_xor189_i_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_xor189_i_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_xor189_i_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_xor189_i_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_xor189_i_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_xor189_i_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_xor189_i_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_xor189_i_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb3_xor189_i),
	.data_out(rnode_168to169_bb3_xor189_i_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_xor189_i_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_xor189_i_0_reg_169_fifo.DATA_WIDTH = 32;
defparam rnode_168to169_bb3_xor189_i_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_xor189_i_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_xor189_i_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_xor189_i_stall_in = 1'b0;
assign rnode_168to169_bb3_xor189_i_0_NO_SHIFT_REG = rnode_168to169_bb3_xor189_i_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_xor189_i_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_xor189_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_lnot33_not_i30_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb3_lnot33_not_i30_0_stall_in_NO_SHIFT_REG;
 logic rnode_168to169_bb3_lnot33_not_i30_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_lnot33_not_i30_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb3_lnot33_not_i30_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_lnot33_not_i30_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_lnot33_not_i30_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_lnot33_not_i30_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_lnot33_not_i30_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_lnot33_not_i30_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_lnot33_not_i30_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_lnot33_not_i30_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_lnot33_not_i30_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb3_lnot33_not_i30),
	.data_out(rnode_168to169_bb3_lnot33_not_i30_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_lnot33_not_i30_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_lnot33_not_i30_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb3_lnot33_not_i30_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_lnot33_not_i30_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_lnot33_not_i30_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_lnot33_not_i30_stall_in = 1'b0;
assign rnode_168to169_bb3_lnot33_not_i30_0_NO_SHIFT_REG = rnode_168to169_bb3_lnot33_not_i30_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_lnot33_not_i30_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_lnot33_not_i30_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_cmp37_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp37_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp37_i_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp37_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp37_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp37_i_1_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp37_i_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp37_i_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp37_i_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp37_i_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_cmp37_i_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_cmp37_i_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_cmp37_i_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_cmp37_i_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_cmp37_i_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_cmp37_i_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb3_cmp37_i),
	.data_out(rnode_168to169_bb3_cmp37_i_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_cmp37_i_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_cmp37_i_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb3_cmp37_i_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_cmp37_i_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_cmp37_i_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_cmp37_i_stall_in = 1'b0;
assign rnode_168to169_bb3_cmp37_i_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_cmp37_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_cmp37_i_0_NO_SHIFT_REG = rnode_168to169_bb3_cmp37_i_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_cmp37_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_cmp37_i_1_NO_SHIFT_REG = rnode_168to169_bb3_cmp37_i_0_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_and36_lobit_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and36_lobit_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_and36_lobit_i_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and36_lobit_i_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_and36_lobit_i_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and36_lobit_i_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and36_lobit_i_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_and36_lobit_i_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_and36_lobit_i_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_and36_lobit_i_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_and36_lobit_i_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_and36_lobit_i_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_and36_lobit_i_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in((local_bb3_and36_lobit_i & 32'h1)),
	.data_out(rnode_168to169_bb3_and36_lobit_i_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_and36_lobit_i_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_and36_lobit_i_0_reg_169_fifo.DATA_WIDTH = 32;
defparam rnode_168to169_bb3_and36_lobit_i_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_and36_lobit_i_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_and36_lobit_i_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and36_lobit_i_stall_in = 1'b0;
assign rnode_168to169_bb3_and36_lobit_i_0_NO_SHIFT_REG = rnode_168to169_bb3_and36_lobit_i_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_and36_lobit_i_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_and36_lobit_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb3_xor188_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb3_xor188_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_xor188_i_0_NO_SHIFT_REG;
 logic rnode_168to169_bb3_xor188_i_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb3_xor188_i_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_xor188_i_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_xor188_i_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb3_xor188_i_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb3_xor188_i_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb3_xor188_i_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb3_xor188_i_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb3_xor188_i_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb3_xor188_i_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb3_xor188_i),
	.data_out(rnode_168to169_bb3_xor188_i_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb3_xor188_i_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb3_xor188_i_0_reg_169_fifo.DATA_WIDTH = 32;
defparam rnode_168to169_bb3_xor188_i_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb3_xor188_i_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb3_xor188_i_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_xor188_i_stall_in = 1'b0;
assign rnode_168to169_bb3_xor188_i_0_NO_SHIFT_REG = rnode_168to169_bb3_xor188_i_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb3_xor188_i_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_xor188_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_9_i132_stall_local;
wire local_bb3_reduction_9_i132;

assign local_bb3_reduction_9_i132 = (local_bb3_reduction_7_i130 & local_bb3_reduction_8_i131);

// This section implements an unregistered operation.
// 
wire local_bb3_brmerge_not_i_stall_local;
wire local_bb3_brmerge_not_i;

assign local_bb3_brmerge_not_i = (rnode_167to169_bb3_cmp27_i_0_NO_SHIFT_REG & rnode_168to169_bb3_lnot33_not_i_0_NO_SHIFT_REG);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb3_cmp38_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp38_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp38_i_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp38_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp38_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp38_i_1_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp38_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp38_i_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp38_i_2_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp38_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp38_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp38_i_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp38_i_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp38_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb3_cmp38_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb3_cmp38_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb3_cmp38_i_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb3_cmp38_i_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb3_cmp38_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_168to169_bb3_cmp38_i_1_NO_SHIFT_REG),
	.data_out(rnode_169to171_bb3_cmp38_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb3_cmp38_i_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb3_cmp38_i_0_reg_171_fifo.DATA_WIDTH = 1;
defparam rnode_169to171_bb3_cmp38_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb3_cmp38_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb3_cmp38_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_cmp38_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_cmp38_i_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_cmp38_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to171_bb3_cmp38_i_0_NO_SHIFT_REG = rnode_169to171_bb3_cmp38_i_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb3_cmp38_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to171_bb3_cmp38_i_1_NO_SHIFT_REG = rnode_169to171_bb3_cmp38_i_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb3_cmp38_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_169to171_bb3_cmp38_i_2_NO_SHIFT_REG = rnode_169to171_bb3_cmp38_i_0_reg_171_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_add_i_stall_local;
wire [31:0] local_bb3_add_i;

assign local_bb3_add_i = ((local_bb3__27_i & 32'h7FFFFF8) | (rnode_168to169_bb3_and37_lobit_i_0_NO_SHIFT_REG & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_brmerge_not_i31_stall_local;
wire local_bb3_brmerge_not_i31;

assign local_bb3_brmerge_not_i31 = (rnode_167to169_bb3_cmp27_i24_0_NO_SHIFT_REG & rnode_168to169_bb3_lnot33_not_i30_0_NO_SHIFT_REG);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb3_cmp37_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp37_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp37_i_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp37_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp37_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp37_i_1_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp37_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp37_i_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp37_i_2_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp37_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp37_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp37_i_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp37_i_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_cmp37_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb3_cmp37_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb3_cmp37_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb3_cmp37_i_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb3_cmp37_i_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb3_cmp37_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_168to169_bb3_cmp37_i_1_NO_SHIFT_REG),
	.data_out(rnode_169to171_bb3_cmp37_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb3_cmp37_i_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb3_cmp37_i_0_reg_171_fifo.DATA_WIDTH = 1;
defparam rnode_169to171_bb3_cmp37_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb3_cmp37_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb3_cmp37_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb3_cmp37_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_cmp37_i_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_cmp37_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to171_bb3_cmp37_i_0_NO_SHIFT_REG = rnode_169to171_bb3_cmp37_i_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb3_cmp37_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to171_bb3_cmp37_i_1_NO_SHIFT_REG = rnode_169to171_bb3_cmp37_i_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb3_cmp37_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_169to171_bb3_cmp37_i_2_NO_SHIFT_REG = rnode_169to171_bb3_cmp37_i_0_reg_171_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_add_i62_stall_local;
wire [31:0] local_bb3_add_i62;

assign local_bb3_add_i62 = ((local_bb3__27_i42 & 32'h7FFFFF8) | (rnode_168to169_bb3_and36_lobit_i_0_NO_SHIFT_REG & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_and17_i109_valid_out_2;
wire local_bb3_and17_i109_stall_in_2;
wire local_bb3_var__u6_valid_out;
wire local_bb3_var__u6_stall_in;
wire local_bb3_add192_i197_valid_out;
wire local_bb3_add192_i197_stall_in;
wire local_bb3__26_i133_valid_out;
wire local_bb3__26_i133_stall_in;
wire local_bb3__26_i133_inputs_ready;
wire local_bb3__26_i133_stall_local;
wire local_bb3__26_i133;

assign local_bb3__26_i133_inputs_ready = (rnode_169to171_bb3_shr16_i108_0_valid_out_0_NO_SHIFT_REG & rnode_169to171_bb3_cmp27_i117_0_valid_out_2_NO_SHIFT_REG & rnode_170to171_bb3_and36_lobit_i195_0_valid_out_NO_SHIFT_REG & rnode_170to171_bb3_xor188_i194_0_valid_out_NO_SHIFT_REG & rnode_170to171_bb3_and20_i112_0_valid_out_0_NO_SHIFT_REG & rnode_169to171_bb3_cmp27_i117_0_valid_out_0_NO_SHIFT_REG & rnode_170to171_bb3_lnot33_not_i124_0_valid_out_NO_SHIFT_REG & rnode_169to171_bb3_cmp27_i117_0_valid_out_1_NO_SHIFT_REG & rnode_170to171_bb3_and20_i112_0_valid_out_1_NO_SHIFT_REG & rnode_170to171_bb3_cmp37_i120_0_valid_out_0_NO_SHIFT_REG);
assign local_bb3__26_i133 = (local_bb3_reduction_9_i132 ? rnode_170to171_bb3_cmp37_i120_0_NO_SHIFT_REG : local_bb3__24_i128);
assign local_bb3_and17_i109_valid_out_2 = 1'b1;
assign local_bb3_var__u6_valid_out = 1'b1;
assign local_bb3_add192_i197_valid_out = 1'b1;
assign local_bb3__26_i133_valid_out = 1'b1;
assign rnode_169to171_bb3_shr16_i108_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_cmp27_i117_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and36_lobit_i195_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_xor188_i194_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and20_i112_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_cmp27_i117_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_lnot33_not_i124_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_cmp27_i117_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and20_i112_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_cmp37_i120_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3__24_i_stall_local;
wire local_bb3__24_i;

assign local_bb3__24_i = (local_bb3_or_cond_not_i | local_bb3_brmerge_not_i);

// This section implements an unregistered operation.
// 
wire local_bb3_brmerge_not_not_i_stall_local;
wire local_bb3_brmerge_not_not_i;

assign local_bb3_brmerge_not_not_i = (local_bb3_brmerge_not_i ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb3_not_cmp38_i_stall_local;
wire local_bb3_not_cmp38_i;

assign local_bb3_not_cmp38_i = (rnode_169to171_bb3_cmp38_i_1_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb3_add193_i_stall_local;
wire [31:0] local_bb3_add193_i;

assign local_bb3_add193_i = ((local_bb3_add_i & 32'h7FFFFF9) + rnode_168to169_bb3_xor189_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3__24_i34_stall_local;
wire local_bb3__24_i34;

assign local_bb3__24_i34 = (local_bb3_or_cond_not_i33 | local_bb3_brmerge_not_i31);

// This section implements an unregistered operation.
// 
wire local_bb3_brmerge_not_not_i35_stall_local;
wire local_bb3_brmerge_not_not_i35;

assign local_bb3_brmerge_not_not_i35 = (local_bb3_brmerge_not_i31 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb3_not_cmp37_i_stall_local;
wire local_bb3_not_cmp37_i;

assign local_bb3_not_cmp37_i = (rnode_169to171_bb3_cmp37_i_1_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb3_add192_i_stall_local;
wire [31:0] local_bb3_add192_i;

assign local_bb3_add192_i = ((local_bb3_add_i62 & 32'h7FFFFF9) + rnode_168to169_bb3_xor188_i_0_NO_SHIFT_REG);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_171to173_bb3_and17_i109_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and17_i109_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to173_bb3_and17_i109_0_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and17_i109_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to173_bb3_and17_i109_0_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and17_i109_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and17_i109_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and17_i109_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_171to173_bb3_and17_i109_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to173_bb3_and17_i109_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to173_bb3_and17_i109_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_171to173_bb3_and17_i109_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_171to173_bb3_and17_i109_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in((local_bb3_and17_i109 & 32'hFF)),
	.data_out(rnode_171to173_bb3_and17_i109_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_171to173_bb3_and17_i109_0_reg_173_fifo.DEPTH = 2;
defparam rnode_171to173_bb3_and17_i109_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_171to173_bb3_and17_i109_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to173_bb3_and17_i109_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_171to173_bb3_and17_i109_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and17_i109_stall_in_2 = 1'b0;
assign rnode_171to173_bb3_and17_i109_0_NO_SHIFT_REG = rnode_171to173_bb3_and17_i109_0_reg_173_NO_SHIFT_REG;
assign rnode_171to173_bb3_and17_i109_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_171to173_bb3_and17_i109_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3_var__u6_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u6_0_stall_in_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u6_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u6_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u6_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u6_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u6_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u6_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3_var__u6_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3_var__u6_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3_var__u6_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3_var__u6_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3_var__u6_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb3_var__u6),
	.data_out(rnode_171to172_bb3_var__u6_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3_var__u6_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3_var__u6_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_171to172_bb3_var__u6_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3_var__u6_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3_var__u6_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_var__u6_stall_in = 1'b0;
assign rnode_171to172_bb3_var__u6_0_NO_SHIFT_REG = rnode_171to172_bb3_var__u6_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3_var__u6_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_var__u6_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3_add192_i197_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add192_i197_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_add192_i197_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add192_i197_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add192_i197_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_add192_i197_1_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add192_i197_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add192_i197_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_add192_i197_2_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add192_i197_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add192_i197_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_add192_i197_3_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add192_i197_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_add192_i197_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add192_i197_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add192_i197_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add192_i197_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3_add192_i197_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3_add192_i197_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3_add192_i197_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3_add192_i197_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3_add192_i197_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb3_add192_i197),
	.data_out(rnode_171to172_bb3_add192_i197_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3_add192_i197_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3_add192_i197_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb3_add192_i197_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3_add192_i197_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3_add192_i197_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_add192_i197_stall_in = 1'b0;
assign rnode_171to172_bb3_add192_i197_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_add192_i197_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3_add192_i197_0_NO_SHIFT_REG = rnode_171to172_bb3_add192_i197_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3_add192_i197_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3_add192_i197_1_NO_SHIFT_REG = rnode_171to172_bb3_add192_i197_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3_add192_i197_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3_add192_i197_2_NO_SHIFT_REG = rnode_171to172_bb3_add192_i197_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3_add192_i197_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3_add192_i197_3_NO_SHIFT_REG = rnode_171to172_bb3_add192_i197_0_reg_172_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3__26_i133_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb3__26_i133_0_stall_in_NO_SHIFT_REG;
 logic rnode_171to172_bb3__26_i133_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3__26_i133_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_171to172_bb3__26_i133_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3__26_i133_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3__26_i133_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3__26_i133_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3__26_i133_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3__26_i133_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3__26_i133_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3__26_i133_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3__26_i133_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb3__26_i133),
	.data_out(rnode_171to172_bb3__26_i133_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3__26_i133_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3__26_i133_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_171to172_bb3__26_i133_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3__26_i133_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3__26_i133_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__26_i133_stall_in = 1'b0;
assign rnode_171to172_bb3__26_i133_0_NO_SHIFT_REG = rnode_171to172_bb3__26_i133_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3__26_i133_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3__26_i133_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_7_i_stall_local;
wire local_bb3_reduction_7_i;

assign local_bb3_reduction_7_i = (local_bb3_cmp25_i & local_bb3_brmerge_not_not_i);

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_7_i36_stall_local;
wire local_bb3_reduction_7_i36;

assign local_bb3_reduction_7_i36 = (local_bb3_cmp25_i23 & local_bb3_brmerge_not_not_i35);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3_var__u6_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb3_var__u6_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb3_var__u6_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_var__u6_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb3_var__u6_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_var__u6_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_var__u6_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_var__u6_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3_var__u6_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3_var__u6_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3_var__u6_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3_var__u6_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3_var__u6_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(rnode_171to172_bb3_var__u6_0_NO_SHIFT_REG),
	.data_out(rnode_172to173_bb3_var__u6_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3_var__u6_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3_var__u6_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb3_var__u6_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3_var__u6_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3_var__u6_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3_var__u6_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_var__u6_0_NO_SHIFT_REG = rnode_172to173_bb3_var__u6_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_var__u6_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_var__u6_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_and193_i198_valid_out;
wire local_bb3_and193_i198_stall_in;
wire local_bb3_and193_i198_inputs_ready;
wire local_bb3_and193_i198_stall_local;
wire [31:0] local_bb3_and193_i198;

assign local_bb3_and193_i198_inputs_ready = rnode_171to172_bb3_add192_i197_0_valid_out_0_NO_SHIFT_REG;
assign local_bb3_and193_i198 = (rnode_171to172_bb3_add192_i197_0_NO_SHIFT_REG & 32'hFFFFFFF);
assign local_bb3_and193_i198_valid_out = 1'b1;
assign rnode_171to172_bb3_add192_i197_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and195_i199_valid_out;
wire local_bb3_and195_i199_stall_in;
wire local_bb3_and195_i199_inputs_ready;
wire local_bb3_and195_i199_stall_local;
wire [31:0] local_bb3_and195_i199;

assign local_bb3_and195_i199_inputs_ready = rnode_171to172_bb3_add192_i197_0_valid_out_1_NO_SHIFT_REG;
assign local_bb3_and195_i199 = (rnode_171to172_bb3_add192_i197_1_NO_SHIFT_REG >> 32'h1B);
assign local_bb3_and195_i199_valid_out = 1'b1;
assign rnode_171to172_bb3_add192_i197_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and198_i200_valid_out;
wire local_bb3_and198_i200_stall_in;
wire local_bb3_and198_i200_inputs_ready;
wire local_bb3_and198_i200_stall_local;
wire [31:0] local_bb3_and198_i200;

assign local_bb3_and198_i200_inputs_ready = rnode_171to172_bb3_add192_i197_0_valid_out_2_NO_SHIFT_REG;
assign local_bb3_and198_i200 = (rnode_171to172_bb3_add192_i197_2_NO_SHIFT_REG & 32'h1);
assign local_bb3_and198_i200_valid_out = 1'b1;
assign rnode_171to172_bb3_add192_i197_0_stall_in_2_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and201_i201_stall_local;
wire [31:0] local_bb3_and201_i201;

assign local_bb3_and201_i201 = (rnode_171to172_bb3_add192_i197_3_NO_SHIFT_REG & 32'h7FFFFFF);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_172to174_bb3__26_i133_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to174_bb3__26_i133_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to174_bb3__26_i133_0_NO_SHIFT_REG;
 logic rnode_172to174_bb3__26_i133_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to174_bb3__26_i133_0_reg_174_NO_SHIFT_REG;
 logic rnode_172to174_bb3__26_i133_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_172to174_bb3__26_i133_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_172to174_bb3__26_i133_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_172to174_bb3__26_i133_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to174_bb3__26_i133_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to174_bb3__26_i133_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_172to174_bb3__26_i133_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_172to174_bb3__26_i133_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(rnode_171to172_bb3__26_i133_0_NO_SHIFT_REG),
	.data_out(rnode_172to174_bb3__26_i133_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_172to174_bb3__26_i133_0_reg_174_fifo.DEPTH = 2;
defparam rnode_172to174_bb3__26_i133_0_reg_174_fifo.DATA_WIDTH = 1;
defparam rnode_172to174_bb3__26_i133_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to174_bb3__26_i133_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_172to174_bb3__26_i133_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3__26_i133_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to174_bb3__26_i133_0_NO_SHIFT_REG = rnode_172to174_bb3__26_i133_0_reg_174_NO_SHIFT_REG;
assign rnode_172to174_bb3__26_i133_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_172to174_bb3__26_i133_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_9_i_stall_local;
wire local_bb3_reduction_9_i;

assign local_bb3_reduction_9_i = (local_bb3_reduction_7_i & local_bb3_reduction_8_i);

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_9_i38_stall_local;
wire local_bb3_reduction_9_i38;

assign local_bb3_reduction_9_i38 = (local_bb3_reduction_7_i36 & local_bb3_reduction_8_i37);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb3_var__u6_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb3_var__u6_0_stall_in_NO_SHIFT_REG;
 logic rnode_173to174_bb3_var__u6_0_NO_SHIFT_REG;
 logic rnode_173to174_bb3_var__u6_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic rnode_173to174_bb3_var__u6_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_var__u6_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_var__u6_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_var__u6_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb3_var__u6_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb3_var__u6_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb3_var__u6_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb3_var__u6_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb3_var__u6_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(rnode_172to173_bb3_var__u6_0_NO_SHIFT_REG),
	.data_out(rnode_173to174_bb3_var__u6_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb3_var__u6_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb3_var__u6_0_reg_174_fifo.DATA_WIDTH = 1;
defparam rnode_173to174_bb3_var__u6_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb3_var__u6_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb3_var__u6_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3_var__u6_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3_var__u6_0_NO_SHIFT_REG = rnode_173to174_bb3_var__u6_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb3_var__u6_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3_var__u6_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3_and193_i198_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and193_i198_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_and193_i198_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and193_i198_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and193_i198_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_and193_i198_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and193_i198_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and193_i198_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_and193_i198_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and193_i198_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_and193_i198_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and193_i198_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and193_i198_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and193_i198_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3_and193_i198_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3_and193_i198_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3_and193_i198_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3_and193_i198_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3_and193_i198_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in((local_bb3_and193_i198 & 32'hFFFFFFF)),
	.data_out(rnode_172to173_bb3_and193_i198_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3_and193_i198_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3_and193_i198_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb3_and193_i198_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3_and193_i198_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3_and193_i198_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and193_i198_stall_in = 1'b0;
assign rnode_172to173_bb3_and193_i198_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_and193_i198_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3_and193_i198_0_NO_SHIFT_REG = rnode_172to173_bb3_and193_i198_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_and193_i198_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3_and193_i198_1_NO_SHIFT_REG = rnode_172to173_bb3_and193_i198_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_and193_i198_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3_and193_i198_2_NO_SHIFT_REG = rnode_172to173_bb3_and193_i198_0_reg_173_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3_and195_i199_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and195_i199_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_and195_i199_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and195_i199_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_and195_i199_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and195_i199_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and195_i199_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and195_i199_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3_and195_i199_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3_and195_i199_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3_and195_i199_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3_and195_i199_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3_and195_i199_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in((local_bb3_and195_i199 & 32'h1F)),
	.data_out(rnode_172to173_bb3_and195_i199_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3_and195_i199_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3_and195_i199_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb3_and195_i199_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3_and195_i199_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3_and195_i199_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and195_i199_stall_in = 1'b0;
assign rnode_172to173_bb3_and195_i199_0_NO_SHIFT_REG = rnode_172to173_bb3_and195_i199_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_and195_i199_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_and195_i199_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3_and198_i200_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and198_i200_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_and198_i200_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and198_i200_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_and198_i200_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and198_i200_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and198_i200_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_and198_i200_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3_and198_i200_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3_and198_i200_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3_and198_i200_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3_and198_i200_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3_and198_i200_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in((local_bb3_and198_i200 & 32'h1)),
	.data_out(rnode_172to173_bb3_and198_i200_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3_and198_i200_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3_and198_i200_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb3_and198_i200_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3_and198_i200_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3_and198_i200_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and198_i200_stall_in = 1'b0;
assign rnode_172to173_bb3_and198_i200_0_NO_SHIFT_REG = rnode_172to173_bb3_and198_i200_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_and198_i200_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_and198_i200_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_shr_i_i202_stall_local;
wire [31:0] local_bb3_shr_i_i202;

assign local_bb3_shr_i_i202 = ((local_bb3_and201_i201 & 32'h7FFFFFF) >> 32'h1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb3__26_i133_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_174to175_bb3__26_i133_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_174to175_bb3__26_i133_0_NO_SHIFT_REG;
 logic rnode_174to175_bb3__26_i133_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_174to175_bb3__26_i133_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_174to175_bb3__26_i133_1_NO_SHIFT_REG;
 logic rnode_174to175_bb3__26_i133_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_174to175_bb3__26_i133_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_174to175_bb3__26_i133_2_NO_SHIFT_REG;
 logic rnode_174to175_bb3__26_i133_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic rnode_174to175_bb3__26_i133_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3__26_i133_0_valid_out_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3__26_i133_0_stall_in_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3__26_i133_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb3__26_i133_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb3__26_i133_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb3__26_i133_0_stall_in_0_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb3__26_i133_0_valid_out_0_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb3__26_i133_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(rnode_172to174_bb3__26_i133_0_NO_SHIFT_REG),
	.data_out(rnode_174to175_bb3__26_i133_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb3__26_i133_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb3__26_i133_0_reg_175_fifo.DATA_WIDTH = 1;
defparam rnode_174to175_bb3__26_i133_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb3__26_i133_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb3__26_i133_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_172to174_bb3__26_i133_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3__26_i133_0_stall_in_0_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3__26_i133_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb3__26_i133_0_NO_SHIFT_REG = rnode_174to175_bb3__26_i133_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb3__26_i133_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb3__26_i133_1_NO_SHIFT_REG = rnode_174to175_bb3__26_i133_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb3__26_i133_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb3__26_i133_2_NO_SHIFT_REG = rnode_174to175_bb3__26_i133_0_reg_175_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_and17_i_valid_out_2;
wire local_bb3_and17_i_stall_in_2;
wire local_bb3_var__u10_valid_out;
wire local_bb3_var__u10_stall_in;
wire local_bb3_add193_i_valid_out;
wire local_bb3_add193_i_stall_in;
wire local_bb3__26_i_valid_out;
wire local_bb3__26_i_stall_in;
wire local_bb3__26_i_inputs_ready;
wire local_bb3__26_i_stall_local;
wire local_bb3__26_i;

assign local_bb3__26_i_inputs_ready = (rnode_167to169_bb3_shr16_i_0_valid_out_0_NO_SHIFT_REG & rnode_167to169_bb3_cmp27_i_0_valid_out_2_NO_SHIFT_REG & rnode_168to169_bb3_and37_lobit_i_0_valid_out_NO_SHIFT_REG & rnode_168to169_bb3_xor189_i_0_valid_out_NO_SHIFT_REG & rnode_168to169_bb3_and20_i_0_valid_out_0_NO_SHIFT_REG & rnode_167to169_bb3_cmp27_i_0_valid_out_0_NO_SHIFT_REG & rnode_168to169_bb3_lnot33_not_i_0_valid_out_NO_SHIFT_REG & rnode_167to169_bb3_cmp27_i_0_valid_out_1_NO_SHIFT_REG & rnode_168to169_bb3_and20_i_0_valid_out_1_NO_SHIFT_REG & rnode_168to169_bb3_cmp38_i_0_valid_out_0_NO_SHIFT_REG);
assign local_bb3__26_i = (local_bb3_reduction_9_i ? rnode_168to169_bb3_cmp38_i_0_NO_SHIFT_REG : local_bb3__24_i);
assign local_bb3_and17_i_valid_out_2 = 1'b1;
assign local_bb3_var__u10_valid_out = 1'b1;
assign local_bb3_add193_i_valid_out = 1'b1;
assign local_bb3__26_i_valid_out = 1'b1;
assign rnode_167to169_bb3_shr16_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_167to169_bb3_cmp27_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_and37_lobit_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_xor189_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_and20_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_167to169_bb3_cmp27_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_lnot33_not_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to169_bb3_cmp27_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_and20_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_cmp38_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and17_i16_valid_out_2;
wire local_bb3_and17_i16_stall_in_2;
wire local_bb3_var__u11_valid_out;
wire local_bb3_var__u11_stall_in;
wire local_bb3_add192_i_valid_out;
wire local_bb3_add192_i_stall_in;
wire local_bb3__26_i39_valid_out;
wire local_bb3__26_i39_stall_in;
wire local_bb3__26_i39_inputs_ready;
wire local_bb3__26_i39_stall_local;
wire local_bb3__26_i39;

assign local_bb3__26_i39_inputs_ready = (rnode_167to169_bb3_shr16_i15_0_valid_out_0_NO_SHIFT_REG & rnode_167to169_bb3_cmp27_i24_0_valid_out_2_NO_SHIFT_REG & rnode_168to169_bb3_and36_lobit_i_0_valid_out_NO_SHIFT_REG & rnode_168to169_bb3_xor188_i_0_valid_out_NO_SHIFT_REG & rnode_168to169_bb3_and20_i19_0_valid_out_0_NO_SHIFT_REG & rnode_167to169_bb3_cmp27_i24_0_valid_out_0_NO_SHIFT_REG & rnode_168to169_bb3_lnot33_not_i30_0_valid_out_NO_SHIFT_REG & rnode_167to169_bb3_cmp27_i24_0_valid_out_1_NO_SHIFT_REG & rnode_168to169_bb3_and20_i19_0_valid_out_1_NO_SHIFT_REG & rnode_168to169_bb3_cmp37_i_0_valid_out_0_NO_SHIFT_REG);
assign local_bb3__26_i39 = (local_bb3_reduction_9_i38 ? rnode_168to169_bb3_cmp37_i_0_NO_SHIFT_REG : local_bb3__24_i34);
assign local_bb3_and17_i16_valid_out_2 = 1'b1;
assign local_bb3_var__u11_valid_out = 1'b1;
assign local_bb3_add192_i_valid_out = 1'b1;
assign local_bb3__26_i39_valid_out = 1'b1;
assign rnode_167to169_bb3_shr16_i15_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_167to169_bb3_cmp27_i24_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_and36_lobit_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_xor188_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_and20_i19_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_167to169_bb3_cmp27_i24_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_lnot33_not_i30_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to169_bb3_cmp27_i24_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_and20_i19_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb3_cmp37_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_shr216_i223_stall_local;
wire [31:0] local_bb3_shr216_i223;

assign local_bb3_shr216_i223 = ((rnode_172to173_bb3_and193_i198_1_NO_SHIFT_REG & 32'hFFFFFFF) >> 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3__pre_i221_stall_local;
wire [31:0] local_bb3__pre_i221;

assign local_bb3__pre_i221 = ((rnode_172to173_bb3_and195_i199_0_NO_SHIFT_REG & 32'h1F) & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_or_i_i203_stall_local;
wire [31:0] local_bb3_or_i_i203;

assign local_bb3_or_i_i203 = ((local_bb3_shr_i_i202 & 32'h3FFFFFF) | (local_bb3_and201_i201 & 32'h7FFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3_cond292_i260_stall_local;
wire [31:0] local_bb3_cond292_i260;

assign local_bb3_cond292_i260 = (rnode_174to175_bb3__26_i133_1_NO_SHIFT_REG ? 32'h400000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u24_stall_local;
wire [31:0] local_bb3_var__u24;

assign local_bb3_var__u24[31:1] = 31'h0;
assign local_bb3_var__u24[0] = rnode_174to175_bb3__26_i133_2_NO_SHIFT_REG;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb3_and17_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and17_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_and17_i_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and17_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_and17_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and17_i_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and17_i_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and17_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb3_and17_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb3_and17_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb3_and17_i_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb3_and17_i_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb3_and17_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((local_bb3_and17_i & 32'hFF)),
	.data_out(rnode_169to171_bb3_and17_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb3_and17_i_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb3_and17_i_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_169to171_bb3_and17_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb3_and17_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb3_and17_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and17_i_stall_in_2 = 1'b0;
assign rnode_169to171_bb3_and17_i_0_NO_SHIFT_REG = rnode_169to171_bb3_and17_i_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb3_and17_i_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_and17_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb3_var__u10_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb3_var__u10_0_stall_in_NO_SHIFT_REG;
 logic rnode_169to170_bb3_var__u10_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3_var__u10_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb3_var__u10_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_var__u10_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_var__u10_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_var__u10_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb3_var__u10_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb3_var__u10_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb3_var__u10_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb3_var__u10_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb3_var__u10_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb3_var__u10),
	.data_out(rnode_169to170_bb3_var__u10_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb3_var__u10_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb3_var__u10_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb3_var__u10_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb3_var__u10_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb3_var__u10_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_var__u10_stall_in = 1'b0;
assign rnode_169to170_bb3_var__u10_0_NO_SHIFT_REG = rnode_169to170_bb3_var__u10_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3_var__u10_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3_var__u10_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb3_add193_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add193_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_add193_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add193_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add193_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_add193_i_1_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add193_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add193_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_add193_i_2_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add193_i_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add193_i_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_add193_i_3_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add193_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_add193_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add193_i_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add193_i_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add193_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb3_add193_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb3_add193_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb3_add193_i_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb3_add193_i_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb3_add193_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb3_add193_i),
	.data_out(rnode_169to170_bb3_add193_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb3_add193_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb3_add193_i_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb3_add193_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb3_add193_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb3_add193_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_add193_i_stall_in = 1'b0;
assign rnode_169to170_bb3_add193_i_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3_add193_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_add193_i_0_NO_SHIFT_REG = rnode_169to170_bb3_add193_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3_add193_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_add193_i_1_NO_SHIFT_REG = rnode_169to170_bb3_add193_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3_add193_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_add193_i_2_NO_SHIFT_REG = rnode_169to170_bb3_add193_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3_add193_i_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_add193_i_3_NO_SHIFT_REG = rnode_169to170_bb3_add193_i_0_reg_170_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb3__26_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb3__26_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_169to170_bb3__26_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3__26_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb3__26_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3__26_i_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3__26_i_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3__26_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb3__26_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb3__26_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb3__26_i_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb3__26_i_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb3__26_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb3__26_i),
	.data_out(rnode_169to170_bb3__26_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb3__26_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb3__26_i_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb3__26_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb3__26_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb3__26_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__26_i_stall_in = 1'b0;
assign rnode_169to170_bb3__26_i_0_NO_SHIFT_REG = rnode_169to170_bb3__26_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3__26_i_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3__26_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb3_and17_i16_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and17_i16_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_and17_i16_0_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and17_i16_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb3_and17_i16_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and17_i16_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and17_i16_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb3_and17_i16_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb3_and17_i16_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb3_and17_i16_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb3_and17_i16_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb3_and17_i16_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb3_and17_i16_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((local_bb3_and17_i16 & 32'hFF)),
	.data_out(rnode_169to171_bb3_and17_i16_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb3_and17_i16_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb3_and17_i16_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_169to171_bb3_and17_i16_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb3_and17_i16_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb3_and17_i16_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and17_i16_stall_in_2 = 1'b0;
assign rnode_169to171_bb3_and17_i16_0_NO_SHIFT_REG = rnode_169to171_bb3_and17_i16_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb3_and17_i16_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_and17_i16_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb3_var__u11_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb3_var__u11_0_stall_in_NO_SHIFT_REG;
 logic rnode_169to170_bb3_var__u11_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3_var__u11_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb3_var__u11_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_var__u11_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_var__u11_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_var__u11_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb3_var__u11_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb3_var__u11_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb3_var__u11_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb3_var__u11_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb3_var__u11_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb3_var__u11),
	.data_out(rnode_169to170_bb3_var__u11_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb3_var__u11_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb3_var__u11_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb3_var__u11_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb3_var__u11_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb3_var__u11_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_var__u11_stall_in = 1'b0;
assign rnode_169to170_bb3_var__u11_0_NO_SHIFT_REG = rnode_169to170_bb3_var__u11_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3_var__u11_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3_var__u11_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb3_add192_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add192_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_add192_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add192_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add192_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_add192_i_1_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add192_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add192_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_add192_i_2_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add192_i_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add192_i_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_add192_i_3_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add192_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb3_add192_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add192_i_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add192_i_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3_add192_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb3_add192_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb3_add192_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb3_add192_i_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb3_add192_i_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb3_add192_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb3_add192_i),
	.data_out(rnode_169to170_bb3_add192_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb3_add192_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb3_add192_i_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb3_add192_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb3_add192_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb3_add192_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_add192_i_stall_in = 1'b0;
assign rnode_169to170_bb3_add192_i_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3_add192_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_add192_i_0_NO_SHIFT_REG = rnode_169to170_bb3_add192_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3_add192_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_add192_i_1_NO_SHIFT_REG = rnode_169to170_bb3_add192_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3_add192_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_add192_i_2_NO_SHIFT_REG = rnode_169to170_bb3_add192_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3_add192_i_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_add192_i_3_NO_SHIFT_REG = rnode_169to170_bb3_add192_i_0_reg_170_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb3__26_i39_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb3__26_i39_0_stall_in_NO_SHIFT_REG;
 logic rnode_169to170_bb3__26_i39_0_NO_SHIFT_REG;
 logic rnode_169to170_bb3__26_i39_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb3__26_i39_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3__26_i39_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3__26_i39_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb3__26_i39_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb3__26_i39_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb3__26_i39_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb3__26_i39_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb3__26_i39_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb3__26_i39_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb3__26_i39),
	.data_out(rnode_169to170_bb3__26_i39_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb3__26_i39_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb3__26_i39_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb3__26_i39_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb3__26_i39_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb3__26_i39_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__26_i39_stall_in = 1'b0;
assign rnode_169to170_bb3__26_i39_0_NO_SHIFT_REG = rnode_169to170_bb3__26_i39_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb3__26_i39_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb3__26_i39_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_or219_i224_stall_local;
wire [31:0] local_bb3_or219_i224;

assign local_bb3_or219_i224 = ((local_bb3_shr216_i223 & 32'h7FFFFFF) | (rnode_172to173_bb3_and198_i200_0_NO_SHIFT_REG & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_tobool213_i222_stall_local;
wire local_bb3_tobool213_i222;

assign local_bb3_tobool213_i222 = ((local_bb3__pre_i221 & 32'h1) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_shr1_i_i204_stall_local;
wire [31:0] local_bb3_shr1_i_i204;

assign local_bb3_shr1_i_i204 = ((local_bb3_or_i_i203 & 32'h7FFFFFF) >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot_ext_i270_stall_local;
wire [31:0] local_bb3_lnot_ext_i270;

assign local_bb3_lnot_ext_i270 = ((local_bb3_var__u24 & 32'h1) ^ 32'h1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3_var__u10_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb3_var__u10_0_stall_in_NO_SHIFT_REG;
 logic rnode_170to171_bb3_var__u10_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_var__u10_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to171_bb3_var__u10_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_var__u10_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_var__u10_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_var__u10_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3_var__u10_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3_var__u10_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3_var__u10_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3_var__u10_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3_var__u10_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb3_var__u10_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb3_var__u10_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3_var__u10_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3_var__u10_0_reg_171_fifo.DATA_WIDTH = 1;
defparam rnode_170to171_bb3_var__u10_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3_var__u10_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3_var__u10_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_var__u10_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_var__u10_0_NO_SHIFT_REG = rnode_170to171_bb3_var__u10_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_var__u10_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_var__u10_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_and194_i_valid_out;
wire local_bb3_and194_i_stall_in;
wire local_bb3_and194_i_inputs_ready;
wire local_bb3_and194_i_stall_local;
wire [31:0] local_bb3_and194_i;

assign local_bb3_and194_i_inputs_ready = rnode_169to170_bb3_add193_i_0_valid_out_0_NO_SHIFT_REG;
assign local_bb3_and194_i = (rnode_169to170_bb3_add193_i_0_NO_SHIFT_REG & 32'hFFFFFFF);
assign local_bb3_and194_i_valid_out = 1'b1;
assign rnode_169to170_bb3_add193_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and196_i_valid_out;
wire local_bb3_and196_i_stall_in;
wire local_bb3_and196_i_inputs_ready;
wire local_bb3_and196_i_stall_local;
wire [31:0] local_bb3_and196_i;

assign local_bb3_and196_i_inputs_ready = rnode_169to170_bb3_add193_i_0_valid_out_1_NO_SHIFT_REG;
assign local_bb3_and196_i = (rnode_169to170_bb3_add193_i_1_NO_SHIFT_REG >> 32'h1B);
assign local_bb3_and196_i_valid_out = 1'b1;
assign rnode_169to170_bb3_add193_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and199_i_valid_out;
wire local_bb3_and199_i_stall_in;
wire local_bb3_and199_i_inputs_ready;
wire local_bb3_and199_i_stall_local;
wire [31:0] local_bb3_and199_i;

assign local_bb3_and199_i_inputs_ready = rnode_169to170_bb3_add193_i_0_valid_out_2_NO_SHIFT_REG;
assign local_bb3_and199_i = (rnode_169to170_bb3_add193_i_2_NO_SHIFT_REG & 32'h1);
assign local_bb3_and199_i_valid_out = 1'b1;
assign rnode_169to170_bb3_add193_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and202_i_stall_local;
wire [31:0] local_bb3_and202_i;

assign local_bb3_and202_i = (rnode_169to170_bb3_add193_i_3_NO_SHIFT_REG & 32'h7FFFFFF);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_170to172_bb3__26_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to172_bb3__26_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_170to172_bb3__26_i_0_NO_SHIFT_REG;
 logic rnode_170to172_bb3__26_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to172_bb3__26_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb3__26_i_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb3__26_i_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb3__26_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_170to172_bb3__26_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to172_bb3__26_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to172_bb3__26_i_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_170to172_bb3__26_i_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_170to172_bb3__26_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb3__26_i_0_NO_SHIFT_REG),
	.data_out(rnode_170to172_bb3__26_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_170to172_bb3__26_i_0_reg_172_fifo.DEPTH = 2;
defparam rnode_170to172_bb3__26_i_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_170to172_bb3__26_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to172_bb3__26_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_170to172_bb3__26_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3__26_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb3__26_i_0_NO_SHIFT_REG = rnode_170to172_bb3__26_i_0_reg_172_NO_SHIFT_REG;
assign rnode_170to172_bb3__26_i_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb3__26_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3_var__u11_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb3_var__u11_0_stall_in_NO_SHIFT_REG;
 logic rnode_170to171_bb3_var__u11_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_var__u11_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to171_bb3_var__u11_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_var__u11_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_var__u11_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_var__u11_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3_var__u11_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3_var__u11_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3_var__u11_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3_var__u11_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3_var__u11_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb3_var__u11_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb3_var__u11_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3_var__u11_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3_var__u11_0_reg_171_fifo.DATA_WIDTH = 1;
defparam rnode_170to171_bb3_var__u11_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3_var__u11_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3_var__u11_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3_var__u11_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_var__u11_0_NO_SHIFT_REG = rnode_170to171_bb3_var__u11_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_var__u11_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_var__u11_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_and193_i_valid_out;
wire local_bb3_and193_i_stall_in;
wire local_bb3_and193_i_inputs_ready;
wire local_bb3_and193_i_stall_local;
wire [31:0] local_bb3_and193_i;

assign local_bb3_and193_i_inputs_ready = rnode_169to170_bb3_add192_i_0_valid_out_0_NO_SHIFT_REG;
assign local_bb3_and193_i = (rnode_169to170_bb3_add192_i_0_NO_SHIFT_REG & 32'hFFFFFFF);
assign local_bb3_and193_i_valid_out = 1'b1;
assign rnode_169to170_bb3_add192_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and195_i_valid_out;
wire local_bb3_and195_i_stall_in;
wire local_bb3_and195_i_inputs_ready;
wire local_bb3_and195_i_stall_local;
wire [31:0] local_bb3_and195_i;

assign local_bb3_and195_i_inputs_ready = rnode_169to170_bb3_add192_i_0_valid_out_1_NO_SHIFT_REG;
assign local_bb3_and195_i = (rnode_169to170_bb3_add192_i_1_NO_SHIFT_REG >> 32'h1B);
assign local_bb3_and195_i_valid_out = 1'b1;
assign rnode_169to170_bb3_add192_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and198_i_valid_out;
wire local_bb3_and198_i_stall_in;
wire local_bb3_and198_i_inputs_ready;
wire local_bb3_and198_i_stall_local;
wire [31:0] local_bb3_and198_i;

assign local_bb3_and198_i_inputs_ready = rnode_169to170_bb3_add192_i_0_valid_out_2_NO_SHIFT_REG;
assign local_bb3_and198_i = (rnode_169to170_bb3_add192_i_2_NO_SHIFT_REG & 32'h1);
assign local_bb3_and198_i_valid_out = 1'b1;
assign rnode_169to170_bb3_add192_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and201_i_stall_local;
wire [31:0] local_bb3_and201_i;

assign local_bb3_and201_i = (rnode_169to170_bb3_add192_i_3_NO_SHIFT_REG & 32'h7FFFFFF);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_170to172_bb3__26_i39_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to172_bb3__26_i39_0_stall_in_NO_SHIFT_REG;
 logic rnode_170to172_bb3__26_i39_0_NO_SHIFT_REG;
 logic rnode_170to172_bb3__26_i39_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to172_bb3__26_i39_0_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb3__26_i39_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb3__26_i39_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb3__26_i39_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_170to172_bb3__26_i39_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to172_bb3__26_i39_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to172_bb3__26_i39_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_170to172_bb3__26_i39_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_170to172_bb3__26_i39_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb3__26_i39_0_NO_SHIFT_REG),
	.data_out(rnode_170to172_bb3__26_i39_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_170to172_bb3__26_i39_0_reg_172_fifo.DEPTH = 2;
defparam rnode_170to172_bb3__26_i39_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_170to172_bb3__26_i39_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to172_bb3__26_i39_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_170to172_bb3__26_i39_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb3__26_i39_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb3__26_i39_0_NO_SHIFT_REG = rnode_170to172_bb3__26_i39_0_reg_172_NO_SHIFT_REG;
assign rnode_170to172_bb3__26_i39_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb3__26_i39_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3__40_demorgan_i225_stall_local;
wire local_bb3__40_demorgan_i225;

assign local_bb3__40_demorgan_i225 = (rnode_171to173_bb3_cmp37_i120_0_NO_SHIFT_REG | local_bb3_tobool213_i222);

// This section implements an unregistered operation.
// 
wire local_bb3__42_i227_stall_local;
wire local_bb3__42_i227;

assign local_bb3__42_i227 = (local_bb3_tobool213_i222 & local_bb3_not_cmp37_i226);

// This section implements an unregistered operation.
// 
wire local_bb3_or2_i_i205_stall_local;
wire [31:0] local_bb3_or2_i_i205;

assign local_bb3_or2_i_i205 = ((local_bb3_shr1_i_i204 & 32'h1FFFFFF) | (local_bb3_or_i_i203 & 32'h7FFFFFF));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3_var__u10_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u10_0_stall_in_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u10_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u10_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u10_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u10_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u10_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u10_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3_var__u10_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3_var__u10_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3_var__u10_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3_var__u10_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3_var__u10_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(rnode_170to171_bb3_var__u10_0_NO_SHIFT_REG),
	.data_out(rnode_171to172_bb3_var__u10_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3_var__u10_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3_var__u10_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_171to172_bb3_var__u10_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3_var__u10_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3_var__u10_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3_var__u10_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_var__u10_0_NO_SHIFT_REG = rnode_171to172_bb3_var__u10_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3_var__u10_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_var__u10_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3_and194_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and194_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and194_i_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and194_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and194_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and194_i_1_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and194_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and194_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and194_i_2_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and194_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and194_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and194_i_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and194_i_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and194_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3_and194_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3_and194_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3_and194_i_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3_and194_i_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3_and194_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((local_bb3_and194_i & 32'hFFFFFFF)),
	.data_out(rnode_170to171_bb3_and194_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3_and194_i_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3_and194_i_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_170to171_bb3_and194_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3_and194_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3_and194_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and194_i_stall_in = 1'b0;
assign rnode_170to171_bb3_and194_i_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and194_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3_and194_i_0_NO_SHIFT_REG = rnode_170to171_bb3_and194_i_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_and194_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3_and194_i_1_NO_SHIFT_REG = rnode_170to171_bb3_and194_i_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_and194_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3_and194_i_2_NO_SHIFT_REG = rnode_170to171_bb3_and194_i_0_reg_171_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3_and196_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and196_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and196_i_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and196_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and196_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and196_i_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and196_i_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and196_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3_and196_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3_and196_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3_and196_i_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3_and196_i_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3_and196_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((local_bb3_and196_i & 32'h1F)),
	.data_out(rnode_170to171_bb3_and196_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3_and196_i_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3_and196_i_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_170to171_bb3_and196_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3_and196_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3_and196_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and196_i_stall_in = 1'b0;
assign rnode_170to171_bb3_and196_i_0_NO_SHIFT_REG = rnode_170to171_bb3_and196_i_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_and196_i_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and196_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3_and199_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and199_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and199_i_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and199_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and199_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and199_i_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and199_i_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and199_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3_and199_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3_and199_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3_and199_i_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3_and199_i_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3_and199_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((local_bb3_and199_i & 32'h1)),
	.data_out(rnode_170to171_bb3_and199_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3_and199_i_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3_and199_i_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_170to171_bb3_and199_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3_and199_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3_and199_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and199_i_stall_in = 1'b0;
assign rnode_170to171_bb3_and199_i_0_NO_SHIFT_REG = rnode_170to171_bb3_and199_i_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_and199_i_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and199_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_shr_i_i_stall_local;
wire [31:0] local_bb3_shr_i_i;

assign local_bb3_shr_i_i = ((local_bb3_and202_i & 32'h7FFFFFF) >> 32'h1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3__26_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3__26_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3__26_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3__26_i_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3__26_i_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3__26_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(rnode_170to172_bb3__26_i_0_NO_SHIFT_REG),
	.data_out(rnode_172to173_bb3__26_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3__26_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3__26_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb3__26_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3__26_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3__26_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_170to172_bb3__26_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__26_i_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__26_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3__26_i_0_NO_SHIFT_REG = rnode_172to173_bb3__26_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3__26_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3__26_i_1_NO_SHIFT_REG = rnode_172to173_bb3__26_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3__26_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3__26_i_2_NO_SHIFT_REG = rnode_172to173_bb3__26_i_0_reg_173_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3_var__u11_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u11_0_stall_in_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u11_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u11_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u11_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u11_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u11_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_var__u11_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3_var__u11_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3_var__u11_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3_var__u11_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3_var__u11_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3_var__u11_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(rnode_170to171_bb3_var__u11_0_NO_SHIFT_REG),
	.data_out(rnode_171to172_bb3_var__u11_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3_var__u11_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3_var__u11_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_171to172_bb3_var__u11_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3_var__u11_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3_var__u11_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3_var__u11_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_var__u11_0_NO_SHIFT_REG = rnode_171to172_bb3_var__u11_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3_var__u11_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_var__u11_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3_and193_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and193_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and193_i_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and193_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and193_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and193_i_1_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and193_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and193_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and193_i_2_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and193_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and193_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and193_i_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and193_i_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and193_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3_and193_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3_and193_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3_and193_i_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3_and193_i_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3_and193_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((local_bb3_and193_i & 32'hFFFFFFF)),
	.data_out(rnode_170to171_bb3_and193_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3_and193_i_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3_and193_i_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_170to171_bb3_and193_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3_and193_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3_and193_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and193_i_stall_in = 1'b0;
assign rnode_170to171_bb3_and193_i_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and193_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3_and193_i_0_NO_SHIFT_REG = rnode_170to171_bb3_and193_i_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_and193_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3_and193_i_1_NO_SHIFT_REG = rnode_170to171_bb3_and193_i_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_and193_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3_and193_i_2_NO_SHIFT_REG = rnode_170to171_bb3_and193_i_0_reg_171_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3_and195_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and195_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and195_i_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and195_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and195_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and195_i_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and195_i_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and195_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3_and195_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3_and195_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3_and195_i_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3_and195_i_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3_and195_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((local_bb3_and195_i & 32'h1F)),
	.data_out(rnode_170to171_bb3_and195_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3_and195_i_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3_and195_i_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_170to171_bb3_and195_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3_and195_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3_and195_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and195_i_stall_in = 1'b0;
assign rnode_170to171_bb3_and195_i_0_NO_SHIFT_REG = rnode_170to171_bb3_and195_i_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_and195_i_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and195_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3_and198_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and198_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and198_i_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and198_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3_and198_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and198_i_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and198_i_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3_and198_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3_and198_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3_and198_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3_and198_i_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3_and198_i_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3_and198_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((local_bb3_and198_i & 32'h1)),
	.data_out(rnode_170to171_bb3_and198_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3_and198_i_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3_and198_i_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_170to171_bb3_and198_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3_and198_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3_and198_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and198_i_stall_in = 1'b0;
assign rnode_170to171_bb3_and198_i_0_NO_SHIFT_REG = rnode_170to171_bb3_and198_i_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3_and198_i_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and198_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_shr_i_i63_stall_local;
wire [31:0] local_bb3_shr_i_i63;

assign local_bb3_shr_i_i63 = ((local_bb3_and201_i & 32'h7FFFFFF) >> 32'h1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3__26_i39_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i39_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i39_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i39_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i39_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i39_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i39_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i39_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i39_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i39_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i39_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i39_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i39_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__26_i39_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3__26_i39_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3__26_i39_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3__26_i39_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3__26_i39_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3__26_i39_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(rnode_170to172_bb3__26_i39_0_NO_SHIFT_REG),
	.data_out(rnode_172to173_bb3__26_i39_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3__26_i39_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3__26_i39_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb3__26_i39_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3__26_i39_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3__26_i39_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_170to172_bb3__26_i39_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__26_i39_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__26_i39_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3__26_i39_0_NO_SHIFT_REG = rnode_172to173_bb3__26_i39_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3__26_i39_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3__26_i39_1_NO_SHIFT_REG = rnode_172to173_bb3__26_i39_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3__26_i39_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3__26_i39_2_NO_SHIFT_REG = rnode_172to173_bb3__26_i39_0_reg_173_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3__43_i228_stall_local;
wire [31:0] local_bb3__43_i228;

assign local_bb3__43_i228 = (local_bb3__42_i227 ? 32'h0 : (local_bb3__pre_i221 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_shr3_i_i206_stall_local;
wire [31:0] local_bb3_shr3_i_i206;

assign local_bb3_shr3_i_i206 = ((local_bb3_or2_i_i205 & 32'h7FFFFFF) >> 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb3_shr217_i_stall_local;
wire [31:0] local_bb3_shr217_i;

assign local_bb3_shr217_i = ((rnode_170to171_bb3_and194_i_1_NO_SHIFT_REG & 32'hFFFFFFF) >> 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3__pre_i_stall_local;
wire [31:0] local_bb3__pre_i;

assign local_bb3__pre_i = ((rnode_170to171_bb3_and196_i_0_NO_SHIFT_REG & 32'h1F) & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_or_i_i_stall_local;
wire [31:0] local_bb3_or_i_i;

assign local_bb3_or_i_i = ((local_bb3_shr_i_i & 32'h3FFFFFF) | (local_bb3_and202_i & 32'h7FFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3_cond293_i_stall_local;
wire [31:0] local_bb3_cond293_i;

assign local_bb3_cond293_i = (rnode_172to173_bb3__26_i_1_NO_SHIFT_REG ? 32'h400000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u25_stall_local;
wire [31:0] local_bb3_var__u25;

assign local_bb3_var__u25[31:1] = 31'h0;
assign local_bb3_var__u25[0] = rnode_172to173_bb3__26_i_2_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_shr216_i_stall_local;
wire [31:0] local_bb3_shr216_i;

assign local_bb3_shr216_i = ((rnode_170to171_bb3_and193_i_1_NO_SHIFT_REG & 32'hFFFFFFF) >> 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3__pre_i77_stall_local;
wire [31:0] local_bb3__pre_i77;

assign local_bb3__pre_i77 = ((rnode_170to171_bb3_and195_i_0_NO_SHIFT_REG & 32'h1F) & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_or_i_i64_stall_local;
wire [31:0] local_bb3_or_i_i64;

assign local_bb3_or_i_i64 = ((local_bb3_shr_i_i63 & 32'h3FFFFFF) | (local_bb3_and201_i & 32'h7FFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3_cond292_i_stall_local;
wire [31:0] local_bb3_cond292_i;

assign local_bb3_cond292_i = (rnode_172to173_bb3__26_i39_1_NO_SHIFT_REG ? 32'h400000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u26_stall_local;
wire [31:0] local_bb3_var__u26;

assign local_bb3_var__u26[31:1] = 31'h0;
assign local_bb3_var__u26[0] = rnode_172to173_bb3__26_i39_2_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_or4_i_i207_stall_local;
wire [31:0] local_bb3_or4_i_i207;

assign local_bb3_or4_i_i207 = ((local_bb3_shr3_i_i206 & 32'h7FFFFF) | (local_bb3_or2_i_i205 & 32'h7FFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3_or220_i_stall_local;
wire [31:0] local_bb3_or220_i;

assign local_bb3_or220_i = ((local_bb3_shr217_i & 32'h7FFFFFF) | (rnode_170to171_bb3_and199_i_0_NO_SHIFT_REG & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_tobool214_i_stall_local;
wire local_bb3_tobool214_i;

assign local_bb3_tobool214_i = ((local_bb3__pre_i & 32'h1) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_shr1_i_i_stall_local;
wire [31:0] local_bb3_shr1_i_i;

assign local_bb3_shr1_i_i = ((local_bb3_or_i_i & 32'h7FFFFFF) >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot_ext_i_stall_local;
wire [31:0] local_bb3_lnot_ext_i;

assign local_bb3_lnot_ext_i = ((local_bb3_var__u25 & 32'h1) ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_or219_i_stall_local;
wire [31:0] local_bb3_or219_i;

assign local_bb3_or219_i = ((local_bb3_shr216_i & 32'h7FFFFFF) | (rnode_170to171_bb3_and198_i_0_NO_SHIFT_REG & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_tobool213_i_stall_local;
wire local_bb3_tobool213_i;

assign local_bb3_tobool213_i = ((local_bb3__pre_i77 & 32'h1) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_shr1_i_i65_stall_local;
wire [31:0] local_bb3_shr1_i_i65;

assign local_bb3_shr1_i_i65 = ((local_bb3_or_i_i64 & 32'h7FFFFFF) >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot_ext_i94_stall_local;
wire [31:0] local_bb3_lnot_ext_i94;

assign local_bb3_lnot_ext_i94 = ((local_bb3_var__u26 & 32'h1) ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_shr5_i_i208_stall_local;
wire [31:0] local_bb3_shr5_i_i208;

assign local_bb3_shr5_i_i208 = ((local_bb3_or4_i_i207 & 32'h7FFFFFF) >> 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb3__40_demorgan_i_stall_local;
wire local_bb3__40_demorgan_i;

assign local_bb3__40_demorgan_i = (rnode_169to171_bb3_cmp38_i_0_NO_SHIFT_REG | local_bb3_tobool214_i);

// This section implements an unregistered operation.
// 
wire local_bb3__42_i_stall_local;
wire local_bb3__42_i;

assign local_bb3__42_i = (local_bb3_tobool214_i & local_bb3_not_cmp38_i);

// This section implements an unregistered operation.
// 
wire local_bb3_or2_i_i_stall_local;
wire [31:0] local_bb3_or2_i_i;

assign local_bb3_or2_i_i = ((local_bb3_shr1_i_i & 32'h1FFFFFF) | (local_bb3_or_i_i & 32'h7FFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3__40_demorgan_i78_stall_local;
wire local_bb3__40_demorgan_i78;

assign local_bb3__40_demorgan_i78 = (rnode_169to171_bb3_cmp37_i_0_NO_SHIFT_REG | local_bb3_tobool213_i);

// This section implements an unregistered operation.
// 
wire local_bb3__42_i79_stall_local;
wire local_bb3__42_i79;

assign local_bb3__42_i79 = (local_bb3_tobool213_i & local_bb3_not_cmp37_i);

// This section implements an unregistered operation.
// 
wire local_bb3_or2_i_i66_stall_local;
wire [31:0] local_bb3_or2_i_i66;

assign local_bb3_or2_i_i66 = ((local_bb3_shr1_i_i65 & 32'h1FFFFFF) | (local_bb3_or_i_i64 & 32'h7FFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3_or6_i_i209_stall_local;
wire [31:0] local_bb3_or6_i_i209;

assign local_bb3_or6_i_i209 = ((local_bb3_shr5_i_i208 & 32'h7FFFF) | (local_bb3_or4_i_i207 & 32'h7FFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3__43_i_stall_local;
wire [31:0] local_bb3__43_i;

assign local_bb3__43_i = (local_bb3__42_i ? 32'h0 : (local_bb3__pre_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_shr3_i_i_stall_local;
wire [31:0] local_bb3_shr3_i_i;

assign local_bb3_shr3_i_i = ((local_bb3_or2_i_i & 32'h7FFFFFF) >> 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb3__43_i80_stall_local;
wire [31:0] local_bb3__43_i80;

assign local_bb3__43_i80 = (local_bb3__42_i79 ? 32'h0 : (local_bb3__pre_i77 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_shr3_i_i67_stall_local;
wire [31:0] local_bb3_shr3_i_i67;

assign local_bb3_shr3_i_i67 = ((local_bb3_or2_i_i66 & 32'h7FFFFFF) >> 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb3_shr7_i_i210_stall_local;
wire [31:0] local_bb3_shr7_i_i210;

assign local_bb3_shr7_i_i210 = ((local_bb3_or6_i_i209 & 32'h7FFFFFF) >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb3_or6_masked_i_i211_stall_local;
wire [31:0] local_bb3_or6_masked_i_i211;

assign local_bb3_or6_masked_i_i211 = ((local_bb3_or6_i_i209 & 32'h7FFFFFF) & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_or4_i_i_stall_local;
wire [31:0] local_bb3_or4_i_i;

assign local_bb3_or4_i_i = ((local_bb3_shr3_i_i & 32'h7FFFFF) | (local_bb3_or2_i_i & 32'h7FFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3_or4_i_i68_stall_local;
wire [31:0] local_bb3_or4_i_i68;

assign local_bb3_or4_i_i68 = ((local_bb3_shr3_i_i67 & 32'h7FFFFF) | (local_bb3_or2_i_i66 & 32'h7FFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3_neg_i_i212_stall_local;
wire [31:0] local_bb3_neg_i_i212;

assign local_bb3_neg_i_i212 = ((local_bb3_or6_masked_i_i211 & 32'h7FFFFFF) | (local_bb3_shr7_i_i210 & 32'h7FF));

// This section implements an unregistered operation.
// 
wire local_bb3_shr5_i_i_stall_local;
wire [31:0] local_bb3_shr5_i_i;

assign local_bb3_shr5_i_i = ((local_bb3_or4_i_i & 32'h7FFFFFF) >> 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb3_shr5_i_i69_stall_local;
wire [31:0] local_bb3_shr5_i_i69;

assign local_bb3_shr5_i_i69 = ((local_bb3_or4_i_i68 & 32'h7FFFFFF) >> 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb3_and_i_i213_stall_local;
wire [31:0] local_bb3_and_i_i213;

assign local_bb3_and_i_i213 = ((local_bb3_neg_i_i212 & 32'h7FFFFFF) ^ 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_or6_i_i_stall_local;
wire [31:0] local_bb3_or6_i_i;

assign local_bb3_or6_i_i = ((local_bb3_shr5_i_i & 32'h7FFFF) | (local_bb3_or4_i_i & 32'h7FFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3_or6_i_i70_stall_local;
wire [31:0] local_bb3_or6_i_i70;

assign local_bb3_or6_i_i70 = ((local_bb3_shr5_i_i69 & 32'h7FFFF) | (local_bb3_or4_i_i68 & 32'h7FFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3__and_i_i213_valid_out;
wire local_bb3__and_i_i213_stall_in;
wire local_bb3__and_i_i213_inputs_ready;
wire local_bb3__and_i_i213_stall_local;
wire [31:0] local_bb3__and_i_i213;

thirtysix_six_comp local_bb3__and_i_i213_popcnt_instance (
	.data((local_bb3_and_i_i213 & 32'h7FFFFFF)),
	.sum(local_bb3__and_i_i213)
);


assign local_bb3__and_i_i213_inputs_ready = rnode_171to172_bb3_add192_i197_0_valid_out_3_NO_SHIFT_REG;
assign local_bb3__and_i_i213_valid_out = 1'b1;
assign rnode_171to172_bb3_add192_i197_0_stall_in_3_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_shr7_i_i_stall_local;
wire [31:0] local_bb3_shr7_i_i;

assign local_bb3_shr7_i_i = ((local_bb3_or6_i_i & 32'h7FFFFFF) >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb3_or6_masked_i_i_stall_local;
wire [31:0] local_bb3_or6_masked_i_i;

assign local_bb3_or6_masked_i_i = ((local_bb3_or6_i_i & 32'h7FFFFFF) & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_shr7_i_i71_stall_local;
wire [31:0] local_bb3_shr7_i_i71;

assign local_bb3_shr7_i_i71 = ((local_bb3_or6_i_i70 & 32'h7FFFFFF) >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb3_or6_masked_i_i72_stall_local;
wire [31:0] local_bb3_or6_masked_i_i72;

assign local_bb3_or6_masked_i_i72 = ((local_bb3_or6_i_i70 & 32'h7FFFFFF) & 32'h7FFFFFF);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3__and_i_i213_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3__and_i_i213_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3__and_i_i213_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3__and_i_i213_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3__and_i_i213_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3__and_i_i213_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3__and_i_i213_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3__and_i_i213_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3__and_i_i213_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3__and_i_i213_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3__and_i_i213_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__and_i_i213_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__and_i_i213_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__and_i_i213_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3__and_i_i213_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3__and_i_i213_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3__and_i_i213_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3__and_i_i213_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3__and_i_i213_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in((local_bb3__and_i_i213 & 32'h3F)),
	.data_out(rnode_172to173_bb3__and_i_i213_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3__and_i_i213_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3__and_i_i213_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb3__and_i_i213_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3__and_i_i213_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3__and_i_i213_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__and_i_i213_stall_in = 1'b0;
assign rnode_172to173_bb3__and_i_i213_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__and_i_i213_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3__and_i_i213_0_NO_SHIFT_REG = rnode_172to173_bb3__and_i_i213_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3__and_i_i213_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3__and_i_i213_1_NO_SHIFT_REG = rnode_172to173_bb3__and_i_i213_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3__and_i_i213_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3__and_i_i213_2_NO_SHIFT_REG = rnode_172to173_bb3__and_i_i213_0_reg_173_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_neg_i_i_stall_local;
wire [31:0] local_bb3_neg_i_i;

assign local_bb3_neg_i_i = ((local_bb3_or6_masked_i_i & 32'h7FFFFFF) | (local_bb3_shr7_i_i & 32'h7FF));

// This section implements an unregistered operation.
// 
wire local_bb3_neg_i_i73_stall_local;
wire [31:0] local_bb3_neg_i_i73;

assign local_bb3_neg_i_i73 = ((local_bb3_or6_masked_i_i72 & 32'h7FFFFFF) | (local_bb3_shr7_i_i71 & 32'h7FF));

// This section implements an unregistered operation.
// 
wire local_bb3_and9_i_i214_stall_local;
wire [31:0] local_bb3_and9_i_i214;

assign local_bb3_and9_i_i214 = ((rnode_172to173_bb3__and_i_i213_0_NO_SHIFT_REG & 32'h3F) & 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb3_and203_i215_stall_local;
wire [31:0] local_bb3_and203_i215;

assign local_bb3_and203_i215 = ((rnode_172to173_bb3__and_i_i213_1_NO_SHIFT_REG & 32'h3F) & 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb3_and206_i217_stall_local;
wire [31:0] local_bb3_and206_i217;

assign local_bb3_and206_i217 = ((rnode_172to173_bb3__and_i_i213_2_NO_SHIFT_REG & 32'h3F) & 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb3_and_i_i1_stall_local;
wire [31:0] local_bb3_and_i_i1;

assign local_bb3_and_i_i1 = ((local_bb3_neg_i_i & 32'h7FFFFFF) ^ 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and_i_i74_stall_local;
wire [31:0] local_bb3_and_i_i74;

assign local_bb3_and_i_i74 = ((local_bb3_neg_i_i73 & 32'h7FFFFFF) ^ 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_sub239_i236_stall_local;
wire [31:0] local_bb3_sub239_i236;

assign local_bb3_sub239_i236 = (32'h0 - (local_bb3_and9_i_i214 & 32'h1F));

// This section implements an unregistered operation.
// 
wire local_bb3_shl204_i216_stall_local;
wire [31:0] local_bb3_shl204_i216;

assign local_bb3_shl204_i216 = ((rnode_172to173_bb3_and193_i198_0_NO_SHIFT_REG & 32'hFFFFFFF) << (local_bb3_and203_i215 & 32'h18));

// This section implements an unregistered operation.
// 
wire local_bb3__and_i_i1_valid_out;
wire local_bb3__and_i_i1_stall_in;
wire local_bb3__and_i_i1_inputs_ready;
wire local_bb3__and_i_i1_stall_local;
wire [31:0] local_bb3__and_i_i1;

thirtysix_six_comp local_bb3__and_i_i1_popcnt_instance (
	.data((local_bb3_and_i_i1 & 32'h7FFFFFF)),
	.sum(local_bb3__and_i_i1)
);


assign local_bb3__and_i_i1_inputs_ready = rnode_169to170_bb3_add193_i_0_valid_out_3_NO_SHIFT_REG;
assign local_bb3__and_i_i1_valid_out = 1'b1;
assign rnode_169to170_bb3_add193_i_0_stall_in_3_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3__and_i_i74_valid_out;
wire local_bb3__and_i_i74_stall_in;
wire local_bb3__and_i_i74_inputs_ready;
wire local_bb3__and_i_i74_stall_local;
wire [31:0] local_bb3__and_i_i74;

thirtysix_six_comp local_bb3__and_i_i74_popcnt_instance (
	.data((local_bb3_and_i_i74 & 32'h7FFFFFF)),
	.sum(local_bb3__and_i_i74)
);


assign local_bb3__and_i_i74_inputs_ready = rnode_169to170_bb3_add192_i_0_valid_out_3_NO_SHIFT_REG;
assign local_bb3__and_i_i74_valid_out = 1'b1;
assign rnode_169to170_bb3_add192_i_0_stall_in_3_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_cond244_i237_stall_local;
wire [31:0] local_bb3_cond244_i237;

assign local_bb3_cond244_i237 = (rnode_171to173_bb3_cmp37_i120_2_NO_SHIFT_REG ? local_bb3_sub239_i236 : (local_bb3__43_i228 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_and205_i218_stall_local;
wire [31:0] local_bb3_and205_i218;

assign local_bb3_and205_i218 = (local_bb3_shl204_i216 & 32'h7FFFFFF);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3__and_i_i1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i1_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3__and_i_i1_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i1_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3__and_i_i1_1_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i1_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i1_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3__and_i_i1_2_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i1_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3__and_i_i1_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i1_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i1_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i1_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3__and_i_i1_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3__and_i_i1_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3__and_i_i1_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3__and_i_i1_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3__and_i_i1_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((local_bb3__and_i_i1 & 32'h3F)),
	.data_out(rnode_170to171_bb3__and_i_i1_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3__and_i_i1_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3__and_i_i1_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_170to171_bb3__and_i_i1_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3__and_i_i1_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3__and_i_i1_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__and_i_i1_stall_in = 1'b0;
assign rnode_170to171_bb3__and_i_i1_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3__and_i_i1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3__and_i_i1_0_NO_SHIFT_REG = rnode_170to171_bb3__and_i_i1_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3__and_i_i1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3__and_i_i1_1_NO_SHIFT_REG = rnode_170to171_bb3__and_i_i1_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3__and_i_i1_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3__and_i_i1_2_NO_SHIFT_REG = rnode_170to171_bb3__and_i_i1_0_reg_171_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb3__and_i_i74_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i74_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3__and_i_i74_0_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i74_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i74_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3__and_i_i74_1_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i74_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i74_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3__and_i_i74_2_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i74_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb3__and_i_i74_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i74_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i74_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb3__and_i_i74_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb3__and_i_i74_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb3__and_i_i74_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb3__and_i_i74_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb3__and_i_i74_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb3__and_i_i74_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in((local_bb3__and_i_i74 & 32'h3F)),
	.data_out(rnode_170to171_bb3__and_i_i74_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb3__and_i_i74_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb3__and_i_i74_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_170to171_bb3__and_i_i74_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb3__and_i_i74_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb3__and_i_i74_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__and_i_i74_stall_in = 1'b0;
assign rnode_170to171_bb3__and_i_i74_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3__and_i_i74_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3__and_i_i74_0_NO_SHIFT_REG = rnode_170to171_bb3__and_i_i74_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3__and_i_i74_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3__and_i_i74_1_NO_SHIFT_REG = rnode_170to171_bb3__and_i_i74_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb3__and_i_i74_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb3__and_i_i74_2_NO_SHIFT_REG = rnode_170to171_bb3__and_i_i74_0_reg_171_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_add245_i238_stall_local;
wire [31:0] local_bb3_add245_i238;

assign local_bb3_add245_i238 = (local_bb3_cond244_i237 + (rnode_171to173_bb3_and17_i109_0_NO_SHIFT_REG & 32'hFF));

// This section implements an unregistered operation.
// 
wire local_bb3_fold_i240_stall_local;
wire [31:0] local_bb3_fold_i240;

assign local_bb3_fold_i240 = (local_bb3_cond244_i237 + (rnode_171to173_bb3_shr16_i108_0_NO_SHIFT_REG & 32'h1FF));

// This section implements an unregistered operation.
// 
wire local_bb3_shl207_i219_stall_local;
wire [31:0] local_bb3_shl207_i219;

assign local_bb3_shl207_i219 = ((local_bb3_and205_i218 & 32'h7FFFFFF) << (local_bb3_and206_i217 & 32'h7));

// This section implements an unregistered operation.
// 
wire local_bb3_and9_i_i_stall_local;
wire [31:0] local_bb3_and9_i_i;

assign local_bb3_and9_i_i = ((rnode_170to171_bb3__and_i_i1_0_NO_SHIFT_REG & 32'h3F) & 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb3_and204_i_stall_local;
wire [31:0] local_bb3_and204_i;

assign local_bb3_and204_i = ((rnode_170to171_bb3__and_i_i1_1_NO_SHIFT_REG & 32'h3F) & 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb3_and207_i_stall_local;
wire [31:0] local_bb3_and207_i;

assign local_bb3_and207_i = ((rnode_170to171_bb3__and_i_i1_2_NO_SHIFT_REG & 32'h3F) & 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb3_and9_i_i75_stall_local;
wire [31:0] local_bb3_and9_i_i75;

assign local_bb3_and9_i_i75 = ((rnode_170to171_bb3__and_i_i74_0_NO_SHIFT_REG & 32'h3F) & 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb3_and203_i_stall_local;
wire [31:0] local_bb3_and203_i;

assign local_bb3_and203_i = ((rnode_170to171_bb3__and_i_i74_1_NO_SHIFT_REG & 32'h3F) & 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb3_and206_i76_stall_local;
wire [31:0] local_bb3_and206_i76;

assign local_bb3_and206_i76 = ((rnode_170to171_bb3__and_i_i74_2_NO_SHIFT_REG & 32'h3F) & 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb3_and250_i241_stall_local;
wire [31:0] local_bb3_and250_i241;

assign local_bb3_and250_i241 = (local_bb3_fold_i240 & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and269_i252_stall_local;
wire [31:0] local_bb3_and269_i252;

assign local_bb3_and269_i252 = (local_bb3_fold_i240 << 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb3_and208_i220_stall_local;
wire [31:0] local_bb3_and208_i220;

assign local_bb3_and208_i220 = (local_bb3_shl207_i219 & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_sub240_i_stall_local;
wire [31:0] local_bb3_sub240_i;

assign local_bb3_sub240_i = (32'h0 - (local_bb3_and9_i_i & 32'h1F));

// This section implements an unregistered operation.
// 
wire local_bb3_shl205_i_stall_local;
wire [31:0] local_bb3_shl205_i;

assign local_bb3_shl205_i = ((rnode_170to171_bb3_and194_i_0_NO_SHIFT_REG & 32'hFFFFFFF) << (local_bb3_and204_i & 32'h18));

// This section implements an unregistered operation.
// 
wire local_bb3_sub239_i_stall_local;
wire [31:0] local_bb3_sub239_i;

assign local_bb3_sub239_i = (32'h0 - (local_bb3_and9_i_i75 & 32'h1F));

// This section implements an unregistered operation.
// 
wire local_bb3_shl204_i_stall_local;
wire [31:0] local_bb3_shl204_i;

assign local_bb3_shl204_i = ((rnode_170to171_bb3_and193_i_0_NO_SHIFT_REG & 32'hFFFFFFF) << (local_bb3_and203_i & 32'h18));

// This section implements an unregistered operation.
// 
wire local_bb3__44_i229_stall_local;
wire [31:0] local_bb3__44_i229;

assign local_bb3__44_i229 = (local_bb3__40_demorgan_i225 ? (local_bb3_and208_i220 & 32'h7FFFFFF) : (local_bb3_or219_i224 & 32'h7FFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3_cond245_i_stall_local;
wire [31:0] local_bb3_cond245_i;

assign local_bb3_cond245_i = (rnode_169to171_bb3_cmp38_i_2_NO_SHIFT_REG ? local_bb3_sub240_i : (local_bb3__43_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_and206_i_stall_local;
wire [31:0] local_bb3_and206_i;

assign local_bb3_and206_i = (local_bb3_shl205_i & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_cond244_i_stall_local;
wire [31:0] local_bb3_cond244_i;

assign local_bb3_cond244_i = (rnode_169to171_bb3_cmp37_i_2_NO_SHIFT_REG ? local_bb3_sub239_i : (local_bb3__43_i80 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_and205_i_stall_local;
wire [31:0] local_bb3_and205_i;

assign local_bb3_and205_i = (local_bb3_shl204_i & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and250_i241_valid_out;
wire local_bb3_and250_i241_stall_in;
wire local_bb3_and269_i252_valid_out;
wire local_bb3_and269_i252_stall_in;
wire local_bb3_add245_i238_valid_out;
wire local_bb3_add245_i238_stall_in;
wire local_bb3__45_i230_valid_out;
wire local_bb3__45_i230_stall_in;
wire local_bb3_not_cmp37_i226_valid_out_1;
wire local_bb3_not_cmp37_i226_stall_in_1;
wire local_bb3__45_i230_inputs_ready;
wire local_bb3__45_i230_stall_local;
wire [31:0] local_bb3__45_i230;

assign local_bb3__45_i230_inputs_ready = (rnode_171to173_bb3_shr16_i108_0_valid_out_NO_SHIFT_REG & rnode_171to173_bb3_and17_i109_0_valid_out_NO_SHIFT_REG & rnode_171to173_bb3_cmp37_i120_0_valid_out_2_NO_SHIFT_REG & rnode_171to173_bb3_cmp37_i120_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb3_and193_i198_0_valid_out_2_NO_SHIFT_REG & rnode_171to173_bb3_cmp37_i120_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb3_and195_i199_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb3_and193_i198_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb3_and198_i200_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb3_and193_i198_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb3__and_i_i213_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb3__and_i_i213_0_valid_out_2_NO_SHIFT_REG & rnode_172to173_bb3__and_i_i213_0_valid_out_0_NO_SHIFT_REG);
assign local_bb3__45_i230 = (local_bb3__42_i227 ? (rnode_172to173_bb3_and193_i198_2_NO_SHIFT_REG & 32'hFFFFFFF) : (local_bb3__44_i229 & 32'h7FFFFFF));
assign local_bb3_and250_i241_valid_out = 1'b1;
assign local_bb3_and269_i252_valid_out = 1'b1;
assign local_bb3_add245_i238_valid_out = 1'b1;
assign local_bb3__45_i230_valid_out = 1'b1;
assign local_bb3_not_cmp37_i226_valid_out_1 = 1'b1;
assign rnode_171to173_bb3_shr16_i108_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to173_bb3_and17_i109_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to173_bb3_cmp37_i120_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_171to173_bb3_cmp37_i120_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_and193_i198_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_171to173_bb3_cmp37_i120_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_and195_i199_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_and193_i198_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_and198_i200_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_and193_i198_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__and_i_i213_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__and_i_i213_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__and_i_i213_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_add246_i_stall_local;
wire [31:0] local_bb3_add246_i;

assign local_bb3_add246_i = (local_bb3_cond245_i + (rnode_169to171_bb3_and17_i_0_NO_SHIFT_REG & 32'hFF));

// This section implements an unregistered operation.
// 
wire local_bb3_fold_i_stall_local;
wire [31:0] local_bb3_fold_i;

assign local_bb3_fold_i = (local_bb3_cond245_i + (rnode_169to171_bb3_shr16_i_0_NO_SHIFT_REG & 32'h1FF));

// This section implements an unregistered operation.
// 
wire local_bb3_shl208_i_stall_local;
wire [31:0] local_bb3_shl208_i;

assign local_bb3_shl208_i = ((local_bb3_and206_i & 32'h7FFFFFF) << (local_bb3_and207_i & 32'h7));

// This section implements an unregistered operation.
// 
wire local_bb3_add245_i_stall_local;
wire [31:0] local_bb3_add245_i;

assign local_bb3_add245_i = (local_bb3_cond244_i + (rnode_169to171_bb3_and17_i16_0_NO_SHIFT_REG & 32'hFF));

// This section implements an unregistered operation.
// 
wire local_bb3_fold_i85_stall_local;
wire [31:0] local_bb3_fold_i85;

assign local_bb3_fold_i85 = (local_bb3_cond244_i + (rnode_169to171_bb3_shr16_i15_0_NO_SHIFT_REG & 32'h1FF));

// This section implements an unregistered operation.
// 
wire local_bb3_shl207_i_stall_local;
wire [31:0] local_bb3_shl207_i;

assign local_bb3_shl207_i = ((local_bb3_and205_i & 32'h7FFFFFF) << (local_bb3_and206_i76 & 32'h7));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb3_and250_i241_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb3_and250_i241_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb3_and250_i241_0_NO_SHIFT_REG;
 logic rnode_173to174_bb3_and250_i241_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb3_and250_i241_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_and250_i241_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_and250_i241_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_and250_i241_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb3_and250_i241_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb3_and250_i241_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb3_and250_i241_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb3_and250_i241_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb3_and250_i241_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in((local_bb3_and250_i241 & 32'hFF)),
	.data_out(rnode_173to174_bb3_and250_i241_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb3_and250_i241_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb3_and250_i241_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb3_and250_i241_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb3_and250_i241_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb3_and250_i241_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and250_i241_stall_in = 1'b0;
assign rnode_173to174_bb3_and250_i241_0_NO_SHIFT_REG = rnode_173to174_bb3_and250_i241_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb3_and250_i241_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3_and250_i241_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_173to175_bb3_and269_i252_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to175_bb3_and269_i252_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to175_bb3_and269_i252_0_NO_SHIFT_REG;
 logic rnode_173to175_bb3_and269_i252_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to175_bb3_and269_i252_0_reg_175_NO_SHIFT_REG;
 logic rnode_173to175_bb3_and269_i252_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_173to175_bb3_and269_i252_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_173to175_bb3_and269_i252_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_173to175_bb3_and269_i252_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to175_bb3_and269_i252_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to175_bb3_and269_i252_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_173to175_bb3_and269_i252_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_173to175_bb3_and269_i252_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in((local_bb3_and269_i252 & 32'hFF800000)),
	.data_out(rnode_173to175_bb3_and269_i252_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_173to175_bb3_and269_i252_0_reg_175_fifo.DEPTH = 2;
defparam rnode_173to175_bb3_and269_i252_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_173to175_bb3_and269_i252_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to175_bb3_and269_i252_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_173to175_bb3_and269_i252_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and269_i252_stall_in = 1'b0;
assign rnode_173to175_bb3_and269_i252_0_NO_SHIFT_REG = rnode_173to175_bb3_and269_i252_0_reg_175_NO_SHIFT_REG;
assign rnode_173to175_bb3_and269_i252_0_stall_in_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_173to175_bb3_and269_i252_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb3_add245_i238_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_173to174_bb3_add245_i238_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb3_add245_i238_0_NO_SHIFT_REG;
 logic rnode_173to174_bb3_add245_i238_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_173to174_bb3_add245_i238_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb3_add245_i238_1_NO_SHIFT_REG;
 logic rnode_173to174_bb3_add245_i238_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb3_add245_i238_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_add245_i238_0_valid_out_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_add245_i238_0_stall_in_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_add245_i238_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb3_add245_i238_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb3_add245_i238_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb3_add245_i238_0_stall_in_0_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb3_add245_i238_0_valid_out_0_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb3_add245_i238_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb3_add245_i238),
	.data_out(rnode_173to174_bb3_add245_i238_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb3_add245_i238_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb3_add245_i238_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb3_add245_i238_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb3_add245_i238_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb3_add245_i238_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_add245_i238_stall_in = 1'b0;
assign rnode_173to174_bb3_add245_i238_0_stall_in_0_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3_add245_i238_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb3_add245_i238_0_NO_SHIFT_REG = rnode_173to174_bb3_add245_i238_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb3_add245_i238_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb3_add245_i238_1_NO_SHIFT_REG = rnode_173to174_bb3_add245_i238_0_reg_174_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb3__45_i230_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_173to174_bb3__45_i230_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb3__45_i230_0_NO_SHIFT_REG;
 logic rnode_173to174_bb3__45_i230_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_173to174_bb3__45_i230_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb3__45_i230_1_NO_SHIFT_REG;
 logic rnode_173to174_bb3__45_i230_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_173to174_bb3__45_i230_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb3__45_i230_2_NO_SHIFT_REG;
 logic rnode_173to174_bb3__45_i230_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb3__45_i230_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3__45_i230_0_valid_out_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3__45_i230_0_stall_in_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3__45_i230_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb3__45_i230_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb3__45_i230_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb3__45_i230_0_stall_in_0_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb3__45_i230_0_valid_out_0_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb3__45_i230_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in((local_bb3__45_i230 & 32'hFFFFFFF)),
	.data_out(rnode_173to174_bb3__45_i230_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb3__45_i230_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb3__45_i230_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb3__45_i230_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb3__45_i230_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb3__45_i230_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__45_i230_stall_in = 1'b0;
assign rnode_173to174_bb3__45_i230_0_stall_in_0_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3__45_i230_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb3__45_i230_0_NO_SHIFT_REG = rnode_173to174_bb3__45_i230_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb3__45_i230_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb3__45_i230_1_NO_SHIFT_REG = rnode_173to174_bb3__45_i230_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb3__45_i230_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb3__45_i230_2_NO_SHIFT_REG = rnode_173to174_bb3__45_i230_0_reg_174_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb3_not_cmp37_i226_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb3_not_cmp37_i226_0_stall_in_NO_SHIFT_REG;
 logic rnode_173to174_bb3_not_cmp37_i226_0_NO_SHIFT_REG;
 logic rnode_173to174_bb3_not_cmp37_i226_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic rnode_173to174_bb3_not_cmp37_i226_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_not_cmp37_i226_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_not_cmp37_i226_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_not_cmp37_i226_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb3_not_cmp37_i226_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb3_not_cmp37_i226_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb3_not_cmp37_i226_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb3_not_cmp37_i226_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb3_not_cmp37_i226_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb3_not_cmp37_i226),
	.data_out(rnode_173to174_bb3_not_cmp37_i226_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb3_not_cmp37_i226_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb3_not_cmp37_i226_0_reg_174_fifo.DATA_WIDTH = 1;
defparam rnode_173to174_bb3_not_cmp37_i226_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb3_not_cmp37_i226_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb3_not_cmp37_i226_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_not_cmp37_i226_stall_in_1 = 1'b0;
assign rnode_173to174_bb3_not_cmp37_i226_0_NO_SHIFT_REG = rnode_173to174_bb3_not_cmp37_i226_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb3_not_cmp37_i226_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3_not_cmp37_i226_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_and251_i_stall_local;
wire [31:0] local_bb3_and251_i;

assign local_bb3_and251_i = (local_bb3_fold_i & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and270_i_stall_local;
wire [31:0] local_bb3_and270_i;

assign local_bb3_and270_i = (local_bb3_fold_i << 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb3_and209_i_stall_local;
wire [31:0] local_bb3_and209_i;

assign local_bb3_and209_i = (local_bb3_shl208_i & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and250_i_stall_local;
wire [31:0] local_bb3_and250_i;

assign local_bb3_and250_i = (local_bb3_fold_i85 & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and269_i_stall_local;
wire [31:0] local_bb3_and269_i;

assign local_bb3_and269_i = (local_bb3_fold_i85 << 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb3_and208_i_stall_local;
wire [31:0] local_bb3_and208_i;

assign local_bb3_and208_i = (local_bb3_shl207_i & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_notrhs_i243_stall_local;
wire local_bb3_notrhs_i243;

assign local_bb3_notrhs_i243 = ((rnode_173to174_bb3_and250_i241_0_NO_SHIFT_REG & 32'hFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_shl273_i253_stall_local;
wire [31:0] local_bb3_shl273_i253;

assign local_bb3_shl273_i253 = ((rnode_173to175_bb3_and269_i252_0_NO_SHIFT_REG & 32'hFF800000) & 32'h7F800000);

// This section implements an unregistered operation.
// 
wire local_bb3_and247_i239_stall_local;
wire [31:0] local_bb3_and247_i239;

assign local_bb3_and247_i239 = (rnode_173to174_bb3_add245_i238_0_NO_SHIFT_REG & 32'h100);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp258_i246_stall_local;
wire local_bb3_cmp258_i246;

assign local_bb3_cmp258_i246 = ($signed(rnode_173to174_bb3_add245_i238_1_NO_SHIFT_REG) > $signed(32'hFE));

// This section implements an unregistered operation.
// 
wire local_bb3_and225_i231_stall_local;
wire [31:0] local_bb3_and225_i231;

assign local_bb3_and225_i231 = ((rnode_173to174_bb3__45_i230_0_NO_SHIFT_REG & 32'hFFFFFFF) & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and270_i249_stall_local;
wire [31:0] local_bb3_and270_i249;

assign local_bb3_and270_i249 = ((rnode_173to174_bb3__45_i230_1_NO_SHIFT_REG & 32'hFFFFFFF) & 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb3_shr271_i250_valid_out;
wire local_bb3_shr271_i250_stall_in;
wire local_bb3_shr271_i250_inputs_ready;
wire local_bb3_shr271_i250_stall_local;
wire [31:0] local_bb3_shr271_i250;

assign local_bb3_shr271_i250_inputs_ready = rnode_173to174_bb3__45_i230_0_valid_out_2_NO_SHIFT_REG;
assign local_bb3_shr271_i250 = ((rnode_173to174_bb3__45_i230_2_NO_SHIFT_REG & 32'hFFFFFFF) >> 32'h3);
assign local_bb3_shr271_i250_valid_out = 1'b1;
assign rnode_173to174_bb3__45_i230_0_stall_in_2_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3__44_i_stall_local;
wire [31:0] local_bb3__44_i;

assign local_bb3__44_i = (local_bb3__40_demorgan_i ? (local_bb3_and209_i & 32'h7FFFFFF) : (local_bb3_or220_i & 32'h7FFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3__44_i81_stall_local;
wire [31:0] local_bb3__44_i81;

assign local_bb3__44_i81 = (local_bb3__40_demorgan_i78 ? (local_bb3_and208_i & 32'h7FFFFFF) : (local_bb3_or219_i & 32'h7FFFFFF));

// This section implements an unregistered operation.
// 
wire local_bb3_notlhs_i242_stall_local;
wire local_bb3_notlhs_i242;

assign local_bb3_notlhs_i242 = ((local_bb3_and247_i239 & 32'h100) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp226_i232_stall_local;
wire local_bb3_cmp226_i232;

assign local_bb3_cmp226_i232 = ((local_bb3_and225_i231 & 32'h7FFFFFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp296_i264_stall_local;
wire local_bb3_cmp296_i264;

assign local_bb3_cmp296_i264 = ((local_bb3_and270_i249 & 32'h7) > 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp296_i264_valid_out;
wire local_bb3_cmp296_i264_stall_in;
wire local_bb3_cmp299_i265_valid_out;
wire local_bb3_cmp299_i265_stall_in;
wire local_bb3_cmp299_i265_inputs_ready;
wire local_bb3_cmp299_i265_stall_local;
wire local_bb3_cmp299_i265;

assign local_bb3_cmp299_i265_inputs_ready = rnode_173to174_bb3__45_i230_0_valid_out_1_NO_SHIFT_REG;
assign local_bb3_cmp299_i265 = ((local_bb3_and270_i249 & 32'h7) == 32'h4);
assign local_bb3_cmp296_i264_valid_out = 1'b1;
assign local_bb3_cmp299_i265_valid_out = 1'b1;
assign rnode_173to174_bb3__45_i230_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb3_shr271_i250_0_valid_out_NO_SHIFT_REG;
 logic rnode_174to175_bb3_shr271_i250_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb3_shr271_i250_0_NO_SHIFT_REG;
 logic rnode_174to175_bb3_shr271_i250_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb3_shr271_i250_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_shr271_i250_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_shr271_i250_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_shr271_i250_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb3_shr271_i250_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb3_shr271_i250_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb3_shr271_i250_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb3_shr271_i250_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb3_shr271_i250_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in((local_bb3_shr271_i250 & 32'h1FFFFFF)),
	.data_out(rnode_174to175_bb3_shr271_i250_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb3_shr271_i250_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb3_shr271_i250_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_174to175_bb3_shr271_i250_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb3_shr271_i250_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb3_shr271_i250_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_shr271_i250_stall_in = 1'b0;
assign rnode_174to175_bb3_shr271_i250_0_NO_SHIFT_REG = rnode_174to175_bb3_shr271_i250_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb3_shr271_i250_0_stall_in_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3_shr271_i250_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_and251_i_valid_out;
wire local_bb3_and251_i_stall_in;
wire local_bb3_and270_i_valid_out;
wire local_bb3_and270_i_stall_in;
wire local_bb3_add246_i_valid_out;
wire local_bb3_add246_i_stall_in;
wire local_bb3__45_i_valid_out;
wire local_bb3__45_i_stall_in;
wire local_bb3_not_cmp38_i_valid_out_1;
wire local_bb3_not_cmp38_i_stall_in_1;
wire local_bb3__45_i_inputs_ready;
wire local_bb3__45_i_stall_local;
wire [31:0] local_bb3__45_i;

assign local_bb3__45_i_inputs_ready = (rnode_169to171_bb3_shr16_i_0_valid_out_NO_SHIFT_REG & rnode_169to171_bb3_and17_i_0_valid_out_NO_SHIFT_REG & rnode_169to171_bb3_cmp38_i_0_valid_out_2_NO_SHIFT_REG & rnode_169to171_bb3_cmp38_i_0_valid_out_0_NO_SHIFT_REG & rnode_170to171_bb3_and194_i_0_valid_out_2_NO_SHIFT_REG & rnode_169to171_bb3_cmp38_i_0_valid_out_1_NO_SHIFT_REG & rnode_170to171_bb3_and196_i_0_valid_out_NO_SHIFT_REG & rnode_170to171_bb3_and194_i_0_valid_out_1_NO_SHIFT_REG & rnode_170to171_bb3_and199_i_0_valid_out_NO_SHIFT_REG & rnode_170to171_bb3_and194_i_0_valid_out_0_NO_SHIFT_REG & rnode_170to171_bb3__and_i_i1_0_valid_out_1_NO_SHIFT_REG & rnode_170to171_bb3__and_i_i1_0_valid_out_2_NO_SHIFT_REG & rnode_170to171_bb3__and_i_i1_0_valid_out_0_NO_SHIFT_REG);
assign local_bb3__45_i = (local_bb3__42_i ? (rnode_170to171_bb3_and194_i_2_NO_SHIFT_REG & 32'hFFFFFFF) : (local_bb3__44_i & 32'h7FFFFFF));
assign local_bb3_and251_i_valid_out = 1'b1;
assign local_bb3_and270_i_valid_out = 1'b1;
assign local_bb3_add246_i_valid_out = 1'b1;
assign local_bb3__45_i_valid_out = 1'b1;
assign local_bb3_not_cmp38_i_valid_out_1 = 1'b1;
assign rnode_169to171_bb3_shr16_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_and17_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_cmp38_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_cmp38_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and194_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_cmp38_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and196_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and194_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and199_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and194_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3__and_i_i1_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3__and_i_i1_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3__and_i_i1_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and250_i_valid_out;
wire local_bb3_and250_i_stall_in;
wire local_bb3_and269_i_valid_out;
wire local_bb3_and269_i_stall_in;
wire local_bb3_add245_i_valid_out;
wire local_bb3_add245_i_stall_in;
wire local_bb3__45_i82_valid_out;
wire local_bb3__45_i82_stall_in;
wire local_bb3_not_cmp37_i_valid_out_1;
wire local_bb3_not_cmp37_i_stall_in_1;
wire local_bb3__45_i82_inputs_ready;
wire local_bb3__45_i82_stall_local;
wire [31:0] local_bb3__45_i82;

assign local_bb3__45_i82_inputs_ready = (rnode_169to171_bb3_shr16_i15_0_valid_out_NO_SHIFT_REG & rnode_169to171_bb3_and17_i16_0_valid_out_NO_SHIFT_REG & rnode_169to171_bb3_cmp37_i_0_valid_out_2_NO_SHIFT_REG & rnode_169to171_bb3_cmp37_i_0_valid_out_0_NO_SHIFT_REG & rnode_170to171_bb3_and193_i_0_valid_out_2_NO_SHIFT_REG & rnode_169to171_bb3_cmp37_i_0_valid_out_1_NO_SHIFT_REG & rnode_170to171_bb3_and195_i_0_valid_out_NO_SHIFT_REG & rnode_170to171_bb3_and193_i_0_valid_out_1_NO_SHIFT_REG & rnode_170to171_bb3_and198_i_0_valid_out_NO_SHIFT_REG & rnode_170to171_bb3_and193_i_0_valid_out_0_NO_SHIFT_REG & rnode_170to171_bb3__and_i_i74_0_valid_out_1_NO_SHIFT_REG & rnode_170to171_bb3__and_i_i74_0_valid_out_2_NO_SHIFT_REG & rnode_170to171_bb3__and_i_i74_0_valid_out_0_NO_SHIFT_REG);
assign local_bb3__45_i82 = (local_bb3__42_i79 ? (rnode_170to171_bb3_and193_i_2_NO_SHIFT_REG & 32'hFFFFFFF) : (local_bb3__44_i81 & 32'h7FFFFFF));
assign local_bb3_and250_i_valid_out = 1'b1;
assign local_bb3_and269_i_valid_out = 1'b1;
assign local_bb3_add245_i_valid_out = 1'b1;
assign local_bb3__45_i82_valid_out = 1'b1;
assign local_bb3_not_cmp37_i_valid_out_1 = 1'b1;
assign rnode_169to171_bb3_shr16_i15_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_and17_i16_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_cmp37_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_cmp37_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and193_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb3_cmp37_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and195_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and193_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and198_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3_and193_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3__and_i_i74_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3__and_i_i74_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb3__and_i_i74_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_not__46_i244_stall_local;
wire local_bb3_not__46_i244;

assign local_bb3_not__46_i244 = (local_bb3_notrhs_i243 | local_bb3_notlhs_i242);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp226_not_i233_stall_local;
wire local_bb3_cmp226_not_i233;

assign local_bb3_cmp226_not_i233 = (local_bb3_cmp226_i232 ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb3_cmp296_i264_0_valid_out_NO_SHIFT_REG;
 logic rnode_174to175_bb3_cmp296_i264_0_stall_in_NO_SHIFT_REG;
 logic rnode_174to175_bb3_cmp296_i264_0_NO_SHIFT_REG;
 logic rnode_174to175_bb3_cmp296_i264_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic rnode_174to175_bb3_cmp296_i264_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_cmp296_i264_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_cmp296_i264_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_cmp296_i264_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb3_cmp296_i264_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb3_cmp296_i264_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb3_cmp296_i264_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb3_cmp296_i264_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb3_cmp296_i264_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(local_bb3_cmp296_i264),
	.data_out(rnode_174to175_bb3_cmp296_i264_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb3_cmp296_i264_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb3_cmp296_i264_0_reg_175_fifo.DATA_WIDTH = 1;
defparam rnode_174to175_bb3_cmp296_i264_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb3_cmp296_i264_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb3_cmp296_i264_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_cmp296_i264_stall_in = 1'b0;
assign rnode_174to175_bb3_cmp296_i264_0_NO_SHIFT_REG = rnode_174to175_bb3_cmp296_i264_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb3_cmp296_i264_0_stall_in_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3_cmp296_i264_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb3_cmp299_i265_0_valid_out_NO_SHIFT_REG;
 logic rnode_174to175_bb3_cmp299_i265_0_stall_in_NO_SHIFT_REG;
 logic rnode_174to175_bb3_cmp299_i265_0_NO_SHIFT_REG;
 logic rnode_174to175_bb3_cmp299_i265_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic rnode_174to175_bb3_cmp299_i265_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_cmp299_i265_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_cmp299_i265_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_cmp299_i265_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb3_cmp299_i265_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb3_cmp299_i265_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb3_cmp299_i265_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb3_cmp299_i265_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb3_cmp299_i265_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(local_bb3_cmp299_i265),
	.data_out(rnode_174to175_bb3_cmp299_i265_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb3_cmp299_i265_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb3_cmp299_i265_0_reg_175_fifo.DATA_WIDTH = 1;
defparam rnode_174to175_bb3_cmp299_i265_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb3_cmp299_i265_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb3_cmp299_i265_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_cmp299_i265_stall_in = 1'b0;
assign rnode_174to175_bb3_cmp299_i265_0_NO_SHIFT_REG = rnode_174to175_bb3_cmp299_i265_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb3_cmp299_i265_0_stall_in_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3_cmp299_i265_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_and272_i251_stall_local;
wire [31:0] local_bb3_and272_i251;

assign local_bb3_and272_i251 = ((rnode_174to175_bb3_shr271_i250_0_NO_SHIFT_REG & 32'h1FFFFFF) & 32'h7FFFFF);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3_and251_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and251_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_and251_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and251_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_and251_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and251_i_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and251_i_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and251_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3_and251_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3_and251_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3_and251_i_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3_and251_i_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3_and251_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in((local_bb3_and251_i & 32'hFF)),
	.data_out(rnode_171to172_bb3_and251_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3_and251_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3_and251_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb3_and251_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3_and251_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3_and251_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and251_i_stall_in = 1'b0;
assign rnode_171to172_bb3_and251_i_0_NO_SHIFT_REG = rnode_171to172_bb3_and251_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3_and251_i_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_and251_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_171to173_bb3_and270_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and270_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to173_bb3_and270_i_0_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and270_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to173_bb3_and270_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and270_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and270_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and270_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_171to173_bb3_and270_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to173_bb3_and270_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to173_bb3_and270_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_171to173_bb3_and270_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_171to173_bb3_and270_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in((local_bb3_and270_i & 32'hFF800000)),
	.data_out(rnode_171to173_bb3_and270_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_171to173_bb3_and270_i_0_reg_173_fifo.DEPTH = 2;
defparam rnode_171to173_bb3_and270_i_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_171to173_bb3_and270_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to173_bb3_and270_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_171to173_bb3_and270_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and270_i_stall_in = 1'b0;
assign rnode_171to173_bb3_and270_i_0_NO_SHIFT_REG = rnode_171to173_bb3_and270_i_0_reg_173_NO_SHIFT_REG;
assign rnode_171to173_bb3_and270_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_171to173_bb3_and270_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3_add246_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add246_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_add246_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add246_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add246_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_add246_i_1_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add246_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_add246_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add246_i_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add246_i_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add246_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3_add246_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3_add246_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3_add246_i_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3_add246_i_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3_add246_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb3_add246_i),
	.data_out(rnode_171to172_bb3_add246_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3_add246_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3_add246_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb3_add246_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3_add246_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3_add246_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_add246_i_stall_in = 1'b0;
assign rnode_171to172_bb3_add246_i_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_add246_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3_add246_i_0_NO_SHIFT_REG = rnode_171to172_bb3_add246_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3_add246_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3_add246_i_1_NO_SHIFT_REG = rnode_171to172_bb3_add246_i_0_reg_172_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3__45_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3__45_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3__45_i_1_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3__45_i_2_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3__45_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3__45_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3__45_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3__45_i_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3__45_i_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3__45_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in((local_bb3__45_i & 32'hFFFFFFF)),
	.data_out(rnode_171to172_bb3__45_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3__45_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3__45_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb3__45_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3__45_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3__45_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__45_i_stall_in = 1'b0;
assign rnode_171to172_bb3__45_i_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3__45_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3__45_i_0_NO_SHIFT_REG = rnode_171to172_bb3__45_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3__45_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3__45_i_1_NO_SHIFT_REG = rnode_171to172_bb3__45_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3__45_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3__45_i_2_NO_SHIFT_REG = rnode_171to172_bb3__45_i_0_reg_172_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3_not_cmp38_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb3_not_cmp38_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_171to172_bb3_not_cmp38_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_not_cmp38_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_171to172_bb3_not_cmp38_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_not_cmp38_i_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_not_cmp38_i_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_not_cmp38_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3_not_cmp38_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3_not_cmp38_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3_not_cmp38_i_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3_not_cmp38_i_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3_not_cmp38_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb3_not_cmp38_i),
	.data_out(rnode_171to172_bb3_not_cmp38_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3_not_cmp38_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3_not_cmp38_i_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_171to172_bb3_not_cmp38_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3_not_cmp38_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3_not_cmp38_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_not_cmp38_i_stall_in_1 = 1'b0;
assign rnode_171to172_bb3_not_cmp38_i_0_NO_SHIFT_REG = rnode_171to172_bb3_not_cmp38_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3_not_cmp38_i_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_not_cmp38_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3_and250_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and250_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_and250_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and250_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_and250_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and250_i_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and250_i_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_and250_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3_and250_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3_and250_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3_and250_i_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3_and250_i_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3_and250_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in((local_bb3_and250_i & 32'hFF)),
	.data_out(rnode_171to172_bb3_and250_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3_and250_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3_and250_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb3_and250_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3_and250_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3_and250_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and250_i_stall_in = 1'b0;
assign rnode_171to172_bb3_and250_i_0_NO_SHIFT_REG = rnode_171to172_bb3_and250_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3_and250_i_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_and250_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_171to173_bb3_and269_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and269_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to173_bb3_and269_i_0_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and269_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to173_bb3_and269_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and269_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and269_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_171to173_bb3_and269_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_171to173_bb3_and269_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to173_bb3_and269_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to173_bb3_and269_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_171to173_bb3_and269_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_171to173_bb3_and269_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in((local_bb3_and269_i & 32'hFF800000)),
	.data_out(rnode_171to173_bb3_and269_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_171to173_bb3_and269_i_0_reg_173_fifo.DEPTH = 2;
defparam rnode_171to173_bb3_and269_i_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_171to173_bb3_and269_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to173_bb3_and269_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_171to173_bb3_and269_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_and269_i_stall_in = 1'b0;
assign rnode_171to173_bb3_and269_i_0_NO_SHIFT_REG = rnode_171to173_bb3_and269_i_0_reg_173_NO_SHIFT_REG;
assign rnode_171to173_bb3_and269_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_171to173_bb3_and269_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3_add245_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add245_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_add245_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add245_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add245_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_add245_i_1_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add245_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3_add245_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add245_i_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add245_i_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_add245_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3_add245_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3_add245_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3_add245_i_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3_add245_i_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3_add245_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb3_add245_i),
	.data_out(rnode_171to172_bb3_add245_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3_add245_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3_add245_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb3_add245_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3_add245_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3_add245_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_add245_i_stall_in = 1'b0;
assign rnode_171to172_bb3_add245_i_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_add245_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3_add245_i_0_NO_SHIFT_REG = rnode_171to172_bb3_add245_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3_add245_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3_add245_i_1_NO_SHIFT_REG = rnode_171to172_bb3_add245_i_0_reg_172_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3__45_i82_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i82_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3__45_i82_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i82_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i82_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3__45_i82_1_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i82_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i82_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3__45_i82_2_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i82_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb3__45_i82_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i82_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i82_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3__45_i82_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3__45_i82_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3__45_i82_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3__45_i82_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3__45_i82_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3__45_i82_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in((local_bb3__45_i82 & 32'hFFFFFFF)),
	.data_out(rnode_171to172_bb3__45_i82_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3__45_i82_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3__45_i82_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb3__45_i82_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3__45_i82_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3__45_i82_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__45_i82_stall_in = 1'b0;
assign rnode_171to172_bb3__45_i82_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3__45_i82_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3__45_i82_0_NO_SHIFT_REG = rnode_171to172_bb3__45_i82_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3__45_i82_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3__45_i82_1_NO_SHIFT_REG = rnode_171to172_bb3__45_i82_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3__45_i82_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb3__45_i82_2_NO_SHIFT_REG = rnode_171to172_bb3__45_i82_0_reg_172_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb3_not_cmp37_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb3_not_cmp37_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_171to172_bb3_not_cmp37_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb3_not_cmp37_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_171to172_bb3_not_cmp37_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_not_cmp37_i_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_not_cmp37_i_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb3_not_cmp37_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb3_not_cmp37_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb3_not_cmp37_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb3_not_cmp37_i_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb3_not_cmp37_i_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb3_not_cmp37_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb3_not_cmp37_i),
	.data_out(rnode_171to172_bb3_not_cmp37_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb3_not_cmp37_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb3_not_cmp37_i_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_171to172_bb3_not_cmp37_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb3_not_cmp37_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb3_not_cmp37_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_not_cmp37_i_stall_in_1 = 1'b0;
assign rnode_171to172_bb3_not_cmp37_i_0_NO_SHIFT_REG = rnode_171to172_bb3_not_cmp37_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb3_not_cmp37_i_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_not_cmp37_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3__47_i245_stall_local;
wire local_bb3__47_i245;

assign local_bb3__47_i245 = (local_bb3_cmp226_i232 | local_bb3_not__46_i244);

// This section implements an unregistered operation.
// 
wire local_bb3_brmerge12_i234_stall_local;
wire local_bb3_brmerge12_i234;

assign local_bb3_brmerge12_i234 = (local_bb3_cmp226_not_i233 | rnode_173to174_bb3_not_cmp37_i226_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot262__i247_stall_local;
wire local_bb3_lnot262__i247;

assign local_bb3_lnot262__i247 = (local_bb3_cmp258_i246 & local_bb3_cmp226_not_i233);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp29649_i268_stall_local;
wire [31:0] local_bb3_cmp29649_i268;

assign local_bb3_cmp29649_i268[31:1] = 31'h0;
assign local_bb3_cmp29649_i268[0] = rnode_174to175_bb3_cmp296_i264_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_conv300_i266_stall_local;
wire [31:0] local_bb3_conv300_i266;

assign local_bb3_conv300_i266[31:1] = 31'h0;
assign local_bb3_conv300_i266[0] = rnode_174to175_bb3_cmp299_i265_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_or274_i254_stall_local;
wire [31:0] local_bb3_or274_i254;

assign local_bb3_or274_i254 = ((local_bb3_and272_i251 & 32'h7FFFFF) | (local_bb3_shl273_i253 & 32'h7F800000));

// This section implements an unregistered operation.
// 
wire local_bb3_notrhs_i_stall_local;
wire local_bb3_notrhs_i;

assign local_bb3_notrhs_i = ((rnode_171to172_bb3_and251_i_0_NO_SHIFT_REG & 32'hFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_shl274_i_stall_local;
wire [31:0] local_bb3_shl274_i;

assign local_bb3_shl274_i = ((rnode_171to173_bb3_and270_i_0_NO_SHIFT_REG & 32'hFF800000) & 32'h7F800000);

// This section implements an unregistered operation.
// 
wire local_bb3_and248_i_stall_local;
wire [31:0] local_bb3_and248_i;

assign local_bb3_and248_i = (rnode_171to172_bb3_add246_i_0_NO_SHIFT_REG & 32'h100);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp259_i_stall_local;
wire local_bb3_cmp259_i;

assign local_bb3_cmp259_i = ($signed(rnode_171to172_bb3_add246_i_1_NO_SHIFT_REG) > $signed(32'hFE));

// This section implements an unregistered operation.
// 
wire local_bb3_and226_i_stall_local;
wire [31:0] local_bb3_and226_i;

assign local_bb3_and226_i = ((rnode_171to172_bb3__45_i_0_NO_SHIFT_REG & 32'hFFFFFFF) & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and271_i_stall_local;
wire [31:0] local_bb3_and271_i;

assign local_bb3_and271_i = ((rnode_171to172_bb3__45_i_1_NO_SHIFT_REG & 32'hFFFFFFF) & 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb3_shr272_i_valid_out;
wire local_bb3_shr272_i_stall_in;
wire local_bb3_shr272_i_inputs_ready;
wire local_bb3_shr272_i_stall_local;
wire [31:0] local_bb3_shr272_i;

assign local_bb3_shr272_i_inputs_ready = rnode_171to172_bb3__45_i_0_valid_out_2_NO_SHIFT_REG;
assign local_bb3_shr272_i = ((rnode_171to172_bb3__45_i_2_NO_SHIFT_REG & 32'hFFFFFFF) >> 32'h3);
assign local_bb3_shr272_i_valid_out = 1'b1;
assign rnode_171to172_bb3__45_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_notrhs_i87_stall_local;
wire local_bb3_notrhs_i87;

assign local_bb3_notrhs_i87 = ((rnode_171to172_bb3_and250_i_0_NO_SHIFT_REG & 32'hFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_shl273_i_stall_local;
wire [31:0] local_bb3_shl273_i;

assign local_bb3_shl273_i = ((rnode_171to173_bb3_and269_i_0_NO_SHIFT_REG & 32'hFF800000) & 32'h7F800000);

// This section implements an unregistered operation.
// 
wire local_bb3_and247_i_stall_local;
wire [31:0] local_bb3_and247_i;

assign local_bb3_and247_i = (rnode_171to172_bb3_add245_i_0_NO_SHIFT_REG & 32'h100);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp258_i_stall_local;
wire local_bb3_cmp258_i;

assign local_bb3_cmp258_i = ($signed(rnode_171to172_bb3_add245_i_1_NO_SHIFT_REG) > $signed(32'hFE));

// This section implements an unregistered operation.
// 
wire local_bb3_and225_i_stall_local;
wire [31:0] local_bb3_and225_i;

assign local_bb3_and225_i = ((rnode_171to172_bb3__45_i82_0_NO_SHIFT_REG & 32'hFFFFFFF) & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_and270_i90_stall_local;
wire [31:0] local_bb3_and270_i90;

assign local_bb3_and270_i90 = ((rnode_171to172_bb3__45_i82_1_NO_SHIFT_REG & 32'hFFFFFFF) & 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb3_shr271_i_valid_out;
wire local_bb3_shr271_i_stall_in;
wire local_bb3_shr271_i_inputs_ready;
wire local_bb3_shr271_i_stall_local;
wire [31:0] local_bb3_shr271_i;

assign local_bb3_shr271_i_inputs_ready = rnode_171to172_bb3__45_i82_0_valid_out_2_NO_SHIFT_REG;
assign local_bb3_shr271_i = ((rnode_171to172_bb3__45_i82_2_NO_SHIFT_REG & 32'hFFFFFFF) >> 32'h3);
assign local_bb3_shr271_i_valid_out = 1'b1;
assign rnode_171to172_bb3__45_i82_0_stall_in_2_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_resultSign_0_i235_stall_local;
wire [31:0] local_bb3_resultSign_0_i235;

assign local_bb3_resultSign_0_i235 = (local_bb3_brmerge12_i234 ? (rnode_173to174_bb3_and35_i118_0_NO_SHIFT_REG & 32'h80000000) : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_resultSign_0_i235_valid_out;
wire local_bb3_resultSign_0_i235_stall_in;
wire local_bb3__47_i245_valid_out;
wire local_bb3__47_i245_stall_in;
wire local_bb3_or2662_i248_valid_out;
wire local_bb3_or2662_i248_stall_in;
wire local_bb3_or2662_i248_inputs_ready;
wire local_bb3_or2662_i248_stall_local;
wire local_bb3_or2662_i248;

assign local_bb3_or2662_i248_inputs_ready = (rnode_173to174_bb3_and35_i118_0_valid_out_NO_SHIFT_REG & rnode_173to174_bb3_not_cmp37_i226_0_valid_out_NO_SHIFT_REG & rnode_173to174_bb3_add245_i238_0_valid_out_0_NO_SHIFT_REG & rnode_173to174_bb3_and250_i241_0_valid_out_NO_SHIFT_REG & rnode_173to174_bb3__45_i230_0_valid_out_0_NO_SHIFT_REG & rnode_173to174_bb3_add245_i238_0_valid_out_1_NO_SHIFT_REG & rnode_173to174_bb3_var__u6_0_valid_out_NO_SHIFT_REG);
assign local_bb3_or2662_i248 = (rnode_173to174_bb3_var__u6_0_NO_SHIFT_REG | local_bb3_lnot262__i247);
assign local_bb3_resultSign_0_i235_valid_out = 1'b1;
assign local_bb3__47_i245_valid_out = 1'b1;
assign local_bb3_or2662_i248_valid_out = 1'b1;
assign rnode_173to174_bb3_and35_i118_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3_not_cmp37_i226_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3_add245_i238_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3_and250_i241_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3__45_i230_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3_add245_i238_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3_var__u6_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_notlhs_i_stall_local;
wire local_bb3_notlhs_i;

assign local_bb3_notlhs_i = ((local_bb3_and248_i & 32'h100) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp227_i_stall_local;
wire local_bb3_cmp227_i;

assign local_bb3_cmp227_i = ((local_bb3_and226_i & 32'h7FFFFFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp297_i_stall_local;
wire local_bb3_cmp297_i;

assign local_bb3_cmp297_i = ((local_bb3_and271_i & 32'h7) > 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp297_i_valid_out;
wire local_bb3_cmp297_i_stall_in;
wire local_bb3_cmp300_i_valid_out;
wire local_bb3_cmp300_i_stall_in;
wire local_bb3_cmp300_i_inputs_ready;
wire local_bb3_cmp300_i_stall_local;
wire local_bb3_cmp300_i;

assign local_bb3_cmp300_i_inputs_ready = rnode_171to172_bb3__45_i_0_valid_out_1_NO_SHIFT_REG;
assign local_bb3_cmp300_i = ((local_bb3_and271_i & 32'h7) == 32'h4);
assign local_bb3_cmp297_i_valid_out = 1'b1;
assign local_bb3_cmp300_i_valid_out = 1'b1;
assign rnode_171to172_bb3__45_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3_shr272_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb3_shr272_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_shr272_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_shr272_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_shr272_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_shr272_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_shr272_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_shr272_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3_shr272_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3_shr272_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3_shr272_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3_shr272_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3_shr272_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in((local_bb3_shr272_i & 32'h1FFFFFF)),
	.data_out(rnode_172to173_bb3_shr272_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3_shr272_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3_shr272_i_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb3_shr272_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3_shr272_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3_shr272_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_shr272_i_stall_in = 1'b0;
assign rnode_172to173_bb3_shr272_i_0_NO_SHIFT_REG = rnode_172to173_bb3_shr272_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_shr272_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_shr272_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_notlhs_i86_stall_local;
wire local_bb3_notlhs_i86;

assign local_bb3_notlhs_i86 = ((local_bb3_and247_i & 32'h100) != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp226_i_stall_local;
wire local_bb3_cmp226_i;

assign local_bb3_cmp226_i = ((local_bb3_and225_i & 32'h7FFFFFF) == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp296_i_stall_local;
wire local_bb3_cmp296_i;

assign local_bb3_cmp296_i = ((local_bb3_and270_i90 & 32'h7) > 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp296_i_valid_out;
wire local_bb3_cmp296_i_stall_in;
wire local_bb3_cmp299_i_valid_out;
wire local_bb3_cmp299_i_stall_in;
wire local_bb3_cmp299_i_inputs_ready;
wire local_bb3_cmp299_i_stall_local;
wire local_bb3_cmp299_i;

assign local_bb3_cmp299_i_inputs_ready = rnode_171to172_bb3__45_i82_0_valid_out_1_NO_SHIFT_REG;
assign local_bb3_cmp299_i = ((local_bb3_and270_i90 & 32'h7) == 32'h4);
assign local_bb3_cmp296_i_valid_out = 1'b1;
assign local_bb3_cmp299_i_valid_out = 1'b1;
assign rnode_171to172_bb3__45_i82_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3_shr271_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb3_shr271_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_shr271_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_shr271_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_shr271_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_shr271_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_shr271_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_shr271_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3_shr271_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3_shr271_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3_shr271_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3_shr271_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3_shr271_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in((local_bb3_shr271_i & 32'h1FFFFFF)),
	.data_out(rnode_172to173_bb3_shr271_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3_shr271_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3_shr271_i_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb3_shr271_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3_shr271_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3_shr271_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_shr271_i_stall_in = 1'b0;
assign rnode_172to173_bb3_shr271_i_0_NO_SHIFT_REG = rnode_172to173_bb3_shr271_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_shr271_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_shr271_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb3_resultSign_0_i235_0_valid_out_NO_SHIFT_REG;
 logic rnode_174to175_bb3_resultSign_0_i235_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb3_resultSign_0_i235_0_NO_SHIFT_REG;
 logic rnode_174to175_bb3_resultSign_0_i235_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb3_resultSign_0_i235_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_resultSign_0_i235_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_resultSign_0_i235_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_resultSign_0_i235_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb3_resultSign_0_i235_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb3_resultSign_0_i235_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb3_resultSign_0_i235_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb3_resultSign_0_i235_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb3_resultSign_0_i235_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in((local_bb3_resultSign_0_i235 & 32'h80000000)),
	.data_out(rnode_174to175_bb3_resultSign_0_i235_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb3_resultSign_0_i235_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb3_resultSign_0_i235_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_174to175_bb3_resultSign_0_i235_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb3_resultSign_0_i235_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb3_resultSign_0_i235_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_resultSign_0_i235_stall_in = 1'b0;
assign rnode_174to175_bb3_resultSign_0_i235_0_NO_SHIFT_REG = rnode_174to175_bb3_resultSign_0_i235_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb3_resultSign_0_i235_0_stall_in_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3_resultSign_0_i235_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb3__47_i245_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_174to175_bb3__47_i245_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_174to175_bb3__47_i245_0_NO_SHIFT_REG;
 logic rnode_174to175_bb3__47_i245_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_174to175_bb3__47_i245_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_174to175_bb3__47_i245_1_NO_SHIFT_REG;
 logic rnode_174to175_bb3__47_i245_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic rnode_174to175_bb3__47_i245_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3__47_i245_0_valid_out_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3__47_i245_0_stall_in_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3__47_i245_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb3__47_i245_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb3__47_i245_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb3__47_i245_0_stall_in_0_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb3__47_i245_0_valid_out_0_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb3__47_i245_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(local_bb3__47_i245),
	.data_out(rnode_174to175_bb3__47_i245_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb3__47_i245_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb3__47_i245_0_reg_175_fifo.DATA_WIDTH = 1;
defparam rnode_174to175_bb3__47_i245_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb3__47_i245_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb3__47_i245_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__47_i245_stall_in = 1'b0;
assign rnode_174to175_bb3__47_i245_0_stall_in_0_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3__47_i245_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb3__47_i245_0_NO_SHIFT_REG = rnode_174to175_bb3__47_i245_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb3__47_i245_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb3__47_i245_1_NO_SHIFT_REG = rnode_174to175_bb3__47_i245_0_reg_175_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb3_or2662_i248_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_174to175_bb3_or2662_i248_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_174to175_bb3_or2662_i248_0_NO_SHIFT_REG;
 logic rnode_174to175_bb3_or2662_i248_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_174to175_bb3_or2662_i248_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_174to175_bb3_or2662_i248_1_NO_SHIFT_REG;
 logic rnode_174to175_bb3_or2662_i248_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_174to175_bb3_or2662_i248_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_174to175_bb3_or2662_i248_2_NO_SHIFT_REG;
 logic rnode_174to175_bb3_or2662_i248_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic rnode_174to175_bb3_or2662_i248_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_or2662_i248_0_valid_out_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_or2662_i248_0_stall_in_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_or2662_i248_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb3_or2662_i248_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb3_or2662_i248_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb3_or2662_i248_0_stall_in_0_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb3_or2662_i248_0_valid_out_0_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb3_or2662_i248_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(local_bb3_or2662_i248),
	.data_out(rnode_174to175_bb3_or2662_i248_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb3_or2662_i248_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb3_or2662_i248_0_reg_175_fifo.DATA_WIDTH = 1;
defparam rnode_174to175_bb3_or2662_i248_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb3_or2662_i248_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb3_or2662_i248_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_or2662_i248_stall_in = 1'b0;
assign rnode_174to175_bb3_or2662_i248_0_stall_in_0_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3_or2662_i248_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb3_or2662_i248_0_NO_SHIFT_REG = rnode_174to175_bb3_or2662_i248_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb3_or2662_i248_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb3_or2662_i248_1_NO_SHIFT_REG = rnode_174to175_bb3_or2662_i248_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb3_or2662_i248_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb3_or2662_i248_2_NO_SHIFT_REG = rnode_174to175_bb3_or2662_i248_0_reg_175_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_not__46_i_stall_local;
wire local_bb3_not__46_i;

assign local_bb3_not__46_i = (local_bb3_notrhs_i | local_bb3_notlhs_i);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp227_not_i_stall_local;
wire local_bb3_cmp227_not_i;

assign local_bb3_cmp227_not_i = (local_bb3_cmp227_i ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3_cmp297_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp297_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp297_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp297_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp297_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp297_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp297_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp297_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3_cmp297_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3_cmp297_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3_cmp297_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3_cmp297_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3_cmp297_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb3_cmp297_i),
	.data_out(rnode_172to173_bb3_cmp297_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3_cmp297_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3_cmp297_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb3_cmp297_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3_cmp297_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3_cmp297_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_cmp297_i_stall_in = 1'b0;
assign rnode_172to173_bb3_cmp297_i_0_NO_SHIFT_REG = rnode_172to173_bb3_cmp297_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_cmp297_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_cmp297_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3_cmp300_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp300_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp300_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp300_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp300_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp300_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp300_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp300_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3_cmp300_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3_cmp300_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3_cmp300_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3_cmp300_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3_cmp300_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb3_cmp300_i),
	.data_out(rnode_172to173_bb3_cmp300_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3_cmp300_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3_cmp300_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb3_cmp300_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3_cmp300_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3_cmp300_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_cmp300_i_stall_in = 1'b0;
assign rnode_172to173_bb3_cmp300_i_0_NO_SHIFT_REG = rnode_172to173_bb3_cmp300_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_cmp300_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_cmp300_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_and273_i_stall_local;
wire [31:0] local_bb3_and273_i;

assign local_bb3_and273_i = ((rnode_172to173_bb3_shr272_i_0_NO_SHIFT_REG & 32'h1FFFFFF) & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_not__46_i88_stall_local;
wire local_bb3_not__46_i88;

assign local_bb3_not__46_i88 = (local_bb3_notrhs_i87 | local_bb3_notlhs_i86);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp226_not_i_stall_local;
wire local_bb3_cmp226_not_i;

assign local_bb3_cmp226_not_i = (local_bb3_cmp226_i ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3_cmp296_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp296_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp296_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp296_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp296_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp296_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp296_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp296_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3_cmp296_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3_cmp296_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3_cmp296_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3_cmp296_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3_cmp296_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb3_cmp296_i),
	.data_out(rnode_172to173_bb3_cmp296_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3_cmp296_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3_cmp296_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb3_cmp296_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3_cmp296_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3_cmp296_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_cmp296_i_stall_in = 1'b0;
assign rnode_172to173_bb3_cmp296_i_0_NO_SHIFT_REG = rnode_172to173_bb3_cmp296_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_cmp296_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_cmp296_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3_cmp299_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp299_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp299_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp299_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp299_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp299_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp299_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_cmp299_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3_cmp299_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3_cmp299_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3_cmp299_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3_cmp299_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3_cmp299_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb3_cmp299_i),
	.data_out(rnode_172to173_bb3_cmp299_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3_cmp299_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3_cmp299_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb3_cmp299_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3_cmp299_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3_cmp299_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_cmp299_i_stall_in = 1'b0;
assign rnode_172to173_bb3_cmp299_i_0_NO_SHIFT_REG = rnode_172to173_bb3_cmp299_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_cmp299_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_cmp299_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_and272_i_stall_local;
wire [31:0] local_bb3_and272_i;

assign local_bb3_and272_i = ((rnode_172to173_bb3_shr271_i_0_NO_SHIFT_REG & 32'h1FFFFFF) & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_or275_i255_stall_local;
wire [31:0] local_bb3_or275_i255;

assign local_bb3_or275_i255 = ((local_bb3_or274_i254 & 32'h7FFFFFFF) | (rnode_174to175_bb3_resultSign_0_i235_0_NO_SHIFT_REG & 32'h80000000));

// This section implements an unregistered operation.
// 
wire local_bb3_var__u27_stall_local;
wire [31:0] local_bb3_var__u27;

assign local_bb3_var__u27[31:1] = 31'h0;
assign local_bb3_var__u27[0] = rnode_174to175_bb3__47_i245_1_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_or2804_i256_stall_local;
wire local_bb3_or2804_i256;

assign local_bb3_or2804_i256 = (rnode_174to175_bb3__47_i245_0_NO_SHIFT_REG | rnode_174to175_bb3_or2662_i248_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_or2875_i258_stall_local;
wire local_bb3_or2875_i258;

assign local_bb3_or2875_i258 = (rnode_174to175_bb3_or2662_i248_1_NO_SHIFT_REG | rnode_174to175_bb3__26_i133_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u28_stall_local;
wire [31:0] local_bb3_var__u28;

assign local_bb3_var__u28[31:1] = 31'h0;
assign local_bb3_var__u28[0] = rnode_174to175_bb3_or2662_i248_2_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3__47_i_stall_local;
wire local_bb3__47_i;

assign local_bb3__47_i = (local_bb3_cmp227_i | local_bb3_not__46_i);

// This section implements an unregistered operation.
// 
wire local_bb3_brmerge12_i_stall_local;
wire local_bb3_brmerge12_i;

assign local_bb3_brmerge12_i = (local_bb3_cmp227_not_i | rnode_171to172_bb3_not_cmp38_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot263__i_stall_local;
wire local_bb3_lnot263__i;

assign local_bb3_lnot263__i = (local_bb3_cmp259_i & local_bb3_cmp227_not_i);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp29749_i_stall_local;
wire [31:0] local_bb3_cmp29749_i;

assign local_bb3_cmp29749_i[31:1] = 31'h0;
assign local_bb3_cmp29749_i[0] = rnode_172to173_bb3_cmp297_i_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_conv301_i_stall_local;
wire [31:0] local_bb3_conv301_i;

assign local_bb3_conv301_i[31:1] = 31'h0;
assign local_bb3_conv301_i[0] = rnode_172to173_bb3_cmp300_i_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_or275_i_stall_local;
wire [31:0] local_bb3_or275_i;

assign local_bb3_or275_i = ((local_bb3_and273_i & 32'h7FFFFF) | (local_bb3_shl274_i & 32'h7F800000));

// This section implements an unregistered operation.
// 
wire local_bb3__47_i89_stall_local;
wire local_bb3__47_i89;

assign local_bb3__47_i89 = (local_bb3_cmp226_i | local_bb3_not__46_i88);

// This section implements an unregistered operation.
// 
wire local_bb3_brmerge12_i83_stall_local;
wire local_bb3_brmerge12_i83;

assign local_bb3_brmerge12_i83 = (local_bb3_cmp226_not_i | rnode_171to172_bb3_not_cmp37_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot262__i_stall_local;
wire local_bb3_lnot262__i;

assign local_bb3_lnot262__i = (local_bb3_cmp258_i & local_bb3_cmp226_not_i);

// This section implements an unregistered operation.
// 
wire local_bb3_cmp29649_i_stall_local;
wire [31:0] local_bb3_cmp29649_i;

assign local_bb3_cmp29649_i[31:1] = 31'h0;
assign local_bb3_cmp29649_i[0] = rnode_172to173_bb3_cmp296_i_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_conv300_i_stall_local;
wire [31:0] local_bb3_conv300_i;

assign local_bb3_conv300_i[31:1] = 31'h0;
assign local_bb3_conv300_i[0] = rnode_172to173_bb3_cmp299_i_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_or274_i_stall_local;
wire [31:0] local_bb3_or274_i;

assign local_bb3_or274_i = ((local_bb3_and272_i & 32'h7FFFFF) | (local_bb3_shl273_i & 32'h7F800000));

// This section implements an unregistered operation.
// 
wire local_bb3_lnot_ext314_i272_stall_local;
wire [31:0] local_bb3_lnot_ext314_i272;

assign local_bb3_lnot_ext314_i272 = ((local_bb3_var__u27 & 32'h1) ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_cond282_i257_stall_local;
wire [31:0] local_bb3_cond282_i257;

assign local_bb3_cond282_i257 = (local_bb3_or2804_i256 ? 32'h80000000 : 32'hFFFFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_cond289_i259_stall_local;
wire [31:0] local_bb3_cond289_i259;

assign local_bb3_cond289_i259 = (local_bb3_or2875_i258 ? 32'h7F800000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot_ext310_i271_stall_local;
wire [31:0] local_bb3_lnot_ext310_i271;

assign local_bb3_lnot_ext310_i271 = ((local_bb3_var__u28 & 32'h1) ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_resultSign_0_i_stall_local;
wire [31:0] local_bb3_resultSign_0_i;

assign local_bb3_resultSign_0_i = (local_bb3_brmerge12_i ? (rnode_171to172_bb3_and35_i_0_NO_SHIFT_REG & 32'h80000000) : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_resultSign_0_i_valid_out;
wire local_bb3_resultSign_0_i_stall_in;
wire local_bb3__47_i_valid_out;
wire local_bb3__47_i_stall_in;
wire local_bb3_or2672_i_valid_out;
wire local_bb3_or2672_i_stall_in;
wire local_bb3_or2672_i_inputs_ready;
wire local_bb3_or2672_i_stall_local;
wire local_bb3_or2672_i;

assign local_bb3_or2672_i_inputs_ready = (rnode_171to172_bb3_and35_i_0_valid_out_NO_SHIFT_REG & rnode_171to172_bb3_not_cmp38_i_0_valid_out_NO_SHIFT_REG & rnode_171to172_bb3_add246_i_0_valid_out_0_NO_SHIFT_REG & rnode_171to172_bb3_and251_i_0_valid_out_NO_SHIFT_REG & rnode_171to172_bb3__45_i_0_valid_out_0_NO_SHIFT_REG & rnode_171to172_bb3_add246_i_0_valid_out_1_NO_SHIFT_REG & rnode_171to172_bb3_var__u10_0_valid_out_NO_SHIFT_REG);
assign local_bb3_or2672_i = (rnode_171to172_bb3_var__u10_0_NO_SHIFT_REG | local_bb3_lnot263__i);
assign local_bb3_resultSign_0_i_valid_out = 1'b1;
assign local_bb3__47_i_valid_out = 1'b1;
assign local_bb3_or2672_i_valid_out = 1'b1;
assign rnode_171to172_bb3_and35_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_not_cmp38_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_add246_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_and251_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3__45_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_add246_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_var__u10_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_resultSign_0_i84_stall_local;
wire [31:0] local_bb3_resultSign_0_i84;

assign local_bb3_resultSign_0_i84 = (local_bb3_brmerge12_i83 ? (rnode_171to172_bb3_and35_i25_0_NO_SHIFT_REG & 32'h80000000) : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_resultSign_0_i84_valid_out;
wire local_bb3_resultSign_0_i84_stall_in;
wire local_bb3__47_i89_valid_out;
wire local_bb3__47_i89_stall_in;
wire local_bb3_or2662_i_valid_out;
wire local_bb3_or2662_i_stall_in;
wire local_bb3_or2662_i_inputs_ready;
wire local_bb3_or2662_i_stall_local;
wire local_bb3_or2662_i;

assign local_bb3_or2662_i_inputs_ready = (rnode_171to172_bb3_and35_i25_0_valid_out_NO_SHIFT_REG & rnode_171to172_bb3_not_cmp37_i_0_valid_out_NO_SHIFT_REG & rnode_171to172_bb3_add245_i_0_valid_out_0_NO_SHIFT_REG & rnode_171to172_bb3_and250_i_0_valid_out_NO_SHIFT_REG & rnode_171to172_bb3__45_i82_0_valid_out_0_NO_SHIFT_REG & rnode_171to172_bb3_add245_i_0_valid_out_1_NO_SHIFT_REG & rnode_171to172_bb3_var__u11_0_valid_out_NO_SHIFT_REG);
assign local_bb3_or2662_i = (rnode_171to172_bb3_var__u11_0_NO_SHIFT_REG | local_bb3_lnot262__i);
assign local_bb3_resultSign_0_i84_valid_out = 1'b1;
assign local_bb3__47_i89_valid_out = 1'b1;
assign local_bb3_or2662_i_valid_out = 1'b1;
assign rnode_171to172_bb3_and35_i25_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_not_cmp37_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_add245_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_and250_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3__45_i82_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_add245_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb3_var__u11_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and293_i261_stall_local;
wire [31:0] local_bb3_and293_i261;

assign local_bb3_and293_i261 = ((local_bb3_cond282_i257 | 32'h80000000) & local_bb3_or275_i255);

// This section implements an unregistered operation.
// 
wire local_bb3_or294_i262_stall_local;
wire [31:0] local_bb3_or294_i262;

assign local_bb3_or294_i262 = ((local_bb3_cond289_i259 & 32'h7F800000) | (local_bb3_cond292_i260 & 32'h400000));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_0_i273_stall_local;
wire [31:0] local_bb3_reduction_0_i273;

assign local_bb3_reduction_0_i273 = ((local_bb3_lnot_ext310_i271 & 32'h1) & (local_bb3_lnot_ext_i270 & 32'h1));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3_resultSign_0_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb3_resultSign_0_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_resultSign_0_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_resultSign_0_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_resultSign_0_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_resultSign_0_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_resultSign_0_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_resultSign_0_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3_resultSign_0_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3_resultSign_0_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3_resultSign_0_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3_resultSign_0_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3_resultSign_0_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in((local_bb3_resultSign_0_i & 32'h80000000)),
	.data_out(rnode_172to173_bb3_resultSign_0_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3_resultSign_0_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3_resultSign_0_i_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb3_resultSign_0_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3_resultSign_0_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3_resultSign_0_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_resultSign_0_i_stall_in = 1'b0;
assign rnode_172to173_bb3_resultSign_0_i_0_NO_SHIFT_REG = rnode_172to173_bb3_resultSign_0_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_resultSign_0_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_resultSign_0_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3__47_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3__47_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3__47_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3__47_i_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3__47_i_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3__47_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb3__47_i),
	.data_out(rnode_172to173_bb3__47_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3__47_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3__47_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb3__47_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3__47_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3__47_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__47_i_stall_in = 1'b0;
assign rnode_172to173_bb3__47_i_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__47_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3__47_i_0_NO_SHIFT_REG = rnode_172to173_bb3__47_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3__47_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3__47_i_1_NO_SHIFT_REG = rnode_172to173_bb3__47_i_0_reg_173_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3_or2672_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2672_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2672_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2672_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2672_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2672_i_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2672_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2672_i_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2672_i_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2672_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2672_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2672_i_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2672_i_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2672_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3_or2672_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3_or2672_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3_or2672_i_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3_or2672_i_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3_or2672_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb3_or2672_i),
	.data_out(rnode_172to173_bb3_or2672_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3_or2672_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3_or2672_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb3_or2672_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3_or2672_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3_or2672_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_or2672_i_stall_in = 1'b0;
assign rnode_172to173_bb3_or2672_i_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_or2672_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3_or2672_i_0_NO_SHIFT_REG = rnode_172to173_bb3_or2672_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_or2672_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3_or2672_i_1_NO_SHIFT_REG = rnode_172to173_bb3_or2672_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_or2672_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3_or2672_i_2_NO_SHIFT_REG = rnode_172to173_bb3_or2672_i_0_reg_173_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3_resultSign_0_i84_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb3_resultSign_0_i84_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_resultSign_0_i84_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_resultSign_0_i84_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb3_resultSign_0_i84_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_resultSign_0_i84_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_resultSign_0_i84_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_resultSign_0_i84_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3_resultSign_0_i84_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3_resultSign_0_i84_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3_resultSign_0_i84_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3_resultSign_0_i84_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3_resultSign_0_i84_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in((local_bb3_resultSign_0_i84 & 32'h80000000)),
	.data_out(rnode_172to173_bb3_resultSign_0_i84_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3_resultSign_0_i84_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3_resultSign_0_i84_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb3_resultSign_0_i84_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3_resultSign_0_i84_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3_resultSign_0_i84_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_resultSign_0_i84_stall_in = 1'b0;
assign rnode_172to173_bb3_resultSign_0_i84_0_NO_SHIFT_REG = rnode_172to173_bb3_resultSign_0_i84_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_resultSign_0_i84_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_resultSign_0_i84_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3__47_i89_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i89_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i89_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i89_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i89_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i89_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i89_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i89_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i89_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i89_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3__47_i89_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3__47_i89_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3__47_i89_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3__47_i89_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3__47_i89_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3__47_i89_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb3__47_i89),
	.data_out(rnode_172to173_bb3__47_i89_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3__47_i89_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3__47_i89_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb3__47_i89_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3__47_i89_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3__47_i89_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3__47_i89_stall_in = 1'b0;
assign rnode_172to173_bb3__47_i89_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__47_i89_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3__47_i89_0_NO_SHIFT_REG = rnode_172to173_bb3__47_i89_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3__47_i89_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3__47_i89_1_NO_SHIFT_REG = rnode_172to173_bb3__47_i89_0_reg_173_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb3_or2662_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2662_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2662_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2662_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2662_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2662_i_1_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2662_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2662_i_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2662_i_2_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2662_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2662_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2662_i_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2662_i_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb3_or2662_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb3_or2662_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb3_or2662_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb3_or2662_i_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb3_or2662_i_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb3_or2662_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb3_or2662_i),
	.data_out(rnode_172to173_bb3_or2662_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb3_or2662_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb3_or2662_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb3_or2662_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb3_or2662_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb3_or2662_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_or2662_i_stall_in = 1'b0;
assign rnode_172to173_bb3_or2662_i_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_or2662_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3_or2662_i_0_NO_SHIFT_REG = rnode_172to173_bb3_or2662_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_or2662_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3_or2662_i_1_NO_SHIFT_REG = rnode_172to173_bb3_or2662_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb3_or2662_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb3_or2662_i_2_NO_SHIFT_REG = rnode_172to173_bb3_or2662_i_0_reg_173_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_and302_i267_stall_local;
wire [31:0] local_bb3_and302_i267;

assign local_bb3_and302_i267 = ((local_bb3_conv300_i266 & 32'h1) & local_bb3_and293_i261);

// This section implements an unregistered operation.
// 
wire local_bb3_or295_i263_stall_local;
wire [31:0] local_bb3_or295_i263;

assign local_bb3_or295_i263 = ((local_bb3_or294_i262 & 32'h7FC00000) | local_bb3_and293_i261);

// This section implements an unregistered operation.
// 
wire local_bb3_or276_i_stall_local;
wire [31:0] local_bb3_or276_i;

assign local_bb3_or276_i = ((local_bb3_or275_i & 32'h7FFFFFFF) | (rnode_172to173_bb3_resultSign_0_i_0_NO_SHIFT_REG & 32'h80000000));

// This section implements an unregistered operation.
// 
wire local_bb3_var__u29_stall_local;
wire [31:0] local_bb3_var__u29;

assign local_bb3_var__u29[31:1] = 31'h0;
assign local_bb3_var__u29[0] = rnode_172to173_bb3__47_i_1_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_or2814_i_stall_local;
wire local_bb3_or2814_i;

assign local_bb3_or2814_i = (rnode_172to173_bb3__47_i_0_NO_SHIFT_REG | rnode_172to173_bb3_or2672_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_or2885_i_stall_local;
wire local_bb3_or2885_i;

assign local_bb3_or2885_i = (rnode_172to173_bb3_or2672_i_1_NO_SHIFT_REG | rnode_172to173_bb3__26_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u30_stall_local;
wire [31:0] local_bb3_var__u30;

assign local_bb3_var__u30[31:1] = 31'h0;
assign local_bb3_var__u30[0] = rnode_172to173_bb3_or2672_i_2_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_or275_i91_stall_local;
wire [31:0] local_bb3_or275_i91;

assign local_bb3_or275_i91 = ((local_bb3_or274_i & 32'h7FFFFFFF) | (rnode_172to173_bb3_resultSign_0_i84_0_NO_SHIFT_REG & 32'h80000000));

// This section implements an unregistered operation.
// 
wire local_bb3_var__u31_stall_local;
wire [31:0] local_bb3_var__u31;

assign local_bb3_var__u31[31:1] = 31'h0;
assign local_bb3_var__u31[0] = rnode_172to173_bb3__47_i89_1_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_or2804_i_stall_local;
wire local_bb3_or2804_i;

assign local_bb3_or2804_i = (rnode_172to173_bb3__47_i89_0_NO_SHIFT_REG | rnode_172to173_bb3_or2662_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_or2875_i_stall_local;
wire local_bb3_or2875_i;

assign local_bb3_or2875_i = (rnode_172to173_bb3_or2662_i_1_NO_SHIFT_REG | rnode_172to173_bb3__26_i39_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u32_stall_local;
wire [31:0] local_bb3_var__u32;

assign local_bb3_var__u32[31:1] = 31'h0;
assign local_bb3_var__u32[0] = rnode_172to173_bb3_or2662_i_2_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_lor_ext_i269_stall_local;
wire [31:0] local_bb3_lor_ext_i269;

assign local_bb3_lor_ext_i269 = ((local_bb3_cmp29649_i268 & 32'h1) | (local_bb3_and302_i267 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_lnot_ext315_i_stall_local;
wire [31:0] local_bb3_lnot_ext315_i;

assign local_bb3_lnot_ext315_i = ((local_bb3_var__u29 & 32'h1) ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_cond283_i_stall_local;
wire [31:0] local_bb3_cond283_i;

assign local_bb3_cond283_i = (local_bb3_or2814_i ? 32'h80000000 : 32'hFFFFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_cond290_i_stall_local;
wire [31:0] local_bb3_cond290_i;

assign local_bb3_cond290_i = (local_bb3_or2885_i ? 32'h7F800000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot_ext311_i_stall_local;
wire [31:0] local_bb3_lnot_ext311_i;

assign local_bb3_lnot_ext311_i = ((local_bb3_var__u30 & 32'h1) ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot_ext314_i_stall_local;
wire [31:0] local_bb3_lnot_ext314_i;

assign local_bb3_lnot_ext314_i = ((local_bb3_var__u31 & 32'h1) ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_cond282_i_stall_local;
wire [31:0] local_bb3_cond282_i;

assign local_bb3_cond282_i = (local_bb3_or2804_i ? 32'h80000000 : 32'hFFFFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb3_cond289_i_stall_local;
wire [31:0] local_bb3_cond289_i;

assign local_bb3_cond289_i = (local_bb3_or2875_i ? 32'h7F800000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb3_lnot_ext310_i_stall_local;
wire [31:0] local_bb3_lnot_ext310_i;

assign local_bb3_lnot_ext310_i = ((local_bb3_var__u32 & 32'h1) ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_1_i274_stall_local;
wire [31:0] local_bb3_reduction_1_i274;

assign local_bb3_reduction_1_i274 = ((local_bb3_lnot_ext314_i272 & 32'h1) & (local_bb3_lor_ext_i269 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_and294_i_stall_local;
wire [31:0] local_bb3_and294_i;

assign local_bb3_and294_i = ((local_bb3_cond283_i | 32'h80000000) & local_bb3_or276_i);

// This section implements an unregistered operation.
// 
wire local_bb3_or295_i_stall_local;
wire [31:0] local_bb3_or295_i;

assign local_bb3_or295_i = ((local_bb3_cond290_i & 32'h7F800000) | (local_bb3_cond293_i & 32'h400000));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_0_i_stall_local;
wire [31:0] local_bb3_reduction_0_i;

assign local_bb3_reduction_0_i = ((local_bb3_lnot_ext311_i & 32'h1) & (local_bb3_lnot_ext_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_and293_i_stall_local;
wire [31:0] local_bb3_and293_i;

assign local_bb3_and293_i = ((local_bb3_cond282_i | 32'h80000000) & local_bb3_or275_i91);

// This section implements an unregistered operation.
// 
wire local_bb3_or294_i_stall_local;
wire [31:0] local_bb3_or294_i;

assign local_bb3_or294_i = ((local_bb3_cond289_i & 32'h7F800000) | (local_bb3_cond292_i & 32'h400000));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_0_i95_stall_local;
wire [31:0] local_bb3_reduction_0_i95;

assign local_bb3_reduction_0_i95 = ((local_bb3_lnot_ext310_i & 32'h1) & (local_bb3_lnot_ext_i94 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_2_i275_stall_local;
wire [31:0] local_bb3_reduction_2_i275;

assign local_bb3_reduction_2_i275 = ((local_bb3_reduction_0_i273 & 32'h1) & (local_bb3_reduction_1_i274 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_and303_i_stall_local;
wire [31:0] local_bb3_and303_i;

assign local_bb3_and303_i = ((local_bb3_conv301_i & 32'h1) & local_bb3_and294_i);

// This section implements an unregistered operation.
// 
wire local_bb3_or296_i_stall_local;
wire [31:0] local_bb3_or296_i;

assign local_bb3_or296_i = ((local_bb3_or295_i & 32'h7FC00000) | local_bb3_and294_i);

// This section implements an unregistered operation.
// 
wire local_bb3_and302_i_stall_local;
wire [31:0] local_bb3_and302_i;

assign local_bb3_and302_i = ((local_bb3_conv300_i & 32'h1) & local_bb3_and293_i);

// This section implements an unregistered operation.
// 
wire local_bb3_or295_i92_stall_local;
wire [31:0] local_bb3_or295_i92;

assign local_bb3_or295_i92 = ((local_bb3_or294_i & 32'h7FC00000) | local_bb3_and293_i);

// This section implements an unregistered operation.
// 
wire local_bb3_add320_i276_valid_out;
wire local_bb3_add320_i276_stall_in;
wire local_bb3_add320_i276_inputs_ready;
wire local_bb3_add320_i276_stall_local;
wire [31:0] local_bb3_add320_i276;

assign local_bb3_add320_i276_inputs_ready = (rnode_173to175_bb3_and269_i252_0_valid_out_NO_SHIFT_REG & rnode_174to175_bb3_resultSign_0_i235_0_valid_out_NO_SHIFT_REG & rnode_174to175_bb3_or2662_i248_0_valid_out_1_NO_SHIFT_REG & rnode_174to175_bb3__26_i133_0_valid_out_0_NO_SHIFT_REG & rnode_174to175_bb3__26_i133_0_valid_out_1_NO_SHIFT_REG & rnode_174to175_bb3__47_i245_0_valid_out_0_NO_SHIFT_REG & rnode_174to175_bb3_or2662_i248_0_valid_out_0_NO_SHIFT_REG & rnode_174to175_bb3__26_i133_0_valid_out_2_NO_SHIFT_REG & rnode_174to175_bb3_or2662_i248_0_valid_out_2_NO_SHIFT_REG & rnode_174to175_bb3_shr271_i250_0_valid_out_NO_SHIFT_REG & rnode_174to175_bb3__47_i245_0_valid_out_1_NO_SHIFT_REG & rnode_174to175_bb3_cmp296_i264_0_valid_out_NO_SHIFT_REG & rnode_174to175_bb3_cmp299_i265_0_valid_out_NO_SHIFT_REG);
assign local_bb3_add320_i276 = ((local_bb3_reduction_2_i275 & 32'h1) + local_bb3_or295_i263);
assign local_bb3_add320_i276_valid_out = 1'b1;
assign rnode_173to175_bb3_and269_i252_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3_resultSign_0_i235_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3_or2662_i248_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3__26_i133_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3__26_i133_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3__47_i245_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3_or2662_i248_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3__26_i133_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3_or2662_i248_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3_shr271_i250_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3__47_i245_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3_cmp296_i264_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3_cmp299_i265_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_lor_ext_i_stall_local;
wire [31:0] local_bb3_lor_ext_i;

assign local_bb3_lor_ext_i = ((local_bb3_cmp29749_i & 32'h1) | (local_bb3_and303_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_lor_ext_i93_stall_local;
wire [31:0] local_bb3_lor_ext_i93;

assign local_bb3_lor_ext_i93 = ((local_bb3_cmp29649_i & 32'h1) | (local_bb3_and302_i & 32'h1));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb3_add320_i276_0_valid_out_NO_SHIFT_REG;
 logic rnode_175to176_bb3_add320_i276_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb3_add320_i276_0_NO_SHIFT_REG;
 logic rnode_175to176_bb3_add320_i276_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb3_add320_i276_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb3_add320_i276_0_valid_out_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb3_add320_i276_0_stall_in_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb3_add320_i276_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb3_add320_i276_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb3_add320_i276_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb3_add320_i276_0_stall_in_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb3_add320_i276_0_valid_out_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb3_add320_i276_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(local_bb3_add320_i276),
	.data_out(rnode_175to176_bb3_add320_i276_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb3_add320_i276_0_reg_176_fifo.DEPTH = 1;
defparam rnode_175to176_bb3_add320_i276_0_reg_176_fifo.DATA_WIDTH = 32;
defparam rnode_175to176_bb3_add320_i276_0_reg_176_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to176_bb3_add320_i276_0_reg_176_fifo.IMPL = "shift_reg";

assign rnode_175to176_bb3_add320_i276_0_reg_176_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_add320_i276_stall_in = 1'b0;
assign rnode_175to176_bb3_add320_i276_0_NO_SHIFT_REG = rnode_175to176_bb3_add320_i276_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb3_add320_i276_0_stall_in_reg_176_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb3_add320_i276_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_1_i_stall_local;
wire [31:0] local_bb3_reduction_1_i;

assign local_bb3_reduction_1_i = ((local_bb3_lnot_ext315_i & 32'h1) & (local_bb3_lor_ext_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_1_i96_stall_local;
wire [31:0] local_bb3_reduction_1_i96;

assign local_bb3_reduction_1_i96 = ((local_bb3_lnot_ext314_i & 32'h1) & (local_bb3_lor_ext_i93 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_var__u33_stall_local;
wire [31:0] local_bb3_var__u33;

assign local_bb3_var__u33 = rnode_175to176_bb3_add320_i276_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_2_i_stall_local;
wire [31:0] local_bb3_reduction_2_i;

assign local_bb3_reduction_2_i = ((local_bb3_reduction_0_i & 32'h1) & (local_bb3_reduction_1_i & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_reduction_2_i97_stall_local;
wire [31:0] local_bb3_reduction_2_i97;

assign local_bb3_reduction_2_i97 = ((local_bb3_reduction_0_i95 & 32'h1) & (local_bb3_reduction_1_i96 & 32'h1));

// This section implements an unregistered operation.
// 
wire local_bb3_add321_i_stall_local;
wire [31:0] local_bb3_add321_i;

assign local_bb3_add321_i = ((local_bb3_reduction_2_i & 32'h1) + local_bb3_or296_i);

// This section implements an unregistered operation.
// 
wire local_bb3_add320_i_valid_out;
wire local_bb3_add320_i_stall_in;
wire local_bb3_add320_i_inputs_ready;
wire local_bb3_add320_i_stall_local;
wire [31:0] local_bb3_add320_i;

assign local_bb3_add320_i_inputs_ready = (rnode_171to173_bb3_and269_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb3_resultSign_0_i84_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb3_or2662_i_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb3__26_i39_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb3__26_i39_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb3__47_i89_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb3_or2662_i_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb3__26_i39_0_valid_out_2_NO_SHIFT_REG & rnode_172to173_bb3_or2662_i_0_valid_out_2_NO_SHIFT_REG & rnode_172to173_bb3_shr271_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb3__47_i89_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb3_cmp296_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb3_cmp299_i_0_valid_out_NO_SHIFT_REG);
assign local_bb3_add320_i = ((local_bb3_reduction_2_i97 & 32'h1) + local_bb3_or295_i92);
assign local_bb3_add320_i_valid_out = 1'b1;
assign rnode_171to173_bb3_and269_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_resultSign_0_i84_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_or2662_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__26_i39_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__26_i39_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__47_i89_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_or2662_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__26_i39_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_or2662_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_shr271_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__47_i89_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_cmp296_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_cmp299_i_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb3_and_i_i_stall_local;
wire [31:0] local_bb3_and_i_i;

assign local_bb3_and_i_i = (local_bb3_add321_i & 32'h7FFFFFFF);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb3_add320_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb3_add320_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb3_add320_i_0_NO_SHIFT_REG;
 logic rnode_173to174_bb3_add320_i_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb3_add320_i_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_add320_i_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_add320_i_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb3_add320_i_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb3_add320_i_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb3_add320_i_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb3_add320_i_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb3_add320_i_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb3_add320_i_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb3_add320_i),
	.data_out(rnode_173to174_bb3_add320_i_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb3_add320_i_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb3_add320_i_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb3_add320_i_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb3_add320_i_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb3_add320_i_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb3_add320_i_stall_in = 1'b0;
assign rnode_173to174_bb3_add320_i_0_NO_SHIFT_REG = rnode_173to174_bb3_add320_i_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb3_add320_i_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb3_add320_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3_astype1_i_i_valid_out;
wire local_bb3_astype1_i_i_stall_in;
wire local_bb3_astype1_i_i_inputs_ready;
wire local_bb3_astype1_i_i_stall_local;
wire [31:0] local_bb3_astype1_i_i;

assign local_bb3_astype1_i_i_inputs_ready = (rnode_171to173_bb3_and270_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb3_resultSign_0_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb3_or2672_i_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb3__26_i_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb3__26_i_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb3__47_i_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb3_or2672_i_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb3__26_i_0_valid_out_2_NO_SHIFT_REG & rnode_172to173_bb3_or2672_i_0_valid_out_2_NO_SHIFT_REG & rnode_172to173_bb3_shr272_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb3__47_i_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb3_cmp297_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb3_cmp300_i_0_valid_out_NO_SHIFT_REG);
assign local_bb3_astype1_i_i = (local_bb3_and_i_i & 32'h7FFFFFFF);
assign local_bb3_astype1_i_i_valid_out = 1'b1;
assign rnode_171to173_bb3_and270_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_resultSign_0_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_or2672_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__26_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__26_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__47_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_or2672_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__26_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_or2672_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_shr272_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3__47_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_cmp297_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb3_cmp300_i_0_stall_in_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb3_add320_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_174to175_bb3_add320_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb3_add320_i_0_NO_SHIFT_REG;
 logic rnode_174to175_bb3_add320_i_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb3_add320_i_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_add320_i_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_add320_i_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb3_add320_i_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb3_add320_i_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb3_add320_i_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb3_add320_i_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb3_add320_i_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb3_add320_i_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(rnode_173to174_bb3_add320_i_0_NO_SHIFT_REG),
	.data_out(rnode_174to175_bb3_add320_i_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb3_add320_i_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb3_add320_i_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_174to175_bb3_add320_i_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb3_add320_i_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb3_add320_i_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb3_add320_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3_add320_i_0_NO_SHIFT_REG = rnode_174to175_bb3_add320_i_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb3_add320_i_0_stall_in_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb3_add320_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb3_cmp31_inputs_ready;
 reg local_bb3_cmp31_valid_out_0_NO_SHIFT_REG;
wire local_bb3_cmp31_stall_in_0;
 reg local_bb3_cmp31_valid_out_1_NO_SHIFT_REG;
wire local_bb3_cmp31_stall_in_1;
wire local_bb3_cmp31_output_regs_ready;
wire local_bb3_cmp31;
 reg local_bb3_cmp31_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb3_cmp31_valid_pipe_1_NO_SHIFT_REG;
wire local_bb3_cmp31_causedstall;

acl_fp_cmp fp_module_local_bb3_cmp31 (
	.clock(clock),
	.dataa(local_bb3_astype1_i_i),
	.datab(input_e_d),
	.enable(local_bb3_cmp31_output_regs_ready),
	.result(local_bb3_cmp31)
);

defparam fp_module_local_bb3_cmp31.COMPARISON_MODE = 5;

assign local_bb3_cmp31_inputs_ready = 1'b1;
assign local_bb3_cmp31_output_regs_ready = 1'b1;
assign local_bb3_astype1_i_i_stall_in = 1'b0;
assign local_bb3_cmp31_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_cmp31_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb3_cmp31_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_cmp31_output_regs_ready)
		begin
			local_bb3_cmp31_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb3_cmp31_valid_pipe_1_NO_SHIFT_REG <= local_bb3_cmp31_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_cmp31_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb3_cmp31_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_cmp31_output_regs_ready)
		begin
			local_bb3_cmp31_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb3_cmp31_valid_out_1_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb3_cmp31_stall_in_0))
			begin
				local_bb3_cmp31_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb3_cmp31_stall_in_1))
			begin
				local_bb3_cmp31_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb3_add320_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_175to176_bb3_add320_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb3_add320_i_0_NO_SHIFT_REG;
 logic rnode_175to176_bb3_add320_i_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb3_add320_i_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb3_add320_i_0_valid_out_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb3_add320_i_0_stall_in_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb3_add320_i_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb3_add320_i_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb3_add320_i_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb3_add320_i_0_stall_in_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb3_add320_i_0_valid_out_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb3_add320_i_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(rnode_174to175_bb3_add320_i_0_NO_SHIFT_REG),
	.data_out(rnode_175to176_bb3_add320_i_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb3_add320_i_0_reg_176_fifo.DEPTH = 1;
defparam rnode_175to176_bb3_add320_i_0_reg_176_fifo.DATA_WIDTH = 32;
defparam rnode_175to176_bb3_add320_i_0_reg_176_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to176_bb3_add320_i_0_reg_176_fifo.IMPL = "shift_reg";

assign rnode_175to176_bb3_add320_i_0_reg_176_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb3_add320_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb3_add320_i_0_NO_SHIFT_REG = rnode_175to176_bb3_add320_i_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb3_add320_i_0_stall_in_reg_176_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb3_add320_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb3__15_stall_local;
wire [31:0] local_bb3__15;

assign local_bb3__15 = (local_bb3_cmp31 ? local_bb3_var__u33 : rnode_175to176_bb3_c0_ene3_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u34_stall_local;
wire [31:0] local_bb3_var__u34;

assign local_bb3_var__u34 = rnode_175to176_bb3_add320_i_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_c0_exi1_stall_local;
wire [95:0] local_bb3_c0_exi1;

assign local_bb3_c0_exi1[31:0] = 32'bx;
assign local_bb3_c0_exi1[63:32] = local_bb3__15;
assign local_bb3_c0_exi1[95:64] = 32'bx;

// This section implements an unregistered operation.
// 
wire local_bb3__16_stall_local;
wire [31:0] local_bb3__16;

assign local_bb3__16 = (local_bb3_cmp31 ? local_bb3_var__u34 : rnode_175to176_bb3_c0_ene4_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_c0_exi2_valid_out;
wire local_bb3_c0_exi2_stall_in;
wire local_bb3_c0_exi2_inputs_ready;
wire local_bb3_c0_exi2_stall_local;
wire [95:0] local_bb3_c0_exi2;

assign local_bb3_c0_exi2_inputs_ready = (local_bb3_cmp31_valid_out_1_NO_SHIFT_REG & rnode_175to176_bb3_c0_ene4_0_valid_out_NO_SHIFT_REG & local_bb3_cmp31_valid_out_0_NO_SHIFT_REG & rnode_175to176_bb3_c0_ene3_0_valid_out_NO_SHIFT_REG & rnode_175to176_bb3_add320_i276_0_valid_out_NO_SHIFT_REG & rnode_175to176_bb3_add320_i_0_valid_out_NO_SHIFT_REG);
assign local_bb3_c0_exi2[63:0] = local_bb3_c0_exi1[63:0];
assign local_bb3_c0_exi2[95:64] = local_bb3__16;
assign local_bb3_c0_exi2_valid_out = 1'b1;
assign local_bb3_cmp31_stall_in_1 = 1'b0;
assign rnode_175to176_bb3_c0_ene4_0_stall_in_NO_SHIFT_REG = 1'b0;
assign local_bb3_cmp31_stall_in_0 = 1'b0;
assign rnode_175to176_bb3_c0_ene3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb3_add320_i276_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb3_add320_i_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements a registered operation.
// 
wire local_bb3_c0_exit_c0_exi2_inputs_ready;
 reg local_bb3_c0_exit_c0_exi2_valid_out_0_NO_SHIFT_REG;
wire local_bb3_c0_exit_c0_exi2_stall_in_0;
 reg local_bb3_c0_exit_c0_exi2_valid_out_1_NO_SHIFT_REG;
wire local_bb3_c0_exit_c0_exi2_stall_in_1;
 reg [95:0] local_bb3_c0_exit_c0_exi2_NO_SHIFT_REG;
wire [95:0] local_bb3_c0_exit_c0_exi2_in;
wire local_bb3_c0_exit_c0_exi2_valid;
wire local_bb3_c0_exit_c0_exi2_causedstall;

acl_stall_free_sink local_bb3_c0_exit_c0_exi2_instance (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_bb3_c0_exi2),
	.data_out(local_bb3_c0_exit_c0_exi2_in),
	.input_accepted(local_bb3_c0_enter_c0_eni4_input_accepted),
	.valid_out(local_bb3_c0_exit_c0_exi2_valid),
	.stall_in(~(local_bb3_c0_exit_c0_exi2_output_regs_ready)),
	.stall_entry(local_bb3_c0_exit_c0_exi2_entry_stall),
	.valid_in(local_bb3_c0_exit_c0_exi2_valid_in),
	.IIphases(local_bb3_c0_exit_c0_exi2_phases),
	.inc_pipelined_thread(local_bb3_c0_enter_c0_eni4_inc_pipelined_thread),
	.dec_pipelined_thread(local_bb3_c0_enter_c0_eni4_dec_pipelined_thread)
);

defparam local_bb3_c0_exit_c0_exi2_instance.DATA_WIDTH = 96;
defparam local_bb3_c0_exit_c0_exi2_instance.PIPELINE_DEPTH = 16;
defparam local_bb3_c0_exit_c0_exi2_instance.SHARINGII = 1;
defparam local_bb3_c0_exit_c0_exi2_instance.SCHEDULEII = 1;
defparam local_bb3_c0_exit_c0_exi2_instance.ALWAYS_THROTTLE = 0;

assign local_bb3_c0_exit_c0_exi2_inputs_ready = 1'b1;
assign local_bb3_c0_exit_c0_exi2_output_regs_ready = ((~(local_bb3_c0_exit_c0_exi2_valid_out_0_NO_SHIFT_REG) | ~(local_bb3_c0_exit_c0_exi2_stall_in_0)) & (~(local_bb3_c0_exit_c0_exi2_valid_out_1_NO_SHIFT_REG) | ~(local_bb3_c0_exit_c0_exi2_stall_in_1)));
assign local_bb3_c0_exit_c0_exi2_valid_in = SFC_1_VALID_175_176_0_NO_SHIFT_REG;
assign local_bb3_c0_exi2_stall_in = 1'b0;
assign SFC_1_VALID_175_176_0_stall_in = 1'b0;
assign local_bb3_c0_exit_c0_exi2_causedstall = (1'b1 && (1'b0 && !(~(local_bb3_c0_exit_c0_exi2_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_c0_exit_c0_exi2_NO_SHIFT_REG <= 'x;
		local_bb3_c0_exit_c0_exi2_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb3_c0_exit_c0_exi2_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_c0_exit_c0_exi2_output_regs_ready)
		begin
			local_bb3_c0_exit_c0_exi2_NO_SHIFT_REG <= local_bb3_c0_exit_c0_exi2_in;
			local_bb3_c0_exit_c0_exi2_valid_out_0_NO_SHIFT_REG <= local_bb3_c0_exit_c0_exi2_valid;
			local_bb3_c0_exit_c0_exi2_valid_out_1_NO_SHIFT_REG <= local_bb3_c0_exit_c0_exi2_valid;
		end
		else
		begin
			if (~(local_bb3_c0_exit_c0_exi2_stall_in_0))
			begin
				local_bb3_c0_exit_c0_exi2_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb3_c0_exit_c0_exi2_stall_in_1))
			begin
				local_bb3_c0_exit_c0_exi2_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb3_c0_exe1_stall_local;
wire [31:0] local_bb3_c0_exe1;

assign local_bb3_c0_exe1 = local_bb3_c0_exit_c0_exi2_NO_SHIFT_REG[63:32];

// This section implements an unregistered operation.
// 
wire local_bb3_c0_exe2_valid_out;
wire local_bb3_c0_exe2_stall_in;
wire local_bb3_c0_exe1_valid_out;
wire local_bb3_c0_exe1_stall_in;
wire local_bb3_c0_exe2_inputs_ready;
wire local_bb3_c0_exe2_stall_local;
wire [31:0] local_bb3_c0_exe2;

assign local_bb3_c0_exe2_inputs_ready = (local_bb3_c0_exit_c0_exi2_valid_out_1_NO_SHIFT_REG & local_bb3_c0_exit_c0_exi2_valid_out_0_NO_SHIFT_REG);
assign local_bb3_c0_exe2 = local_bb3_c0_exit_c0_exi2_NO_SHIFT_REG[95:64];
assign local_bb3_c0_exe2_stall_local = (local_bb3_c0_exe2_stall_in | local_bb3_c0_exe1_stall_in);
assign local_bb3_c0_exe2_valid_out = local_bb3_c0_exe2_inputs_ready;
assign local_bb3_c0_exe1_valid_out = local_bb3_c0_exe2_inputs_ready;
assign local_bb3_c0_exit_c0_exi2_stall_in_1 = (local_bb3_c0_exe2_stall_local | ~(local_bb3_c0_exe2_inputs_ready));
assign local_bb3_c0_exit_c0_exi2_stall_in_0 = (local_bb3_c0_exe2_stall_local | ~(local_bb3_c0_exe2_inputs_ready));

// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_scalarizer_0mul_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_scalarizer_1mul_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_ld__0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_i_012_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_mul25_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb3_inc_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb3_c0_exe1_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb3_c0_exe2_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_0_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_1_0_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb3_c0_exe2_valid_out & local_bb3_c0_exe1_valid_out & local_bb3_var__valid_out & rcnode_180to181_rc1_bb3_inc_0_valid_out_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign local_bb3_c0_exe2_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb3_c0_exe1_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb3_var__stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rcnode_180to181_rc1_bb3_inc_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_scalarizer_0mul_0 = lvb_scalarizer_0mul_0_reg_NO_SHIFT_REG;
assign lvb_scalarizer_0mul_1 = lvb_scalarizer_0mul_0_reg_NO_SHIFT_REG;
assign lvb_scalarizer_1mul_0 = lvb_scalarizer_1mul_0_reg_NO_SHIFT_REG;
assign lvb_scalarizer_1mul_1 = lvb_scalarizer_1mul_0_reg_NO_SHIFT_REG;
assign lvb_ld__0 = lvb_ld__0_reg_NO_SHIFT_REG;
assign lvb_ld__1 = lvb_ld__0_reg_NO_SHIFT_REG;
assign lvb_i_012_0 = lvb_i_012_0_reg_NO_SHIFT_REG;
assign lvb_i_012_1 = lvb_i_012_0_reg_NO_SHIFT_REG;
assign lvb_mul25_0 = lvb_mul25_0_reg_NO_SHIFT_REG;
assign lvb_mul25_1 = lvb_mul25_0_reg_NO_SHIFT_REG;
assign lvb_bb3_inc_0 = lvb_bb3_inc_0_reg_NO_SHIFT_REG;
assign lvb_bb3_inc_1 = lvb_bb3_inc_0_reg_NO_SHIFT_REG;
assign lvb_bb3_c0_exe1_0 = lvb_bb3_c0_exe1_0_reg_NO_SHIFT_REG;
assign lvb_bb3_c0_exe1_1 = lvb_bb3_c0_exe1_0_reg_NO_SHIFT_REG;
assign lvb_bb3_c0_exe2_0 = lvb_bb3_c0_exe2_0_reg_NO_SHIFT_REG;
assign lvb_bb3_c0_exe2_1 = lvb_bb3_c0_exe2_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_0_0 = lvb_input_global_id_0_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_0_1 = lvb_input_global_id_0_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_1_0 = lvb_input_global_id_1_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_1_1 = lvb_input_global_id_1_0_reg_NO_SHIFT_REG;
assign valid_out_0 = (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG);
assign valid_out_1 = ((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG);
assign combined_branch_stall_in_signal = ((((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_1) | ((~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_0));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		lvb_scalarizer_0mul_0_reg_NO_SHIFT_REG <= 'x;
		lvb_scalarizer_1mul_0_reg_NO_SHIFT_REG <= 'x;
		lvb_ld__0_reg_NO_SHIFT_REG <= 'x;
		lvb_i_012_0_reg_NO_SHIFT_REG <= 'x;
		lvb_mul25_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_inc_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_c0_exe1_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_c0_exe2_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_0_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_1_0_reg_NO_SHIFT_REG <= 'x;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_scalarizer_0mul_0_reg_NO_SHIFT_REG <= (rcnode_180to181_rc1_bb3_inc_0_NO_SHIFT_REG[63:32] & 32'hFFFFFFFE);
			lvb_scalarizer_1mul_0_reg_NO_SHIFT_REG <= (rcnode_180to181_rc1_bb3_inc_0_NO_SHIFT_REG[95:64] & 32'hFFFFFFFE);
			lvb_ld__0_reg_NO_SHIFT_REG <= rcnode_180to181_rc1_bb3_inc_0_NO_SHIFT_REG[255:224];
			lvb_i_012_0_reg_NO_SHIFT_REG <= rcnode_180to181_rc1_bb3_inc_0_NO_SHIFT_REG[127:96];
			lvb_mul25_0_reg_NO_SHIFT_REG <= rcnode_180to181_rc1_bb3_inc_0_NO_SHIFT_REG[223:192];
			lvb_bb3_inc_0_reg_NO_SHIFT_REG <= rcnode_180to181_rc1_bb3_inc_0_NO_SHIFT_REG[31:0];
			lvb_bb3_c0_exe1_0_reg_NO_SHIFT_REG <= local_bb3_c0_exe1;
			lvb_bb3_c0_exe2_0_reg_NO_SHIFT_REG <= local_bb3_c0_exe2;
			lvb_input_global_id_0_0_reg_NO_SHIFT_REG <= rcnode_180to181_rc1_bb3_inc_0_NO_SHIFT_REG[159:128];
			lvb_input_global_id_1_0_reg_NO_SHIFT_REG <= rcnode_180to181_rc1_bb3_inc_0_NO_SHIFT_REG[191:160];
			branch_compare_result_NO_SHIFT_REG <= local_bb3_var_;
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
module AOChalfSampleRobustImageKernel_basic_block_4
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_r,
		input [31:0] 		input_wii_div,
		input [31:0] 		input_wii_add6,
		input 		input_wii_cmp9,
		input [31:0] 		input_wii_sub20,
		input [31:0] 		input_wii_sub22,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_scalarizer_0mul,
		input [31:0] 		input_scalarizer_1mul,
		input [31:0] 		input_ld_,
		input [31:0] 		input_i_012,
		input [31:0] 		input_c0_exe1,
		input [31:0] 		input_c0_exe2,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_global_id_1,
		output 		valid_out_0,
		input 		stall_in_0,
		output [31:0] 		lvb_scalarizer_0mul_0,
		output [31:0] 		lvb_scalarizer_1mul_0,
		output [31:0] 		lvb_ld__0,
		output [31:0] 		lvb_c0_exe1_0,
		output [31:0] 		lvb_c0_exe2_0,
		output [31:0] 		lvb_bb4_inc36_0,
		output [31:0] 		lvb_input_global_id_0_0,
		output [31:0] 		lvb_input_global_id_1_0,
		output 		valid_out_1,
		input 		stall_in_1,
		output [31:0] 		lvb_scalarizer_0mul_1,
		output [31:0] 		lvb_scalarizer_1mul_1,
		output [31:0] 		lvb_ld__1,
		output [31:0] 		lvb_c0_exe1_1,
		output [31:0] 		lvb_c0_exe2_1,
		output [31:0] 		lvb_bb4_inc36_1,
		output [31:0] 		lvb_input_global_id_0_1,
		output [31:0] 		lvb_input_global_id_1_1,
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
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_scalarizer_0mul_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_scalarizer_1mul_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__staging_reg_NO_SHIFT_REG;
 reg [31:0] input_i_012_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe2_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_scalarizer_0mul_NO_SHIFT_REG;
 reg [31:0] local_lvm_scalarizer_1mul_NO_SHIFT_REG;
 reg [31:0] local_lvm_ld__NO_SHIFT_REG;
 reg [31:0] local_lvm_i_012_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe1_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe2_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_1_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG));
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
		input_scalarizer_0mul_staging_reg_NO_SHIFT_REG <= 'x;
		input_scalarizer_1mul_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__staging_reg_NO_SHIFT_REG <= 'x;
		input_i_012_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe2_staging_reg_NO_SHIFT_REG <= 'x;
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
				input_scalarizer_0mul_staging_reg_NO_SHIFT_REG <= input_scalarizer_0mul;
				input_scalarizer_1mul_staging_reg_NO_SHIFT_REG <= input_scalarizer_1mul;
				input_ld__staging_reg_NO_SHIFT_REG <= input_ld_;
				input_i_012_staging_reg_NO_SHIFT_REG <= input_i_012;
				input_c0_exe1_staging_reg_NO_SHIFT_REG <= input_c0_exe1;
				input_c0_exe2_staging_reg_NO_SHIFT_REG <= input_c0_exe2;
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
					local_lvm_scalarizer_0mul_NO_SHIFT_REG <= input_scalarizer_0mul_staging_reg_NO_SHIFT_REG;
					local_lvm_scalarizer_1mul_NO_SHIFT_REG <= input_scalarizer_1mul_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__staging_reg_NO_SHIFT_REG;
					local_lvm_i_012_NO_SHIFT_REG <= input_i_012_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_scalarizer_0mul_NO_SHIFT_REG <= input_scalarizer_0mul;
					local_lvm_scalarizer_1mul_NO_SHIFT_REG <= input_scalarizer_1mul;
					local_lvm_ld__NO_SHIFT_REG <= input_ld_;
					local_lvm_i_012_NO_SHIFT_REG <= input_i_012;
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2;
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
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
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
wire local_bb4_inc36_valid_out;
wire local_bb4_inc36_stall_in;
wire local_bb4_inc36_inputs_ready;
wire local_bb4_inc36_stall_local;
wire [31:0] local_bb4_inc36;
wire [223:0] rci_rcnode_1to3_rc1_scalarizer_0mul_0_reg_1;

assign local_bb4_inc36_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb4_inc36 = (local_lvm_i_012_NO_SHIFT_REG + 32'h1);
assign local_bb4_inc36_valid_out = local_bb4_inc36_inputs_ready;
assign local_bb4_inc36_stall_local = local_bb4_inc36_stall_in;
assign merge_node_stall_in_0 = (|local_bb4_inc36_stall_local);
assign rci_rcnode_1to3_rc1_scalarizer_0mul_0_reg_1[31:0] = (local_lvm_scalarizer_0mul_NO_SHIFT_REG & 32'hFFFFFFFE);
assign rci_rcnode_1to3_rc1_scalarizer_0mul_0_reg_1[63:32] = (local_lvm_scalarizer_1mul_NO_SHIFT_REG & 32'hFFFFFFFE);
assign rci_rcnode_1to3_rc1_scalarizer_0mul_0_reg_1[95:64] = local_lvm_ld__NO_SHIFT_REG;
assign rci_rcnode_1to3_rc1_scalarizer_0mul_0_reg_1[127:96] = local_lvm_c0_exe1_NO_SHIFT_REG;
assign rci_rcnode_1to3_rc1_scalarizer_0mul_0_reg_1[159:128] = local_lvm_c0_exe2_NO_SHIFT_REG;
assign rci_rcnode_1to3_rc1_scalarizer_0mul_0_reg_1[191:160] = local_lvm_input_global_id_0_NO_SHIFT_REG;
assign rci_rcnode_1to3_rc1_scalarizer_0mul_0_reg_1[223:192] = local_lvm_input_global_id_1_NO_SHIFT_REG;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rcnode_1to3_rc1_scalarizer_0mul_0_valid_out_NO_SHIFT_REG;
 logic rcnode_1to3_rc1_scalarizer_0mul_0_stall_in_NO_SHIFT_REG;
 logic [223:0] rcnode_1to3_rc1_scalarizer_0mul_0_NO_SHIFT_REG;
 logic rcnode_1to3_rc1_scalarizer_0mul_0_reg_3_inputs_ready_NO_SHIFT_REG;
 logic [223:0] rcnode_1to3_rc1_scalarizer_0mul_0_reg_3_NO_SHIFT_REG;
 logic rcnode_1to3_rc1_scalarizer_0mul_0_valid_out_reg_3_NO_SHIFT_REG;
 logic rcnode_1to3_rc1_scalarizer_0mul_0_stall_in_reg_3_NO_SHIFT_REG;
 logic rcnode_1to3_rc1_scalarizer_0mul_0_stall_out_reg_3_IP_NO_SHIFT_REG;
 logic rcnode_1to3_rc1_scalarizer_0mul_0_stall_out_reg_3_NO_SHIFT_REG;

acl_data_fifo rcnode_1to3_rc1_scalarizer_0mul_0_reg_3_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rcnode_1to3_rc1_scalarizer_0mul_0_reg_3_inputs_ready_NO_SHIFT_REG),
	.stall_in(rcnode_1to3_rc1_scalarizer_0mul_0_stall_in_reg_3_NO_SHIFT_REG),
	.valid_out(rcnode_1to3_rc1_scalarizer_0mul_0_valid_out_reg_3_NO_SHIFT_REG),
	.stall_out(rcnode_1to3_rc1_scalarizer_0mul_0_stall_out_reg_3_IP_NO_SHIFT_REG),
	.data_in(rci_rcnode_1to3_rc1_scalarizer_0mul_0_reg_1),
	.data_out(rcnode_1to3_rc1_scalarizer_0mul_0_reg_3_NO_SHIFT_REG)
);

defparam rcnode_1to3_rc1_scalarizer_0mul_0_reg_3_fifo.DEPTH = 3;
defparam rcnode_1to3_rc1_scalarizer_0mul_0_reg_3_fifo.DATA_WIDTH = 224;
defparam rcnode_1to3_rc1_scalarizer_0mul_0_reg_3_fifo.ALLOW_FULL_WRITE = 0;
defparam rcnode_1to3_rc1_scalarizer_0mul_0_reg_3_fifo.IMPL = "ll_reg";

assign rcnode_1to3_rc1_scalarizer_0mul_0_reg_3_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_1_NO_SHIFT_REG;
assign rcnode_1to3_rc1_scalarizer_0mul_0_stall_out_reg_3_NO_SHIFT_REG = (~(rcnode_1to3_rc1_scalarizer_0mul_0_reg_3_inputs_ready_NO_SHIFT_REG) | rcnode_1to3_rc1_scalarizer_0mul_0_stall_out_reg_3_IP_NO_SHIFT_REG);
assign merge_node_stall_in_1 = rcnode_1to3_rc1_scalarizer_0mul_0_stall_out_reg_3_NO_SHIFT_REG;
assign rcnode_1to3_rc1_scalarizer_0mul_0_NO_SHIFT_REG = rcnode_1to3_rc1_scalarizer_0mul_0_reg_3_NO_SHIFT_REG;
assign rcnode_1to3_rc1_scalarizer_0mul_0_stall_in_reg_3_NO_SHIFT_REG = rcnode_1to3_rc1_scalarizer_0mul_0_stall_in_NO_SHIFT_REG;
assign rcnode_1to3_rc1_scalarizer_0mul_0_valid_out_NO_SHIFT_REG = rcnode_1to3_rc1_scalarizer_0mul_0_valid_out_reg_3_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb4_inc36_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_bb4_inc36_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb4_inc36_0_NO_SHIFT_REG;
 logic rnode_1to2_bb4_inc36_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_bb4_inc36_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb4_inc36_1_NO_SHIFT_REG;
 logic rnode_1to2_bb4_inc36_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb4_inc36_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb4_inc36_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb4_inc36_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb4_inc36_0_stall_out_reg_2_NO_SHIFT_REG;
 reg rnode_1to2_bb4_inc36_0_consumed_0_NO_SHIFT_REG;
 reg rnode_1to2_bb4_inc36_0_consumed_1_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb4_inc36_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb4_inc36_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb4_inc36_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb4_inc36_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb4_inc36_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb4_inc36),
	.data_out(rnode_1to2_bb4_inc36_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb4_inc36_0_reg_2_fifo.DEPTH = 1;
defparam rnode_1to2_bb4_inc36_0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_bb4_inc36_0_reg_2_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_1to2_bb4_inc36_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb4_inc36_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb4_inc36_valid_out;
assign local_bb4_inc36_stall_in = rnode_1to2_bb4_inc36_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb4_inc36_0_stall_in_0_reg_2_NO_SHIFT_REG = ((rnode_1to2_bb4_inc36_0_stall_in_0_NO_SHIFT_REG & ~(rnode_1to2_bb4_inc36_0_consumed_0_NO_SHIFT_REG)) | (rnode_1to2_bb4_inc36_0_stall_in_1_NO_SHIFT_REG & ~(rnode_1to2_bb4_inc36_0_consumed_1_NO_SHIFT_REG)));
assign rnode_1to2_bb4_inc36_0_valid_out_0_NO_SHIFT_REG = (rnode_1to2_bb4_inc36_0_valid_out_0_reg_2_NO_SHIFT_REG & ~(rnode_1to2_bb4_inc36_0_consumed_0_NO_SHIFT_REG));
assign rnode_1to2_bb4_inc36_0_valid_out_1_NO_SHIFT_REG = (rnode_1to2_bb4_inc36_0_valid_out_0_reg_2_NO_SHIFT_REG & ~(rnode_1to2_bb4_inc36_0_consumed_1_NO_SHIFT_REG));
assign rnode_1to2_bb4_inc36_0_NO_SHIFT_REG = rnode_1to2_bb4_inc36_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb4_inc36_1_NO_SHIFT_REG = rnode_1to2_bb4_inc36_0_reg_2_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rnode_1to2_bb4_inc36_0_consumed_0_NO_SHIFT_REG <= 1'b0;
		rnode_1to2_bb4_inc36_0_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rnode_1to2_bb4_inc36_0_consumed_0_NO_SHIFT_REG <= (rnode_1to2_bb4_inc36_0_valid_out_0_reg_2_NO_SHIFT_REG & (rnode_1to2_bb4_inc36_0_consumed_0_NO_SHIFT_REG | ~(rnode_1to2_bb4_inc36_0_stall_in_0_NO_SHIFT_REG)) & rnode_1to2_bb4_inc36_0_stall_in_0_reg_2_NO_SHIFT_REG);
		rnode_1to2_bb4_inc36_0_consumed_1_NO_SHIFT_REG <= (rnode_1to2_bb4_inc36_0_valid_out_0_reg_2_NO_SHIFT_REG & (rnode_1to2_bb4_inc36_0_consumed_1_NO_SHIFT_REG | ~(rnode_1to2_bb4_inc36_0_stall_in_1_NO_SHIFT_REG)) & rnode_1to2_bb4_inc36_0_stall_in_0_reg_2_NO_SHIFT_REG);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb4_cmp_valid_out;
wire local_bb4_cmp_stall_in;
wire local_bb4_cmp_inputs_ready;
wire local_bb4_cmp_stall_local;
wire local_bb4_cmp;

assign local_bb4_cmp_inputs_ready = rnode_1to2_bb4_inc36_0_valid_out_0_NO_SHIFT_REG;
assign local_bb4_cmp = ($signed(rnode_1to2_bb4_inc36_0_NO_SHIFT_REG) > $signed(input_r));
assign local_bb4_cmp_valid_out = local_bb4_cmp_inputs_ready;
assign local_bb4_cmp_stall_local = local_bb4_cmp_stall_in;
assign rnode_1to2_bb4_inc36_0_stall_in_0_NO_SHIFT_REG = (|local_bb4_cmp_stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_2to3_bb4_inc36_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to3_bb4_inc36_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_2to3_bb4_inc36_0_NO_SHIFT_REG;
 logic rnode_2to3_bb4_inc36_0_reg_3_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_2to3_bb4_inc36_0_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb4_inc36_0_valid_out_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb4_inc36_0_stall_in_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb4_inc36_0_stall_out_reg_3_NO_SHIFT_REG;

acl_data_fifo rnode_2to3_bb4_inc36_0_reg_3_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to3_bb4_inc36_0_reg_3_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to3_bb4_inc36_0_stall_in_reg_3_NO_SHIFT_REG),
	.valid_out(rnode_2to3_bb4_inc36_0_valid_out_reg_3_NO_SHIFT_REG),
	.stall_out(rnode_2to3_bb4_inc36_0_stall_out_reg_3_NO_SHIFT_REG),
	.data_in(rnode_1to2_bb4_inc36_1_NO_SHIFT_REG),
	.data_out(rnode_2to3_bb4_inc36_0_reg_3_NO_SHIFT_REG)
);

defparam rnode_2to3_bb4_inc36_0_reg_3_fifo.DEPTH = 1;
defparam rnode_2to3_bb4_inc36_0_reg_3_fifo.DATA_WIDTH = 32;
defparam rnode_2to3_bb4_inc36_0_reg_3_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_2to3_bb4_inc36_0_reg_3_fifo.IMPL = "ll_reg";

assign rnode_2to3_bb4_inc36_0_reg_3_inputs_ready_NO_SHIFT_REG = rnode_1to2_bb4_inc36_0_valid_out_1_NO_SHIFT_REG;
assign rnode_1to2_bb4_inc36_0_stall_in_1_NO_SHIFT_REG = rnode_2to3_bb4_inc36_0_stall_out_reg_3_NO_SHIFT_REG;
assign rnode_2to3_bb4_inc36_0_NO_SHIFT_REG = rnode_2to3_bb4_inc36_0_reg_3_NO_SHIFT_REG;
assign rnode_2to3_bb4_inc36_0_stall_in_reg_3_NO_SHIFT_REG = rnode_2to3_bb4_inc36_0_stall_in_NO_SHIFT_REG;
assign rnode_2to3_bb4_inc36_0_valid_out_NO_SHIFT_REG = rnode_2to3_bb4_inc36_0_valid_out_reg_3_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_2to3_bb4_cmp_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to3_bb4_cmp_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to3_bb4_cmp_0_NO_SHIFT_REG;
 logic rnode_2to3_bb4_cmp_0_reg_3_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to3_bb4_cmp_0_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb4_cmp_0_valid_out_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb4_cmp_0_stall_in_reg_3_NO_SHIFT_REG;
 logic rnode_2to3_bb4_cmp_0_stall_out_reg_3_NO_SHIFT_REG;

acl_data_fifo rnode_2to3_bb4_cmp_0_reg_3_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to3_bb4_cmp_0_reg_3_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to3_bb4_cmp_0_stall_in_reg_3_NO_SHIFT_REG),
	.valid_out(rnode_2to3_bb4_cmp_0_valid_out_reg_3_NO_SHIFT_REG),
	.stall_out(rnode_2to3_bb4_cmp_0_stall_out_reg_3_NO_SHIFT_REG),
	.data_in(local_bb4_cmp),
	.data_out(rnode_2to3_bb4_cmp_0_reg_3_NO_SHIFT_REG)
);

defparam rnode_2to3_bb4_cmp_0_reg_3_fifo.DEPTH = 1;
defparam rnode_2to3_bb4_cmp_0_reg_3_fifo.DATA_WIDTH = 1;
defparam rnode_2to3_bb4_cmp_0_reg_3_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_2to3_bb4_cmp_0_reg_3_fifo.IMPL = "ll_reg";

assign rnode_2to3_bb4_cmp_0_reg_3_inputs_ready_NO_SHIFT_REG = local_bb4_cmp_valid_out;
assign local_bb4_cmp_stall_in = rnode_2to3_bb4_cmp_0_stall_out_reg_3_NO_SHIFT_REG;
assign rnode_2to3_bb4_cmp_0_NO_SHIFT_REG = rnode_2to3_bb4_cmp_0_reg_3_NO_SHIFT_REG;
assign rnode_2to3_bb4_cmp_0_stall_in_reg_3_NO_SHIFT_REG = rnode_2to3_bb4_cmp_0_stall_in_NO_SHIFT_REG;
assign rnode_2to3_bb4_cmp_0_valid_out_NO_SHIFT_REG = rnode_2to3_bb4_cmp_0_valid_out_reg_3_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb4_var__valid_out;
wire local_bb4_var__stall_in;
wire local_bb4_var__inputs_ready;
wire local_bb4_var__stall_local;
wire local_bb4_var_;

assign local_bb4_var__inputs_ready = rnode_2to3_bb4_cmp_0_valid_out_NO_SHIFT_REG;
assign local_bb4_var_ = (input_wii_cmp9 | rnode_2to3_bb4_cmp_0_NO_SHIFT_REG);
assign local_bb4_var__valid_out = local_bb4_var__inputs_ready;
assign local_bb4_var__stall_local = local_bb4_var__stall_in;
assign rnode_2to3_bb4_cmp_0_stall_in_NO_SHIFT_REG = (|local_bb4_var__stall_local);

// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_scalarizer_0mul_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_scalarizer_1mul_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_ld__0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_c0_exe1_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_c0_exe2_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb4_inc36_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_0_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_1_0_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb4_var__valid_out & rnode_2to3_bb4_inc36_0_valid_out_NO_SHIFT_REG & rcnode_1to3_rc1_scalarizer_0mul_0_valid_out_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign local_bb4_var__stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_2to3_bb4_inc36_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rcnode_1to3_rc1_scalarizer_0mul_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_scalarizer_0mul_0 = lvb_scalarizer_0mul_0_reg_NO_SHIFT_REG;
assign lvb_scalarizer_0mul_1 = lvb_scalarizer_0mul_0_reg_NO_SHIFT_REG;
assign lvb_scalarizer_1mul_0 = lvb_scalarizer_1mul_0_reg_NO_SHIFT_REG;
assign lvb_scalarizer_1mul_1 = lvb_scalarizer_1mul_0_reg_NO_SHIFT_REG;
assign lvb_ld__0 = lvb_ld__0_reg_NO_SHIFT_REG;
assign lvb_ld__1 = lvb_ld__0_reg_NO_SHIFT_REG;
assign lvb_c0_exe1_0 = lvb_c0_exe1_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe1_1 = lvb_c0_exe1_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe2_0 = lvb_c0_exe2_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe2_1 = lvb_c0_exe2_0_reg_NO_SHIFT_REG;
assign lvb_bb4_inc36_0 = lvb_bb4_inc36_0_reg_NO_SHIFT_REG;
assign lvb_bb4_inc36_1 = lvb_bb4_inc36_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_0_0 = lvb_input_global_id_0_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_0_1 = lvb_input_global_id_0_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_1_0 = lvb_input_global_id_1_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_1_1 = lvb_input_global_id_1_0_reg_NO_SHIFT_REG;
assign valid_out_0 = (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG);
assign valid_out_1 = ((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG);
assign combined_branch_stall_in_signal = ((((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_1) | ((~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_0));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		lvb_scalarizer_0mul_0_reg_NO_SHIFT_REG <= 'x;
		lvb_scalarizer_1mul_0_reg_NO_SHIFT_REG <= 'x;
		lvb_ld__0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe1_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe2_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb4_inc36_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_0_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_1_0_reg_NO_SHIFT_REG <= 'x;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_scalarizer_0mul_0_reg_NO_SHIFT_REG <= (rcnode_1to3_rc1_scalarizer_0mul_0_NO_SHIFT_REG[31:0] & 32'hFFFFFFFE);
			lvb_scalarizer_1mul_0_reg_NO_SHIFT_REG <= (rcnode_1to3_rc1_scalarizer_0mul_0_NO_SHIFT_REG[63:32] & 32'hFFFFFFFE);
			lvb_ld__0_reg_NO_SHIFT_REG <= rcnode_1to3_rc1_scalarizer_0mul_0_NO_SHIFT_REG[95:64];
			lvb_c0_exe1_0_reg_NO_SHIFT_REG <= rcnode_1to3_rc1_scalarizer_0mul_0_NO_SHIFT_REG[127:96];
			lvb_c0_exe2_0_reg_NO_SHIFT_REG <= rcnode_1to3_rc1_scalarizer_0mul_0_NO_SHIFT_REG[159:128];
			lvb_bb4_inc36_0_reg_NO_SHIFT_REG <= rnode_2to3_bb4_inc36_0_NO_SHIFT_REG;
			lvb_input_global_id_0_0_reg_NO_SHIFT_REG <= rcnode_1to3_rc1_scalarizer_0mul_0_NO_SHIFT_REG[191:160];
			lvb_input_global_id_1_0_reg_NO_SHIFT_REG <= rcnode_1to3_rc1_scalarizer_0mul_0_NO_SHIFT_REG[223:192];
			branch_compare_result_NO_SHIFT_REG <= local_bb4_var_;
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
module AOChalfSampleRobustImageKernel_basic_block_5
	(
		input 		clock,
		input 		resetn,
		input [63:0] 		input_out,
		input [31:0] 		input_wii_div,
		input 		input_wii_cmp9,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_c0_exe1,
		input [31:0] 		input_c0_exe2,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_global_id_1,
		output 		valid_out,
		input 		stall_in,
		input [31:0] 		workgroup_size,
		input 		start,
		input [511:0] 		avm_local_bb5_st_c0_exe18_readdata,
		input 		avm_local_bb5_st_c0_exe18_readdatavalid,
		input 		avm_local_bb5_st_c0_exe18_waitrequest,
		output [32:0] 		avm_local_bb5_st_c0_exe18_address,
		output 		avm_local_bb5_st_c0_exe18_read,
		output 		avm_local_bb5_st_c0_exe18_write,
		input 		avm_local_bb5_st_c0_exe18_writeack,
		output [511:0] 		avm_local_bb5_st_c0_exe18_writedata,
		output [63:0] 		avm_local_bb5_st_c0_exe18_byteenable,
		output [4:0] 		avm_local_bb5_st_c0_exe18_burstcount,
		output 		local_bb5_st_c0_exe18_active,
		input 		clock2x
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
wire merge_node_stall_in_3;
 reg merge_node_valid_out_3_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe2_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe1_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe2_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_1_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG));
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
		input_c0_exe1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe2_staging_reg_NO_SHIFT_REG <= 'x;
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
				input_c0_exe1_staging_reg_NO_SHIFT_REG <= input_c0_exe1;
				input_c0_exe2_staging_reg_NO_SHIFT_REG <= input_c0_exe2;
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
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2;
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
wire local_bb5_c0_eni11_stall_local;
wire [95:0] local_bb5_c0_eni11;

assign local_bb5_c0_eni11[31:0] = 32'bx;
assign local_bb5_c0_eni11[63:32] = local_lvm_c0_exe2_NO_SHIFT_REG;
assign local_bb5_c0_eni11[95:64] = 32'bx;

// This section implements a registered operation.
// 
wire local_bb5_mul39_inputs_ready;
 reg local_bb5_mul39_valid_out_NO_SHIFT_REG;
wire local_bb5_mul39_stall_in;
wire local_bb5_mul39_output_regs_ready;
wire [31:0] local_bb5_mul39;
 reg local_bb5_mul39_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb5_mul39_valid_pipe_1_NO_SHIFT_REG;
wire local_bb5_mul39_causedstall;

acl_int_mult int_module_local_bb5_mul39 (
	.clock(clock),
	.dataa((input_wii_div & 32'h7FFFFFFF)),
	.datab(local_lvm_input_global_id_1_NO_SHIFT_REG),
	.enable(local_bb5_mul39_output_regs_ready),
	.result(local_bb5_mul39)
);

defparam int_module_local_bb5_mul39.INPUT1_WIDTH = 31;
defparam int_module_local_bb5_mul39.INPUT2_WIDTH = 32;
defparam int_module_local_bb5_mul39.OUTPUT_WIDTH = 32;
defparam int_module_local_bb5_mul39.LATENCY = 3;
defparam int_module_local_bb5_mul39.SIGNED = 0;

assign local_bb5_mul39_inputs_ready = merge_node_valid_out_2_NO_SHIFT_REG;
assign local_bb5_mul39_output_regs_ready = (&(~(local_bb5_mul39_valid_out_NO_SHIFT_REG) | ~(local_bb5_mul39_stall_in)));
assign merge_node_stall_in_2 = (~(local_bb5_mul39_output_regs_ready) | ~(local_bb5_mul39_inputs_ready));
assign local_bb5_mul39_causedstall = (local_bb5_mul39_inputs_ready && (~(local_bb5_mul39_output_regs_ready) && !(~(local_bb5_mul39_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb5_mul39_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb5_mul39_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb5_mul39_output_regs_ready)
		begin
			local_bb5_mul39_valid_pipe_0_NO_SHIFT_REG <= local_bb5_mul39_inputs_ready;
			local_bb5_mul39_valid_pipe_1_NO_SHIFT_REG <= local_bb5_mul39_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb5_mul39_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb5_mul39_output_regs_ready)
		begin
			local_bb5_mul39_valid_out_NO_SHIFT_REG <= local_bb5_mul39_valid_pipe_1_NO_SHIFT_REG;
		end
		else
		begin
			if (~(local_bb5_mul39_stall_in))
			begin
				local_bb5_mul39_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_1to4_input_global_id_0_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to4_input_global_id_0_0_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to4_input_global_id_0_0_reg_4_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_valid_out_reg_4_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_stall_in_reg_4_NO_SHIFT_REG;
 logic rnode_1to4_input_global_id_0_0_stall_out_reg_4_NO_SHIFT_REG;

acl_data_fifo rnode_1to4_input_global_id_0_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to4_input_global_id_0_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to4_input_global_id_0_0_stall_in_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_1to4_input_global_id_0_0_valid_out_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_1to4_input_global_id_0_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(local_lvm_input_global_id_0_NO_SHIFT_REG),
	.data_out(rnode_1to4_input_global_id_0_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_1to4_input_global_id_0_0_reg_4_fifo.DEPTH = 4;
defparam rnode_1to4_input_global_id_0_0_reg_4_fifo.DATA_WIDTH = 32;
defparam rnode_1to4_input_global_id_0_0_reg_4_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to4_input_global_id_0_0_reg_4_fifo.IMPL = "ll_reg";

assign rnode_1to4_input_global_id_0_0_reg_4_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_3_NO_SHIFT_REG;
assign merge_node_stall_in_3 = rnode_1to4_input_global_id_0_0_stall_out_reg_4_NO_SHIFT_REG;
assign rnode_1to4_input_global_id_0_0_NO_SHIFT_REG = rnode_1to4_input_global_id_0_0_reg_4_NO_SHIFT_REG;
assign rnode_1to4_input_global_id_0_0_stall_in_reg_4_NO_SHIFT_REG = rnode_1to4_input_global_id_0_0_stall_in_NO_SHIFT_REG;
assign rnode_1to4_input_global_id_0_0_valid_out_NO_SHIFT_REG = rnode_1to4_input_global_id_0_0_valid_out_reg_4_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb5_c0_eni22_valid_out;
wire local_bb5_c0_eni22_stall_in;
wire local_bb5_c0_eni22_inputs_ready;
wire local_bb5_c0_eni22_stall_local;
wire [95:0] local_bb5_c0_eni22;

assign local_bb5_c0_eni22_inputs_ready = (merge_node_valid_out_0_NO_SHIFT_REG & merge_node_valid_out_1_NO_SHIFT_REG);
assign local_bb5_c0_eni22[63:0] = local_bb5_c0_eni11[63:0];
assign local_bb5_c0_eni22[95:64] = local_lvm_c0_exe1_NO_SHIFT_REG;
assign local_bb5_c0_eni22_valid_out = local_bb5_c0_eni22_inputs_ready;
assign local_bb5_c0_eni22_stall_local = local_bb5_c0_eni22_stall_in;
assign merge_node_stall_in_0 = (local_bb5_c0_eni22_stall_local | ~(local_bb5_c0_eni22_inputs_ready));
assign merge_node_stall_in_1 = (local_bb5_c0_eni22_stall_local | ~(local_bb5_c0_eni22_inputs_ready));

// Register node:
//  * latency = 0
//  * capacity = 2
 logic rnode_4to4_bb5_mul39_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to4_bb5_mul39_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_4to4_bb5_mul39_0_NO_SHIFT_REG;
 logic rnode_4to4_bb5_mul39_0_reg_4_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_4to4_bb5_mul39_0_reg_4_NO_SHIFT_REG;
 logic rnode_4to4_bb5_mul39_0_valid_out_reg_4_NO_SHIFT_REG;
 logic rnode_4to4_bb5_mul39_0_stall_in_reg_4_NO_SHIFT_REG;
 logic rnode_4to4_bb5_mul39_0_stall_out_reg_4_NO_SHIFT_REG;

acl_data_fifo rnode_4to4_bb5_mul39_0_reg_4_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to4_bb5_mul39_0_reg_4_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to4_bb5_mul39_0_stall_in_reg_4_NO_SHIFT_REG),
	.valid_out(rnode_4to4_bb5_mul39_0_valid_out_reg_4_NO_SHIFT_REG),
	.stall_out(rnode_4to4_bb5_mul39_0_stall_out_reg_4_NO_SHIFT_REG),
	.data_in(local_bb5_mul39),
	.data_out(rnode_4to4_bb5_mul39_0_reg_4_NO_SHIFT_REG)
);

defparam rnode_4to4_bb5_mul39_0_reg_4_fifo.DEPTH = 3;
defparam rnode_4to4_bb5_mul39_0_reg_4_fifo.DATA_WIDTH = 32;
defparam rnode_4to4_bb5_mul39_0_reg_4_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_4to4_bb5_mul39_0_reg_4_fifo.IMPL = "zl_reg";

assign rnode_4to4_bb5_mul39_0_reg_4_inputs_ready_NO_SHIFT_REG = local_bb5_mul39_valid_out_NO_SHIFT_REG;
assign local_bb5_mul39_stall_in = rnode_4to4_bb5_mul39_0_stall_out_reg_4_NO_SHIFT_REG;
assign rnode_4to4_bb5_mul39_0_NO_SHIFT_REG = rnode_4to4_bb5_mul39_0_reg_4_NO_SHIFT_REG;
assign rnode_4to4_bb5_mul39_0_stall_in_reg_4_NO_SHIFT_REG = rnode_4to4_bb5_mul39_0_stall_in_NO_SHIFT_REG;
assign rnode_4to4_bb5_mul39_0_valid_out_NO_SHIFT_REG = rnode_4to4_bb5_mul39_0_valid_out_reg_4_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb5_c0_enter3_c0_eni22_inputs_ready;
 reg local_bb5_c0_enter3_c0_eni22_valid_out_0_NO_SHIFT_REG;
wire local_bb5_c0_enter3_c0_eni22_stall_in_0;
 reg local_bb5_c0_enter3_c0_eni22_valid_out_1_NO_SHIFT_REG;
wire local_bb5_c0_enter3_c0_eni22_stall_in_1;
 reg local_bb5_c0_enter3_c0_eni22_valid_out_2_NO_SHIFT_REG;
wire local_bb5_c0_enter3_c0_eni22_stall_in_2;
wire local_bb5_c0_enter3_c0_eni22_output_regs_ready;
 reg [95:0] local_bb5_c0_enter3_c0_eni22_NO_SHIFT_REG;
wire local_bb5_c0_enter3_c0_eni22_input_accepted;
 reg local_bb5_c0_enter3_c0_eni22_valid_bit_NO_SHIFT_REG;
wire local_bb5_c0_exit7_c0_exi16_entry_stall;
wire local_bb5_c0_exit7_c0_exi16_output_regs_ready;
wire [15:0] local_bb5_c0_exit7_c0_exi16_valid_bits;
wire local_bb5_c0_exit7_c0_exi16_valid_in;
wire local_bb5_c0_exit7_c0_exi16_phases;
wire local_bb5_c0_enter3_c0_eni22_inc_pipelined_thread;
wire local_bb5_c0_enter3_c0_eni22_dec_pipelined_thread;
wire local_bb5_c0_enter3_c0_eni22_causedstall;

assign local_bb5_c0_enter3_c0_eni22_inputs_ready = local_bb5_c0_eni22_valid_out;
assign local_bb5_c0_enter3_c0_eni22_output_regs_ready = 1'b1;
assign local_bb5_c0_enter3_c0_eni22_input_accepted = (local_bb5_c0_enter3_c0_eni22_inputs_ready && !(local_bb5_c0_exit7_c0_exi16_entry_stall));
assign local_bb5_c0_enter3_c0_eni22_inc_pipelined_thread = 1'b1;
assign local_bb5_c0_enter3_c0_eni22_dec_pipelined_thread = ~(1'b0);
assign local_bb5_c0_eni22_stall_in = ((~(local_bb5_c0_enter3_c0_eni22_inputs_ready) | local_bb5_c0_exit7_c0_exi16_entry_stall) | ~(1'b1));
assign local_bb5_c0_enter3_c0_eni22_causedstall = (1'b1 && ((~(local_bb5_c0_enter3_c0_eni22_inputs_ready) | local_bb5_c0_exit7_c0_exi16_entry_stall) && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb5_c0_enter3_c0_eni22_valid_bit_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb5_c0_enter3_c0_eni22_valid_bit_NO_SHIFT_REG <= local_bb5_c0_enter3_c0_eni22_input_accepted;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb5_c0_enter3_c0_eni22_NO_SHIFT_REG <= 'x;
		local_bb5_c0_enter3_c0_eni22_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb5_c0_enter3_c0_eni22_valid_out_1_NO_SHIFT_REG <= 1'b0;
		local_bb5_c0_enter3_c0_eni22_valid_out_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb5_c0_enter3_c0_eni22_output_regs_ready)
		begin
			local_bb5_c0_enter3_c0_eni22_NO_SHIFT_REG <= local_bb5_c0_eni22;
			local_bb5_c0_enter3_c0_eni22_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb5_c0_enter3_c0_eni22_valid_out_1_NO_SHIFT_REG <= 1'b1;
			local_bb5_c0_enter3_c0_eni22_valid_out_2_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb5_c0_enter3_c0_eni22_stall_in_0))
			begin
				local_bb5_c0_enter3_c0_eni22_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb5_c0_enter3_c0_eni22_stall_in_1))
			begin
				local_bb5_c0_enter3_c0_eni22_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb5_c0_enter3_c0_eni22_stall_in_2))
			begin
				local_bb5_c0_enter3_c0_eni22_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb5_add40_valid_out;
wire local_bb5_add40_stall_in;
wire local_bb5_add40_inputs_ready;
wire local_bb5_add40_stall_local;
wire [31:0] local_bb5_add40;

assign local_bb5_add40_inputs_ready = (rnode_1to4_input_global_id_0_0_valid_out_NO_SHIFT_REG & rnode_4to4_bb5_mul39_0_valid_out_NO_SHIFT_REG);
assign local_bb5_add40 = (rnode_4to4_bb5_mul39_0_NO_SHIFT_REG + rnode_1to4_input_global_id_0_0_NO_SHIFT_REG);
assign local_bb5_add40_valid_out = local_bb5_add40_inputs_ready;
assign local_bb5_add40_stall_local = local_bb5_add40_stall_in;
assign rnode_1to4_input_global_id_0_0_stall_in_NO_SHIFT_REG = (local_bb5_add40_stall_local | ~(local_bb5_add40_inputs_ready));
assign rnode_4to4_bb5_mul39_0_stall_in_NO_SHIFT_REG = (local_bb5_add40_stall_local | ~(local_bb5_add40_inputs_ready));

// This section implements an unregistered operation.
// 
wire local_bb5_c0_ene14_stall_local;
wire [31:0] local_bb5_c0_ene14;

assign local_bb5_c0_ene14 = local_bb5_c0_enter3_c0_eni22_NO_SHIFT_REG[63:32];

// This section implements an unregistered operation.
// 
wire local_bb5_c0_ene25_stall_local;
wire [31:0] local_bb5_c0_ene25;

assign local_bb5_c0_ene25 = local_bb5_c0_enter3_c0_eni22_NO_SHIFT_REG[95:64];

// This section implements an unregistered operation.
// 
wire SFC_2_VALID_2_2_0_valid_out;
wire SFC_2_VALID_2_2_0_stall_in;
wire SFC_2_VALID_2_2_0_inputs_ready;
wire SFC_2_VALID_2_2_0_stall_local;
wire SFC_2_VALID_2_2_0;

assign SFC_2_VALID_2_2_0_inputs_ready = local_bb5_c0_enter3_c0_eni22_valid_out_2_NO_SHIFT_REG;
assign SFC_2_VALID_2_2_0 = local_bb5_c0_enter3_c0_eni22_valid_bit_NO_SHIFT_REG;
assign SFC_2_VALID_2_2_0_valid_out = 1'b1;
assign local_bb5_c0_enter3_c0_eni22_stall_in_2 = 1'b0;

// Register node:
//  * latency = 15
//  * capacity = 15
 logic rnode_4to19_bb5_add40_0_valid_out_NO_SHIFT_REG;
 logic rnode_4to19_bb5_add40_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_4to19_bb5_add40_0_NO_SHIFT_REG;
 logic rnode_4to19_bb5_add40_0_reg_19_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_4to19_bb5_add40_0_reg_19_NO_SHIFT_REG;
 logic rnode_4to19_bb5_add40_0_valid_out_reg_19_NO_SHIFT_REG;
 logic rnode_4to19_bb5_add40_0_stall_in_reg_19_NO_SHIFT_REG;
 logic rnode_4to19_bb5_add40_0_stall_out_reg_19_NO_SHIFT_REG;

acl_data_fifo rnode_4to19_bb5_add40_0_reg_19_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to19_bb5_add40_0_reg_19_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to19_bb5_add40_0_stall_in_reg_19_NO_SHIFT_REG),
	.valid_out(rnode_4to19_bb5_add40_0_valid_out_reg_19_NO_SHIFT_REG),
	.stall_out(rnode_4to19_bb5_add40_0_stall_out_reg_19_NO_SHIFT_REG),
	.data_in(local_bb5_add40),
	.data_out(rnode_4to19_bb5_add40_0_reg_19_NO_SHIFT_REG)
);

defparam rnode_4to19_bb5_add40_0_reg_19_fifo.DEPTH = 16;
defparam rnode_4to19_bb5_add40_0_reg_19_fifo.DATA_WIDTH = 32;
defparam rnode_4to19_bb5_add40_0_reg_19_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_4to19_bb5_add40_0_reg_19_fifo.IMPL = "ram";

assign rnode_4to19_bb5_add40_0_reg_19_inputs_ready_NO_SHIFT_REG = local_bb5_add40_valid_out;
assign local_bb5_add40_stall_in = rnode_4to19_bb5_add40_0_stall_out_reg_19_NO_SHIFT_REG;
assign rnode_4to19_bb5_add40_0_NO_SHIFT_REG = rnode_4to19_bb5_add40_0_reg_19_NO_SHIFT_REG;
assign rnode_4to19_bb5_add40_0_stall_in_reg_19_NO_SHIFT_REG = rnode_4to19_bb5_add40_0_stall_in_NO_SHIFT_REG;
assign rnode_4to19_bb5_add40_0_valid_out_NO_SHIFT_REG = rnode_4to19_bb5_add40_0_valid_out_reg_19_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb5_select17_valid_out;
wire local_bb5_select17_stall_in;
wire local_bb5_select17_inputs_ready;
wire local_bb5_select17_stall_local;
wire [31:0] local_bb5_select17;

assign local_bb5_select17_inputs_ready = local_bb5_c0_enter3_c0_eni22_valid_out_0_NO_SHIFT_REG;
assign local_bb5_select17 = (input_wii_cmp9 ? 32'h0 : local_bb5_c0_ene14);
assign local_bb5_select17_valid_out = 1'b1;
assign local_bb5_c0_enter3_c0_eni22_stall_in_0 = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb5_select20_valid_out;
wire local_bb5_select20_stall_in;
wire local_bb5_select20_inputs_ready;
wire local_bb5_select20_stall_local;
wire [31:0] local_bb5_select20;

assign local_bb5_select20_inputs_ready = local_bb5_c0_enter3_c0_eni22_valid_out_1_NO_SHIFT_REG;
assign local_bb5_select20 = (input_wii_cmp9 ? 32'h0 : local_bb5_c0_ene25);
assign local_bb5_select20_valid_out = 1'b1;
assign local_bb5_c0_enter3_c0_eni22_stall_in_1 = 1'b0;

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
assign SFC_2_VALID_2_2_0_stall_in = 1'b0;
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
			SFC_2_VALID_2_3_0_NO_SHIFT_REG <= SFC_2_VALID_2_2_0;
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_19to20_bb5_add40_0_valid_out_NO_SHIFT_REG;
 logic rnode_19to20_bb5_add40_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_19to20_bb5_add40_0_NO_SHIFT_REG;
 logic rnode_19to20_bb5_add40_0_reg_20_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_19to20_bb5_add40_0_reg_20_NO_SHIFT_REG;
 logic rnode_19to20_bb5_add40_0_valid_out_reg_20_NO_SHIFT_REG;
 logic rnode_19to20_bb5_add40_0_stall_in_reg_20_NO_SHIFT_REG;
 logic rnode_19to20_bb5_add40_0_stall_out_reg_20_NO_SHIFT_REG;

acl_data_fifo rnode_19to20_bb5_add40_0_reg_20_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_19to20_bb5_add40_0_reg_20_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_19to20_bb5_add40_0_stall_in_reg_20_NO_SHIFT_REG),
	.valid_out(rnode_19to20_bb5_add40_0_valid_out_reg_20_NO_SHIFT_REG),
	.stall_out(rnode_19to20_bb5_add40_0_stall_out_reg_20_NO_SHIFT_REG),
	.data_in(rnode_4to19_bb5_add40_0_NO_SHIFT_REG),
	.data_out(rnode_19to20_bb5_add40_0_reg_20_NO_SHIFT_REG)
);

defparam rnode_19to20_bb5_add40_0_reg_20_fifo.DEPTH = 1;
defparam rnode_19to20_bb5_add40_0_reg_20_fifo.DATA_WIDTH = 32;
defparam rnode_19to20_bb5_add40_0_reg_20_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_19to20_bb5_add40_0_reg_20_fifo.IMPL = "ll_reg";

assign rnode_19to20_bb5_add40_0_reg_20_inputs_ready_NO_SHIFT_REG = rnode_4to19_bb5_add40_0_valid_out_NO_SHIFT_REG;
assign rnode_4to19_bb5_add40_0_stall_in_NO_SHIFT_REG = rnode_19to20_bb5_add40_0_stall_out_reg_20_NO_SHIFT_REG;
assign rnode_19to20_bb5_add40_0_NO_SHIFT_REG = rnode_19to20_bb5_add40_0_reg_20_NO_SHIFT_REG;
assign rnode_19to20_bb5_add40_0_stall_in_reg_20_NO_SHIFT_REG = rnode_19to20_bb5_add40_0_stall_in_NO_SHIFT_REG;
assign rnode_19to20_bb5_add40_0_valid_out_NO_SHIFT_REG = rnode_19to20_bb5_add40_0_valid_out_reg_20_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb5_div38_inputs_ready;
 reg local_bb5_div38_valid_out_NO_SHIFT_REG;
wire local_bb5_div38_stall_in;
wire local_bb5_div38_output_regs_ready;
wire [31:0] local_bb5_div38;
 reg local_bb5_div38_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb5_div38_valid_pipe_1_NO_SHIFT_REG;
 reg local_bb5_div38_valid_pipe_2_NO_SHIFT_REG;
 reg local_bb5_div38_valid_pipe_3_NO_SHIFT_REG;
 reg local_bb5_div38_valid_pipe_4_NO_SHIFT_REG;
 reg local_bb5_div38_valid_pipe_5_NO_SHIFT_REG;
 reg local_bb5_div38_valid_pipe_6_NO_SHIFT_REG;
 reg local_bb5_div38_valid_pipe_7_NO_SHIFT_REG;
 reg local_bb5_div38_valid_pipe_8_NO_SHIFT_REG;
 reg local_bb5_div38_valid_pipe_9_NO_SHIFT_REG;
 reg local_bb5_div38_valid_pipe_10_NO_SHIFT_REG;
 reg local_bb5_div38_valid_pipe_11_NO_SHIFT_REG;
 reg local_bb5_div38_valid_pipe_12_NO_SHIFT_REG;
wire local_bb5_div38_causedstall;

acl_fp_div_s5 fp_module_local_bb5_div38 (
	.clock(clock),
	.dataa(local_bb5_select17),
	.datab(local_bb5_select20),
	.enable(local_bb5_div38_output_regs_ready),
	.result(local_bb5_div38)
);


assign local_bb5_div38_inputs_ready = 1'b1;
assign local_bb5_div38_output_regs_ready = 1'b1;
assign local_bb5_select17_stall_in = 1'b0;
assign local_bb5_select20_stall_in = 1'b0;
assign local_bb5_div38_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb5_div38_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb5_div38_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
		local_bb5_div38_valid_pipe_2_NO_SHIFT_REG <= 1'b0;
		local_bb5_div38_valid_pipe_3_NO_SHIFT_REG <= 1'b0;
		local_bb5_div38_valid_pipe_4_NO_SHIFT_REG <= 1'b0;
		local_bb5_div38_valid_pipe_5_NO_SHIFT_REG <= 1'b0;
		local_bb5_div38_valid_pipe_6_NO_SHIFT_REG <= 1'b0;
		local_bb5_div38_valid_pipe_7_NO_SHIFT_REG <= 1'b0;
		local_bb5_div38_valid_pipe_8_NO_SHIFT_REG <= 1'b0;
		local_bb5_div38_valid_pipe_9_NO_SHIFT_REG <= 1'b0;
		local_bb5_div38_valid_pipe_10_NO_SHIFT_REG <= 1'b0;
		local_bb5_div38_valid_pipe_11_NO_SHIFT_REG <= 1'b0;
		local_bb5_div38_valid_pipe_12_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb5_div38_output_regs_ready)
		begin
			local_bb5_div38_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb5_div38_valid_pipe_1_NO_SHIFT_REG <= local_bb5_div38_valid_pipe_0_NO_SHIFT_REG;
			local_bb5_div38_valid_pipe_2_NO_SHIFT_REG <= local_bb5_div38_valid_pipe_1_NO_SHIFT_REG;
			local_bb5_div38_valid_pipe_3_NO_SHIFT_REG <= local_bb5_div38_valid_pipe_2_NO_SHIFT_REG;
			local_bb5_div38_valid_pipe_4_NO_SHIFT_REG <= local_bb5_div38_valid_pipe_3_NO_SHIFT_REG;
			local_bb5_div38_valid_pipe_5_NO_SHIFT_REG <= local_bb5_div38_valid_pipe_4_NO_SHIFT_REG;
			local_bb5_div38_valid_pipe_6_NO_SHIFT_REG <= local_bb5_div38_valid_pipe_5_NO_SHIFT_REG;
			local_bb5_div38_valid_pipe_7_NO_SHIFT_REG <= local_bb5_div38_valid_pipe_6_NO_SHIFT_REG;
			local_bb5_div38_valid_pipe_8_NO_SHIFT_REG <= local_bb5_div38_valid_pipe_7_NO_SHIFT_REG;
			local_bb5_div38_valid_pipe_9_NO_SHIFT_REG <= local_bb5_div38_valid_pipe_8_NO_SHIFT_REG;
			local_bb5_div38_valid_pipe_10_NO_SHIFT_REG <= local_bb5_div38_valid_pipe_9_NO_SHIFT_REG;
			local_bb5_div38_valid_pipe_11_NO_SHIFT_REG <= local_bb5_div38_valid_pipe_10_NO_SHIFT_REG;
			local_bb5_div38_valid_pipe_12_NO_SHIFT_REG <= local_bb5_div38_valid_pipe_11_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb5_div38_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb5_div38_output_regs_ready)
		begin
			local_bb5_div38_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb5_div38_stall_in))
			begin
				local_bb5_div38_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


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
wire local_bb5_idxprom41_stall_local;
wire [63:0] local_bb5_idxprom41;

assign local_bb5_idxprom41[63:32] = 32'h0;
assign local_bb5_idxprom41[31:0] = rnode_19to20_bb5_add40_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb5_c0_exi16_valid_out;
wire local_bb5_c0_exi16_stall_in;
wire local_bb5_c0_exi16_inputs_ready;
wire local_bb5_c0_exi16_stall_local;
wire [63:0] local_bb5_c0_exi16;

assign local_bb5_c0_exi16_inputs_ready = local_bb5_div38_valid_out_NO_SHIFT_REG;
assign local_bb5_c0_exi16[31:0] = 32'bx;
assign local_bb5_c0_exi16[63:32] = local_bb5_div38;
assign local_bb5_c0_exi16_valid_out = 1'b1;
assign local_bb5_div38_stall_in = 1'b0;

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


// This section implements an unregistered operation.
// 
wire local_bb5_arrayidx42_valid_out;
wire local_bb5_arrayidx42_stall_in;
wire local_bb5_arrayidx42_inputs_ready;
wire local_bb5_arrayidx42_stall_local;
wire [63:0] local_bb5_arrayidx42;

assign local_bb5_arrayidx42_inputs_ready = rnode_19to20_bb5_add40_0_valid_out_NO_SHIFT_REG;
assign local_bb5_arrayidx42 = ((input_out & 64'hFFFFFFFFFFFFFC00) + ((local_bb5_idxprom41 & 64'hFFFFFFFF) << 6'h2));
assign local_bb5_arrayidx42_valid_out = local_bb5_arrayidx42_inputs_ready;
assign local_bb5_arrayidx42_stall_local = local_bb5_arrayidx42_stall_in;
assign rnode_19to20_bb5_add40_0_stall_in_NO_SHIFT_REG = (|local_bb5_arrayidx42_stall_local);

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
 logic rnode_20to21_bb5_arrayidx42_0_valid_out_NO_SHIFT_REG;
 logic rnode_20to21_bb5_arrayidx42_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_20to21_bb5_arrayidx42_0_NO_SHIFT_REG;
 logic rnode_20to21_bb5_arrayidx42_0_reg_21_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_20to21_bb5_arrayidx42_0_reg_21_NO_SHIFT_REG;
 logic rnode_20to21_bb5_arrayidx42_0_valid_out_reg_21_NO_SHIFT_REG;
 logic rnode_20to21_bb5_arrayidx42_0_stall_in_reg_21_NO_SHIFT_REG;
 logic rnode_20to21_bb5_arrayidx42_0_stall_out_reg_21_NO_SHIFT_REG;

acl_data_fifo rnode_20to21_bb5_arrayidx42_0_reg_21_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_20to21_bb5_arrayidx42_0_reg_21_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_20to21_bb5_arrayidx42_0_stall_in_reg_21_NO_SHIFT_REG),
	.valid_out(rnode_20to21_bb5_arrayidx42_0_valid_out_reg_21_NO_SHIFT_REG),
	.stall_out(rnode_20to21_bb5_arrayidx42_0_stall_out_reg_21_NO_SHIFT_REG),
	.data_in((local_bb5_arrayidx42 & 64'hFFFFFFFFFFFFFFFC)),
	.data_out(rnode_20to21_bb5_arrayidx42_0_reg_21_NO_SHIFT_REG)
);

defparam rnode_20to21_bb5_arrayidx42_0_reg_21_fifo.DEPTH = 2;
defparam rnode_20to21_bb5_arrayidx42_0_reg_21_fifo.DATA_WIDTH = 64;
defparam rnode_20to21_bb5_arrayidx42_0_reg_21_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_20to21_bb5_arrayidx42_0_reg_21_fifo.IMPL = "ll_reg";

assign rnode_20to21_bb5_arrayidx42_0_reg_21_inputs_ready_NO_SHIFT_REG = local_bb5_arrayidx42_valid_out;
assign local_bb5_arrayidx42_stall_in = rnode_20to21_bb5_arrayidx42_0_stall_out_reg_21_NO_SHIFT_REG;
assign rnode_20to21_bb5_arrayidx42_0_NO_SHIFT_REG = rnode_20to21_bb5_arrayidx42_0_reg_21_NO_SHIFT_REG;
assign rnode_20to21_bb5_arrayidx42_0_stall_in_reg_21_NO_SHIFT_REG = rnode_20to21_bb5_arrayidx42_0_stall_in_NO_SHIFT_REG;
assign rnode_20to21_bb5_arrayidx42_0_valid_out_NO_SHIFT_REG = rnode_20to21_bb5_arrayidx42_0_valid_out_reg_21_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire SFC_2_VALID_6_7_0_inputs_ready;
 reg SFC_2_VALID_6_7_0_valid_out_NO_SHIFT_REG;
wire SFC_2_VALID_6_7_0_stall_in;
wire SFC_2_VALID_6_7_0_output_regs_ready;
 reg SFC_2_VALID_6_7_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_6_7_0_causedstall;

assign SFC_2_VALID_6_7_0_inputs_ready = 1'b1;
assign SFC_2_VALID_6_7_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_5_6_0_stall_in = 1'b0;
assign SFC_2_VALID_6_7_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_6_7_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_6_7_0_output_regs_ready)
		begin
			SFC_2_VALID_6_7_0_NO_SHIFT_REG <= SFC_2_VALID_5_6_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_2_VALID_7_8_0_inputs_ready;
 reg SFC_2_VALID_7_8_0_valid_out_NO_SHIFT_REG;
wire SFC_2_VALID_7_8_0_stall_in;
wire SFC_2_VALID_7_8_0_output_regs_ready;
 reg SFC_2_VALID_7_8_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_7_8_0_causedstall;

assign SFC_2_VALID_7_8_0_inputs_ready = 1'b1;
assign SFC_2_VALID_7_8_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_6_7_0_stall_in = 1'b0;
assign SFC_2_VALID_7_8_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_7_8_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_7_8_0_output_regs_ready)
		begin
			SFC_2_VALID_7_8_0_NO_SHIFT_REG <= SFC_2_VALID_6_7_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_2_VALID_8_9_0_inputs_ready;
 reg SFC_2_VALID_8_9_0_valid_out_NO_SHIFT_REG;
wire SFC_2_VALID_8_9_0_stall_in;
wire SFC_2_VALID_8_9_0_output_regs_ready;
 reg SFC_2_VALID_8_9_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_8_9_0_causedstall;

assign SFC_2_VALID_8_9_0_inputs_ready = 1'b1;
assign SFC_2_VALID_8_9_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_7_8_0_stall_in = 1'b0;
assign SFC_2_VALID_8_9_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_8_9_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_8_9_0_output_regs_ready)
		begin
			SFC_2_VALID_8_9_0_NO_SHIFT_REG <= SFC_2_VALID_7_8_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_2_VALID_9_10_0_inputs_ready;
 reg SFC_2_VALID_9_10_0_valid_out_NO_SHIFT_REG;
wire SFC_2_VALID_9_10_0_stall_in;
wire SFC_2_VALID_9_10_0_output_regs_ready;
 reg SFC_2_VALID_9_10_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_9_10_0_causedstall;

assign SFC_2_VALID_9_10_0_inputs_ready = 1'b1;
assign SFC_2_VALID_9_10_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_8_9_0_stall_in = 1'b0;
assign SFC_2_VALID_9_10_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_9_10_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_9_10_0_output_regs_ready)
		begin
			SFC_2_VALID_9_10_0_NO_SHIFT_REG <= SFC_2_VALID_8_9_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_2_VALID_10_11_0_inputs_ready;
 reg SFC_2_VALID_10_11_0_valid_out_NO_SHIFT_REG;
wire SFC_2_VALID_10_11_0_stall_in;
wire SFC_2_VALID_10_11_0_output_regs_ready;
 reg SFC_2_VALID_10_11_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_10_11_0_causedstall;

assign SFC_2_VALID_10_11_0_inputs_ready = 1'b1;
assign SFC_2_VALID_10_11_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_9_10_0_stall_in = 1'b0;
assign SFC_2_VALID_10_11_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_10_11_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_10_11_0_output_regs_ready)
		begin
			SFC_2_VALID_10_11_0_NO_SHIFT_REG <= SFC_2_VALID_9_10_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_2_VALID_11_12_0_inputs_ready;
 reg SFC_2_VALID_11_12_0_valid_out_NO_SHIFT_REG;
wire SFC_2_VALID_11_12_0_stall_in;
wire SFC_2_VALID_11_12_0_output_regs_ready;
 reg SFC_2_VALID_11_12_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_11_12_0_causedstall;

assign SFC_2_VALID_11_12_0_inputs_ready = 1'b1;
assign SFC_2_VALID_11_12_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_10_11_0_stall_in = 1'b0;
assign SFC_2_VALID_11_12_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_11_12_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_11_12_0_output_regs_ready)
		begin
			SFC_2_VALID_11_12_0_NO_SHIFT_REG <= SFC_2_VALID_10_11_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_2_VALID_12_13_0_inputs_ready;
 reg SFC_2_VALID_12_13_0_valid_out_NO_SHIFT_REG;
wire SFC_2_VALID_12_13_0_stall_in;
wire SFC_2_VALID_12_13_0_output_regs_ready;
 reg SFC_2_VALID_12_13_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_12_13_0_causedstall;

assign SFC_2_VALID_12_13_0_inputs_ready = 1'b1;
assign SFC_2_VALID_12_13_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_11_12_0_stall_in = 1'b0;
assign SFC_2_VALID_12_13_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_12_13_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_12_13_0_output_regs_ready)
		begin
			SFC_2_VALID_12_13_0_NO_SHIFT_REG <= SFC_2_VALID_11_12_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_2_VALID_13_14_0_inputs_ready;
 reg SFC_2_VALID_13_14_0_valid_out_NO_SHIFT_REG;
wire SFC_2_VALID_13_14_0_stall_in;
wire SFC_2_VALID_13_14_0_output_regs_ready;
 reg SFC_2_VALID_13_14_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_13_14_0_causedstall;

assign SFC_2_VALID_13_14_0_inputs_ready = 1'b1;
assign SFC_2_VALID_13_14_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_12_13_0_stall_in = 1'b0;
assign SFC_2_VALID_13_14_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_13_14_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_13_14_0_output_regs_ready)
		begin
			SFC_2_VALID_13_14_0_NO_SHIFT_REG <= SFC_2_VALID_12_13_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_2_VALID_14_15_0_inputs_ready;
 reg SFC_2_VALID_14_15_0_valid_out_NO_SHIFT_REG;
wire SFC_2_VALID_14_15_0_stall_in;
wire SFC_2_VALID_14_15_0_output_regs_ready;
 reg SFC_2_VALID_14_15_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_14_15_0_causedstall;

assign SFC_2_VALID_14_15_0_inputs_ready = 1'b1;
assign SFC_2_VALID_14_15_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_13_14_0_stall_in = 1'b0;
assign SFC_2_VALID_14_15_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_14_15_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_14_15_0_output_regs_ready)
		begin
			SFC_2_VALID_14_15_0_NO_SHIFT_REG <= SFC_2_VALID_13_14_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire SFC_2_VALID_15_16_0_inputs_ready;
 reg SFC_2_VALID_15_16_0_valid_out_NO_SHIFT_REG;
wire SFC_2_VALID_15_16_0_stall_in;
wire SFC_2_VALID_15_16_0_output_regs_ready;
 reg SFC_2_VALID_15_16_0_NO_SHIFT_REG /* synthesis  preserve  */;
wire SFC_2_VALID_15_16_0_causedstall;

assign SFC_2_VALID_15_16_0_inputs_ready = 1'b1;
assign SFC_2_VALID_15_16_0_output_regs_ready = 1'b1;
assign SFC_2_VALID_14_15_0_stall_in = 1'b0;
assign SFC_2_VALID_15_16_0_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		SFC_2_VALID_15_16_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (SFC_2_VALID_15_16_0_output_regs_ready)
		begin
			SFC_2_VALID_15_16_0_NO_SHIFT_REG <= SFC_2_VALID_14_15_0_NO_SHIFT_REG;
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb5_c0_exit7_c0_exi16_inputs_ready;
 reg local_bb5_c0_exit7_c0_exi16_valid_out_NO_SHIFT_REG;
wire local_bb5_c0_exit7_c0_exi16_stall_in;
 reg [63:0] local_bb5_c0_exit7_c0_exi16_NO_SHIFT_REG;
wire [63:0] local_bb5_c0_exit7_c0_exi16_in;
wire local_bb5_c0_exit7_c0_exi16_valid;
wire local_bb5_c0_exit7_c0_exi16_causedstall;

acl_stall_free_sink local_bb5_c0_exit7_c0_exi16_instance (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_bb5_c0_exi16),
	.data_out(local_bb5_c0_exit7_c0_exi16_in),
	.input_accepted(local_bb5_c0_enter3_c0_eni22_input_accepted),
	.valid_out(local_bb5_c0_exit7_c0_exi16_valid),
	.stall_in(~(local_bb5_c0_exit7_c0_exi16_output_regs_ready)),
	.stall_entry(local_bb5_c0_exit7_c0_exi16_entry_stall),
	.valid_in(local_bb5_c0_exit7_c0_exi16_valid_in),
	.IIphases(local_bb5_c0_exit7_c0_exi16_phases),
	.inc_pipelined_thread(local_bb5_c0_enter3_c0_eni22_inc_pipelined_thread),
	.dec_pipelined_thread(local_bb5_c0_enter3_c0_eni22_dec_pipelined_thread)
);

defparam local_bb5_c0_exit7_c0_exi16_instance.DATA_WIDTH = 64;
defparam local_bb5_c0_exit7_c0_exi16_instance.PIPELINE_DEPTH = 20;
defparam local_bb5_c0_exit7_c0_exi16_instance.SHARINGII = 1;
defparam local_bb5_c0_exit7_c0_exi16_instance.SCHEDULEII = 1;
defparam local_bb5_c0_exit7_c0_exi16_instance.ALWAYS_THROTTLE = 0;

assign local_bb5_c0_exit7_c0_exi16_inputs_ready = 1'b1;
assign local_bb5_c0_exit7_c0_exi16_output_regs_ready = (&(~(local_bb5_c0_exit7_c0_exi16_valid_out_NO_SHIFT_REG) | ~(local_bb5_c0_exit7_c0_exi16_stall_in)));
assign local_bb5_c0_exit7_c0_exi16_valid_in = SFC_2_VALID_15_16_0_NO_SHIFT_REG;
assign local_bb5_c0_exi16_stall_in = 1'b0;
assign SFC_2_VALID_15_16_0_stall_in = 1'b0;
assign local_bb5_c0_exit7_c0_exi16_causedstall = (1'b1 && (1'b0 && !(~(local_bb5_c0_exit7_c0_exi16_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb5_c0_exit7_c0_exi16_NO_SHIFT_REG <= 'x;
		local_bb5_c0_exit7_c0_exi16_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb5_c0_exit7_c0_exi16_output_regs_ready)
		begin
			local_bb5_c0_exit7_c0_exi16_NO_SHIFT_REG <= local_bb5_c0_exit7_c0_exi16_in;
			local_bb5_c0_exit7_c0_exi16_valid_out_NO_SHIFT_REG <= local_bb5_c0_exit7_c0_exi16_valid;
		end
		else
		begin
			if (~(local_bb5_c0_exit7_c0_exi16_stall_in))
			begin
				local_bb5_c0_exit7_c0_exi16_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb5_c0_exe18_valid_out;
wire local_bb5_c0_exe18_stall_in;
wire local_bb5_c0_exe18_inputs_ready;
wire local_bb5_c0_exe18_stall_local;
wire [31:0] local_bb5_c0_exe18;

assign local_bb5_c0_exe18_inputs_ready = local_bb5_c0_exit7_c0_exi16_valid_out_NO_SHIFT_REG;
assign local_bb5_c0_exe18 = local_bb5_c0_exit7_c0_exi16_NO_SHIFT_REG[63:32];
assign local_bb5_c0_exe18_valid_out = local_bb5_c0_exe18_inputs_ready;
assign local_bb5_c0_exe18_stall_local = local_bb5_c0_exe18_stall_in;
assign local_bb5_c0_exit7_c0_exi16_stall_in = (|local_bb5_c0_exe18_stall_local);

// This section implements a registered operation.
// 
wire local_bb5_st_c0_exe18_inputs_ready;
 reg local_bb5_st_c0_exe18_valid_out_NO_SHIFT_REG;
wire local_bb5_st_c0_exe18_stall_in;
wire local_bb5_st_c0_exe18_output_regs_ready;
wire local_bb5_st_c0_exe18_fu_stall_out;
wire local_bb5_st_c0_exe18_fu_valid_out;
wire local_bb5_st_c0_exe18_causedstall;

lsu_top lsu_local_bb5_st_c0_exe18 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb5_st_c0_exe18_fu_stall_out),
	.i_valid(local_bb5_st_c0_exe18_inputs_ready),
	.i_address((rnode_20to21_bb5_arrayidx42_0_NO_SHIFT_REG & 64'hFFFFFFFFFFFFFFFC)),
	.i_writedata(local_bb5_c0_exe18),
	.i_cmpdata(),
	.i_predicate(1'b0),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb5_st_c0_exe18_output_regs_ready)),
	.o_valid(local_bb5_st_c0_exe18_fu_valid_out),
	.o_readdata(),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb5_st_c0_exe18_active),
	.avm_address(avm_local_bb5_st_c0_exe18_address),
	.avm_read(avm_local_bb5_st_c0_exe18_read),
	.avm_readdata(avm_local_bb5_st_c0_exe18_readdata),
	.avm_write(avm_local_bb5_st_c0_exe18_write),
	.avm_writeack(avm_local_bb5_st_c0_exe18_writeack),
	.avm_burstcount(avm_local_bb5_st_c0_exe18_burstcount),
	.avm_writedata(avm_local_bb5_st_c0_exe18_writedata),
	.avm_byteenable(avm_local_bb5_st_c0_exe18_byteenable),
	.avm_waitrequest(avm_local_bb5_st_c0_exe18_waitrequest),
	.avm_readdatavalid(avm_local_bb5_st_c0_exe18_readdatavalid),
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

defparam lsu_local_bb5_st_c0_exe18.AWIDTH = 33;
defparam lsu_local_bb5_st_c0_exe18.WIDTH_BYTES = 4;
defparam lsu_local_bb5_st_c0_exe18.MWIDTH_BYTES = 64;
defparam lsu_local_bb5_st_c0_exe18.WRITEDATAWIDTH_BYTES = 64;
defparam lsu_local_bb5_st_c0_exe18.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb5_st_c0_exe18.READ = 0;
defparam lsu_local_bb5_st_c0_exe18.ATOMIC = 0;
defparam lsu_local_bb5_st_c0_exe18.WIDTH = 32;
defparam lsu_local_bb5_st_c0_exe18.MWIDTH = 512;
defparam lsu_local_bb5_st_c0_exe18.ATOMIC_WIDTH = 3;
defparam lsu_local_bb5_st_c0_exe18.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb5_st_c0_exe18.KERNEL_SIDE_MEM_LATENCY = 4;
defparam lsu_local_bb5_st_c0_exe18.MEMORY_SIDE_MEM_LATENCY = 8;
defparam lsu_local_bb5_st_c0_exe18.USE_WRITE_ACK = 0;
defparam lsu_local_bb5_st_c0_exe18.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb5_st_c0_exe18.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb5_st_c0_exe18.NUMBER_BANKS = 1;
defparam lsu_local_bb5_st_c0_exe18.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb5_st_c0_exe18.INTENDED_DEVICE_FAMILY = "Stratix V";
defparam lsu_local_bb5_st_c0_exe18.USEINPUTFIFO = 0;
defparam lsu_local_bb5_st_c0_exe18.USECACHING = 0;
defparam lsu_local_bb5_st_c0_exe18.USEOUTPUTFIFO = 1;
defparam lsu_local_bb5_st_c0_exe18.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb5_st_c0_exe18.HIGH_FMAX = 1;
defparam lsu_local_bb5_st_c0_exe18.ADDRSPACE = 1;
defparam lsu_local_bb5_st_c0_exe18.STYLE = "BURST-COALESCED";
defparam lsu_local_bb5_st_c0_exe18.USE_BYTE_EN = 0;

assign local_bb5_st_c0_exe18_inputs_ready = (local_bb5_c0_exe18_valid_out & rnode_20to21_bb5_arrayidx42_0_valid_out_NO_SHIFT_REG);
assign local_bb5_st_c0_exe18_output_regs_ready = (&(~(local_bb5_st_c0_exe18_valid_out_NO_SHIFT_REG) | ~(local_bb5_st_c0_exe18_stall_in)));
assign local_bb5_c0_exe18_stall_in = (local_bb5_st_c0_exe18_fu_stall_out | ~(local_bb5_st_c0_exe18_inputs_ready));
assign rnode_20to21_bb5_arrayidx42_0_stall_in_NO_SHIFT_REG = (local_bb5_st_c0_exe18_fu_stall_out | ~(local_bb5_st_c0_exe18_inputs_ready));
assign local_bb5_st_c0_exe18_causedstall = (local_bb5_st_c0_exe18_inputs_ready && (local_bb5_st_c0_exe18_fu_stall_out && !(~(local_bb5_st_c0_exe18_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb5_st_c0_exe18_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb5_st_c0_exe18_output_regs_ready)
		begin
			local_bb5_st_c0_exe18_valid_out_NO_SHIFT_REG <= local_bb5_st_c0_exe18_fu_valid_out;
		end
		else
		begin
			if (~(local_bb5_st_c0_exe18_stall_in))
			begin
				local_bb5_st_c0_exe18_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_25to25_bb5_st_c0_exe18_valid_out;
wire rstag_25to25_bb5_st_c0_exe18_stall_in;
wire rstag_25to25_bb5_st_c0_exe18_inputs_ready;
wire rstag_25to25_bb5_st_c0_exe18_stall_local;
 reg rstag_25to25_bb5_st_c0_exe18_staging_valid_NO_SHIFT_REG;
wire rstag_25to25_bb5_st_c0_exe18_combined_valid;

assign rstag_25to25_bb5_st_c0_exe18_inputs_ready = local_bb5_st_c0_exe18_valid_out_NO_SHIFT_REG;
assign rstag_25to25_bb5_st_c0_exe18_combined_valid = (rstag_25to25_bb5_st_c0_exe18_staging_valid_NO_SHIFT_REG | rstag_25to25_bb5_st_c0_exe18_inputs_ready);
assign rstag_25to25_bb5_st_c0_exe18_valid_out = rstag_25to25_bb5_st_c0_exe18_combined_valid;
assign rstag_25to25_bb5_st_c0_exe18_stall_local = rstag_25to25_bb5_st_c0_exe18_stall_in;
assign local_bb5_st_c0_exe18_stall_in = (|rstag_25to25_bb5_st_c0_exe18_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_25to25_bb5_st_c0_exe18_staging_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (rstag_25to25_bb5_st_c0_exe18_stall_local)
		begin
			if (~(rstag_25to25_bb5_st_c0_exe18_staging_valid_NO_SHIFT_REG))
			begin
				rstag_25to25_bb5_st_c0_exe18_staging_valid_NO_SHIFT_REG <= rstag_25to25_bb5_st_c0_exe18_inputs_ready;
			end
		end
		else
		begin
			rstag_25to25_bb5_st_c0_exe18_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
wire branch_var__output_regs_ready;

assign branch_var__inputs_ready = rstag_25to25_bb5_st_c0_exe18_valid_out;
assign branch_var__output_regs_ready = ~(stall_in);
assign rstag_25to25_bb5_st_c0_exe18_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign valid_out = branch_var__inputs_ready;

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module AOChalfSampleRobustImageKernel_function
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
		input [511:0] 		avm_local_bb3_ld__readdata,
		input 		avm_local_bb3_ld__readdatavalid,
		input 		avm_local_bb3_ld__waitrequest,
		output [32:0] 		avm_local_bb3_ld__address,
		output 		avm_local_bb3_ld__read,
		output 		avm_local_bb3_ld__write,
		input 		avm_local_bb3_ld__writeack,
		output [511:0] 		avm_local_bb3_ld__writedata,
		output [63:0] 		avm_local_bb3_ld__byteenable,
		output [4:0] 		avm_local_bb3_ld__burstcount,
		input [511:0] 		avm_local_bb5_st_c0_exe18_readdata,
		input 		avm_local_bb5_st_c0_exe18_readdatavalid,
		input 		avm_local_bb5_st_c0_exe18_waitrequest,
		output [32:0] 		avm_local_bb5_st_c0_exe18_address,
		output 		avm_local_bb5_st_c0_exe18_read,
		output 		avm_local_bb5_st_c0_exe18_write,
		input 		avm_local_bb5_st_c0_exe18_writeack,
		output [511:0] 		avm_local_bb5_st_c0_exe18_writedata,
		output [63:0] 		avm_local_bb5_st_c0_exe18_byteenable,
		output [4:0] 		avm_local_bb5_st_c0_exe18_burstcount,
		input 		start,
		input [31:0] 		input_inSize_x,
		input [31:0] 		input_r,
		input [31:0] 		input_inSize_y,
		input 		clock2x,
		input [63:0] 		input_in,
		input [31:0] 		input_e_d,
		input [63:0] 		input_out,
		output reg 		has_a_write_pending,
		output reg 		has_a_lsu_active
	);


wire [31:0] cur_cycle;
wire bb_0_stall_out;
wire bb_0_valid_out;
wire [31:0] bb_0_lvb_bb0_div;
wire [31:0] bb_0_lvb_bb0_add6;
wire bb_0_lvb_bb0_cmp9;
wire [31:0] bb_0_lvb_bb0_sub20;
wire [31:0] bb_0_lvb_bb0_sub22;
wire [31:0] bb_0_lvb_input_global_id_0;
wire [31:0] bb_0_lvb_input_global_id_1;
wire bb_1_stall_out;
wire bb_1_valid_out;
wire [31:0] bb_1_lvb_bb1_scalarizer_0mul;
wire [31:0] bb_1_lvb_bb1_scalarizer_1mul;
wire [31:0] bb_1_lvb_bb1_ld_;
wire [31:0] bb_1_lvb_input_global_id_0;
wire [31:0] bb_1_lvb_input_global_id_1;
wire bb_1_local_bb1_ld__active;
wire bb_2_stall_out_0;
wire bb_2_stall_out_1;
wire bb_2_valid_out;
wire [31:0] bb_2_lvb_scalarizer_0mul;
wire [31:0] bb_2_lvb_scalarizer_1mul;
wire [31:0] bb_2_lvb_ld_;
wire [31:0] bb_2_lvb_i_012;
wire [31:0] bb_2_lvb_t_011;
wire [31:0] bb_2_lvb_sum_010;
wire [31:0] bb_2_lvb_bb2_mul25;
wire [31:0] bb_2_lvb_input_global_id_0;
wire [31:0] bb_2_lvb_input_global_id_1;
wire bb_3_stall_out_0;
wire bb_3_stall_out_1;
wire bb_3_valid_out_0;
wire [31:0] bb_3_lvb_scalarizer_0mul_0;
wire [31:0] bb_3_lvb_scalarizer_1mul_0;
wire [31:0] bb_3_lvb_ld__0;
wire [31:0] bb_3_lvb_i_012_0;
wire [31:0] bb_3_lvb_mul25_0;
wire [31:0] bb_3_lvb_bb3_inc_0;
wire [31:0] bb_3_lvb_bb3_c0_exe1_0;
wire [31:0] bb_3_lvb_bb3_c0_exe2_0;
wire [31:0] bb_3_lvb_input_global_id_0_0;
wire [31:0] bb_3_lvb_input_global_id_1_0;
wire bb_3_valid_out_1;
wire [31:0] bb_3_lvb_scalarizer_0mul_1;
wire [31:0] bb_3_lvb_scalarizer_1mul_1;
wire [31:0] bb_3_lvb_ld__1;
wire [31:0] bb_3_lvb_i_012_1;
wire [31:0] bb_3_lvb_mul25_1;
wire [31:0] bb_3_lvb_bb3_inc_1;
wire [31:0] bb_3_lvb_bb3_c0_exe1_1;
wire [31:0] bb_3_lvb_bb3_c0_exe2_1;
wire [31:0] bb_3_lvb_input_global_id_0_1;
wire [31:0] bb_3_lvb_input_global_id_1_1;
wire bb_3_local_bb3_ld__active;
wire bb_4_stall_out;
wire bb_4_valid_out_0;
wire [31:0] bb_4_lvb_scalarizer_0mul_0;
wire [31:0] bb_4_lvb_scalarizer_1mul_0;
wire [31:0] bb_4_lvb_ld__0;
wire [31:0] bb_4_lvb_c0_exe1_0;
wire [31:0] bb_4_lvb_c0_exe2_0;
wire [31:0] bb_4_lvb_bb4_inc36_0;
wire [31:0] bb_4_lvb_input_global_id_0_0;
wire [31:0] bb_4_lvb_input_global_id_1_0;
wire bb_4_valid_out_1;
wire [31:0] bb_4_lvb_scalarizer_0mul_1;
wire [31:0] bb_4_lvb_scalarizer_1mul_1;
wire [31:0] bb_4_lvb_ld__1;
wire [31:0] bb_4_lvb_c0_exe1_1;
wire [31:0] bb_4_lvb_c0_exe2_1;
wire [31:0] bb_4_lvb_bb4_inc36_1;
wire [31:0] bb_4_lvb_input_global_id_0_1;
wire [31:0] bb_4_lvb_input_global_id_1_1;
wire bb_5_stall_out;
wire bb_5_valid_out;
wire bb_5_local_bb5_st_c0_exe18_active;
wire loop_limiter_0_stall_out;
wire loop_limiter_0_valid_out;
wire loop_limiter_1_stall_out;
wire loop_limiter_1_valid_out;
wire writes_pending;
wire [2:0] lsus_active;

AOChalfSampleRobustImageKernel_basic_block_0 AOChalfSampleRobustImageKernel_basic_block_0 (
	.clock(clock),
	.resetn(resetn),
	.start(start),
	.input_inSize_x(input_inSize_x),
	.input_r(input_r),
	.input_inSize_y(input_inSize_y),
	.valid_in(valid_in),
	.stall_out(bb_0_stall_out),
	.input_global_id_0(input_global_id_0),
	.input_global_id_1(input_global_id_1),
	.valid_out(bb_0_valid_out),
	.stall_in(bb_1_stall_out),
	.lvb_bb0_div(bb_0_lvb_bb0_div),
	.lvb_bb0_add6(bb_0_lvb_bb0_add6),
	.lvb_bb0_cmp9(bb_0_lvb_bb0_cmp9),
	.lvb_bb0_sub20(bb_0_lvb_bb0_sub20),
	.lvb_bb0_sub22(bb_0_lvb_bb0_sub22),
	.lvb_input_global_id_0(bb_0_lvb_input_global_id_0),
	.lvb_input_global_id_1(bb_0_lvb_input_global_id_1),
	.workgroup_size(workgroup_size)
);


AOChalfSampleRobustImageKernel_basic_block_1 AOChalfSampleRobustImageKernel_basic_block_1 (
	.clock(clock),
	.resetn(resetn),
	.input_inSize_x(input_inSize_x),
	.input_in(input_in),
	.input_wii_div(bb_0_lvb_bb0_div),
	.input_wii_add6(bb_0_lvb_bb0_add6),
	.input_wii_cmp9(bb_0_lvb_bb0_cmp9),
	.input_wii_sub20(bb_0_lvb_bb0_sub20),
	.input_wii_sub22(bb_0_lvb_bb0_sub22),
	.valid_in(bb_0_valid_out),
	.stall_out(bb_1_stall_out),
	.input_global_id_0(bb_0_lvb_input_global_id_0),
	.input_global_id_1(bb_0_lvb_input_global_id_1),
	.valid_out(bb_1_valid_out),
	.stall_in(loop_limiter_0_stall_out),
	.lvb_bb1_scalarizer_0mul(bb_1_lvb_bb1_scalarizer_0mul),
	.lvb_bb1_scalarizer_1mul(bb_1_lvb_bb1_scalarizer_1mul),
	.lvb_bb1_ld_(bb_1_lvb_bb1_ld_),
	.lvb_input_global_id_0(bb_1_lvb_input_global_id_0),
	.lvb_input_global_id_1(bb_1_lvb_input_global_id_1),
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
	.clock2x(clock2x)
);


AOChalfSampleRobustImageKernel_basic_block_2 AOChalfSampleRobustImageKernel_basic_block_2 (
	.clock(clock),
	.resetn(resetn),
	.input_inSize_x(input_inSize_x),
	.input_wii_div(bb_0_lvb_bb0_div),
	.input_wii_add6(bb_0_lvb_bb0_add6),
	.input_wii_cmp9(bb_0_lvb_bb0_cmp9),
	.input_wii_sub20(bb_0_lvb_bb0_sub20),
	.input_wii_sub22(bb_0_lvb_bb0_sub22),
	.valid_in_0(bb_4_valid_out_1),
	.stall_out_0(bb_2_stall_out_0),
	.input_scalarizer_0mul_0(bb_4_lvb_scalarizer_0mul_1),
	.input_scalarizer_1mul_0(bb_4_lvb_scalarizer_1mul_1),
	.input_ld__0(bb_4_lvb_ld__1),
	.input_i_012_0(bb_4_lvb_bb4_inc36_1),
	.input_t_011_0(bb_4_lvb_c0_exe2_1),
	.input_sum_010_0(bb_4_lvb_c0_exe1_1),
	.input_global_id_0_0(bb_4_lvb_input_global_id_0_1),
	.input_global_id_1_0(bb_4_lvb_input_global_id_1_1),
	.valid_in_1(loop_limiter_0_valid_out),
	.stall_out_1(bb_2_stall_out_1),
	.input_scalarizer_0mul_1(bb_1_lvb_bb1_scalarizer_0mul),
	.input_scalarizer_1mul_1(bb_1_lvb_bb1_scalarizer_1mul),
	.input_ld__1(bb_1_lvb_bb1_ld_),
	.input_i_012_1(bb_0_lvb_bb0_add6),
	.input_t_011_1(32'h0),
	.input_sum_010_1(32'h0),
	.input_global_id_0_1(bb_1_lvb_input_global_id_0),
	.input_global_id_1_1(bb_1_lvb_input_global_id_1),
	.valid_out(bb_2_valid_out),
	.stall_in(loop_limiter_1_stall_out),
	.lvb_scalarizer_0mul(bb_2_lvb_scalarizer_0mul),
	.lvb_scalarizer_1mul(bb_2_lvb_scalarizer_1mul),
	.lvb_ld_(bb_2_lvb_ld_),
	.lvb_i_012(bb_2_lvb_i_012),
	.lvb_t_011(bb_2_lvb_t_011),
	.lvb_sum_010(bb_2_lvb_sum_010),
	.lvb_bb2_mul25(bb_2_lvb_bb2_mul25),
	.lvb_input_global_id_0(bb_2_lvb_input_global_id_0),
	.lvb_input_global_id_1(bb_2_lvb_input_global_id_1),
	.workgroup_size(workgroup_size),
	.start(start)
);


AOChalfSampleRobustImageKernel_basic_block_3 AOChalfSampleRobustImageKernel_basic_block_3 (
	.clock(clock),
	.resetn(resetn),
	.input_r(input_r),
	.input_in(input_in),
	.input_e_d(input_e_d),
	.input_wii_div(bb_0_lvb_bb0_div),
	.input_wii_add6(bb_0_lvb_bb0_add6),
	.input_wii_cmp9(bb_0_lvb_bb0_cmp9),
	.input_wii_sub20(bb_0_lvb_bb0_sub20),
	.input_wii_sub22(bb_0_lvb_bb0_sub22),
	.valid_in_0(bb_3_valid_out_1),
	.stall_out_0(bb_3_stall_out_0),
	.input_scalarizer_0mul_0(bb_3_lvb_scalarizer_0mul_1),
	.input_scalarizer_1mul_0(bb_3_lvb_scalarizer_1mul_1),
	.input_ld__0(bb_3_lvb_ld__1),
	.input_i_012_0(bb_3_lvb_i_012_1),
	.input_mul25_0(bb_3_lvb_mul25_1),
	.input_j_17_0(bb_3_lvb_bb3_inc_1),
	.input_t_16_0(bb_3_lvb_bb3_c0_exe2_1),
	.input_sum_15_0(bb_3_lvb_bb3_c0_exe1_1),
	.input_global_id_0_0(bb_3_lvb_input_global_id_0_1),
	.input_global_id_1_0(bb_3_lvb_input_global_id_1_1),
	.valid_in_1(loop_limiter_1_valid_out),
	.stall_out_1(bb_3_stall_out_1),
	.input_scalarizer_0mul_1(bb_2_lvb_scalarizer_0mul),
	.input_scalarizer_1mul_1(bb_2_lvb_scalarizer_1mul),
	.input_ld__1(bb_2_lvb_ld_),
	.input_i_012_1(bb_2_lvb_i_012),
	.input_mul25_1(bb_2_lvb_bb2_mul25),
	.input_j_17_1(bb_0_lvb_bb0_add6),
	.input_t_16_1(bb_2_lvb_t_011),
	.input_sum_15_1(bb_2_lvb_sum_010),
	.input_global_id_0_1(bb_2_lvb_input_global_id_0),
	.input_global_id_1_1(bb_2_lvb_input_global_id_1),
	.valid_out_0(bb_3_valid_out_0),
	.stall_in_0(bb_4_stall_out),
	.lvb_scalarizer_0mul_0(bb_3_lvb_scalarizer_0mul_0),
	.lvb_scalarizer_1mul_0(bb_3_lvb_scalarizer_1mul_0),
	.lvb_ld__0(bb_3_lvb_ld__0),
	.lvb_i_012_0(bb_3_lvb_i_012_0),
	.lvb_mul25_0(bb_3_lvb_mul25_0),
	.lvb_bb3_inc_0(bb_3_lvb_bb3_inc_0),
	.lvb_bb3_c0_exe1_0(bb_3_lvb_bb3_c0_exe1_0),
	.lvb_bb3_c0_exe2_0(bb_3_lvb_bb3_c0_exe2_0),
	.lvb_input_global_id_0_0(bb_3_lvb_input_global_id_0_0),
	.lvb_input_global_id_1_0(bb_3_lvb_input_global_id_1_0),
	.valid_out_1(bb_3_valid_out_1),
	.stall_in_1(bb_3_stall_out_0),
	.lvb_scalarizer_0mul_1(bb_3_lvb_scalarizer_0mul_1),
	.lvb_scalarizer_1mul_1(bb_3_lvb_scalarizer_1mul_1),
	.lvb_ld__1(bb_3_lvb_ld__1),
	.lvb_i_012_1(bb_3_lvb_i_012_1),
	.lvb_mul25_1(bb_3_lvb_mul25_1),
	.lvb_bb3_inc_1(bb_3_lvb_bb3_inc_1),
	.lvb_bb3_c0_exe1_1(bb_3_lvb_bb3_c0_exe1_1),
	.lvb_bb3_c0_exe2_1(bb_3_lvb_bb3_c0_exe2_1),
	.lvb_input_global_id_0_1(bb_3_lvb_input_global_id_0_1),
	.lvb_input_global_id_1_1(bb_3_lvb_input_global_id_1_1),
	.workgroup_size(workgroup_size),
	.start(start),
	.avm_local_bb3_ld__readdata(avm_local_bb3_ld__readdata),
	.avm_local_bb3_ld__readdatavalid(avm_local_bb3_ld__readdatavalid),
	.avm_local_bb3_ld__waitrequest(avm_local_bb3_ld__waitrequest),
	.avm_local_bb3_ld__address(avm_local_bb3_ld__address),
	.avm_local_bb3_ld__read(avm_local_bb3_ld__read),
	.avm_local_bb3_ld__write(avm_local_bb3_ld__write),
	.avm_local_bb3_ld__writeack(avm_local_bb3_ld__writeack),
	.avm_local_bb3_ld__writedata(avm_local_bb3_ld__writedata),
	.avm_local_bb3_ld__byteenable(avm_local_bb3_ld__byteenable),
	.avm_local_bb3_ld__burstcount(avm_local_bb3_ld__burstcount),
	.local_bb3_ld__active(bb_3_local_bb3_ld__active),
	.clock2x(clock2x)
);


AOChalfSampleRobustImageKernel_basic_block_4 AOChalfSampleRobustImageKernel_basic_block_4 (
	.clock(clock),
	.resetn(resetn),
	.input_r(input_r),
	.input_wii_div(bb_0_lvb_bb0_div),
	.input_wii_add6(bb_0_lvb_bb0_add6),
	.input_wii_cmp9(bb_0_lvb_bb0_cmp9),
	.input_wii_sub20(bb_0_lvb_bb0_sub20),
	.input_wii_sub22(bb_0_lvb_bb0_sub22),
	.valid_in(bb_3_valid_out_0),
	.stall_out(bb_4_stall_out),
	.input_scalarizer_0mul(bb_3_lvb_scalarizer_0mul_0),
	.input_scalarizer_1mul(bb_3_lvb_scalarizer_1mul_0),
	.input_ld_(bb_3_lvb_ld__0),
	.input_i_012(bb_3_lvb_i_012_0),
	.input_c0_exe1(bb_3_lvb_bb3_c0_exe1_0),
	.input_c0_exe2(bb_3_lvb_bb3_c0_exe2_0),
	.input_global_id_0(bb_3_lvb_input_global_id_0_0),
	.input_global_id_1(bb_3_lvb_input_global_id_1_0),
	.valid_out_0(bb_4_valid_out_0),
	.stall_in_0(bb_5_stall_out),
	.lvb_scalarizer_0mul_0(bb_4_lvb_scalarizer_0mul_0),
	.lvb_scalarizer_1mul_0(bb_4_lvb_scalarizer_1mul_0),
	.lvb_ld__0(bb_4_lvb_ld__0),
	.lvb_c0_exe1_0(bb_4_lvb_c0_exe1_0),
	.lvb_c0_exe2_0(bb_4_lvb_c0_exe2_0),
	.lvb_bb4_inc36_0(bb_4_lvb_bb4_inc36_0),
	.lvb_input_global_id_0_0(bb_4_lvb_input_global_id_0_0),
	.lvb_input_global_id_1_0(bb_4_lvb_input_global_id_1_0),
	.valid_out_1(bb_4_valid_out_1),
	.stall_in_1(bb_2_stall_out_0),
	.lvb_scalarizer_0mul_1(bb_4_lvb_scalarizer_0mul_1),
	.lvb_scalarizer_1mul_1(bb_4_lvb_scalarizer_1mul_1),
	.lvb_ld__1(bb_4_lvb_ld__1),
	.lvb_c0_exe1_1(bb_4_lvb_c0_exe1_1),
	.lvb_c0_exe2_1(bb_4_lvb_c0_exe2_1),
	.lvb_bb4_inc36_1(bb_4_lvb_bb4_inc36_1),
	.lvb_input_global_id_0_1(bb_4_lvb_input_global_id_0_1),
	.lvb_input_global_id_1_1(bb_4_lvb_input_global_id_1_1),
	.workgroup_size(workgroup_size),
	.start(start)
);


AOChalfSampleRobustImageKernel_basic_block_5 AOChalfSampleRobustImageKernel_basic_block_5 (
	.clock(clock),
	.resetn(resetn),
	.input_out(input_out),
	.input_wii_div(bb_0_lvb_bb0_div),
	.input_wii_cmp9(bb_0_lvb_bb0_cmp9),
	.valid_in(bb_4_valid_out_0),
	.stall_out(bb_5_stall_out),
	.input_c0_exe1(bb_4_lvb_c0_exe1_0),
	.input_c0_exe2(bb_4_lvb_c0_exe2_0),
	.input_global_id_0(bb_4_lvb_input_global_id_0_0),
	.input_global_id_1(bb_4_lvb_input_global_id_1_0),
	.valid_out(bb_5_valid_out),
	.stall_in(stall_in),
	.workgroup_size(workgroup_size),
	.start(start),
	.avm_local_bb5_st_c0_exe18_readdata(avm_local_bb5_st_c0_exe18_readdata),
	.avm_local_bb5_st_c0_exe18_readdatavalid(avm_local_bb5_st_c0_exe18_readdatavalid),
	.avm_local_bb5_st_c0_exe18_waitrequest(avm_local_bb5_st_c0_exe18_waitrequest),
	.avm_local_bb5_st_c0_exe18_address(avm_local_bb5_st_c0_exe18_address),
	.avm_local_bb5_st_c0_exe18_read(avm_local_bb5_st_c0_exe18_read),
	.avm_local_bb5_st_c0_exe18_write(avm_local_bb5_st_c0_exe18_write),
	.avm_local_bb5_st_c0_exe18_writeack(avm_local_bb5_st_c0_exe18_writeack),
	.avm_local_bb5_st_c0_exe18_writedata(avm_local_bb5_st_c0_exe18_writedata),
	.avm_local_bb5_st_c0_exe18_byteenable(avm_local_bb5_st_c0_exe18_byteenable),
	.avm_local_bb5_st_c0_exe18_burstcount(avm_local_bb5_st_c0_exe18_burstcount),
	.local_bb5_st_c0_exe18_active(bb_5_local_bb5_st_c0_exe18_active),
	.clock2x(clock2x)
);


acl_loop_limiter loop_limiter_0 (
	.clock(clock),
	.resetn(resetn),
	.i_valid(bb_1_valid_out),
	.i_stall(bb_2_stall_out_1),
	.i_valid_exit(bb_4_valid_out_0),
	.i_stall_exit(bb_5_stall_out),
	.o_valid(loop_limiter_0_valid_out),
	.o_stall(loop_limiter_0_stall_out)
);

defparam loop_limiter_0.ENTRY_WIDTH = 1;
defparam loop_limiter_0.EXIT_WIDTH = 1;
defparam loop_limiter_0.THRESHOLD = 193;

acl_loop_limiter loop_limiter_1 (
	.clock(clock),
	.resetn(resetn),
	.i_valid(bb_2_valid_out),
	.i_stall(bb_3_stall_out_1),
	.i_valid_exit(bb_3_valid_out_0),
	.i_stall_exit(bb_4_stall_out),
	.o_valid(loop_limiter_1_valid_out),
	.o_stall(loop_limiter_1_stall_out)
);

defparam loop_limiter_1.ENTRY_WIDTH = 1;
defparam loop_limiter_1.EXIT_WIDTH = 1;
defparam loop_limiter_1.THRESHOLD = 182;

AOChalfSampleRobustImageKernel_sys_cycle_time system_cycle_time_module (
	.clock(clock),
	.resetn(resetn),
	.cur_cycle(cur_cycle)
);


assign valid_out = bb_5_valid_out;
assign stall_out = bb_0_stall_out;
assign writes_pending = bb_5_local_bb5_st_c0_exe18_active;
assign lsus_active[0] = bb_1_local_bb1_ld__active;
assign lsus_active[1] = bb_3_local_bb3_ld__active;
assign lsus_active[2] = bb_5_local_bb5_st_c0_exe18_active;

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
module AOChalfSampleRobustImageKernel_function_wrapper
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
		input [511:0] 		avm_local_bb3_ld__inst0_readdata,
		input 		avm_local_bb3_ld__inst0_readdatavalid,
		input 		avm_local_bb3_ld__inst0_waitrequest,
		output [32:0] 		avm_local_bb3_ld__inst0_address,
		output 		avm_local_bb3_ld__inst0_read,
		output 		avm_local_bb3_ld__inst0_write,
		input 		avm_local_bb3_ld__inst0_writeack,
		output [511:0] 		avm_local_bb3_ld__inst0_writedata,
		output [63:0] 		avm_local_bb3_ld__inst0_byteenable,
		output [4:0] 		avm_local_bb3_ld__inst0_burstcount,
		input [511:0] 		avm_local_bb5_st_c0_exe18_inst0_readdata,
		input 		avm_local_bb5_st_c0_exe18_inst0_readdatavalid,
		input 		avm_local_bb5_st_c0_exe18_inst0_waitrequest,
		output [32:0] 		avm_local_bb5_st_c0_exe18_inst0_address,
		output 		avm_local_bb5_st_c0_exe18_inst0_read,
		output 		avm_local_bb5_st_c0_exe18_inst0_write,
		input 		avm_local_bb5_st_c0_exe18_inst0_writeack,
		output [511:0] 		avm_local_bb5_st_c0_exe18_inst0_writedata,
		output [63:0] 		avm_local_bb5_st_c0_exe18_inst0_byteenable,
		output [4:0] 		avm_local_bb5_st_c0_exe18_inst0_burstcount
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
 reg [255:0] kernel_arguments_NO_SHIFT_REG;
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
		kernel_arguments_NO_SHIFT_REG <= 256'h0;
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
AOChalfSampleRobustImageKernel_function AOChalfSampleRobustImageKernel_function_inst0 (
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
	.avm_local_bb3_ld__readdata(avm_local_bb3_ld__inst0_readdata),
	.avm_local_bb3_ld__readdatavalid(avm_local_bb3_ld__inst0_readdatavalid),
	.avm_local_bb3_ld__waitrequest(avm_local_bb3_ld__inst0_waitrequest),
	.avm_local_bb3_ld__address(avm_local_bb3_ld__inst0_address),
	.avm_local_bb3_ld__read(avm_local_bb3_ld__inst0_read),
	.avm_local_bb3_ld__write(avm_local_bb3_ld__inst0_write),
	.avm_local_bb3_ld__writeack(avm_local_bb3_ld__inst0_writeack),
	.avm_local_bb3_ld__writedata(avm_local_bb3_ld__inst0_writedata),
	.avm_local_bb3_ld__byteenable(avm_local_bb3_ld__inst0_byteenable),
	.avm_local_bb3_ld__burstcount(avm_local_bb3_ld__inst0_burstcount),
	.avm_local_bb5_st_c0_exe18_readdata(avm_local_bb5_st_c0_exe18_inst0_readdata),
	.avm_local_bb5_st_c0_exe18_readdatavalid(avm_local_bb5_st_c0_exe18_inst0_readdatavalid),
	.avm_local_bb5_st_c0_exe18_waitrequest(avm_local_bb5_st_c0_exe18_inst0_waitrequest),
	.avm_local_bb5_st_c0_exe18_address(avm_local_bb5_st_c0_exe18_inst0_address),
	.avm_local_bb5_st_c0_exe18_read(avm_local_bb5_st_c0_exe18_inst0_read),
	.avm_local_bb5_st_c0_exe18_write(avm_local_bb5_st_c0_exe18_inst0_write),
	.avm_local_bb5_st_c0_exe18_writeack(avm_local_bb5_st_c0_exe18_inst0_writeack),
	.avm_local_bb5_st_c0_exe18_writedata(avm_local_bb5_st_c0_exe18_inst0_writedata),
	.avm_local_bb5_st_c0_exe18_byteenable(avm_local_bb5_st_c0_exe18_inst0_byteenable),
	.avm_local_bb5_st_c0_exe18_burstcount(avm_local_bb5_st_c0_exe18_inst0_burstcount),
	.start(start_out),
	.input_inSize_x(kernel_arguments_NO_SHIFT_REG[159:128]),
	.input_r(kernel_arguments_NO_SHIFT_REG[255:224]),
	.input_inSize_y(kernel_arguments_NO_SHIFT_REG[191:160]),
	.clock2x(clock2x),
	.input_in(kernel_arguments_NO_SHIFT_REG[127:64]),
	.input_e_d(kernel_arguments_NO_SHIFT_REG[223:192]),
	.input_out(kernel_arguments_NO_SHIFT_REG[63:0]),
	.has_a_write_pending(has_a_write_pending),
	.has_a_lsu_active(has_a_lsu_active)
);



endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module AOChalfSampleRobustImageKernel_sys_cycle_time
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

