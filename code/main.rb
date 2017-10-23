require_relative "machine"

accept_states_string = "{3,4,5}"

transition_rule_strings = []
transition_rule_strings.push '1, ,3'
transition_rule_strings.push '1,0,1'
transition_rule_strings.push '0, ,1'

machine = Machine.new [0,1], transition_rule_strings

puts machine.inspect
puts machine.isValid?
puts machine.isNFA?

(1...15).each do |i|
    num = i.to_s.rjust(2, '0')
    count = 0
    states = ""
    transitions = Array.new
    File.readlines("../data/fa#{num}.fa").each do |line|
        if count === 0 then
            states = line
        else
            transitions.push line
        end
        count += 1
    end
    
    states.delete! "{}"
    
    states = Array.new states.to_i
    
    machine = Machine.new states, transitions
    
    print machine.instance_variable_get "@alphabet"
end