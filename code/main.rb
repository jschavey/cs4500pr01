require_relative "machine"

accept_states_string = "{3,4,5}"

machine = Machine.new [0,1], ['1, ,3','1,0,1','0,,1']

puts machine.inspect